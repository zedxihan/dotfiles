{ pkgs, lib, ... }:

let
  git-copy =
    pkgs.runCommand "git-copy"
      {
        nativeBuildInputs = [ pkgs.go ];
      }
      ''
        mkdir -p $out/bin
        export HOME=$TMPDIR
        export GOCACHE=$TMPDIR/go-cache
        export GOPATH=$TMPDIR/go-path
        go build -ldflags="-s -w" -o $out/bin/git-copy ${./git-copy.go}
      '';
in
{
  home.packages = [
    git-copy
  ];

  # --- SSH Key Generation ---
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
