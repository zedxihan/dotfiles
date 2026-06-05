{
  description = "Portable Nix Configuration for Linux and macOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }@inputs:
    let
      linuxUsername = "zedxihan";
      macUsername = "zedxihan";
    in
    {
      # --- Arch ---
      homeConfigurations."arch-setup" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/arch/home.nix
        ];
        extraSpecialArgs = { inherit linuxUsername inputs; };
      };

      # --- macOS ---
      darwinConfigurations."mac-setup" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit macUsername; };
        modules = [
          ./hosts/mac/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${macUsername} = import ./hosts/mac/home.nix;
            home-manager.extraSpecialArgs = { inherit macUsername inputs; };
          }
        ];
      };
    };
}
