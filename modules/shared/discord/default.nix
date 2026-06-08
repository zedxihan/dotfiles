{
  pkgs,
  lib,
  ...
}:

let
  isLinux = pkgs.stdenv.isLinux;
in
{
  home.packages = lib.mkIf isLinux [
    pkgs.equibop
  ];
}
