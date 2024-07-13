{ pkgs, ... }:

{
  imports = [ ./gnome.nix ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
    fcitx5.waylandFrontend = true;
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
    firefox
    kdePackages.partitionmanager
    papirus-icon-theme
    ptyxis
    resources
    vscode
  ];

  # Flatpak
  services.flatpak.enable = true;
  fonts.fontDir.enable = true;
}
