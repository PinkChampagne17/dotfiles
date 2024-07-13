{ pkgs, ... }:

{
  imports = [
    ./gnome.nix
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
    fcitx5.waylandFrontend = true;
  };

  fonts = {
    fontconfig = {
      defaultFonts = {
        serif = [
          "Source Han Serif SC"
          "Source Han Serif"
        ];
        sansSerif = [
          "Source Han Sans SC"
          "Source Han Sans"
        ];
        monospace = [
          "Source Han Mono SC"
          "Source Han Mono"
        ];
      };
    };
    packages = with pkgs; [
      cascadia-code
      noto-fonts-color-emoji
      source-han-sans
      source-han-mono
      source-han-serif
    ];
  };

  # Fcitx not work
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    baobab
    firefox
    kdePackages.partitionmanager
    nvtopPackages.full
    papirus-icon-theme
    ptyxis
    resources
    vscode
  ];

  # Flatpak
  services.flatpak.enable = true;
  fonts.fontDir.enable = true;
}
