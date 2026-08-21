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
    ./bun
    ./git
    ./studio
    ./zed
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  home.packages = with pkgs; [
    gcc
    gh
    gnumake
    just
    lazygit
    nixd
    nixfmt
    runix
    uv
    vscodium
  ];
}
