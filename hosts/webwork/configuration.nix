{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "webwork";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "26.05";
}
