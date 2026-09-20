{ pkgs, ... }:
{
  services.flatpak.packages = [
    "com.google.AndroidStudio"
  ];

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
