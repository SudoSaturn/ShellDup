#!/bin/bash
#
# install-all.sh
# Complete setup installer: kitty terminal + full environment configuration
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/sudosaturn/ShellDup/main/install-all.sh | bash
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

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

# Clean any existing kitty builds in current user's home directory
if [ -d "$HOME/kitty" ]; then
    echo -e "${YELLOW}Found existing kitty directory in home folder. Removing...${NC}"
    rm -rf "$HOME/kitty"
    echo -e "${GREEN}✓${NC} Cleaned home directory"
fi

echo ""
echo "BE PATIENT! this might take a while"
echo ""

# Keep sudo alive in the background
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Configuration - all dynamic, no hardcoded paths
SHELLDUP_REPO_URL="https://github.com/sudosaturn/ShellDup.git"
SHELLDUP_BRANCH="main"
SHELLDUP_DIR="/tmp/shelldup-$$"
KITTY_DIR="$SHELLDUP_DIR/kitty"
KITTY_TEMP_DIR="/tmp/kitty-official-$$"

# Allow override via environment variables
if [ -n "$CUSTOM_SHELLDUP_REPO" ]; then
    SHELLDUP_REPO_URL="$CUSTOM_SHELLDUP_REPO"
fi
if [ -n "$CUSTOM_SHELLDUP_BRANCH" ]; then
    SHELLDUP_BRANCH="$CUSTOM_SHELLDUP_BRANCH"
fi

echo -e "${CYAN}[1/15]${NC} Checking prerequisites..."
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed${NC}"
    echo "Install with: xcode-select --install"
    exit 1
fi
if ! command -v go &> /dev/null; then
    echo -e "${RED}Error: go is not installed${NC}"
    echo "Install from: https://go.dev/dl/"
    exit 1
fi
echo -e "${GREEN}✓${NC} Prerequisites OK"

echo ""
echo -e "${CYAN}[2/15]${NC} Cloning ShellDup repository..."
rm -rf "$SHELLDUP_DIR"
git clone --depth 1 --branch "$SHELLDUP_BRANCH" "$SHELLDUP_REPO_URL" "$SHELLDUP_DIR" &>/dev/null || {
    echo -e "${RED}Error: Failed to clone repository${NC}"
    exit 1
}
echo -e "${GREEN}✓${NC} Repository cloned"

if [ ! -d "$KITTY_DIR" ]; then
    echo -e "${RED}Error: kitty directory not found in ShellDup repository${NC}"
    exit 1
fi

echo ""
echo -e "${CYAN}[3/15]${NC} Cloning .github directory from official kitty repository..."
rm -rf "$KITTY_TEMP_DIR"
mkdir -p "$KITTY_TEMP_DIR"
cd "$KITTY_TEMP_DIR"

# Clone with sparse checkout to get only .github directory
git clone --filter=blob:none --sparse https://github.com/kovidgoyal/kitty.git . &>/dev/null || {
    echo -e "${RED}Error: Failed to clone official kitty repository${NC}"
    exit 1
}
git sparse-checkout set .github &>/dev/null || {
    echo -e "${RED}Error: Failed to set sparse checkout${NC}"
    exit 1
}

# Copy .github directory to ShellDup kitty directory
cp -r .github "$KITTY_DIR/" || {
    echo -e "${RED}Error: Failed to copy .github directory${NC}"
    exit 1
}

# Clean up temporary kitty clone
cd /tmp
rm -rf "$KITTY_TEMP_DIR"
echo -e "${GREEN}✓${NC} .github directory added"

cd "$KITTY_DIR" || exit 1

echo ""
echo -e "${CYAN}[4/15]${NC} Cleaning build directory..."
rm -rf build dependencies kitty.app 2>/dev/null || true
echo -e "${GREEN}✓${NC} Cleaned"

echo ""
echo -e "${CYAN}[5/15]${NC} Downloading dependencies (may take several minutes)..."
./dev.sh deps &>/dev/null || {
    echo -e "${RED}Error: Failed to download dependencies${NC}"
    exit 1
}
echo -e "${GREEN}✓${NC} Dependencies downloaded"

echo ""
echo -e "${CYAN}[6/15]${NC} Building kitty (may take several minutes)..."
./dev.sh build &>/dev/null || {
    echo -e "${RED}Error: Failed to build kitty${NC}"
    exit 1
}
echo -e "${GREEN}✓${NC} Kitty built"

