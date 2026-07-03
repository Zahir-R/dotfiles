{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    unityhub
    mono
    csharp-ls
    (godot-mono.overrideAttrs (oldAttrs: {
      postFixup = (oldAttrs.postFixup or "") + ''
        wrapProgram $out/bin/godot4-mono \
          --add-flags "--display-driver wayland" \
          --set __GLX_VENDOR_LIBRARY_NAME nvidia \
          --set __NV_PRIME_RENDER_OFFLOAD 1 \
          --set __VK_LAYER_NV_optimus NVIDIA_only \
          --set OGL_DRIVER_NAME nvidia \
          --unset DRI_PRIME
      '';
    }))
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
