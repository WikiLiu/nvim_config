return {
	"loctvl842/monokai-pro.nvim",
	lazy = false,
	branch = "master",
	priority = 1000,
	config = function()
		local monokai = require("monokai-pro")
		monokai.setup({
			transparent_background = false,
			terminal_colors = true,
			devicons = true,
			filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
			day_night = {
				enable = false,
				day_filter = "classic",
				night_filter = "spectrum",
			},
			styles = {
    			comment = { italic = true },
    			keyword = { italic = true }, -- any other keyword
    			type = { italic = true }, -- (preferred) int, long, char, etc
    			storageclass = { italic = true }, -- static, register, volatile, etc
    			structure = { italic = true }, -- struct, union, enum, etc
    			parameter = { italic = true }, -- parameter pass in function
    			annotation = { italic = true },
    			tag_attribute = { italic = true }, -- attribute of tag in reactjs
  			},
			inc_search = "background", -- underline | background
		  	background_clear = {
    			"float_win",
    			"toggleterm",
    			"telescope",
    			"which-key",
    			"renamer",
    			"notify",
    			-- "nvim-tree",
    			"neo-tree",
    			"bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
  			},-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
			plugins = {
				bufferline = {
					underline_selected = false,
					underline_visible = false,
					bold = false,
				},
				indent_blankline = {
					context_highlight = "pro", -- default | pro
					context_start_underline = false,
				},
			},
			override = function(c)
				return {
					-- ColorColumn = { bg = c.base.dimmed3 },
					-- ColorColumn = { bg =  "#272727" },
					-- Mine
					Normal = { bg = "#1c1c1c" },
					DashboardRecent = { fg = c.base.magenta },
					DashboardProject = { fg = c.base.blue },
					DashboardConfiguration = { fg = c.base.white },
					DashboardSession = { fg = c.base.green },
					DashboardLazy = { fg = c.base.cyan },
					DashboardServer = { fg = c.base.yellow },
					DashboardQuit = { fg = c.base.red },
				}
			end,
    		overridePalette = function(filter)
      			return {
        			-- dark2 = "#101014",
        			-- dark1 = "#16161E",
        			background = "#1c1c1c",
        			-- text = "#C0CAF5",
        			-- accent1 = "#f7768e",
        			-- accent2 = "#7aa2f7",
        			-- accent3 = "#e0af68",
        			-- accent4 = "#9ece6a",
        			-- accent5 = "#0DB9D7",
        			-- accent6 = "#9d7cd8",
        			-- dimmed1 = "#737aa2",
        			-- dimmed2 = "#787c99",
        			-- dimmed3 = "#363b54",
        			-- dimmed4 = "#363b54",
        			-- dimmed5 = "#16161e",
      			}
    		end,
		})
		monokai.load()
	end,
}
