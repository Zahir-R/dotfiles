{ pkgs, ... }: {
  users.users.zahir = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "video" "adbusers" "kvm" "docker" ];
  };
}
