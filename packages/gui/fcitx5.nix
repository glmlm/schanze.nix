{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc-ut
    ];
  };
  xdg.configFile.fcitx5 = {
    source = ../../dotfiles/fcitx5;
    recursive = true;
  };
}
