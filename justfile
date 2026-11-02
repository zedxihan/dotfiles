default:
    @just --list

# Update system configuration
update:
    home-manager switch --flake .#arch-setup --impure

# Set up GPU drivers for non-NixOS systems
gpu-setup:
    sudo $(readlink -f ~/.nix-profile/bin/non-nixos-gpu-setup)

# Garbage collection and hard link deduplication
clean:
    echo "🧹 Wiping old generation history..."
    nix-env --delete-generations old --profile ~/.local/state/nix/profiles/home-manager

    echo "🗑️ Collecting store garbage..."
    nix-collect-garbage -d

    echo "⚡ Deduplicating identical store files..."
    nix store optimise
