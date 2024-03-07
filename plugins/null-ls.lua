return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
-- CPP
--      null_ls.builtins.diagnostics.cpplint.with({
--	command = '/usr/bin/cpplint',
--        args = { "--linelength=120", "--filter=-whitespace/tab,-whitespace/braces,-readability/casting,-whitespace/parens,-whitespace/braces", "$FILENAME", },--
--      }),
    }
    return config -- return final config table
  end,
}
