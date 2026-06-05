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
    ../../modules/shared/packages
    ../../modules/shared/shell
    ../../modules/shared/kitty
    ../../modules/shared/dev
    ../../modules/shared/backup.nix
    ../../modules/darwin
  ];

  programs.home-manager.enable = true;
}
