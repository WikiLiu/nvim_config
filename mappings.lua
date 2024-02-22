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
	  local path = vim.fn.getreg('l')
		-- 检查 path 是否为空
if path == nil or path == '' then
    -- 如果 path 为空，则获取当前目录作为默认值
    path = vim.fn.getcwd()
end
  	  require('telescope.builtin').live_grep({search_dirs = {path}})
      end,
      desc = "Find word in current folder",
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

	
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
