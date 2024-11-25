{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager = {
      gnome.enable = true;
      xterm.enable = false;
    };
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-console
      gnome-tour
      epiphany # web browser
      # evince # document viewer
      geary # email reader
      gnome-contacts
      gnome-disk-utility
      gnome-maps
    ]
  );

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    dconf-editor
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
  ];

  services.udev.packages = [ pkgs.gnome-settings-daemon ];
}
