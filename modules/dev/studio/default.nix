{ pkgs, config, ... }:
{
  services.flatpak = {
    packages = [
      "com.google.AndroidStudio"
    ];

    overrides."com.google.AndroidStudio" = {
      Context = {
        devices = [ "kvm" ];
        sockets = [ "x11" ];
      };

      Environment = {
        ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
        ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Android/Sdk";
        QT_QPA_PLATFORM = "xcb";
      };
    };
  };

  home.packages = [
    pkgs.android-tools
  ];

  home.sessionVariables = {
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    # Wayland rendering compatibility in JetBrains IDEs
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home.sessionPath = [
    "$HOME/Android/Sdk/emulator"
  ];
}
