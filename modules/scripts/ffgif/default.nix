{ pkgs, lib, ... }:

let
  ffgif = pkgs.writers.writeNuBin "ffgif" /* nu */ ''
    $env.PATH = [ ${
      lib.escapeShellArgs (
        with pkgs;
        map (x: "${x}/bin") [
          ffmpeg
          gum
        ]
      )
    } ]

    ${builtins.readFile ./ffgif.nu}
  '';
in
{
  home.packages = [ ffgif ];
}
