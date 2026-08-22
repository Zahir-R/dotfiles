{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    ensureDatabases = [ "dev_db" ];
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
    '';
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  services.redis.servers."main" = {
    enable = true;
    port = 6379;
  };
}
