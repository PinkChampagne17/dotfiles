{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bottles
    goverlay
    lutris
    mangohud
    protontricks
    protonup-qt
    wineWowPackages.stable
    # wineWowPackages.waylandFull
    winetricks
  ];

  # https://wiki.nixos.org/wiki/Steam
  # https://wiki.nixos.org/wiki/GameMode
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      # protontricks = true;
      remotePlay.openFirewall = true;
    };
  };
}
