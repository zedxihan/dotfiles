{ pkgs, lib, ... }:

{
  # Linux packages
  home.packages = with pkgs; [
  ];

  # --- Fish ---
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting "" # Disable the welcome message
    '';
  };

  # Backup existing Fish config
  home.activation.backupFish = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    if [ -f "$HOME/.config/fish/config.fish" ] && [ ! -L "$HOME/.config/fish/config.fish" ]; then
      echo "Nix: Backing up existing Fish configuration to ~/.config/fish/config.fish.bak"
      rm -f "$HOME/.config/fish/config.fish.bak"
      mv "$HOME/.config/fish/config.fish" "$HOME/.config/fish/config.fish.bak"
    fi
  '';
}
