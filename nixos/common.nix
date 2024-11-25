{ pkgs, ... }:

{
  boot.tmp.cleanOnBoot = true;

  environment.systemPackages = with pkgs; [
    ast-grep
    bat
    chezmoi
    delta
    devbox
    dig
    fastfetch
    fd
    fzf
    git
    go-task
    inetutils
    lazygit
    nixfmt-rfc-style
    nushell
    ripgrep
    starship
    tldr
    tokei
    tree
    wget
    zoxide
  ];

  networking.hosts = {
    "127.0.0.1" = [ "tpstelemetry.tencent.com" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "http://shiroko.local:5000"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org" # https://nix-community.org/cache/
      ];
      trusted-public-keys = [
        "shiroko.local-1:en6OjkF+gHD8HTFNpPNpFiTWSA0E3C71uPQ8CS0co9k="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs = {
    nh.enable = true;
    nix-ld.enable = true;
  };

  services.resolved.enable = true;

  users.users.pinkchampagne = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    # packages = with pkgs; [ ];
  };
}
