{ pkgs, ... }:

{
  # --- Dev Tools ---
  home.packages = with pkgs; [
    bun
    gh
    lazygit
    uv
    just
    nix-tree
    nix-update
    curl
    gcc
    gnumake
    sd
    unzip
    xh
  ];
}
