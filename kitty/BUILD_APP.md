# Building kitty.app Bundle

This guide explains how to build a macOS application bundle for kitty.

## Quick Start

### Option 1: Using the build script (Recommended)

If you've cloned the repository:

```bash
./build-app.sh
```

### Option 2: One-line remote execution

From your kitty source directory, run:

```bash
curl -fsSL https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/build-app.sh | bash
```

**Replace:**
- `USERNAME` with your GitHub username (e.g., `kovidgoyal`)
- `REPO` with your repository name (e.g., `kitty`)
- `BRANCH` with your branch name (e.g., `master` or `main`)

**Example:**
```bash
# If hosted at github.com/kovidgoyal/kitty on master branch:
curl -fsSL https://raw.githubusercontent.com/kovidgoyal/kitty/master/build-app.sh | bash
```

### Option 3: Download and run

```bash
curl -fsSL https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/build-app.sh -o build-app.sh
chmod +x build-app.sh
./build-app.sh
```

## Prerequisites

- macOS 11.0 or later
- Xcode Command Line Tools
- Go (for building)
- Internet connection (for downloading dependencies)

## What the script does

1. **Builds kitty** - Compiles the source code
2. **Installs documentation dependencies** - Downloads Sphinx and related tools
3. **Sets up Sphinx tools** - Creates necessary symlinks
4. **Builds documentation** - Generates man pages and HTML docs
5. **Applies fixes** - Patches setup.py if needed
6. **Creates kitty.app** - Builds the final application bundle
7. **Installs to /Applications** - Automatically moves the app to /Applications

## Output

After successful completion, you'll have:

- **Location**: `/Applications/kitty.app`
- **Size**: ~57 MB
- **Structure**: Standard macOS app bundle
- **Ready to use**: Launch from Spotlight or Applications folder

## Usage after installation

### Open the app

```bash
open -a kitty
```

### Launch from Spotlight

Press `⌘+Space`, type "kitty", and press Enter

### Run from terminal

```bash
/Applications/kitty.app/Contents/MacOS/kitty
```

## Troubleshooting

### "command not found: dev.sh"
Make sure you're in the kitty source directory:
```bash
cd /path/to/kitty
```

### "sphinx-build: command not found"
The script will automatically install documentation dependencies. If it fails, run manually:
```bash
./dev.sh deps --for-docs
```

### Build fails with "File exists" error
The script includes a fix for this. If it still fails, try:
```bash
rm -rf kitty.app
./build-app.sh
```

### Permission denied
Make sure the script is executable:
```bash
chmod +x build-app.sh
```

### "Need sudo to install to /Applications"
The script will automatically request sudo permissions if needed to:
- Remove an existing kitty.app from /Applications
- Move the new kitty.app to /Applications

This is normal and safe. You'll be prompted for your password.

## Manual Build Process

If you prefer to build manually:

```bash
# 1. Build kitty
./dev.sh build

# 2. Install doc dependencies
./dev.sh deps --for-docs

# 3. Setup sphinx
mkdir -p dependencies/darwin-arm64/bin
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-build dependencies/darwin-arm64/bin/sphinx-build
ln -sf ../python/Python.framework/Versions/3.12/bin/sphinx-autobuild dependencies/darwin-arm64/bin/sphinx-autobuild

# 4. Build docs
./dev.sh docs

# 5. Build app bundle
DEVELOP_ROOT="$(pwd)/dependencies/darwin-arm64" \
PKG_CONFIG_PATH="$(pwd)/dependencies/darwin-arm64/lib/pkgconfig" \
PKGCONFIG_EXE="$(pwd)/dependencies/darwin-arm64/bin/pkg-config" \
./dependencies/darwin-arm64/python/Python.framework/Versions/Current/bin/python3 \
setup.py kitty.app
```

## For Your Fork

If you're hosting this on your own GitHub fork, update the curl command in your README:

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/kitty/YOUR_BRANCH/build-app.sh | bash
```

## Notes

- The build process takes several minutes on first run
- Subsequent builds are faster as dependencies are cached
- The script creates a backup of `setup.py` as `setup.py.backup`
- All dependencies are stored in `dependencies/darwin-arm64/`

## License

This build script follows the same license as kitty (GPLv3).
