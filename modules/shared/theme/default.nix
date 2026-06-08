{
  config,
  lib,
  pkgs,
  ...
}:

let
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

  matugenTemplates = lib.mapAttrs (name: cfg: {
    input_path = "${config.xdg.configHome}/matugen/templates/${baseNameOf cfg.src}";
    output_path = cfg.out;
  }) templates;

  # Smart reload: only applies if wallpaper is found
  matugen-reload = pkgs.writers.writeNuBin "matugen-reload" ''
    let img = if $nu.os-info.name == "macos" {
      try { osascript -e 'tell app "Finder" to get POSIX path of (desktop picture as alias)' | str trim } catch { "" }
    } else {
      let path = ($env.PATH? | default "" | split row (char esep) | append ["/usr/bin" "/bin"] | uniq)
      with-env { PATH: $path } {
        try { swww query | lines | first | split row "image: " | last | str trim } catch { "" }
      }
    }
    if ($img != "" and ($img | path exists)) {
      ^${pkgs.matugen}/bin/matugen image $img -m dark -q
    }
  '';
in
{
  config = lib.mkMerge [
    # --- SHARED ---
    {
      home.packages = [ matugen-reload ];
      xdg.configFile = lib.mapAttrs' (
        name: cfg: lib.nameValuePair "matugen/templates/${baseNameOf cfg.src}" { source = cfg.src; }
      ) templates;
    }

    # --- LINUX ---
    (lib.mkIf pkgs.stdenv.isLinux {
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
    })

    # --- MAC ---
    (lib.mkIf pkgs.stdenv.isDarwin {
      home.packages = [ pkgs.matugen ];

      xdg.configFile."matugen/config.toml".text = (lib.generators.toTOML { }) {
        config.version_check = false;
        templates = matugenTemplates;
      };

      home.activation.setupMatugenTheme = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        ${matugen-reload}/bin/matugen-reload
      '';

      # Auto-reload when wallpaper changes
      launchd.agents.matugen-wallpaper-watcher = {
        enable = true;
        config = {
          ProgramArguments = [ "${matugen-reload}/bin/matugen-reload" ];
          WatchPaths = [ "${config.home.homeDirectory}/Library/Application Support/Dock/desktoppicture.db" ];
          RunAtLoad = true;
        };
      };
    })
  ];
}
