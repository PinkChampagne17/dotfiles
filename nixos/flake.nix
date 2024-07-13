{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nixos-5500 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          /etc/nixos/configuration.nix
          ./common.nix
          ./gui.nix
		  ./bluetooth.nix
        ];
      };

      nixos-vm-aarch = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        # specialArgs = { inherit inputs; };
        modules = [
          /etc/nixos/configuration.nix
          ./common.nix
          ./gui.nix
          # ./hyprland.nix
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
