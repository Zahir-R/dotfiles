# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # boot.loader.grub.enable = false;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "game-dev";
  networking.networkmanager.enable = true;
  time.timeZone = "America/La_Paz";
  i18n.defaultLocale = "en_US.UTF-8";
 
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
    nerd-fonts.jetbrains-mono
  ];

  # Private Software
  nixpkgs.config.allowUnfree = true;
  # Hyprland environment
  programs.hyprland.enable = true;
  
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Greeter SDDM
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "catppuccin-mocha-mauve";
    };
    defaultSession = "hyprland";
  };
  
  # Enable sound (Pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User config
  users.users.zahir = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    packages = with pkgs; [
      tree
      kitty
      rofi
      waybar
      wl-clipboard
      xdg-utils
    ];
  };

  programs.firefox.enable = true;

  # https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # Essentials
    vim
    wget
    git
    gnumake
    neovim
    gcc
    ripgrep
    fd
    unzip

    # .NET Stack Game Dev
    dotnet-sdk_8
    mono

    # Engines & Tools
    # Godot with Wayland forcing
    (pkgs.godot-mono.overrideAttrs (oldAttrs: {
      postFixup = (oldAttrs.postFixup or "") + ''
        wrapProgram $out/bin/godot4-mono --add-flags "--display-driver wayland"
      '';
    }))
    unityhub
    
    # SDDM Theme
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
    })
  
    fastfetch
  ];

  # NeoVim/Omnisharp environment variables so OmniSharp can find .NET SDK
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # NVIDIA Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
 
 system.stateVersion = "26.05";
}

