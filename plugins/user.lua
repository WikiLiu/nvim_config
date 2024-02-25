return {
	-- You can also add new plugins here as well:
	-- Add plugins, the lazy syntax
	-- "andweeb/presence.nvim",
	-- {
	--   "ray-x/lsp_signature.nvim",
	--   event = "BufRead",
	--   config = function()
	--     require("lsp_signature").setup()
	--   end,
	-- },
	{
		"preservim/tagbar",
		lazy = false,
	},
	  { "kkharji/sqlite.lua" },
	  {"nvim-lua/plenary.nvim",
		branch = master	
	},
{
  "princejoogie/dir-telescope.nvim",
  -- telescope.nvim is a required dependency
  requires = {"nvim-telescope/telescope.nvim"},
  config = function()
    require("dir-telescope").setup({
      -- these are the default options set
      hidden = true,
      no_ignore = false,
      show_preview = true,
    })
  end,
	lazy=false,
},
}
