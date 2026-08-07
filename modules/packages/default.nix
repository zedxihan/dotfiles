{ pkgs, inputs, ... }:

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
    inputs.memify.packages."${pkgs.stdenv.hostPlatform.system}".memify
  ];
}
