{ pkgs, lib, ... }:

{
  imports = [
    ./tools.nix
  ];

  # --- SSH Key Auto-Generation ---
  home.activation.createSshKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
      echo "Nix: Auto-generating SSH key..."
      mkdir -p "$HOME/.ssh"
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519" -C "dev@gaffarmahmud.com"
    fi
  '';

  # --- SSH Client ---
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        ServerAliveInterval = 60;
      };
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  # --- Git Setup ---
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Gaffar Mahmud";
        email = "dev@gaffarmahmud.com";
        signingkey = "~/.ssh/id_ed25519.pub";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.gpgsign = true;
      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };

  # --- Direnv ---
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
