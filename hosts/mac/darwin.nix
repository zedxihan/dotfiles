{ pkgs, macUsername, ... }:

{
  # --- System settings ---
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 5;

  # --- macOS defaults ---
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv"; # List view
    };
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
  };

  # --- Primary user ---
  system.primaryUser = macUsername;

  security.pam.services.sudo_local.touchIdAuth = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users.${macUsername}.home = "/Users/${macUsername}";

  # --- Shells ---
  programs.zsh.enable = true;
}
