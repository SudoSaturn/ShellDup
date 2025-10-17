# Quick Install Summary

## One-Command Installation

From your kitty source directory:

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/kitty/YOUR_BRANCH/build-app.sh | bash
```

**That's it!** The script will:
- ✅ Build kitty from source
- ✅ Install all dependencies
- ✅ Build documentation
- ✅ Create the app bundle
- ✅ Install to `/Applications/kitty.app`

## What You'll See

The script shows 7 steps:
1. Building kitty
2. Checking documentation dependencies
3. Setting up sphinx tools
4. Building documentation
5. Checking setup.py for required fixes
6. Building kitty.app bundle
7. Installing to /Applications

## Sudo Password

You may be prompted for your password to:
- Remove existing kitty.app from /Applications (if present)
- Install the new kitty.app to /Applications

This is normal and safe.

## After Installation

Launch kitty:
- **Spotlight**: Press `⌘+Space`, type "kitty"
- **Terminal**: `open -a kitty`
- **Direct**: `/Applications/kitty.app/Contents/MacOS/kitty`

## Example for Your Fork

If your GitHub is `github.com/sudosaturn/kitty` on the `main` branch:

```bash
cd ~/kitty
curl -fsSL https://raw.githubusercontent.com/sudosaturn/kitty/main/build-app.sh | bash
```

## Time Required

- **First run**: ~5-10 minutes (downloads dependencies, builds docs)
- **Subsequent runs**: ~2-3 minutes (dependencies cached)

## Requirements

- macOS 11.0+
- Xcode Command Line Tools
- Internet connection
- ~500 MB disk space

---

For more details, see [BUILD_APP.md](BUILD_APP.md)
