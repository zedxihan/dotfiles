{ pkgs, ... }:

{
  # --- Universal CLI Utils ---
  home.packages = with pkgs; [
    ripgrep
    fd
    btop
    jq
    tldr
    fastfetch
    aria2
    wget
    yt-dlp
    xdg-utils
    comma
  ];
}
