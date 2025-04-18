{ helpers, ... }:
{
  config.autoCmd = [
    # Vertically center document when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }

    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Close Snacks.picker prompt in insert mode by clicking escape
    {
      event = [ "FileType" ];
      pattern = "snacks_picker_input";
      command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
    }

    # Highlight yank text
    {
      event = "TextYankPost";
      pattern = "*";
      command = "lua vim.highlight.on_yank{timeout=500}";
    }

    # Enter git buffer in insert mode
    {
      event = "FileType";
      pattern = [
        "gitcommit"
        "gitrebase"
      ];
      command = "startinsert | 1";
    }

    # Sort python imports
    {
      event = "BufWritePre";
      pattern = "*.py";
      callback = {
        __raw =
          helpers.mkLuaFn # lua
            ''
              	vim.lsp.buf.code_action({
              		context = {
              			only = { "source.organizeImports.ruff" },
              		},
              		apply = true,
              	})

              	vim.cmd("write")
            '';
      };
    }
  ];
}
