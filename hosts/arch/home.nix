{
  linuxUsername,
  ...
}:

{
  home.stateVersion = "25.05";
  home.username = linuxUsername;
  home.homeDirectory = "/home/${linuxUsername}";

  # --- Modules ---
  imports = [
    ../../modules/shared/packages
    ../../modules/shared/shell
    ../../modules/shared/kitty
    ../../modules/shared/dev
    ../../modules/shared/backup.nix
    ../../modules/shared/zen-browser
    ../../modules/linux
  ];
  programs.home-manager.enable = true;
}
