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

# Garbage collection
clean:
    nix-collect-garbage -d
