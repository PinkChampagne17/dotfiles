{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-alien.url = "github:thiagokokada/nix-alien";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        nixos-5500 = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            /etc/nixos/configuration.nix
            ./common.nix
            ./gui.nix
            ./distrobox.nix
            ./host.nix
            ./gamming.nix
          ];
        };

        nixos-5600 = nixpkgs-unstable.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            # pkgs = import nixpkgs {
            #   inherit system;
            #   config.allowUnfree = true;
            # };
            inherit self system;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            /etc/nixos/configuration.nix
            ./common.nix
            ./gui.nix
            # ./distrobox.nix
            ./host.nix
            ./nvidia.nix
            ./gamming.nix
            (
              { self, system, ... }:
              {
                environment.systemPackages = with self.inputs.nix-alien.packages.${system}; [
                  nix-alien
                ];
              }
            )
          ];
        };

        nixos-vm-aarch = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          # specialArgs = { inherit inputs; };
          modules = [
            /etc/nixos/configuration.nix
            ./common.nix
            ./gui.nix
            ./guest.nix
          ];
        };

        nixos-vm-amd64 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # specialArgs = { inherit inputs; };
          modules = [
            /etc/nixos/configuration.nix
            ./common.nix
            ./gui.nix
            #   ./hyprland.nix
            #   ./hyprland-32.nix
          ];
        };
      };
    };
}
