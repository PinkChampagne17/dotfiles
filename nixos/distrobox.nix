{ lib, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    [
      distrobox
    ]
    ++ lib.optional services.xserver.enable pkgs.boxbuddy;

  # Docker
  virtualisation.docker.enable = true;
  users.users.pinkchampagne.extraGroups = [ "docker" ];
}
