{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./starship.nix
  ];

  # Symlink dotfiles repo
  home.file.".dotfiles".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles";

  # --- Nushell ---
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
  };

  # --- Shell Aliases ---
  home.shellAliases = {
    cat = "bat";
    find = "fd";
    ls = "eza --icons";
    ll = "eza -l --icons";
    la = "eza -la --icons";
    update = "just --justfile ~/.dotfiles/justfile update";
    clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
    q = "qs -c ii";

    # Hermes Agent
    hermes = "just --justfile ~/.hermes/justfile";
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
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
  };
}
