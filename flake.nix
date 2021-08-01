{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
      {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/nixos
            home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            inherit inputs system;
          };
        };
  };
}
