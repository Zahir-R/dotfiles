{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodejs_18
    pnpm
  ];
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
}
