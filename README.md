# ❄️ Installation Guide: Portable Nix Dotfiles

> [!IMPORTANT]  
> This is my **Nix-managed** configuration, designed to be layered on top of existing systems. **Read this entire guide before running any commands.**

---

## 🛑 Step 0: Mandatory Prerequisites

### 🐧 For Linux (Arch Linux)
1.  **Arch Linux** must be installed.
2.  **[end-4/dots-hyprland (ii)](https://github.com/end-4/dots-hyprland)** **MUST** be installed and fully functional.
    - This flake manages files in `~/.config/hypr/custom/`. If you have manual changes there, they will be moved to `.bak`.
3.  **Nix** must be installed (see Step 1).

### 🍎 For macOS
1.  **[Homebrew](https://brew.sh)** must be installed.
2.  **Nix** must be installed (see Step 1).

---

> [!WARNING]  
> **Backup your files!** Before running the installation, you should manually backup any critical configurations. While this flake includes an automatic backup script that renames conflicting files to `<filename>.bak`, it is safer to do it yourself first.

---

## ❄️ Step 1: Install & Configure Nix

If you don't have Nix installed, use the [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer) (recommended for both Arch and Mac):

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

### Enable Flakes
Ensure your Nix configuration allows Flakes. Edit (or create) `/etc/nix/nix.conf` or `~/.config/nix/nix.conf`:

```conf
experimental-features = nix-command flakes
```

---

## 📂 Step 2: Clone & Configure

> [!IMPORTANT]  
> The configuration expects the repository to be located at `~/GitHub/dotfiles`. This path is used for certain symlinks and internal logic.

1.  **Clone the repository**:
    ```bash
    mkdir -p ~/GitHub && cd ~/GitHub
    git clone https://github.com/zedxihan/dotfiles.git
    cd dotfiles
    ```

2.  **⚠️ IMPORTANT: Set your Username**  
    The configuration has hardcoded usernames. You **MUST** change them to match your system username before installing, or the activation will fail.

    Check your current username:
    ```bash
    whoami
    ```

    Open `flake.nix` and update these lines:
    ```nix
    let
      linuxUsername = "your-username-here";
      macUsername = "your-username-here";
    in
    ```

---

## 🚀 Step 3: Installation

Run the command corresponding to your operating system:

**Linux (Arch):**
```bash
home-manager switch --flake .#arch-setup --impure
```

**macOS:**
```bash
darwin-rebuild switch --flake .#mac-setup
```

---

## 💡 Usage & Maintenance

### 🛠️ Maintenance
You can manage your configuration from anywhere using the `dots` command:

```bash
dots update  # Syncs your latest Nix configuration
dots clean   # Removes old Nix generations to free up space
dots         # Lists all available maintenance commands
```

### ⌨️ Keybinds & Shortcuts
- **Linux (Hyprland)**: Custom keybinds are managed in `modules/linux/default.nix`.
- **Global Editing**: Use the `CTRL + SUPER + ALT + /` shortcut to open your configuration directly in Zed.
