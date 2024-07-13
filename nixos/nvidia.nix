{ config, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Nvidia
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        nvtopPackages.full
      ];
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

    # opengl = {
    #   enable = true;
    #   driSupport = true;
    #   driSupport32Bit = true;
    # };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
