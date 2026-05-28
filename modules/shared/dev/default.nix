{ pkgs, ... }:

let
  runix = pkgs.writeShellScriptBin "runix" ''
    export NIXPKGS_ALLOW_UNFREE=1
    export NIXPKGS_ALLOW_BROKEN=1
    exec nix run --impure "''${@/#/nixpkgs#}"
  '';
in
{
  imports = [
    ./git
  ];

  # --- Direnv ---
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  # --- Dev Tools ---
  home.packages = with pkgs; [
    bun
    gh
    lazygit
    neovim
    vscodium
    uv
    just
    nix-tree
    curl
    gcc
    gnumake
    sd
    unzip
    xh
    runix
  ];
}
