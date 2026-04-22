{ nhVars, pkgs, ... }:

{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = nhVars.gcSched;
      extraArgs = "--keep ${toString nhVars.gcKeepGen} --keep-since ${toString nhVars.gcKeepDay}d";
    };
  };
  home.sessionVariables.NH_FLAKE = nhVars.flakePath;
  systemd.user.services.nh-clean.Service.Environment = "PATH=${pkgs.nix}/bin";
}
