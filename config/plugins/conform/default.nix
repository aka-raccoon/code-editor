{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    shfmt
    shellcheck
    sqlfluff
    stylua
  ];
  plugins.conform-nvim = {
    enable = true;

    lazyLoad.settings = {
      cmd = [
        "ConformInfo"
      ];
      event = [ "BufWritePre" ];
    };

    settings = {
      default_format_opts = {
        quiet = false;
        async = false;
        lsp_format = "first";
      };
      format_on_save = {
        timeout_ms = 500;
      };
      notify_on_error = true;
      formatters_by_ft = {
        fish = [ "fish_indent" ];
        lua = [ "stylua" ];
        nix = {
          __unkeyed = "injected";
          lsp_format = "first";
        };
        python = {
          __unkeyed = "injected";
          lsp_format = "first";
        };
        sql = [ "sqlfluff" ];
      };
      formatters = {
        injected = {
          ignore_errors = false;
          lang_to_formatters = {
            sh = [
              "shfmt"
              "shellcheck"
            ];
            bash = [
              "shfmt"
              "shellcheck"
            ];
            fish = [
              "fish_indent"
            ];
          };
        };
      };
    };
  };
}
