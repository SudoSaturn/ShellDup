#!/bin/bash
#
# install-kitty.sh
# One-command installer for kitty terminal
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/install-kitty.sh | bash
#
# This script will:
#   1. Clone the kitty repository
#   2. Build kitty from source
#   3. Install to /Applications/kitty.app
#   4. Clean up temporary files
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo "========================================="
echo -e "${BLUE}kitty Terminal Installer${NC}"
echo "========================================="
echo ""

# Configuration
REPO_URL="https://github.com/kovidgoyal/kitty.git"
BRANCH="master"
BUILD_DIR="/tmp/kitty-build-$$"

# Allow override via environment variables
if [ -n "$KITTY_REPO_URL" ]; then
    REPO_URL="$KITTY_REPO_URL"
fi
if [ -n "$KITTY_BRANCH" ]; then
    BRANCH="$KITTY_BRANCH"
fi

echo -e "${YELLOW}Configuration:${NC}"
echo "  Repository: $REPO_URL"
echo "  Branch: $BRANCH"
echo "  Build directory: $BUILD_DIR"
echo ""

# Check prerequisites
echo -e "${YELLOW}[1/8] Checking prerequisites...${NC}"

# Check for git
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed${NC}"
    echo "Please install Xcode Command Line Tools:"
    echo "  xcode-select --install"
    exit 1
fi

# Check for go
if ! command -v go &> /dev/null; then
    echo -e "${RED}Error: go is not installed${NC}"
    echo "Please install Go from: https://go.dev/dl/"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites satisfied${NC}"
echo ""

# Clone repository
echo -e "${YELLOW}[2/8] Cloning kitty repository...${NC}"
rm -rf "$BUILD_DIR"
git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$BUILD_DIR"
cd "$BUILD_DIR"
echo -e "${GREEN}✓ Repository cloned${NC}"
echo ""

# Build kitty
echo -e "${YELLOW}[3/8] Building kitty...${NC}"
./dev.sh build
echo -e "${GREEN}✓ Build complete${NC}"
echo ""

# Install documentation dependencies
echo -e "${YELLOW}[4/8] Installing documentation dependencies...${NC}"
./dev.sh deps --for-docs
echo -e "${GREEN}✓ Documentation dependencies installed${NC}"
echo ""

# Setup sphinx tools
echo -e "${YELLOW}[5/8] Setting up sphinx tools...${NC}"
mkdir -p dependencies/darwin-arm64/bin
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-build dependencies/darwin-arm64/bin/sphinx-build 2>/dev/null || true
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-autobuild dependencies/darwin-arm64/bin/sphinx-autobuild 2>/dev/null || true
echo -e "${GREEN}✓ Sphinx tools configured${NC}"
echo ""

# Build documentation
echo -e "${YELLOW}[6/8] Building documentation...${NC}"
./dev.sh docs
echo -e "${GREEN}✓ Documentation built${NC}"
echo ""

# Apply setup.py fix
echo -e "${YELLOW}[7/8] Applying fixes and building app bundle...${NC}"

# Check if fix is needed
if ! grep -q "kitten_symlink = os.path.join" setup.py; then
    # Apply the fix
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

# Build the app bundle
rm -rf kitty.app

DEVELOP_ROOT="$BUILD_DIR/dependencies/darwin-arm64" \
PKG_CONFIG_PATH="$BUILD_DIR/dependencies/darwin-arm64/lib/pkgconfig" \
PKGCONFIG_EXE="$BUILD_DIR/dependencies/darwin-arm64/bin/pkg-config" \
"$BUILD_DIR/dependencies/darwin-arm64/python/Python.framework/Versions/Current/bin/python3" \
setup.py kitty.app

echo -e "${GREEN}✓ kitty.app bundle created${NC}"
echo ""

# Install to /Applications
echo -e "${YELLOW}[8/8] Installing to /Applications...${NC}"

# Check if /Applications/kitty.app already exists
if [ -d "/Applications/kitty.app" ]; then
    echo "Removing existing kitty.app from /Applications..."
    if rm -rf "/Applications/kitty.app" 2>/dev/null; then
        echo -e "${GREEN}✓ Removed old version${NC}"
    else
        echo -e "${YELLOW}⚠ Need sudo to remove existing app${NC}"
        sudo rm -rf "/Applications/kitty.app"
        echo -e "${GREEN}✓ Removed old version${NC}"
    fi
fi

# Move the app to /Applications
echo "Moving kitty.app to /Applications..."
if mv kitty.app /Applications/ 2>/dev/null; then
    echo -e "${GREEN}✓ Installed to /Applications/kitty.app${NC}"
else
    echo -e "${YELLOW}⚠ Need sudo to install to /Applications${NC}"
    sudo mv kitty.app /Applications/
    echo -e "${GREEN}✓ Installed to /Applications/kitty.app${NC}"
fi

echo ""

# Cleanup
echo -e "${YELLOW}Cleaning up temporary files...${NC}"
cd /
rm -rf "$BUILD_DIR"
echo -e "${GREEN}✓ Cleanup complete${NC}"
echo ""

# Final message
echo "========================================="
echo -e "${GREEN}✓ Installation complete!${NC}"
echo "========================================="
echo ""
echo "Location: /Applications/kitty.app"
echo "Size: $(du -sh /Applications/kitty.app 2>/dev/null | cut -f1 || echo 'N/A')"
echo ""
echo -e "${BLUE}You can now:${NC}"
echo "  • Open it: ${GREEN}open -a kitty${NC}"
echo "  • Launch from Spotlight: Press ${GREEN}⌘+Space${NC}, type ${GREEN}'kitty'${NC}"
echo "  • Run from terminal: ${GREEN}/Applications/kitty.app/Contents/MacOS/kitty${NC}"
echo ""
echo -e "${YELLOW}Note:${NC} The build directory has been removed to save space."
echo ""
