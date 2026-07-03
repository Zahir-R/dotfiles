{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "micro-server";
  networking.networkmanager.enable = true;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  documentation.enable = false;
  documentation.nixos.enable = false;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  system.stateVersion = "26.05";
}
