{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) getExe optional;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;

  templates = pkgs.writers.writeJSON "matugen-templates" {
    kitty = {
      input_path = ./templates/kitty-colors.conf;
      output_path = "${config.xdg.configHome}/kitty/matugen-theme.conf";
    };
    equibop = {
      input_path = ./templates/midnight-discord.css;
      output_path = "${config.xdg.configHome}/equibop/settings/quickCss.css";
    };
  };

  # Matugen reload
  matugen-reload = pkgs.writers.writeNuBin "matugen-reload" ''
    let img = if $nu.os-info.name == "macos" {
      try { osascript -e 'tell app "Finder" to get POSIX path of (desktop picture as alias)' | str trim } catch { "" }
    } else {
      try { swww query | lines | first | split row "image: " | last | str trim } catch { "" }
    }
    if ($img != "" and ($img | path exists)) {
      ^${pkgs.matugen}/bin/matugen image $img -m dark -t tonal-spot -q
    }
  '';
in
{
  # Shared config
  home.packages = [ matugen-reload ] ++ optional isDarwin pkgs.matugen;

  home.activation.setupMatugenTheme =
    let
      script = pkgs.writers.writeNu "activation" /* nu */ ''
        let conf = "${config.xdg.configHome}/matugen/config.toml"
        if ($conf | path exists) {
          let new = open "${templates}" | from json
          open $conf | upsert templates {|i| ($i.templates? | default {}) | merge $new } | save -f $conf
        }
        ${getExe matugen-reload}
      '';
    in
    lib.hm.dag.entryAfter [ "linkGeneration" ] "${script}";

  # macOS only
  launchd.agents.matugen-wallpaper-watcher = lib.mkIf isDarwin {
    enable = true;
    config = {
      ProgramArguments = [ "${matugen-reload}/bin/matugen-reload" ];
      WatchPaths = [ "${config.home.homeDirectory}/Library/Application Support/Dock/desktoppicture.db" ];
      RunAtLoad = true;
    };
  };
}
