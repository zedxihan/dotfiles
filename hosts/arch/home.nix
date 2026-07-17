{
  username,
  inputs,
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
    ../../modules/shell
    ../../modules/theme
    ../../modules/wrapNixGL.nix
    ../../modules/zen-browser
    ../../modules/linux
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
