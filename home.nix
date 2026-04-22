{
  stateVersion,
  username,
  pkgs,
  ...
}:

{
  programs.home-manager.enable = true;
  home = {
    inherit stateVersion username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
  };

  imports = [
    ./packages
  ];
}
