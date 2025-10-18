#!/bin/bash

set -e


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

log "Installing stuff"
# Note: kitty is not installed via brew - we use our custom-built version
# brew install --quiet \
#     jless \
#     git \
#     starship \
#     cmake \
#     less \
#     gnu-sed \
#     wget \
#     zoxide \
#     eza \
#     fd \
#     fzf \
#     ripgrep \
#     dust \
#     tldr \
#     tig \
#     btop \
#     tree \
#     tmux \
#     hyperfine\
#     neovim \
#     neofetch \
#     yazi \
#     lazygit \
#     lazydocker \
#     nali \
#     aria2 \
#     apidog \
#     httpie \
#     nmap \
#     telnet \
#     bat \
#     spotify_player \
#     tv \
#     mise \
#     gh \
#     git \
#     node \
#     python \
#     rust \
#     go \
#     unar \
#     sevenzip \
#     brotli \
#     upx \
#     ffmpeg \
#     graphviz \
#     exiftool \
#     ffmpegthumbnailer \
#     jq \
#     jc \
#     hugo \
#     duti \
#     pipx \
#     rar

# brew tap oven-sh/bun
# brew install node pnpm bun
# brew install lua luarocks php composer
# composer global require psy/psysh
# pipx install git+https://github.com/ranger/ranger.git
# pipx inject ranger Pillow
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# if [ ! -d "$HOME/.oh-my-zsh" ]; then
#     sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# fi
# pipx upgrade-all
# mkdir -p ~/.config-backup
# [ -f ~/.zshrc ] && cp ~/.zshrc ~/.config-backup/
# [ -f ~/.zprofile ] && cp ~/.zprofile ~/.config-backup/
# [ -d ~/.config ] && cp -r ~/.config ~/.config-backup/

# # Copy shell configurations
# defaults write com.apple.finder QuitMenuItem -bool true
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# defaults write com.apple.finder AppleShowAllFiles -bool true
# defaults write com.apple.finder ShowPathbar -bool true
# defaults write com.apple.finder FXDefaultSearchScope -string SCcf
# defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
# defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
# defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
# defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
# defaults write com.apple.finder NewWindowTarget -string PfHm
# defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"
# defaults write com.apple.finder QLEnableTextSelection -bool true
# defaults write com.apple.LaunchServices LSQuarantine -bool false
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtras -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
# defaults write com.apple.frameworks.diskimages skip-verify -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
# defaults write com.apple.CrashReporter DialogType -string none
# defaults write com.apple.AdLib forceLimitAdTracking -bool true
# defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
# defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false



# Copy .zshrc
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/.zshrc" ~/.zshrc

# .zprofile
cat > ~/.zprofile << 'EOF'

eval "$(/opt/homebrew/bin/brew shellenv)"

PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH
EOF


mkdir -p ~/.config/{starship,yazi,kitty,nvim,lazygit,tmux,btop,bat,neofetch,spotify_player} 2>/dev/null || true

# Copy starship config
cp "$SCRIPT_DIR/.config/starship.toml" ~/.config/starship.toml

# Copy yazi configs
cp -r "$SCRIPT_DIR/.config/yazi/"* ~/.config/yazi/

# Copy kitty configs
cp -r "$SCRIPT_DIR/.config/kitty/"* ~/.config/kitty/

# JetBrains Mono Nerd Font
brew install --cask font-jetbrains-mono-nerd-font

# Copy lazygit config
cp "$SCRIPT_DIR/.config/lazygit/config.yml" ~/.config/lazygit/config.yml


if ! command -v mise &> /dev/null; then
    curl https://mise.run | sh
fi

# Set up Git configuration
# log "Setting up Git configuration..."
git config --global init.defaultBranch main
git config --global pull.rebase false

mkdir -p ~/.zsh/completions

#  Catppuccin themes for other stuff
# log "Installing Catppuccin themes..."

mkdir -p ~/.config/bat/themes
if [ ! -f ~/.config/bat/themes/Catppuccin-macchiato.tmTheme ]; then
    curl -s https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-macchiato.tmTheme > ~/.config/bat/themes/Catppuccin-macchiato.tmTheme
    bat cache --build
fi

mkdir -p ~/.config/kitty/themes/catppuccin
if [ ! -f ~/.config/kitty/themes/catppuccin/macchiato.conf ]; then
    curl -s https://raw.githubusercontent.com/catppuccin/kitty/main/macchiato.conf > ~/.config/kitty/themes/catppuccin/macchiato.conf
fi

# Copy neofetch config
if [ ! -f ~/.config/neofetch/config.conf ]; then
    cp "$SCRIPT_DIR/.config/neofetch/config.conf" ~/.config/neofetch/config.conf
else
    echo "$(cat "$SCRIPT_DIR/.config/neofetch/config.conf")" >> ~/.config/neofetch/config.conf
fi



source ~/.zshrc 2>/dev/null || true

if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/local/bin/zsh" ] && [ "$SHELL" != "/opt/homebrew/bin/zsh" ]; then
    log "Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

echo ""
echo ""
echo "Please restart your terminal or run: source ~/.zshrc"
echo ""
