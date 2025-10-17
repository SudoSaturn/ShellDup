# Quick Install

Install kitty with a single command (no cloning required):

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/kitty/YOUR_BRANCH/install-kitty.sh | bash
```

Replace `YOUR_USERNAME` and `YOUR_BRANCH` with your GitHub details.

**Example:**
```bash
curl -fsSL https://raw.githubusercontent.com/sudosaturn/kitty/main/install-kitty.sh | bash
```

This will automatically:
- Clone the repository
- Build from source
- Install to `/Applications/kitty.app`
- Clean up temporary files

**Requirements:** macOS 11.0+, Xcode Command Line Tools, Go

**Time:** ~5-10 minutes

After installation, launch with: `open -a kitty` or via Spotlight (⌘+Space → "kitty")

---

**For developers:** If you already have the source, use `./build-app.sh` instead.

See [ONE_COMMAND_INSTALL.md](ONE_COMMAND_INSTALL.md) for full documentation.
