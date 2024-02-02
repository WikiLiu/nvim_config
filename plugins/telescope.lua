return{
    "nvim-telescope/telescope.nvim",
		opts = function(_, opts) -- override the options using lazy.nvim,
      opts.defaults = {
        history = {
          path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
          limit = 100,
        }
      }
    return opts
    end,
}
