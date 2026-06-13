{
  linuxUsername,
  inputs,
  ...
}:

{
  home.stateVersion = "25.05";
  home.username = linuxUsername;
  home.homeDirectory = "/home/${linuxUsername}";

  # --- Modules ---
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ../../modules/shared/backup.nix
    ../../modules/shared/dev
    ../../modules/shared/discord
    ../../modules/shared/kitty
    ../../modules/shared/packages
    ../../modules/shared/shell
    ../../modules/shared/theme
    ../../modules/shared/wrapGPU.nix
    ../../modules/shared/zen-browser
    ../../modules/linux
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
