# Install kitty Terminal - One Command

## 🚀 Quick Install (No Prerequisites)

Run this single command from **anywhere** (no need to clone or cd):

```bash
curl -fsSL https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/install-kitty.sh | bash
```

**Replace:**
- `USERNAME` with your GitHub username
- `REPO` with your repository name  
- `BRANCH` with your branch name

### Example

For the official kitty repo:
```bash
curl -fsSL https://raw.githubusercontent.com/kovidgoyal/kitty/master/install-kitty.sh | bash
```

For your fork (e.g., `github.com/sudosaturn/kitty` on `main` branch):
```bash
curl -fsSL https://raw.githubusercontent.com/sudosaturn/kitty/main/install-kitty.sh | bash
```

## What Happens

The script will automatically:

1. ✅ Clone the kitty repository to `/tmp/kitty-build-XXXXX`
2. ✅ Build kitty from source
3. ✅ Install all dependencies
4. ✅ Build documentation
5. ✅ Create the app bundle
6. ✅ Install to `/Applications/kitty.app`
7. ✅ Clean up temporary files

**Total time:** 5-10 minutes on first run

## Requirements

- macOS 11.0 or later
- Xcode Command Line Tools (install with: `xcode-select --install`)
- Go programming language ([download here](https://go.dev/dl/))
- Internet connection
- ~500 MB temporary disk space

## Sudo Password

You may be prompted for your password to install to `/Applications`. This is normal and safe.

## After Installation

### Launch kitty

**From Spotlight:**
- Press `⌘+Space`
- Type "kitty"
- Press Enter

**From Terminal:**
```bash
open -a kitty
```

**Direct execution:**
```bash
/Applications/kitty.app/Contents/MacOS/kitty
```

## Customization

You can customize the installation by setting environment variables:

```bash
# Install from a different repository
KITTY_REPO_URL="https://github.com/yourusername/kitty.git" \
KITTY_BRANCH="your-branch" \
curl -fsSL https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/install-kitty.sh | bash
```

## For Developers

If you already have the kitty source code and want to build locally, use `build-app.sh` instead:

```bash
cd /path/to/kitty
./build-app.sh
```

See [BUILD_APP.md](BUILD_APP.md) for details.

## Troubleshooting

### "git: command not found"
Install Xcode Command Line Tools:
```bash
xcode-select --install
```

### "go: command not found"
Install Go from: https://go.dev/dl/

### "Permission denied"
The script will automatically request sudo when needed. Enter your password when prompted.

### Build fails
Check that you have:
- Stable internet connection
- At least 500 MB free disk space
- macOS 11.0 or later

### Already installed
The script will automatically remove the old version before installing the new one.

## Security Note

Always review scripts before piping to bash. You can inspect the script at:
```
https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/install-kitty.sh
```

Or download and review first:
```bash
curl -fsSL https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/install-kitty.sh -o install-kitty.sh
cat install-kitty.sh  # Review the script
chmod +x install-kitty.sh
./install-kitty.sh
```

## What Gets Installed

- **Location:** `/Applications/kitty.app`
- **Size:** ~57 MB
- **Type:** Standard macOS application bundle
- **Cleanup:** All temporary build files are automatically removed

## Uninstall

To remove kitty:
```bash
rm -rf /Applications/kitty.app
```

---

## Comparison: Two Installation Methods

### Method 1: One-Command Install (This Method)
```bash
curl -fsSL https://raw.githubusercontent.com/.../install-kitty.sh | bash
```
- ✅ No need to clone repository
- ✅ No need to cd anywhere
- ✅ Automatic cleanup
- ✅ Run from anywhere
- ⏱️ 5-10 minutes

### Method 2: Local Build (For Developers)
```bash
git clone https://github.com/kovidgoyal/kitty.git
cd kitty
./build-app.sh
```
- ✅ Keep source code
- ✅ Make modifications
- ✅ Faster rebuilds
- ⏱️ 5-10 minutes first time, 2-3 minutes after

---

**Enjoy your new kitty terminal!** 🐱
