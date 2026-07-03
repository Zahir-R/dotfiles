{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodejs_22
    pnpm
    jdk17
  ];

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };
}
