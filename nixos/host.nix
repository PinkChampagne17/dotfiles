{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clash-verge-rev
    piper
    snapshot
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.Experimental = true;
  #   hardware.pulseaudio.enable = true;
  #   hardware.pulseaudio.package = pkgs.pulseaudioFull;

  services.ratbagd.enable = true;
}
