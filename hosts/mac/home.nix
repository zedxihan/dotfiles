{
  macUsername,
  ...
}:

{
  home.stateVersion = "25.05";
  home.username = macUsername;
  home.homeDirectory = "/Users/${macUsername}";

  # --- Modules ---
  imports = [
    ../../modules/shared/backup.nix
    ../../modules/shared/dev
    ../../modules/shared/discord
    ../../modules/shared/kitty
    ../../modules/shared/packages
    ../../modules/shared/shell
    ../../modules/shared/theme
    ../../modules/shared/zen-browser
    ../../modules/darwin
  ];

  programs.home-manager.enable = true;
}
