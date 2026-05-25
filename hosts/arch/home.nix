{
  config,
  pkgs,
  linuxUsername,
  ...
}:

{
  home.stateVersion = "25.05";
  home.username = linuxUsername;
  home.homeDirectory = "/home/${linuxUsername}";

  # --- Modules ---
  imports = [
    ../../modules/shared/packages.nix
    ../../modules/shared/shell.nix
    ../../modules/shared/kitty.nix
    ../../modules/shared/dev.nix
    ../../modules/linux
  ];

  programs.home-manager.enable = true;
}
