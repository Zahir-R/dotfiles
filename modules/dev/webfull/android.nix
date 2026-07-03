{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [
    inputs.android-nixpkgs.overlays.default
  ];

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    chromium
  ];

  environment.sessionVariables = {
    ANDROID_HOME = "/home/zahir/Android/Sdk";
    CHROME_BIN = "${pkgs.chromium}/bin/chromium";
  };
}
