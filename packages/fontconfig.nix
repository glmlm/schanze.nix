{ pkgs, config, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Noto Sans Mono CJK JP" ];
      sansSerif = [ "Noto Sans CJK JP" ];
      serif = [ "Noto Serif CJK JP" ];
    };
  };
  home = {
    packages = with pkgs; [
      fontconfig
      nerd-fonts.symbols-only
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      twemoji-color-font
    ];
    sessionVariables.FONTCONFIG_FILE = "${config.xdg.configHome}/fontconfig/fonts.conf";
  };
  xdg.configFile."fontconfig/fonts.conf".source = pkgs.replaceVars ../dotfiles/fontconfig/fonts.conf {
    fonts = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
  };
}
