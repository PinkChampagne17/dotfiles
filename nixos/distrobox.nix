{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages =
    with pkgs;
    [ distrobox ] ++ lib.optional config.services.xserver.enable pkgs.boxbuddy;

  # Docker
  virtualisation.docker.enable = true;
  users.users.pinkchampagne.extraGroups = [ "docker" ];
  hardware.nvidia-container-toolkit.enable = lib.elem "nvidia" config.services.xserver.videoDrivers;
}
