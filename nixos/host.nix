{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages =
    with pkgs;
    [
      piper
      snapshot
      wireshark
    ]
    ++ (with pkgs-unstable; [ zed-editor ]);

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.Experimental = true;
  #   hardware.pulseaudio.enable = true;
  #   hardware.pulseaudio.package = pkgs.pulseaudioFull;

  programs.clash-verge = {
    enable = true;
    autoStart = true;
  };

  services.ratbagd.enable = true;
}
