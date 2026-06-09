{
  pkgs,
  lib,
  wrapGPU,
  ...
}:

let
  isLinux = pkgs.stdenv.isLinux;
  equibop-wrapped = wrapGPU pkgs.equibop {
    SPEECHD_ADDRESS = "none";
    NIXOS_SPEECH = "False";
  };
in
{
  home.packages = lib.mkIf isLinux [
    equibop-wrapped
  ];

  # # Core behavior
  # xdg.configFile."equibop/settings.json".text = builtins.toJSON {
  #   discordBranch = "stable";
  #   minimizeToTray = false;
  #   tray = true;
  #   hardwareAcceleration = true;
  #   arRPC = true;
  #   splashTheming = true;
  # };

  # Plugin settings
  xdg.configFile."equibop/settings/settings.json".text = builtins.toJSON {
    useQuickCss = true;
    plugins = {
      AnonymiseFileNames.enabled = true;
      BlurNSFW.enabled = true;
      ClearURLs.enabled = true;
      FakeNitro.enabled = true;
      MessageLinkEmbeds.enabled = true;
      MessageLogger.enabled = true;
      PermissionsViewer.enabled = true;
      PlatformIndicators.enabled = true;
      PreviewMessage.enabled = true;
      QuickReply.enabled = true;
      ShowHiddenChannels.enabled = true;
      SilentTyping.enabled = true;
      ViewIcons.enabled = true;
      YoutubeAdblock.enabled = true;
      MessageBurst.enabled = true;
      MessageLoggerEnhanced.enabled = true;
      MusicControls.enabled = true;
      NoTrack.enabled = true;
      # Auto-added plugins
      Settings.enabled = true;
      SupportHelper.enabled = true;
      WebContextMenus.enabled = true;
    };
  };
}
