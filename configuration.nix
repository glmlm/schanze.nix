{
  hostName,
  pkgs,
  stateVersion,
  username,
  ...
}:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    tmp.useTmpfs = true;
  };
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
  hardware.bluetooth.enable = true;
  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  security.rtkit.enable = true;
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -s ${pkgs.sway}/share/wayland-sessions -t -r --asterisks";
        user = "greeter";
      };
      useTextGreeter = true;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    printing.enable = true;
    udisks2.enable = true;
  };
  system.stateVersion = stateVersion;
  time.timeZone = "UTC";
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  imports = [
    ./hardware-configuration.nix
  ];
}
