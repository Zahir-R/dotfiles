{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/shared/base.nix
      ../../modules/hardware/nvidia.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "web-work";
  networking.networkmanager.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.hyprland.enable = true;
  security.rtkit.enable = true;
  services.pipewire = { 
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "catppuccin-mocha-mauve";
    };
    defaultSession = "hyprland";
  };

  programs.adb.enable = true;

  users.users.zahir = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "adbusers" "kvm" ];
  };

  androidsdk = {
    enable = true;
    platformVersions = [ "34" "35" ];
    buildToolsVersions = [ "34.0.0" "35.0.0" ];
    includeEmulator = true;
    emulatorFormats = [ "x86_64" ];
  };

  environment.systemPackages = with pkgs; [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
    })

    android-studio
    chromium
  ];

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  system.stateVersion = "26.05";
}
