{ pkgs, inputs, config, ... }: {
  imports = [ inputs.android-nixpkgs.overlays.default ];

  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    nodejs_22 pnpm php83 php83Packages.composer
    android-studio android-tools chromium jdk17
  ];
  environment.sessionVariables = let
    combinedDotnet = pkgs.dotnetCorePackages.combinePackages [
      pkgs.dotnetCorePackages.sdk_8_0
      pkgs.dotnetCorePackages.sdk_10_0
    ];
  in {
    DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
    MSBuildSDKsPath = "${combinedDotnet}/share/dotnet/sdk/10.0.301/Sdks";
    ANDROID_HOME = "/home/zahir/Android/Sdk";
    CHROME_BIN = "${pkgs.chromium}/bin/chromium";
  };
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
}
