{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    zed-editor
  ];
}
