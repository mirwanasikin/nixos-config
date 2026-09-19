{
  config,
  pkgs,
  ...
}:
{
  services.hermes-agent = {
    enable = true;
    settings = {
      model = {
        provider = "custom";
        base_url = "http://127.0.0.1:20128/v1";
        default = "aneh";
        api_key = "\${NINEROUTER_KEY}";
      };
      display = {
        compact = false;
        personality = "kawaii";
      };
    };
    environmentFiles = [ config.age.secrets.hermes-env.path ];
    addToSystemPackages = true;
    extraPackages = [ pkgs.himalaya ];
  };
}
