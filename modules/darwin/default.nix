{ pkgs, ... }:

{
  # macOS-only settings, packages, or system preferences
  home.packages = with pkgs; [
    # macOS-only packages here
  ];
}
