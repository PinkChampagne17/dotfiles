{ config, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Nvidia

  environment.systemPackages = with pkgs; [ nvtopPackages.full ];

  hardware = {
    # graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement = {
        enable = false;
        # finegrained = true;
      };
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
