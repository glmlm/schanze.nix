{ lib, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      bars = [ ];
      menu = "fuzzel";
      modifier = "Mod4";
    };
    extraConfig = builtins.readFile ../../dotfiles/sway/config;
    systemd.variables = lib.mkOptionDefault [
      "PATH"
    ];
  };
  home = {
    packages = with pkgs; [
      adwaita-icon-theme
      blueman
      brightnessctl
    ];
    sessionVariables.WLR_XWAYLAND =
      let
        xwaylandSatelliteWrapper = pkgs.writeShellScriptBin "xwayland-satellite-wrapper" ''
          swaymsg exec ${pkgs.xwayland-satellite}/bin/xwayland-satellite
        '';
      in
      "${xwaylandSatelliteWrapper}/bin/xwayland-satellite-wrapper";
  };
  programs = {
    foot.enable = true;
    fuzzel.enable = true;
    waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
    pipewire.wireplumber.enable = true;
    udiskie.enable = true;
  };
  systemd.user.packages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-wlr
  ];
  xdg.portal = {
    enable = true;
    config.sway.default = [ "wlr" ];
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
