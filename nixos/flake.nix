{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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

        nixos-5600 = nixpkgs.lib.nixosSystem rec {
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
            ./nvidia.nix
            ./gamming.nix
          ];
        };

        nixos-vm-aarch = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";

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
