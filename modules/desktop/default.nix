{ pkgs, ... }: {
  programs.hyprland.enable = true;
  security.rtkit.enable = true;

  services.pipewire = { 
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
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

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override { flavor = "mocha"; accent = "mauve"; })
    rofi waybar wl-clipboard xdg-utils thunar firefox eza bat bibata-cursors
  ];
}
