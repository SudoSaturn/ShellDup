# Complete Development Environment Setup

## 🚀 One-Command Installation

Install everything (kitty terminal + full environment) with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/sudosaturn/ShellDup/main/install-all.sh | bash
```

## What Gets Installed

### Part 1: kitty Terminal
- Custom-built kitty terminal from source
- Installed to `/Applications/kitty.app`
- Includes all themes and configurations

### Part 2: Development Environment
- **Shell**: zsh with Oh My Zsh
- **Prompt**: Starship (with custom theme)
- **Terminal Tools**:
  - `yazi` - Modern file manager
  - `ranger` - Terminal file manager
  - `lazygit` - Git TUI
  - `lazydocker` - Docker TUI
  - `btop` - System monitor
  - `neofetch` - System info
  
- **Development Tools**:
  - Node.js, pnpm, bun
  - Python, pipx
  - Rust, cargo
  - Go
  - PHP, composer
  - Lua, luarocks
  - mise (version manager)

- **Utilities**:
  - `eza` - Modern ls replacement
  - `bat` - Cat with syntax highlighting
  - `ripgrep` - Fast grep
  - `fd` - Fast find
  - `fzf` - Fuzzy finder
  - `zoxide` - Smart cd
  - `dust` - Disk usage
  - `jq`, `jc` - JSON tools
  - And many more...

## Requirements

- **macOS**: 11.0 or later
- **Xcode Command Line Tools**: Install with `xcode-select --install`
- **Go**: Download from [go.dev/dl](https://go.dev/dl/)
- **Internet connection**
- **Disk space**: ~500 MB temporary (cleaned up after install)
- **Time**: 10-15 minutes

## What Happens During Installation

1. ✅ Prompts for sudo password (needed for /Applications install and Homebrew)
2. ✅ Checks prerequisites (git, go)
3. ✅ Clones kitty repository
4. ✅ Builds kitty from source
5. ✅ Installs documentation
6. ✅ Creates app bundle
7. ✅ Installs to /Applications
8. ✅ Clones ShellDup repository
9. ✅ Installs all development tools via Homebrew
10. ✅ Copies all configuration files
11. ✅ Sets up shell environment
12. ✅ Cleans up temporary files

## Customization

You can customize the installation by setting environment variables:

```bash
# Use a different kitty repository
export CUSTOM_KITTY_REPO="https://github.com/YOUR_USERNAME/kitty.git"
export CUSTOM_KITTY_BRANCH="your-branch"

# Use a different ShellDup repository
export CUSTOM_SHELLDUP_REPO="https://github.com/YOUR_USERNAME/ShellDup.git"
export CUSTOM_SHELLDUP_BRANCH="your-branch"

# Then run the installer
curl -fsSL https://raw.githubusercontent.com/sudosaturn/ShellDup/main/install-all.sh | bash
```

## After Installation

1. **Launch kitty**:
   - Open from Applications folder
   - Or run: `open -a kitty`
   - Or use Spotlight: `⌘+Space` → type "kitty"

2. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

3. **Verify installation**:
   ```bash
   # Check kitty version
   /Applications/kitty.app/Contents/MacOS/kitty --version
   
   # Check installed tools
   starship --version
   eza --version
   bat --version
   ```

## Configuration Files

All configuration files are copied from the `.config` directory:

- `~/.zshrc` - Shell configuration
- `~/.config/starship.toml` - Starship prompt
- `~/.config/kitty/` - kitty terminal settings
- `~/.config/yazi/` - Yazi file manager
- `~/.config/lazygit/` - Lazygit settings
- `~/.config/neofetch/` - Neofetch configuration

## Troubleshooting

### "git not found"
Install Xcode Command Line Tools:
```bash
xcode-select --install
```

### "go not found"
Download and install Go from: https://go.dev/dl/

### Permission denied during install
The script will prompt for your sudo password at the very beginning. This is needed to:

- Install kitty to `/Applications`
- Run Homebrew installations
- The password is requested upfront so you don't have to wait through the build process

### Build fails
Make sure you have:
- Latest Xcode Command Line Tools
- Go 1.20 or later
- Stable internet connection

## Manual Installation

If you prefer to run the steps manually:

1. **Install kitty**:
   ```bash
   cd /tmp
   git clone https://github.com/kovidgoyal/kitty.git
   cd kitty
   ./dev.sh build
   ./dev.sh deps --for-docs
   ./dev.sh docs
   # ... (see kitty/install-kitty.sh for full steps)
   ```

2. **Setup environment**:
   ```bash
   git clone https://github.com/sudosaturn/ShellDup.git
   cd ShellDup
   bash setup-duplicate.sh
   ```

## Uninstallation

To remove everything:

```bash
# Remove kitty
sudo rm -rf /Applications/kitty.app

# Remove configurations (backup first!)
rm -rf ~/.config/{kitty,yazi,lazygit,neofetch,starship.toml}
rm ~/.zshrc

# Uninstall Homebrew packages (optional)
brew uninstall starship eza bat yazi lazygit # ... etc
```

## Support

For issues or questions:
- Check the [kitty documentation](https://sw.kovidgoyal.net/kitty/)
- Review configuration files in `.config/`
- Open an issue on GitHub

---

**Note**: This installer is designed for macOS. For other platforms, manual installation is required.
