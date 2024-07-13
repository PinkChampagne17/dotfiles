{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages =
    with pkgs;
    [
      clash-verge-rev
      piper
      snapshot
    ]
    ++ (with pkgs-unstable; [
      nushell
      zed-editor
      zoxide # For v0.9.5
    ]);

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.Experimental = true;
  #   hardware.pulseaudio.enable = true;
  #   hardware.pulseaudio.package = pkgs.pulseaudioFull;

  services.ratbagd.enable = true;
}
