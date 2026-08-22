{ pkgs, ... }: {
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  environment.systemPackages = with pkgs; [
    chromium
  ];

  environment.sessionVariables = {
    CHROME_BIN = "${pkgs.chromium}/bin/chromium";
  };
}
