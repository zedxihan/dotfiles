{ pkgs, ... }:

{
  imports = [
    ./system.nix
  ];

  # --- Homebrew ---
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "equibop"
      "spotify"
    ];
  };

  # --- System Packages ---
  environment.systemPackages = with pkgs; [
  ];

  # --- Shells ---
  programs.zsh.enable = true;
}
