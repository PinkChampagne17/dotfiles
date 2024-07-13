{ pkgs, ... }:

{
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # For Flatpak
  xdg.portal.config.common.default = "gtk";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
