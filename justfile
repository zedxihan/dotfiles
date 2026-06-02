default:
    @just --list

# Update system configuration based on current OS
update:
    #!/usr/bin/env bash
    if [ "$(uname)" = "Darwin" ]; then
        echo "Updating macOS Darwin configuration..."
        darwin-rebuild switch --flake ~/.dotfiles/#mac-setup
    --
    else
        echo "Updating Linux Home Manager configuration..."
        home-manager switch --flake ~/.dotfiles/#arch-setup --impure
    fi

# Garbage collection
clean:
    nix-collect-garbage -d