echo ""
echo -e "${CYAN}[7/15]${NC} Installing documentation dependencies..."
./dev.sh deps --for-docs &>/dev/null || {
    echo -e "${RED}Error: Failed to install doc dependencies${NC}"
    exit 1
}
echo -e "${GREEN}✓${NC} Doc dependencies installed"

echo ""
echo -e "${CYAN}[8/15]${NC} Setting up sphinx tools..."
mkdir -p dependencies/darwin-arm64/bin
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-build dependencies/darwin-arm64/bin/sphinx-build 2>/dev/null || true
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-autobuild dependencies/darwin-arm64/bin/sphinx-autobuild 2>/dev/null || true
echo -e "${GREEN}✓${NC} Sphinx tools setup"

echo ""
echo -e "${CYAN}[9/15]${NC} Building documentation..."
./dev.sh docs &>/dev/null || {
    echo -e "${RED}Error: Failed to build documentation${NC}"
    exit 1
}
echo -e "${GREEN}✓${NC} Documentation built"

echo ""
echo -e "${CYAN}[10/15]${NC} Building macOS app bundle..."
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
setup.py kitty.app &>/dev/null || {
    echo -e "${RED}Error: Failed to build kitty.app${NC}"
    exit 1
}
echo -e "${GREEN}✓${NC} App bundle created"

echo ""
echo -e "${CYAN}[11/15]${NC} Fixing library paths in app bundle..."
# Create lib directory inside the app bundle
mkdir -p kitty.app/Contents/Frameworks

# Copy all required dylibs into the app
cp -r dependencies/darwin-arm64/lib/*.dylib kitty.app/Contents/Frameworks/ 2>/dev/null || true

# Fix library paths using install_name_tool
KITTY_BINARY="kitty.app/Contents/MacOS/kitty"
for lib in kitty.app/Contents/Frameworks/*.dylib; do
    lib_name=$(basename "$lib")
    # Change the library path in the binary to use @executable_path
    sudo install_name_tool -change "$KITTY_DIR/dependencies/darwin-arm64/lib/$lib_name" "@executable_path/../Frameworks/$lib_name" "$KITTY_BINARY" 2>/dev/null || true
    # Fix the library's own id
    sudo install_name_tool -id "@executable_path/../Frameworks/$lib_name" "$lib" 2>/dev/null || true
    # Fix dependencies within the library itself
    for dep in kitty.app/Contents/Frameworks/*.dylib; do
        dep_name=$(basename "$dep")
        sudo install_name_tool -change "$KITTY_DIR/dependencies/darwin-arm64/lib/$dep_name" "@executable_path/../Frameworks/$dep_name" "$lib" 2>/dev/null || true
    done
done
echo -e "${GREEN}✓${NC} Library paths fixed"

echo ""
echo -e "${CYAN}[12/15]${NC} Installing to /Applications..."
if [ -d "/Applications/kitty.app" ]; then
    sudo rm -rf "/Applications/kitty.app"
fi
sudo mv kitty.app /Applications/ || {
    echo -e "${RED}Error: Failed to install to /Applications${NC}"
    exit 1
}
echo -e "${GREEN}✓${NC} Installed to /Applications"

echo ""
echo -e "${CYAN}[13/15]${NC} Removing Gatekeeper restrictions..."
sudo xattr -cr /Applications/kitty.app 2>/dev/null || true
sudo xattr -d com.apple.quarantine /Applications/kitty.app 2>/dev/null || true
sudo codesign --force --deep --sign - /Applications/kitty.app 2>/dev/null || true
sudo spctl --add --label "kitty" /Applications/kitty.app 2>/dev/null || true
sudo spctl --enable --label "kitty" 2>/dev/null || true
echo -e "${GREEN}✓${NC} Gatekeeper restrictions removed"

echo ""
echo -e "${CYAN}[14/15]${NC} Cleaning up kitty build files..."
cd "$SHELLDUP_DIR" || exit 1
rm -rf "$KITTY_DIR"
echo -e "${GREEN}✓${NC} Build files cleaned"

echo ""
echo -e "${CYAN}[15/15]${NC} Running setup script..."
if [ ! -f "setup-duplicate.sh" ]; then
    echo -e "${RED}Error: setup-duplicate.sh not found in ShellDup repository${NC}"
    echo -e "${YELLOW}Repository contents:${NC}"
    ls -la "$SHELLDUP_DIR"
    exit 1
fi

if ! bash setup-duplicate.sh; then
    echo -e "${RED}Error: setup-duplicate.sh failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} Setup complete"

echo ""
echo -e "${CYAN}Final cleanup...${NC}"
cd "$HOME" || exit 1
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
