{ config, lib, ... }:

let
  # Filter only enabled files
  enabledFiles = lib.filterAttrs (_: v: v.enable) config.home.file;

  # Get target paths relative to $HOME
  paths = lib.mapAttrsToList (_: v: v.target) enabledFiles;

  backupScript = path: ''
    if [ -e "$HOME/${path}" ] || [ -L "$HOME/${path}" ]; then
      if [ ! -L "$HOME/${path}" 2>/dev/null ] || [[ ! "$(readlink "$HOME/${path}")" =~ /nix/store ]]; then
        echo "Nix: Backing up existing manual file/link ~/${path} to ~/${path}.bak"
        rm -rf "$HOME/${path}.bak"
        mv "$HOME/${path}" "$HOME/${path}.bak"
      fi
    fi
  '';
in
{
  home.activation.backupCustomFiles = lib.hm.dag.entryBefore [ "checkLinkTargets" ] (
    lib.concatStringsSep "\n" (map backupScript paths)
  );
}
