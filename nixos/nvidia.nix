{ config, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Nvidia
  hardware = {
    graphics = {
      enable = true;
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement = {
        enable = false;
        # finegrained = true;
      };
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
