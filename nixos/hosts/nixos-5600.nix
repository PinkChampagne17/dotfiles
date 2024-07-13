{ ... }:

{
  imports = [
    /etc/nixos/configuration.nix
    ../common.nix
    ../gui.nix
    ../host.nix
    ../nvidia.nix
    ../distrobox.nix
    ../gamming.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      efiSupport = true;
      enableCryptodisk = true;
      device = "nodev";
    };
  };

  fileSystems."/".options = [
    "subvol=@"
    "compress=zstd:1"
    "noatime"
  ];

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/606E4C547FCBB145";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1001"
      "gid=100"
      "windows_names"
    ];
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/C022AA4B225A6D42";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1001"
      "gid=100"
      "windows_names"
      "prealloc"
    ];
  };
}
