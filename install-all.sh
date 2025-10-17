#!/bin/bash
#
# install-all.sh
# Complete setup installer: kitty terminal + full environment configuration
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/sudosaturn/ShellDup/main/install-all.sh | bash
#
# This script will:
#   1. Clone and build kitty terminal from source
#   2. Install kitty to /Applications/kitty.app
#   3. Clone ShellDup repository
#   4. Run complete environment setup
#   5. Clean up temporary files
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Progress bar function
show_progress() {
    local current=$1
    local total=$2
    local message=$3
    local percent=$((current * 100 / total))
    local filled=$((percent * 30 / 100))
    local empty=$((30 - filled))
    
    # Clear the line first
    printf "\r\033[K"
    printf "[%3d%%] " "$percent"
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' ' '
}

complete_step() {
    # Do nothing - just let the progress bar continue on the same line
    :
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
KITTY_REPO_URL="https://github.com/kovidgoyal/kitty.git"
KITTY_BRANCH="master"
SHELLDUP_REPO_URL="https://github.com/sudosaturn/ShellDup.git"
SHELLDUP_BRANCH="main"
KITTY_BUILD_DIR="/tmp/kitty-build-$$"
SHELLDUP_DIR="/tmp/shelldup-$$"

# Allow override via environment variables
if [ -n "$CUSTOM_KITTY_REPO" ]; then
    KITTY_REPO_URL="$CUSTOM_KITTY_REPO"
fi
if [ -n "$CUSTOM_KITTY_BRANCH" ]; then
    KITTY_BRANCH="$CUSTOM_KITTY_BRANCH"
fi
if [ -n "$CUSTOM_SHELLDUP_REPO" ]; then
    SHELLDUP_REPO_URL="$CUSTOM_SHELLDUP_REPO"
fi
if [ -n "$CUSTOM_SHELLDUP_BRANCH" ]; then
    SHELLDUP_BRANCH="$CUSTOM_SHELLDUP_BRANCH"
fi


TOTAL_STEPS=11

# Check prerequisites
show_progress 1 $TOTAL_STEPS ""
if ! command -v git &> /dev/null; then
    echo -e "\n${RED}Error: git is not installed${NC}"
    echo "Please install Xcode Command Line Tools: xcode-select --install"
    exit 1
fi
if ! command -v go &> /dev/null; then
    echo -e "\n${RED}Error: go is not installed${NC}"
    echo "Please install Go from: https://go.dev/dl/"
    exit 1
fi

# Clone kitty repository
show_progress 2 $TOTAL_STEPS ""
rm -rf "$KITTY_BUILD_DIR"
git clone --depth 1 --branch "$KITTY_BRANCH" "$KITTY_REPO_URL" "$KITTY_BUILD_DIR" &>/dev/null
cd "$KITTY_BUILD_DIR"

# Build kitty
show_progress 3 $TOTAL_STEPS ""
./dev.sh build &>/dev/null

# Install documentation dependencies
show_progress 4 $TOTAL_STEPS ""
./dev.sh deps --for-docs &>/dev/null

# Setup sphinx tools
show_progress 5 $TOTAL_STEPS ""
mkdir -p dependencies/darwin-arm64/bin
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-build dependencies/darwin-arm64/bin/sphinx-build 2>/dev/null || true
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-autobuild dependencies/darwin-arm64/bin/sphinx-autobuild 2>/dev/null || true

# Build documentation
show_progress 6 $TOTAL_STEPS ""
./dev.sh docs &>/dev/null

# Apply setup.py fix and build app
show_progress 7 $TOTAL_STEPS ""
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
DEVELOP_ROOT="$KITTY_BUILD_DIR/dependencies/darwin-arm64" \
PKG_CONFIG_PATH="$KITTY_BUILD_DIR/dependencies/darwin-arm64/lib/pkgconfig" \
PKGCONFIG_EXE="$KITTY_BUILD_DIR/dependencies/darwin-arm64/bin/pkg-config" \
"$KITTY_BUILD_DIR/dependencies/darwin-arm64/python/Python.framework/Versions/Current/bin/python3" \
setup.py kitty.app &>/dev/null

# Install to /Applications
show_progress 8 $TOTAL_STEPS ""
if [ -d "/Applications/kitty.app" ]; then
    sudo rm -rf "/Applications/kitty.app"
fi
sudo mv kitty.app /Applications/

# Cleanup kitty build
show_progress 9 $TOTAL_STEPS ""
cd /
rm -rf "$KITTY_BUILD_DIR"

# Clone ShellDup repository
show_progress 10 $TOTAL_STEPS ""
rm -rf "$SHELLDUP_DIR"
git clone --depth 1 --branch "$SHELLDUP_BRANCH" "$SHELLDUP_REPO_URL" "$SHELLDUP_DIR" &>/dev/null
cd "$SHELLDUP_DIR"

# Run the setup script
show_progress 11 $TOTAL_STEPS ""
bash setup-duplicate.sh &>/dev/null

# Cleanup ShellDup temporary directory
cd /
rm -rf "$SHELLDUP_DIR"

clear
echo ""
echo ""
echo "Installation complete!"
echo ""
read -p "Press Enter to apply changes..."
source ~/.zshrc
echo ""
