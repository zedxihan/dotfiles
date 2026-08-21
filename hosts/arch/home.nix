{
  username,
  inputs,
  lib,
  ...
}:

{
  home.stateVersion = "25.05";
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # --- Modules ---
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ../../modules/backup.nix
    ../../modules/dev
    ../../modules/discord
    ../../modules/kitty
    ../../modules/packages
    ../../modules/qbittorrent
    ../../modules/scripts
    ../../modules/shell
    ../../modules/theme
    ../../modules/wrapNixGL.nix
    ../../modules/zen-browser
    ../../modules/linux
  ]
  ++ lib.optional (builtins.pathExists ../local.nix) ../local.nix;

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
