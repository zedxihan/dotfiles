{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aria2
    btop
    curl
    fastfetch
    fd
    jq
    nix-tree
    ripgrep
    sd
    tldr
    unzip
    wget
    xdg-utils
    xh
    yt-dlp
  ];
}
