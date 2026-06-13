{
  pkgs,
  lib,
  config,
  wrapGPU,
  ...
}:

let
  inherit (pkgs.stdenv) isLinux;

  baseSettings = {
    discordBranch = "stable";
    minimizeToTray = false;
    tray = true;
    hardwareAcceleration = true;
    arRPC = true;
    splashTheming = true;
    autoUpdate = true;
  };

  equibop-wrapped = wrapGPU {
    pkg = pkgs.equibop;
    env = {
      SPEECHD_ADDRESS = "none";
      NIXOS_SPEECH = "False";
    };
  };
in
{
  home.packages = lib.mkIf isLinux [
    equibop-wrapped
  ];

  # Plugin settings
  xdg.configFile."equibop/settings/settings.json".text = builtins.toJSON {
    useQuickCss = true;
    plugins = {
      AnonymiseFileNames.enabled = true;
      BlurNSFW.enabled = true;
      ClearURLs.enabled = true;
      FakeNitro.enabled = true;
      MessageBurst.enabled = true;
      MessageLinkEmbeds.enabled = true;
      MessageLogger.enabled = true;
      MessageLoggerEnhanced.enabled = true;
      MusicControls.enabled = true;
      NoTrack.enabled = true;
      PermissionsViewer.enabled = true;
      PlatformIndicators.enabled = true;
      PreviewMessage.enabled = true;
      QuickReply.enabled = true;
      ShowHiddenChannels.enabled = true;
      SilentTyping.enabled = true;
      ViewIcons.enabled = true;
      YoutubeAdblock.enabled = true;
      #  Auto-added plugins
      CrashHandler.enabled = true;
      NewPluginsManager.enabled = false;
      WebKeybinds.enabled = true;
    };
  };

  # Merge into writable config
  home.activation.setupEquibop = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.nushell}/bin/nu -c '
      let f = "${config.xdg.configHome}/equibop/settings.json"
      let nix = ${builtins.toJSON baseSettings}
      mkdir ($f | path dirname)
      if ($f | path exists) { open $f | merge $nix } else { $nix } | save -f $f
    '
  '';
}
