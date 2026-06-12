{ pkgs, inputs, ... }:

let
  gl = inputs.nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixGLDefault or null;
  isLinux = pkgs.stdenv.isLinux;

  wrap =
    {
      pkg,
      env ? { },
    }:
    if pkg == null then
      null
    else if isLinux && gl != null then
      inputs.nix-wrapper-modules.lib.wrapPackage {
        inherit pkgs env;
        package = pkg;
        argv0type = cmd: "${gl}/bin/nixGL ${cmd}";
      }
    else
      pkg;
in
{
  _module.args.wrapGPU = wrap;
}
