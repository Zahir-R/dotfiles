{ config, pkgs, inputs, ... }: {
  home.username = "zahir";
  home.homeDirectory = "/home/zahir";
  home.stateVersion = "26.05";

  home.file = {
    ".config/hypr/hyprland.lua".source = ../../config/hypr/hyprland.lua;
    ".config/nvim/lua/plugins/lsp.lua".source = ../../config/nvim/lua/plugins/lsp.lua;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = { opacity = 0.97; padding = { x = 10; y = 10; }; dynamic_title = true; };
      font = {
        size = 10.0;
        normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
        bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
      };
      colors.primary = { background = "#1e1e2e"; foreground = "#cdd6f4"; };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --icons --group-directories-first";
      cat = "bat";
      zreload = "sudo nixos-rebuild switch --flake ~/dotfiles/#\$(hostname)";
    };
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ../../hosts/webwork/starship.toml);
  };

  programs.zoxide = { enable = true; enableZshIntegration = true; };
  programs.home-manager.enable = true;
}
