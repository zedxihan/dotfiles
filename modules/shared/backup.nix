{
  config,
  lib,
  pkgs,
  ...
}:

let
  enabledFiles = lib.filterAttrs (_: v: v.enable) config.home.file;
  paths = lib.mapAttrsToList (name: v: v.target or name) enabledFiles;

  backupCustomFiles = pkgs.writers.writeNu "backup-custom-files" ''
    for target in ('${builtins.toJSON paths}' | from json) {
      let file = ($env.HOME | path join $target)
      let type = (try { $file | path type } catch { null })
      let nix_link = $type == "symlink" and ((try { $file | path expand -s } catch { "" }) | str contains "/nix/store")

      if ($type != null and (not $nix_link)) {
        print $"Nix: Backing up existing manual file/link ~/($target) to ~/($target).bak"
        rm -rf $"($file).bak"
        mv $file $"($file).bak"
      }
    }
  '';
in
{
  home.activation.backupCustomFiles = lib.hm.dag.entryBefore [ "checkLinkTargets" ] (
    "${backupCustomFiles}"
  );
}
