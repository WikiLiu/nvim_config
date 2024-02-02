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
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		branch = "master",
		priority = 1000,
		config = function()
			local monokai = require("monokai-pro")
			monokai.setup({
				transparent_background = false,
				devicons = true,
				filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
				day_night = {
					enable = false,
					day_filter = "classic",
					night_filter = "spectrum",
				},
				inc_search = "background", -- underline | background
				background_clear = { "toggleterm" },
				plugins = {
					bufferline = {
						underline_selected = true,
						underline_visible = false,
						bold = false,
					},
					indent_blankline = {
						context_highlight = "pro", -- default | pro
						context_start_underline = true,
					},
				},
				override = function(c)
					return {
						ColorColumn = { bg = c.base.dimmed3 },
						-- Mine
						DashboardRecent = { fg = c.base.magenta },
						DashboardProject = { fg = c.base.blue },
						DashboardConfiguration = { fg = c.base.white },
						DashboardSession = { fg = c.base.green },
						DashboardLazy = { fg = c.base.cyan },
						DashboardServer = { fg = c.base.yellow },
						DashboardQuit = { fg = c.base.red },
					}
				end,
			})
			monokai.load()
		end,
	},
	{
		"preservim/tagbar",
		lazy = false,
	},
	-- Runners and terminal
	{
		'stevearc/overseer.nvim',
		opts = {
			strategy = {
				"toggleterm",
				-- load your default shell before starting the task
				use_shell = true,
				-- overwrite the default toggleterm "direction" parameter
				direction = "horizontal",
				-- overwrite the default toggleterm "highlights" parameter
				highlights = table,
				-- overwrite the default toggleterm "auto_scroll" parameter
				auto_scroll = true,
				-- have the toggleterm window close and delete the terminal buffer
				-- automatically after the task exits
				close_on_exit = false,
				-- have the toggleterm window close without deleting the terminal buffer
				-- automatically after the task exits
				-- can be "never, "success", or "always". "success" will close the window
				-- only if the exit code is 0.
				quit_on_exit = "success",
				-- open the toggleterm window when a task starts
				open_on_start = true,
				-- mirrors the toggleterm "hidden" parameter, and keeps the task from
				-- being rendered in the toggleable window
				hidden = false,
				-- command to run when the terminal is created. Combine with `use_shell`
				-- to run a terminal command before starting the task
				on_create = nil,
			},

		},
		config = function()
			require('overseer').setup({
			strategy = {
			"toggleterm",direction = "horizontal", open_on_start = true,
			},
			})
		end,
	},
	  { "kkharji/sqlite.lua" },
  { "nvim-telescope/telescope-smart-history.nvim", dependencies = { "tami5/sqlite.lua" } },
}
