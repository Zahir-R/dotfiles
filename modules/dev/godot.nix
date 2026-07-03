{ pkgs, ... }: {
  # Desktop Environment Core
  programs.hyprland.enable = true;
  programs.starship.enable = true;
  services.pipewire = { 
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  # Developer Specific Software Packages
  environment.systemPackages = with pkgs; [
    # Essentials
    rofi
    waybar
    wl-clipboard
    xdg-utils

    # Engines (Currently godot4-mono works,
    # I will probably change unityhub config)
    unityhub
    (pkgs.godot-mono.overrideAttrs (oldAttrs: {
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

    # Tools
    mono
    csharp-ls

    (dotnetCorePackages.combinePackages [ 
      dotnetCorePackages.sdk_8_0
      dotnetCorePackages.sdk_10_0
    ])
  ];

  # Explicit Environment Linking
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
