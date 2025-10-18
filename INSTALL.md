# This Is My Humble Terminal Setup

## Install everything with a single command

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

### Permission denied during install

The script will prompt for your sudo password at the very beginning. This is needed to:

- Install kitty to `/Applications`
- Run Homebrew installations
- The password is requested upfront so you don't have to wait through the build process

### Build fails

Make sure you have:

- Latest Xcode Command Line Tools
- Stable internet connection

## Support

For issues or questions:

- Check the [kitty documentation](https://sw.kovidgoyal.net/kitty/)
- Review configuration files in `.config/`
- Open an issue on GitHub

---

**Note**: This installer is designed for macOS only.
