# ❄️ Installation Guide

Nix-managed dotfiles for **Arch Linux** with Hyprland, built on top of [end-4/dots-hyprland (ii)](https://github.com/end-4/dots-hyprland).

---

## 🛑 Prerequisites

- **Arch Linux** installed
- **Flatpak** (`sudo pacman -S flatpak`)
- **[end-4/dots-hyprland (ii)](https://github.com/end-4/dots-hyprland)** installed and functional
- **Nix** with flakes enabled

> [!WARNING]  
> **Back up your files.** The flake has an automatic backup script that renames conflicting files to `<filename>.bak`, but manual backup is safer.

---

## ❄️ Step 1: Install & Configure Nix

If you don't have Nix installed, use the [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer):

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

### Enable Flakes
Ensure your Nix configuration allows Flakes. Edit (or create) `/etc/nix/nix.conf` or `~/.config/nix/nix.conf`:

```conf
experimental-features = nix-command flakes
```

---

## 📂 Step 2: Clone

> [!IMPORTANT]  
> The config expects the repo at `~/GitHub/dotfiles`. This path is used for internal symlinks.

```bash
mkdir -p ~/GitHub && cd ~/GitHub
git clone https://github.com/zedxihan/dotfiles.git
cd dotfiles
```

> Username is auto-detected via `builtins.getEnv "USER"` (requires `--impure`). No editing needed.

---

## 🚀 Step 3: Install

```bash
home-manager switch --flake .#arch-setup --impure
```

---

## 💡 Usage

Once installed, use the `dots` command from anywhere:

```bash
dots update  # Rebuild configuration
dots clean   # Remove old generations, garbage collect
dots         # List all commands
```

Custom Hyprland keybinds: `modules/linux/hyprland.nix` — opened in zed via `CTRL + SUPER + ALT + /`
