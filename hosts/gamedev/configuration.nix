{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "gamedev";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap.enable = true;
  system.stateVersion = "26.05";
}
