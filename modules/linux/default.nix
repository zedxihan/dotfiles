{ ... }:

{
  imports = [
    ./hyprland.nix
  ];

  # --- Flatpak ---
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    uninstallUnused = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.spotify.Client"
      "org.qbittorrent.qBittorrent"
    ];
    update.onActivation = true;
  };

  # --- Fish ---
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting "" # Disable the welcome message
    '';
  };
}
