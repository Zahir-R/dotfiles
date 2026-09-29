{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "Toshiba_Satellite";
  networking.networkmanager.enable = true;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  system.stateVersion = "26.05";
}
