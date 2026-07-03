{ pkgs, inputs, config, ... }: {
  imports = [ inputs.android-nixpkgs.overlays.default ];

  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    nodejs_22 pnpm php83 php83Packages.composer
    android-studio android-tools chromium
  ];

  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
}
