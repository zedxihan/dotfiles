default:
    @just --list

# Update system configuration based on current OS
update:
    #!/usr/bin/env nu
    if $nu.os-info.name == "macos" {
        print "Updating macOS Darwin configuration..."
        darwin-rebuild switch --flake .#mac-setup
    } else {
        print "Updating Linux Home Manager configuration..."
        home-manager switch --flake .#arch-setup --impure
    }

# Garbage collection and hard link deduplication
clean:
    echo "🧹 Wiping old generation history..."
    nix-env --delete-generations old --profile ~/.local/state/nix/profiles/home-manager

    echo "🗑️ Collecting store garbage..."
    nix-collect-garbage -d

    echo "⚡ Deduplicating identical store files..."
    nix store optimise
