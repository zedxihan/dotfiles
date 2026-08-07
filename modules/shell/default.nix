{
  config,
  ...
}:

{
  imports = [
    ./starship.nix
  ];

  # Symlink dotfiles repo
  home.file.".dotfiles".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/GitHub/dotfiles";

  # --- Nushell ---
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
  };

  # --- Shell Aliases ---
  home.shellAliases = {
    bun = "sfw bun";
    cat = "bat";
    find = "fd";
    ls = "eza --icons";
    ll = "eza -l --icons";
    la = "eza -la --icons";
    q = "qs -c ii";
    dots = "just -f ~/GitHub/dotfiles/justfile";
  };

  programs.eza = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    icons = "auto";
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };

  programs.fzf = {
    enable = true;
    # enableNushellIntegration = true;
    enableFishIntegration = true;
  };

  home.sessionVariables = {
    CARAPACE_BRIDGES = "zsh,fish,bash";
    CARAPACE_MATCH = "1";
    ANDROID_HOME = "$HOME/.android-sdk";
    ANDROID_SDK_ROOT = "$HOME/.android-sdk";

  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
