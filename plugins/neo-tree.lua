	  local get_path = function(state)
	     local node = state.tree:get_node()
		 if node.type == 'directory' then
			return node.path
		 end
		 return node:get_parent_id()
	  end
	  local do_setcd = function(state)
		 local p = get_path(state)
	     print(p) -- show in command line
         vim.cmd(string.format('exec(":lcd %s")',p))
		 return p
	  end


return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = function(_, opts)
        opts.commands.copy_locate_path = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            path = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h")
		path = path..'/'
	    vim.fn.setreg('l', path)
								require("user.select-dir").save_unique_string(path)
								vim.notify(path,'info', {
  									title = "base seach dir",
      							}) 
	    path = vim.fn.fnamemodify(path, ":~:.:h")
            
            -- 设置寄存器
            local register = '*'
            vim.cmd('let @' .. register .. ' = ' .. vim.fn.string(path))
        end
	opts.commands.grep_in_path = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            path = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h")
            require('telescope.builtin').live_grep({search_dirs = {path}})
        end
	opts.commands.spectre  = function(state)
				local p = do_setcd(state)
				require('spectre').open({
				  is_insert_mode = true,
				  cwd = p,
				  is_close = false, -- close an exists instance of spectre and open new
				})
        end
        
        opts.window.mappings.L = "copy_locate_path"
	opts.window.mappings.G = "grep_in_path"
	opts.window.mappings["<leader>r"] = "spectre"
	
    end
}
