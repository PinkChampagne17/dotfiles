{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
    fcitx5.waylandFrontend = true; # `true` for KDE
  };

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # For KDE
  xdg.portal.config.common.default = "gtk"; # For KDE

  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts-emoji
    source-han-sans
    source-han-mono
    source-han-serif
  ];

  programs.firefox.enable = true;

  # Fcitx not work
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    vscode
  ];
}
