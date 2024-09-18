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

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-console
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      epiphany # web browser
      # evince # document viewer
      geary # email reader
      gnome-contacts
      gnome-disk-utility
      gnome-maps
    ]);

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
  ];

  services.udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
}
