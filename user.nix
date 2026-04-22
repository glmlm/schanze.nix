{
  hostName = "nixos";
  system = "x86_64-linux"; # refs: `nix eval --impure --expr "builtins.currentSystem"`
  username = "your-username"; # refs: `whoami`
  unfreePkgs = [
  ];
  extraArgs = {
    stateVersion = "26.05"; # state anchor which prevents breaking changes on updates
    userLocale = {
      lang = "en_US";
      encoding = "UTF-8";
    };
    nhVars = {
      gcSched = "daily"; # refs: `MANPAGER="less -p programs.nh.clean.dates" man home-configuration.nix`
      gcKeepGen = 5;
      gcKeepDay = 3;
      flakePath = "$HOME/.config/home-manager";
    };
  };
}
