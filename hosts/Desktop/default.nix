{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "Desktop";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.enable = false;
  system.stateVersion = "26.05";

  zramSwap = {
    enable = true;
    priority = 100;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
      priority = 10;
    }
  ];

  boot.kernelParams = [
    # "resume_offset=31420416"
    "mem_sleep_default=deep"
  ];
  # boot.resumeDevice = "/dev/disk/by-uuid/f102c018-f9e9-432b-87b9-df0d956544ad";
  boot.initrd.systemd.enable = true;
  powerManagement.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.logind.settings.Login = {
    LidSwitch = "suspend-then-hibernate";
    PowerKey = "hibernate";
    PowerKeyLongPress = "poweroff";
  };

  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "30m";
    SuspendState = "mem";
  };
}
