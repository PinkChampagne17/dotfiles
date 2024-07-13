{ pkgs, ... }:

{
  imports = [
    ./gnome.nix
  ];
  #   services.displayManager.sddm.wayland.enable = true;
  #   services.displayManager.sddm.enable = true;
  #   services.desktopManager.plasma6.enable = true;

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
    fcitx5.waylandFrontend = true; # `true` for KDE
  };

  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts-emoji
    source-han-sans
    source-han-mono
    source-han-serif
  ];

  # Fcitx not work
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    baobab
    devbox
    firefox
    # google-chrome
    kdePackages.partitionmanager
    mission-center
    # microsoft-edge
    papirus-icon-theme
    ptyxis
    resources
    # telegram-desktop
    vscode
  ];

  # Flatpak
  services.flatpak.enable = true;

  #   xdg.portal.config.common.default = "gtk";
  #   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  #   https://nixos.wiki/wiki/NTFS
  #   boot.supportedFilesystems = [ "ntfs" ];
}
