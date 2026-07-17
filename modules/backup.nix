{
  config,
  lib,
  pkgs,
  ...
}:

let
  managed = lib.mapAttrsToList (n: v: {
    target = "${config.home.homeDirectory}/${v.target or n}";
    source = toString v.source;
  }) (lib.filterAttrs (_: v: v.enable) config.home.file);

  backupScript = pkgs.writers.writeNu "backup-custom-files" ''
    '${builtins.toJSON managed}'
    | from json
    | where { $in.target | path exists }
    | where {|row|
        let phys = ($row.target | path expand)
        (not ($phys | str contains "/nix/store")) and (not ($phys | str contains "/GitHub/dotfiles"))
      }
    | each {
        print $"Nix: Backing up manual drift -> ($in.target).bak"
        rm -rf $"($in.target).bak"
        mv $in.target $"($in.target).bak"
      }
    | ignore
  '';
in
{
  home.activation.backupCustomFiles = lib.hm.dag.entryBefore [ "checkLinkTargets" ] "${backupScript}";
}
