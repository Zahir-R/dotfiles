{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    unityhub
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
  ];
}
