#!/bin/bash
#
# build-app.sh
# Automated script to build kitty.app bundle
#
# Usage:
#   Local:  ./build-app.sh
#   Remote: curl -fsSL https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/build-app.sh | bash
#

set -e  # Exit on error

echo "========================================="
echo "Building kitty.app"
echo "========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
# If piped from curl, use current directory
if [ -t 0 ]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
else
    SCRIPT_DIR="$(pwd)"
fi
cd "$SCRIPT_DIR"

# Verify we're in the kitty source directory
if [ ! -f "setup.py" ] || [ ! -f "dev.sh" ]; then
    echo -e "${RED}Error: This script must be run from the kitty source directory${NC}"
    echo "Please cd to your kitty source directory first, then run this script."
    exit 1
fi

# Step 1: Build the project
echo -e "${YELLOW}[1/6] Building kitty...${NC}"
./dev.sh build
echo -e "${GREEN}✓ Build complete${NC}"
echo ""

# Step 2: Check if docs dependencies are installed
echo -e "${YELLOW}[2/6] Checking documentation dependencies...${NC}"
if [ ! -f "dependencies/darwin-arm64/python/Python.framework/Versions/3.12/bin/sphinx-build" ]; then
    echo "Installing documentation dependencies..."
    ./dev.sh deps --for-docs
    echo -e "${GREEN}✓ Documentation dependencies installed${NC}"
else
    echo -e "${GREEN}✓ Documentation dependencies already installed${NC}"
fi
echo ""

# Step 3: Create symlinks for sphinx tools
echo -e "${YELLOW}[3/6] Setting up sphinx tools...${NC}"
mkdir -p dependencies/darwin-arm64/bin
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-build dependencies/darwin-arm64/bin/sphinx-build 2>/dev/null || true
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-autobuild dependencies/darwin-arm64/bin/sphinx-autobuild 2>/dev/null || true
echo -e "${GREEN}✓ Sphinx tools configured${NC}"
echo ""

# Step 4: Build documentation
echo -e "${YELLOW}[4/6] Building documentation...${NC}"
if [ ! -d "docs/_build/man" ]; then
    ./dev.sh docs
    echo -e "${GREEN}✓ Documentation built${NC}"
else
    echo -e "${GREEN}✓ Documentation already built${NC}"
fi
echo ""

# Step 5: Apply setup.py fix if needed
echo -e "${YELLOW}[5/6] Checking setup.py for required fixes...${NC}"
if ! grep -q "kitten_symlink = os.path.join" setup.py; then
    echo "Applying fix to setup.py..."
    # Create a backup
    cp setup.py setup.py.backup
    
    # Apply the fix using sed
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
    
    echo -e "${GREEN}✓ setup.py fixed${NC}"
else
    echo -e "${GREEN}✓ setup.py already fixed${NC}"
fi
echo ""

# Step 6: Build the app bundle
echo -e "${YELLOW}[6/7] Building kitty.app bundle...${NC}"
rm -rf kitty.app

DEVELOP_ROOT="$SCRIPT_DIR/dependencies/darwin-arm64" \
PKG_CONFIG_PATH="$SCRIPT_DIR/dependencies/darwin-arm64/lib/pkgconfig" \
PKGCONFIG_EXE="$SCRIPT_DIR/dependencies/darwin-arm64/bin/pkg-config" \
"$SCRIPT_DIR/dependencies/darwin-arm64/python/Python.framework/Versions/Current/bin/python3" \
setup.py kitty.app

echo -e "${GREEN}✓ kitty.app bundle created${NC}"
echo ""

# Step 7: Install to /Applications
echo -e "${YELLOW}[7/7] Installing to /Applications...${NC}"

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
echo "========================================="
echo -e "${GREEN}✓ Installation complete!${NC}"
echo "========================================="
echo ""
echo "Location: /Applications/kitty.app"
echo "Size: $(du -sh /Applications/kitty.app | cut -f1)"
echo ""
echo "You can now:"
echo "  • Open it: open -a kitty"
echo "  • Launch from Spotlight: Press ⌘+Space, type 'kitty'"
echo "  • Run from terminal: /Applications/kitty.app/Contents/MacOS/kitty"
echo ""
