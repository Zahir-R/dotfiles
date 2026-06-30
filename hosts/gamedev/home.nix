{ config, pkgs, ... }: {
  home.username = "zahir";
  home.homeDirectory = "/home/zahir";

  home.stateVersion = "26.05"; 

  home.file = {
    ".config/hypr/hyprland.lua".source = ../../config/hypr/hyprland.lua;
    ".config/nvim/lua/plugins/lsp.lua".source = ../../config/nvim/lua/plugins/lsp.lua;
  };

  home.packages = with pkgs; [
    firefox
    nerd-fonts.jetbrains-mono
    eza
    bat
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.97;
        padding = { x = 10; y = 10; };
        dynamic_title = true;
      };

      font = {
          size = 10.0;
          normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
          bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
          italic = { family = "JetBrainsMono Nerd Font"; style = "Italic"; };
          bold_italic = { family = "JetBrainsMono Nerd Font"; style = "Bold Italic"; };
      };

      terminal.shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "--login" ];
      };

      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6a3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c3e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ../../hosts/gamedev/starship.toml);
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      share = true;
    };

    autosuggestion.enable = true;

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      cat = "bat";
      zconf = "nvim ~/dotfiles/hosts/gamedev/home.nix";
      zreload = "sudo nixos-rebuild switch --flake ~/dotfiles/#gamedev";
    };

    syntaxHighlighting = {
      enable = true;
      styles = {
        "command" = "fg=#f5c2e7,bold";
        "precommand" = "fg=#f5c2e7,bold";
        "alias" = "fg=#f5c2e7,bold";
        "builtin" = "fg=#f5c2e7,bold";
        "function" = "fg=#f5c2e7,bold";
        "unknown-token" = "fg=#6c7086";
      };
    };
  };

  programs.home-manager.enable = true;
}
