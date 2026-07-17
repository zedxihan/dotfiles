{ pkgs, lib, ... }: {
  home = {
    packages = [ pkgs.bun ];
    sessionPath = [ "$HOME/.bun/bin" ];

    file.".bunfig.toml".text = ''
      [install]
      minimumReleaseAge = 604800
      ignoreScripts = true
    '';

    activation.installSocketFirewall = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.bun}/bin/bun install -g --only-missing sfw
    '';
  };

  programs.nushell.extraEnv = ''
    $env.PATH = $env.PATH | append ("~/.bun/bin" | path expand)
  '';
}
