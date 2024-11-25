{ pkgs, ... }:

{
  environment = {
    sessionVariables = {
      # MANGOHUD = "1";
      # GDK_SCALE = "2"; # https://wiki.archlinux.org/title/HiDPI#Steam
    };
    systemPackages = with pkgs; [
      # bottles
      # goverlay
      # lutris
      # mangohud
      # protontricks
      # protonup-qt
      # wineWowPackages.stable
      # wineWowPackages.waylandFull
      # winetricks
    ];
  };

  # https://wiki.nixos.org/wiki/Steam
  # https://wiki.nixos.org/wiki/GameMode
  programs = {
    gamemode.enable = true;
    # gamescope = {
    #   enable = true;
    #   capSysNice = true;
    # };
    steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      package = pkgs.steam.override {
        extraEnv = {
          # MANGOHUD = true;
          GDK_SCALE = 2; # TODO: dynamic
        };
      };
    };
  };
}
