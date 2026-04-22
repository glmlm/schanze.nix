{
  userLocale,
  config,
  pkgs,
  ...
}:

let
  inherit (userLocale) lang encoding;
in
{
  home.sessionVariables = {
    LANG = "${lang}.${encoding}";
    LOCPATH = "${config.home.homeDirectory}/.local/share/locale";
  };
  xdg.dataFile."locale/${lang}.${encoding}".source = pkgs.runCommand "user-locale" { } ''
    mkdir -p $out
    ${pkgs.glibc.bin}/bin/localedef -i ${lang} -f ${encoding} $out
  '';
}
