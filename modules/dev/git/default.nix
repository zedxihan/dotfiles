{ pkgs, lib, ... }:

let
  git-copy = pkgs.writers.writeNuBin "git-copy" ''
    ${builtins.readFile ./git-copy.nu}
  '';
in
{
  home.packages = [
    git-copy
  ];

  # --- SSH Key Generation ---
  home.activation.createSshKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.writers.writeNu "create-ssh-key" ''
      def mkKey [path, comment] {
        if not ($path | path exists) {
          print $"Nix: Auto-generating ($path)..."
          ^${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -f $path -C $comment
        }
      }
      let ssh = ($env.HOME | path join ".ssh")
      if not ($ssh | path exists) { mkdir $ssh }
      mkKey ($ssh | path join "id_ed25519") "dev@gaffarmahmud.com"
      mkKey ($ssh | path join "aur") "aur"
    ''}
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
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "aur.archlinux.org" = {
        User = "aur";
        IdentityFile = "~/.ssh/aur";
        IdentitiesOnly = "yes";
      };
    };
  };

  # --- Git Setup & Config ---
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

      blame.coloring = "highlightRecent";

      color = {
        ui = true;
        blame.highlightRecent = "black bold,1 year ago,white,1 month ago,default,7 days ago,blue";

        branch = {
          current = "magenta";
          local = "default";
          remote = "yellow";
          upstream = "green";
        };
        diff = {
          meta = "black bold";
          frag = "magenta";
          old = "red";
        };
        decorate = {
          HEAD = "red";
          branch = "blue";
          tag = "yellow";
          remoteBranch = "magenta";
        };
      };

      url = {
        "git@github.com:".insteadOf = [
          "https://github.com/"
          "gh:"
        ];
        "git@github.com:zedxihan/".insteadOf = "me:";
        "ssh://aur@aur.archlinux.org/".insteadOf = "aur:";
      };
    };
  };
}
