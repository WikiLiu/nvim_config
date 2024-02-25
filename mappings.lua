-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  	-- first key is the mode
  	n = {
    	-- second key is the lefthand side of the map

    	-- navigate buffer tabs with `H` and `L`
    	-- L = {
    	--   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    	--   desc = "Next buffer",
    	-- },
    	-- H = {
    	--   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    	--   desc = "Previous buffer",
    	-- },

    	-- mappings seen under group name "Buffer"
    	["<leader>bD"] = {
      		function()
        		require("astronvim.utils.status").heirline.buffer_picker(
          			function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        		)
      		end,
      		desc = "Pick to close",
    	},
		["<leader>or"] = {
			":OverseerRun<cr>",
			desc = "Overseer Run Task",
		},
		["<leader><F7>"] = {
			":ToggleTerm size= 10 direction=horizontal<cr>",
			desc = "Term horizontal",
		},

		["<leader>fi"] = {
      		function()
				local base_search_dir = vim.g.base_search_dir
				if base_search_dir==nil or base_search_dir == '' then
					base_search_dir = require("user.select-dir").load_dir()
				end
	  			local word_under_cursor = vim.fn.expand("<cword>")
  	   			require('telescope').extensions.live_grep_args.live_grep_args({default_text = word_under_cursor , search_dirs = {base_search_dir}})
      		end,
      		desc = "Find cursor word in path folder",
		},

		["<leader>fI"] = {
      		function()
				local base_search_dir = vim.g.base_search_dir

				if base_search_dir==nil or base_search_dir == '' then
					base_search_dir = require("user.select-dir").load_dir()
				end
  	  			require('telescope').extensions.live_grep_args.live_grep_args({search_dirs = {base_search_dir}})
      		end,
      		desc = "Find word in path folder",
		},
		["<leader>fg"] = {
			":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
			desc = "Grep args",
		},
		["<leader>fd"] = {
			"<cmd>Telescope dir live_grep<CR>",
			desc = "Grep in directory",
		},
		["<leader>fD"] = {
			"<cmd>FileInDirectory<CR>",
			desc = "File in directory",
		},
		["<leader>fM"] = {
			"<cmd>Telescope bookmarks list<CR>",
			desc = "List bookmarks",
		},
		["mm"] = {
			":lua require('bookmarks').bookmark_toggle()<cr>",
			desc = "add or remove bookmark at current line",
		},
		["mc"] = {
			":lua require('bookmarks').bookmark_clean()<cr>",
			desc = "clean all marks in local buffer",
		},
		["mi"] = {
			":lua require('bookmarks').bookmark_ann()<cr>",
			desc = "add or edit mark annotation at current line",
		},
		["mn"] = {
			":lua require('bookmarks').bookmark_next()<cr>",
			desc = "jump to next mark in local buffer",
		},
		["mp"] = {
			":lua require('bookmarks').bookmark_prev()<cr>",
			desc = "jump to previous mark in local buffer",
		},
		["ml"] = {
			":lua require('bookmarks').bookmark_list()<cr>",
			desc = "show marked file list in quickfix window",
		},
    	-- tables with the `name` key will be registered with which-key if it's installed
    	-- this is useful for naming menus
    	["<leader>b"] = { name = "Buffers" },
    	["<F8>"] = { ":Tagbar<cr>", desc = "Open/Close tagbar" },
    	-- quick save
    	-- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
		["<F2>"] = {
			function ()
				local base_search_dir = vim.g.base_search_dir

				if base_search_dir==nil or base_search_dir == '' then
					base_search_dir = require("user.select-dir").load_dir()

				end
				vim.notify(base_search_dir,'info', {
  					title = "base seach dir",
      			})
			end,
			desc = "show search base directory",
		},
		["<leader><F2>"] = {
			function ()
				require("user.select-dir").get_dirs()
			end,
			desc = "modified search base directory",
		},
		["[<F2>"] = {
			function ()
				require("user.select-dir").move_prev()
			end,
			desc = "Prev of search directory",
		},
		["]<F2>"] = {
			function ()
				require("user.select-dir").move_next()
			end,
			desc = "Next of search directory",
		},
		["<leader>f<F2>"] = {
			function ()
				require("user.select-dir").dir_history()
			end,
			desc = "History of search directory",
		},

  	},

  	t = {
    	-- setting a mapping to false will disable it
    	-- ["<esc>"] = false,
  	},
	v = {
		["f"] = {
      		function()
				local base_search_dir = vim.g.base_search_dir

				if base_search_dir==nil or base_search_dir == '' then
					base_search_dir = require("user.select-dir").load_dir()
				end

  				local _, ls, cs = unpack(vim.fn.getpos("v"))
  				local _, le, ce = unpack(vim.fn.getpos("."))

  				-- nvim_buf_get_text requires start and end args be in correct order
  				ls, le = math.min(ls, le), math.max(ls, le)
  				cs, ce = math.min(cs, ce), math.max(cs, ce)
  				local word_under_cursor = vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
	  			word_under_cursor = word_under_cursor[1] or ""
  	   			require('telescope.builtin').live_grep({postfix = '  --regexp ', default_text = word_under_cursor , search_dirs = {base_search_dir}})
				-- remind in where seach
      		end,
      		desc = "Find visual word in path folder",
		},
	},
}
