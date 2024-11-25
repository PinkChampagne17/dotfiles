{ ... }:
{
  imports = [
    /etc/nixos/configuration.nix
    ./common.nix
    ./gui.nix
    ./distrobox.nix
    ./host.nix
    ./gaming.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      enableCryptodisk = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/9E8C2CC88C2C9CB1";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1001"
      "gid=100"
      "windows_names"
    ];
  };
}
