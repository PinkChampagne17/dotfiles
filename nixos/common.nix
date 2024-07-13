{
  lib,
  pkgs,
  pkgs-beta,
  ...
}:

{
  boot.tmp.cleanOnBoot = true;

  environment.systemPackages =
    with pkgs;
    [
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
      lazygit
      nixfmt-rfc-style
      ripgrep
      starship
      tldr
      tokei
      tree
      wget
    ]
    ++ (with pkgs-beta; [
      nushell # For v0.94.0
      zoxide # For v0.9.5
    ]);

  # Swap
  # zramSwap.enable = true;
  # swapDevices = lib.mkForce [];

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
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org" # https://nix-community.org/cache/
      ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };
  };

  programs = {
    nh.enable = true;
    nix-ld.enable = true;
  };

  users.users.pinkchampagne = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
  };
}
