{ pkgs, nixosConfig, ... }:

{
  targets.genericLinux.enable = !pkgs.stdenv.isDarwin && nixosConfig == null;

  imports = [
    ./fcitx5.nix
    ./firefox.nix
    ./window-manager.nix
  ];
}
