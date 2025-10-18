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

# Progress display function
CURRENT_STEP=""
STEP_PRINTED=false

print_progress() {
    local message="$1"
    # Move cursor up if step was already printed, clear line and print progress
    if [ "$STEP_PRINTED" = true ]; then
        echo -ne "\033[1A\r\033[K${CYAN}${CURRENT_STEP}${NC}\n"
    fi
    echo -ne "\r\033[K${BLUE}  ↳${NC} $message"
}

print_step() {
    local step="$1"
    CURRENT_STEP="$step"
    # Move up 2 lines to overwrite previous step if it exists
    if [ "$STEP_PRINTED" = true ]; then
        echo -ne "\033[2A\r\033[K"
    fi
    echo -e "${CYAN}${step}${NC}"
    STEP_PRINTED=true
}

finish_step() {
    # Move cursor up, clear both lines and print step with checkmark
    echo -ne "\033[1A\r\033[K${CYAN}${CURRENT_STEP}${NC} ${GREEN}✓${NC}\n"
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

print_step "[1/15] Installing prerequisites..."
for pkg in jless git starship cmake less gnu-sed wget zoxide eza fd fzf ripgrep dust tldr tig btop tree tmux hyperfine neovim neofetch yazi lazygit lazydocker nali aria2 apidog httpie nmap telnet bat spotify_player television mise gh node python rust go unar sevenzip brotli upx ffmpeg graphviz exiftool ffmpegthumbnailer jq jc hugo duti pipx rar; do
    print_progress "Installing $pkg..."
    brew install --quiet "$pkg" 2>/dev/null || true
done

print_progress "Tapping oven-sh/bun..."
brew tap oven-sh/bun 2>/dev/null || true
for pkg in pnpm bun; do
    print_progress "Installing $pkg..."
    brew install --quiet "$pkg" 2>/dev/null || true
done

for pkg in lua luarocks php composer; do
    print_progress "Installing $pkg..."
    brew install --quiet "$pkg" 2>/dev/null || true
done

print_progress "Installing psy/psysh..."
composer global require psy/psysh &>/dev/null || true
print_progress "Installing ranger..."
pipx install git+https://github.com/ranger/ranger.git &>/dev/null || true
print_progress "Injecting Pillow into ranger..."
pipx inject ranger-fm Pillow &>/dev/null || true
print_progress "Installing rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y &>/dev/null || true
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_progress "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null || true
fi
print_progress "Upgrading pipx packages..."
pipx upgrade-all &>/dev/null || true
print_progress "Backing up configs..."
mkdir -p ~/.config-backup
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.config-backup/ 2>/dev/null || true
[ -f ~/.zprofile ] && cp ~/.zprofile ~/.config-backup/ 2>/dev/null || true
if [ -d ~/.config ]; then
    for dir in starship yazi kitty nvim lazygit tmux btop bat neofetch spotify_player; do
        [ -d ~/.config/$dir ] && cp -r ~/.config/$dir ~/.config-backup/ 2>/dev/null || true
    done
fi

print_progress "Configuring macOS defaults..."
defaults write com.apple.finder QuitMenuItem -bool true 2>/dev/null
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false 2>/dev/null
defaults write com.apple.finder AppleShowAllFiles -bool true 2>/dev/null
defaults write com.apple.finder ShowPathbar -bool true 2>/dev/null
defaults write com.apple.finder FXDefaultSearchScope -string SCcf 2>/dev/null
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false 2>/dev/null
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false 2>/dev/null
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false 2>/dev/null
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false 2>/dev/null
defaults write com.apple.finder NewWindowTarget -string PfHm 2>/dev/null
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/" 2>/dev/null
defaults write com.apple.finder QLEnableTextSelection -bool true 2>/dev/null
defaults write com.apple.LaunchServices LSQuarantine -bool false 2>/dev/null
defaults write com.apple.Safari IncludeDevelopMenu -bool true 2>/dev/null
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true 2>/dev/null
defaults write com.apple.Safari WebKitDeveloperExtras -bool true 2>/dev/null
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true 2>/dev/null
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true 2>/dev/null
defaults write com.apple.frameworks.diskimages skip-verify -bool true 2>/dev/null
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true 2>/dev/null
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true 2>/dev/null
defaults write com.apple.CrashReporter DialogType -string none 2>/dev/null
defaults write com.apple.AdLib forceLimitAdTracking -bool true 2>/dev/null
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false 2>/dev/null
defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false 2>/dev/null
finish_step

print_step "[2/15] Cloning repository..."
print_progress "Removing old directory..."
rm -rf "$SHELLDUP_DIR"
print_progress "Cloning from GitHub..."
git clone --depth 1 --branch "$SHELLDUP_BRANCH" "$SHELLDUP_REPO_URL" "$SHELLDUP_DIR" &>/dev/null || {
    echo -e "${RED}Error: Failed to clone repository${NC}"
    exit 1
}
finish_step

cd "$KITTY_DIR" || exit 1

print_step "[4/15] Cleaning build directory..."
print_progress "Removing old build files..."
rm -rf build dependencies kitty.app 2>/dev/null || true
finish_step

print_step "[5/15] Downloading dependencies..."
print_progress "Downloading (this may take several minutes)..."
./dev.sh deps &>/dev/null || {
    echo -e "${RED}Error: Failed to download dependencies${NC}"
    exit 1
}
finish_step

print_step "[6/15] Building kitty..."
print_progress "Building (this may take several minutes)..."
./dev.sh build &>/dev/null || {
    echo -e "${RED}Error: Failed to build kitty${NC}"
    exit 1
}
finish_step

print_step "[7/15] Installing documentation dependencies..."
print_progress "Installing doc dependencies..."
./dev.sh deps --for-docs &>/dev/null || {
    echo -e "${RED}Error: Failed to install doc dependencies${NC}"
    exit 1
}
finish_step

print_step "[8/15] Setting up sphinx tools..."
print_progress "Creating symlinks..."
mkdir -p dependencies/darwin-arm64/bin
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-build dependencies/darwin-arm64/bin/sphinx-build 2>/dev/null || true
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-autobuild dependencies/darwin-arm64/bin/sphinx-autobuild 2>/dev/null || true
finish_step

print_step "[9/15] Building documentation..."
print_progress "Building docs..."
./dev.sh docs &>/dev/null || {
    echo -e "${RED}Error: Failed to build documentation${NC}"
    exit 1
}
finish_step

print_step "[10/15] Building macOS app bundle..."
# Refresh sudo for upcoming operations (will prompt if needed)
sudo -v
print_progress "Patching setup.py..."
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
print_progress "Building app bundle..."
rm -rf kitty.app
DEVELOP_ROOT="$KITTY_DIR/dependencies/darwin-arm64" \
PKG_CONFIG_PATH="$KITTY_DIR/dependencies/darwin-arm64/lib/pkgconfig" \
PKGCONFIG_EXE="$KITTY_DIR/dependencies/darwin-arm64/bin/pkg-config" \
"$KITTY_DIR/dependencies/darwin-arm64/python/Python.framework/Versions/Current/bin/python3" \
setup.py kitty.app &>/dev/null || {
    echo -e "${RED}Error: Failed to build kitty.app${NC}"
    exit 1
}
finish_step

print_step "[11/15] Fixing library paths in app bundle..."
# Refresh sudo
sudo -v
print_progress "Creating Frameworks directory..."
mkdir -p kitty.app/Contents/Frameworks

print_progress "Copying Python framework..."
cp -r dependencies/darwin-arm64/python/Python.framework kitty.app/Contents/Frameworks/ 2>/dev/null || true

print_progress "Copying dylibs..."
cp -r dependencies/darwin-arm64/lib/*.dylib kitty.app/Contents/Frameworks/ 2>/dev/null || true

KITTY_BINARY="kitty.app/Contents/MacOS/kitty"

print_progress "Fixing Python framework path..."
sudo install_name_tool -change "$KITTY_DIR/dependencies/darwin-arm64/python/Python.framework/Versions/3.12/Python" "@executable_path/../Frameworks/Python.framework/Versions/3.12/Python" "$KITTY_BINARY" 2>/dev/null || true

print_progress "Fixing dylib paths in main binary..."
for lib in kitty.app/Contents/Frameworks/*.dylib; do
    lib_name=$(basename "$lib")
    sudo install_name_tool -change "$KITTY_DIR/dependencies/darwin-arm64/lib/$lib_name" "@executable_path/../Frameworks/$lib_name" "$KITTY_BINARY" 2>/dev/null || true
    sudo install_name_tool -id "@executable_path/../Frameworks/$lib_name" "$lib" 2>/dev/null || true
    for dep in kitty.app/Contents/Frameworks/*.dylib; do
        dep_name=$(basename "$dep")
        sudo install_name_tool -change "$KITTY_DIR/dependencies/darwin-arm64/lib/$dep_name" "@executable_path/../Frameworks/$dep_name" "$lib" 2>/dev/null || true
    done
done

print_progress "Fixing dylib paths in Python modules..."
find kitty.app/Contents/Resources/kitty -name "*.so" -type f | while read so_file; do
    for lib in kitty.app/Contents/Frameworks/*.dylib; do
        lib_name=$(basename "$lib")
        sudo install_name_tool -change "$KITTY_DIR/dependencies/darwin-arm64/lib/$lib_name" "@loader_path/../../../Frameworks/$lib_name" "$so_file" 2>/dev/null || true
    done
    sudo install_name_tool -change "$KITTY_DIR/dependencies/darwin-arm64/python/Python.framework/Versions/3.12/Python" "@loader_path/../../../Frameworks/Python.framework/Versions/3.12/Python" "$so_file" 2>/dev/null || true
done
finish_step

print_step "[12/15] Installing to /Applications..."
# Refresh sudo
sudo -v
print_progress "Removing old installation..."
if [ -d "/Applications/kitty.app" ]; then
    sudo rm -rf "/Applications/kitty.app"
fi
print_progress "Moving to /Applications..."
sudo mv kitty.app /Applications/ || {
    echo -e "${RED}Error: Failed to install to /Applications${NC}"
    exit 1
}
finish_step

print_step "[13/15] Removing Gatekeeper restrictions..."
# Refresh sudo
sudo -v
print_progress "Removing quarantine attributes..."
sudo xattr -cr /Applications/kitty.app 2>/dev/null || true
sudo xattr -d com.apple.quarantine /Applications/kitty.app 2>/dev/null || true
print_progress "Code signing..."
sudo codesign --force --deep --sign - /Applications/kitty.app 2>/dev/null || true
print_progress "Updating security policy..."
sudo spctl --add --label "kitty" /Applications/kitty.app 2>/dev/null || true
sudo spctl --enable --label "kitty" 2>/dev/null || true
finish_step

print_step "[14/15] Cleaning up kitty build files..."
print_progress "Removing build directory..."
cd "$SHELLDUP_DIR" || exit 1
rm -rf "$KITTY_DIR"
finish_step

print_step "[15/15] Running setup script..."

# Use the cloned repository directory
SCRIPT_DIR="$SHELLDUP_DIR"

print_progress "Copying .zshrc..."
cp "$SCRIPT_DIR/.zshrc" ~/.zshrc

print_progress "Creating .zprofile..."
cat > ~/.zprofile << 'EOF'

eval "$(/opt/homebrew/bin/brew shellenv)"

PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH
EOF

print_progress "Creating config directories..."
mkdir -p ~/.config/{starship,yazi,kitty,nvim,lazygit,tmux,btop,bat,neofetch,spotify_player} 2>/dev/null || true

print_progress "Copying starship config..."
cp "$SCRIPT_DIR/.config/starship.toml" ~/.config/starship.toml

print_progress "Copying yazi configs..."
cp -r "$SCRIPT_DIR/.config/yazi/"* ~/.config/yazi/

print_progress "Copying kitty configs..."
cp -r "$SCRIPT_DIR/.config/kitty/"* ~/.config/kitty/

print_progress "Installing JetBrains Mono Nerd Font..."
brew install --cask font-jetbrains-mono-nerd-font 2>/dev/null || true

print_progress "Copying lazygit config..."
cp "$SCRIPT_DIR/.config/lazygit/config.yml" ~/.config/lazygit/config.yml

if ! command -v mise &> /dev/null; then
    print_progress "Installing mise..."
    curl https://mise.run | sh 2>/dev/null || true
fi

print_progress "Configuring Git..."
git config --global init.defaultBranch main
git config --global pull.rebase false

print_progress "Creating completions directory..."
mkdir -p ~/.zsh/completions

print_progress "Installing Catppuccin theme for bat..."
mkdir -p ~/.config/bat/themes
if [ ! -f ~/.config/bat/themes/Catppuccin-macchiato.tmTheme ]; then
    curl -s https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-macchiato.tmTheme > ~/.config/bat/themes/Catppuccin-macchiato.tmTheme
    bat cache --build 2>/dev/null || true
fi

print_progress "Installing Catppuccin theme for kitty..."
mkdir -p ~/.config/kitty/themes/catppuccin
if [ ! -f ~/.config/kitty/themes/catppuccin/macchiato.conf ]; then
    curl -s https://raw.githubusercontent.com/catppuccin/kitty/main/macchiato.conf > ~/.config/kitty/themes/catppuccin/macchiato.conf
fi

print_progress "Copying neofetch config..."
if [ ! -f ~/.config/neofetch/config.conf ]; then
    cp "$SCRIPT_DIR/.config/neofetch/config.conf" ~/.config/neofetch/config.conf 2>/dev/null || true
else
    echo "$(cat "$SCRIPT_DIR/.config/neofetch/config.conf")" >> ~/.config/neofetch/config.conf 2>/dev/null || true
fi

print_progress "Configuring btop to run at login..."
# Make btop.sh executable
chmod +x ~/.config/kitty/btop.sh

# Create LaunchAgent to run btop at login
mkdir -p ~/Library/LaunchAgents
cat > ~/Library/LaunchAgents/com.user.kitty.btop.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.kitty.btop</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/zsh</string>
        <string>-c</string>
        <string>sleep 3 && ~/.config/kitty/btop.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <false/>
</dict>
</plist>
EOF

# Load the LaunchAgent
launchctl load ~/Library/LaunchAgents/com.user.kitty.btop.plist 2>/dev/null || true

finish_step

print_progress "Final cleanup..."
cd "$HOME" || exit 1
rm -rf "$SHELLDUP_DIR"

clear
echo ""
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Installation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}Applying changes...${NC}"
sleep 2
source ~/.zshrc 2>/dev/null || true

if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/local/bin/zsh" ] && [ "$SHELL" != "/opt/homebrew/bin/zsh" ]; then
    echo -e "${YELLOW}Setting zsh as default shell...${NC}"
    chsh -s $(which zsh)
fi

echo ""
echo -e "${CYAN}Starting btop panel...${NC}"
sleep 1
~/.config/kitty/btop.sh &>/dev/null &
