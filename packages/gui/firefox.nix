{ pkgs, config, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles.default.extensions.packages = with pkgs.firefox-addons; [
    ];
  };
}
