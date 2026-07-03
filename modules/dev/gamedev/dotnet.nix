{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    mono
    csharp-ls
    (dotnetCorePackages.combinePackages [ 
      dotnetCorePackages.sdk_8_0
      dotnetCorePackages.sdk_10_0
    ])
  ];

  environment.sessionVariables = let
    combinedDotnet = pkgs.dotnetCorePackages.combinePackages [ 
      pkgs.dotnetCorePackages.sdk_8_0
      pkgs.dotnetCorePackages.sdk_10_0
    ];
  in {
    DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
    MSBuildSDKsPath = "${combinedDotnet}/share/dotnet/sdk/10.0.301/Sdks";
  };
}
