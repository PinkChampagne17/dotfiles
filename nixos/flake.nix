{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-beta.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-beta,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      buildSpecialArgs = system: {
        pkgs-beta = import nixpkgs-beta {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        nixos-5500 = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = buildSpecialArgs system;
          modules = [
            /etc/nixos/configuration.nix
            ./common.nix
            ./gui.nix
            ./distrobox.nix
            ./host.nix
            ./gamming.nix # TODO: rename to gaming.nix
          ];
        };

        nixos-5600 = nixpkgs-beta.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = buildSpecialArgs system;
          modules = [
            ./hosts/nixos-5600.nix
          ];
        };

        nixos-vm-aarch = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = buildSpecialArgs system;
          modules = [
            /etc/nixos/configuration.nix
            ./common.nix
            ./distrobox.nix
            ./gui.nix
            ./guest.nix
          ];
        };

        nixos-vm-amd64 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            /etc/nixos/configuration.nix
            ./common.nix
            ./gui.nix
          ];
        };
      };
    };
}
