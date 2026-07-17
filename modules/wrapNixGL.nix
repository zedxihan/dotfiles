{
  pkgs,
  inputs,
  lib,
  ...
}:

let
  inherit (lib) getExe';
  inherit (pkgs.stdenv.hostPlatform) system;
  nixGL = getExe' inputs.nixgl.packages.${system}.nixGLDefault "nixGL";

  wrapNixGLEnv =
    env: pkg:
    if pkg == null then pkg
    else
      inputs.nix-wrapper-modules.lib.wrapPackage {
        inherit pkgs env;
        package = pkg;
        argv0type = cmd: "${nixGL} ${cmd}";
      };

  wrapNixGL = wrapNixGLEnv { };
in
{
  _module.args = {
    inherit wrapNixGL wrapNixGLEnv;
  };
}
