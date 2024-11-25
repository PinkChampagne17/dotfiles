{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      buildSpecialArgs = system: {
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
          modules = [ ./nixos-5500.nix ];
        };

        nixos-5600 = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = buildSpecialArgs system;
          modules = [
            /etc/nixos/configuration.nix
            ./common.nix
            ./gui.nix
            ./distrobox.nix
            ./host.nix
            ./nvidia.nix
            ./gaming.nix
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
