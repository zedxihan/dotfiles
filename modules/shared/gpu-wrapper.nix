{ pkgs, inputs, ... }:

let
  gl = inputs.nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixGLDefault or null;
  wrap =
    pkg: env:
    (
      if pkgs.stdenv.isLinux && gl != null then
        pkgs.symlinkJoin {
          name = "${pkg.pname or pkg.name}-gl";
          paths = [ pkg ];
          postBuild = "ln -sf ${pkgs.writeShellScript "gl-wrap" ''
            ${pkgs.lib.concatStrings (pkgs.lib.mapAttrsToList (k: v: "export ${k}='${v}'\n") env)}
            exec ${gl}/bin/nixGL ${pkg}/bin/$(basename "$0") "$@"
          ''} $out/bin/*";
        }
      else
        pkg
    )
    // pkgs.lib.optionalAttrs (pkg ? override) {
      override = a: wrap (pkg.override a) env;
    };
in
{
  _module.args.wrapGPU = wrap;
}
