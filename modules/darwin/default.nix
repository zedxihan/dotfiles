{ pkgs, ... }:

{
  imports = [
    ./system.nix
  ];

  environment.systemPackages = with pkgs; [
    # macOS-only packages here
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

  # --- Shells ---
  programs.zsh.enable = true;
}
