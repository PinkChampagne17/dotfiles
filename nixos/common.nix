{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ast-grep
	bat
    chezmoi
	delta
    dig
	distrobox
    fastfetch
    fd
    fzf
    git
	go-task
    nushell
    ripgrep
    starship
	tldr
    wget
    zoxide
  ];

  programs.neovim.enable = true;

  virtualisation.docker.enable = true;
  users.users.pinkchampagne.extraGroups = [ "docker" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];

    # https://mirrors.tuna.tsinghua.edu.cn/help/nix-channels/
    settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  };
}
