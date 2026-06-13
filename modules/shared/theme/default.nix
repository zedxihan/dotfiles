{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mapAttrs
    mapAttrs'
    nameValuePair
    optional
    ;
  inherit (pkgs.stdenv) isDarwin;

  templates = {
    kitty = {
      src = ./templates/kitty-colors.conf;
      out = "${config.xdg.configHome}/kitty/matugen-theme.conf";
    };
    equibop = {
      src = ./templates/midnight-discord.css;
      out = "${config.xdg.configHome}/equibop/settings/quickCss.css";
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

  matugenTemplates = mapAttrs (name: cfg: {
    input_path = "${config.xdg.configHome}/matugen/templates/${baseNameOf cfg.src}";
    output_path = cfg.out;
  }) templates;
in
{
  # Shared config
  home.packages = [ matugen-reload ] ++ optional isDarwin pkgs.matugen;

  xdg.configFile = (
    mapAttrs' (
      name: cfg: nameValuePair "matugen/templates/${baseNameOf cfg.src}" { source = cfg.src; }
    ) templates
  );

  home.activation.setupMatugenTheme = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    ${pkgs.nushell}/bin/nu -c '
      let conf = "${config.xdg.configHome}/matugen/config.toml"
      if ($conf | path exists) {
        let new = ${builtins.toJSON matugenTemplates}
        open $conf | upsert templates {|i| ($i.templates? | default {}) | merge $new } | save -f $conf
      }
      ^${matugen-reload}/bin/matugen-reload
    '
  '';

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
