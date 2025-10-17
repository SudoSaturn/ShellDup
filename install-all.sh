#!/bin/bash
#
# install-all.sh
# Complete setup installer: kitty terminal + full environment configuration
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Error handler
error_exit() {
    echo -e "\n${RED}========================================${NC}"
    echo -e "${RED}ERROR: $1${NC}"
    echo -e "${RED}========================================${NC}"
    echo ""
    echo -e "${YELLOW}Step that failed:${NC} $2"
    exit 1
}

clear
echo ""
echo "               _          __          "
echo " ___ ___ _  __(_)______ _/ /____  ____"
echo "/ -_) _ \ |/ / / __/ _ \`/ __/ _ \/ __/"
echo "\__/_//_/___/_/\__/\_,_/\__/\___/_/   "
echo ""
echo ""
read -p "Press Enter to continue"
echo ""

# Request sudo access upfront
echo "you need sudo access to run this"
echo ""
sudo -v
echo ""
echo "BE PATIENT! this might take a while"
echo ""

# Keep sudo alive in the background
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Configuration
SHELLDUP_REPO_URL="https://github.com/sudosaturn/ShellDup.git"
SHELLDUP_BRANCH="main"
SHELLDUP_DIR="/tmp/shelldup-$$"
KITTY_DIR="$SHELLDUP_DIR/kitty"

# Allow override via environment variables
if [ -n "$CUSTOM_SHELLDUP_REPO" ]; then
    SHELLDUP_REPO_URL="$CUSTOM_SHELLDUP_REPO"
fi
if [ -n "$CUSTOM_SHELLDUP_BRANCH" ]; then
    SHELLDUP_BRANCH="$CUSTOM_SHELLDUP_BRANCH"
fi

echo -e "${CYAN}[1/12]${NC} Checking prerequisites..."
if ! command -v git &> /dev/null; then
    error_exit "git is not installed. Install with: xcode-select --install" "Prerequisites check"
fi
if ! command -v go &> /dev/null; then
    error_exit "go is not installed. Install from: https://go.dev/dl/" "Prerequisites check"
fi
echo -e "${GREEN}✓${NC} Prerequisites OK"

echo ""
echo -e "${CYAN}[2/12]${NC} Cloning ShellDup repository..."
rm -rf "$SHELLDUP_DIR"
git clone --depth 1 --branch "$SHELLDUP_BRANCH" "$SHELLDUP_REPO_URL" "$SHELLDUP_DIR" &>/dev/null || \
    error_exit "Failed to clone repository" "Git clone"
echo -e "${GREEN}✓${NC} Repository cloned"

# Verify kitty directory exists
if [ ! -d "$KITTY_DIR" ]; then
    error_exit "kitty directory not found in ShellDup repository" "Directory verification"
fi

cd "$KITTY_DIR"

# Clean any existing builds and dependencies
echo ""
echo -e "${CYAN}[3/12]${NC} Cleaning previous builds..."
rm -rf build dependencies kitty.app &>/dev/null || true
echo -e "${GREEN}✓${NC} Cleaned"

echo ""
echo -e "${CYAN}[4/12]${NC} Downloading kitty dependencies (this may take several minutes)..."
./dev.sh deps &>/dev/null || error_exit "Failed to download dependencies" "Dependencies download"
echo -e "${GREEN}✓${NC} Dependencies downloaded"

echo ""
echo -e "${CYAN}[5/12]${NC} Building kitty (this may take several minutes)..."
./dev.sh build &>/dev/null || error_exit "Failed to build kitty" "Kitty build"
echo -e "${GREEN}✓${NC} Kitty built"

echo ""
echo -e "${CYAN}[6/12]${NC} Installing documentation dependencies..."
./dev.sh deps --for-docs &>/dev/null || error_exit "Failed to install doc dependencies" "Doc dependencies"
echo -e "${GREEN}✓${NC} Doc dependencies installed"

echo ""
echo -e "${CYAN}[7/12]${NC} Setting up sphinx tools..."
mkdir -p dependencies/darwin-arm64/bin
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-build dependencies/darwin-arm64/bin/sphinx-build 2>/dev/null || true
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-autobuild dependencies/darwin-arm64/bin/sphinx-autobuild 2>/dev/null || true
echo -e "${GREEN}✓${NC} Sphinx tools setup"

echo ""
echo -e "${CYAN}[8/12]${NC} Building documentation..."
./dev.sh docs &>/dev/null || error_exit "Failed to build documentation" "Documentation build"
echo -e "${GREEN}✓${NC} Documentation built"

echo ""
echo -e "${CYAN}[9/12]${NC} Building macOS app bundle..."
if ! grep -q "kitten_symlink = os.path.join" setup.py; then
    sed -i '' '/if not for_freeze:/,/os.symlink(os.path.relpath(kitten_exe/c\
    if not for_freeze:\
        kitten_exe = build_static_kittens(args, launcher_dir=os.path.dirname(kitty_exe))\
        if not kitten_exe:\
            raise SystemExit('\''kitten not built cannot create macOS bundle'\'')\
        kitten_symlink = os.path.join(os.path.dirname(in_src_launcher), os.path.basename(kitten_exe))\
        if os.path.exists(kitten_symlink):\
            os.remove(kitten_symlink)\
        os.symlink(os.path.relpath(kitten_exe, os.path.dirname(in_src_launcher)), kitten_symlink)
' setup.py
fi
rm -rf kitty.app
DEVELOP_ROOT="$KITTY_DIR/dependencies/darwin-arm64" \
PKG_CONFIG_PATH="$KITTY_DIR/dependencies/darwin-arm64/lib/pkgconfig" \
PKGCONFIG_EXE="$KITTY_DIR/dependencies/darwin-arm64/bin/pkg-config" \
"$KITTY_DIR/dependencies/darwin-arm64/python/Python.framework/Versions/Current/bin/python3" \
setup.py kitty.app &>/dev/null || error_exit "Failed to build kitty.app" "App bundle creation"
echo -e "${GREEN}✓${NC} App bundle created"

echo ""
echo -e "${CYAN}[10/12]${NC} Installing to /Applications..."
if [ -d "/Applications/kitty.app" ]; then
    sudo rm -rf "/Applications/kitty.app"
fi
sudo mv kitty.app /Applications/ || error_exit "Failed to install to /Applications" "App installation"
echo -e "${GREEN}✓${NC} Installed to /Applications"

echo ""
echo -e "${CYAN}[11/12]${NC} Cleaning up kitty build files..."
cd "$SHELLDUP_DIR"
rm -rf "$KITTY_DIR"
echo -e "${GREEN}✓${NC} Build files cleaned"

echo ""
echo -e "${CYAN}[12/12]${NC} Running setup script..."
if [ ! -f "setup-duplicate.sh" ]; then
    error_exit "setup-duplicate.sh not found in repository" "Setup script verification"
fi
bash setup-duplicate.sh &>/dev/null || error_exit "Failed to run setup-duplicate.sh" "Setup script execution"
echo -e "${GREEN}✓${NC} Setup complete"

echo ""
echo -e "${CYAN}[13/13]${NC} Final cleanup..."
cd "$HOME"
rm -rf "$SHELLDUP_DIR"
echo -e "${GREEN}✓${NC} Cleanup complete"

clear
echo ""
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Installation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}To apply changes, run:${NC}"
echo -e "${CYAN}  source ~/.zshrc${NC}"
echo ""
echo -e "${YELLOW}Or simply restart your terminal.${NC}"
echo ""
