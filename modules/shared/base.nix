{ pkgs, ... }: {
  # Base System Settings
  time.timeZone = "America/La_Paz";
  i18n.defaultLocale = "en_US.UTF-8";
  console = { 
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Global Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
    nerd-fonts.jetbrains-mono  
  ];

  # Universal Core Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gnumake
    neovim
    gcc
    ripgrep
    fd
    unzip
    fastfetch
    tree

    vimPlugins.nvim-treesitter.withAllGrammars
  ];
}
