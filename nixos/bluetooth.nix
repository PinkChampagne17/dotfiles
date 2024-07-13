{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.Experimental = true;
#   hardware.pulseaudio.enable = true;
#   hardware.pulseaudio.package = pkgs.pulseaudioFull;
}
