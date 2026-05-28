{ pkgs, ... }:

{
  imports = [
  ];

  # Linux packages
  home.packages = with pkgs; [
  ];

  # --- Fish ---
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting "" # Disable the welcome message
    '';
  };

}
