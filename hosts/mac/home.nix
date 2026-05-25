{
  config,
  pkgs,
  macUsername,
  ...
}:

{
  home.stateVersion = "25.05";
  home.username = macUsername;
  home.homeDirectory = "/Users/${macUsername}";

  # --- Modules ---
  imports = [
    ../../modules/shared/packages.nix
    ../../modules/shared/shell.nix
    ../../modules/shared/kitty.nix
    ../../modules/shared/dev.nix
    ../../modules/darwin
  ];

  programs.home-manager.enable = true;
}
