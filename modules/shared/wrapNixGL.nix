{
  pkgs,
  inputs,
  lib,
  ...
}:

let
  inherit (lib) getExe';
  inherit (pkgs.stdenv.hostPlatform) system isLinux;
  nixGL = getExe' inputs.nixgl.packages.${system}.nixGLDefault "nixGL";

  wrapNixGLEnv =
    pkg: env:
    if pkg == null || !isLinux then
      pkg
    else
      inputs.nix-wrapper-modules.lib.wrapPackage {
        inherit pkgs env;
        package = pkg;
        argv0type = cmd: "${nixGL} ${cmd}";
      };

  wrapNixGL = pkg: wrapNixGLEnv pkg { };
in
{
  _module.args = {
    inherit wrapNixGL wrapNixGLEnv;
  };
}
