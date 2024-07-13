{ lib, pkgs, ... }:

{
  virtualisation.vmware.guest = {
    enable = true;
    headless = pkgs.hostPlatform.system == "aarch64-linux";
  };
}
