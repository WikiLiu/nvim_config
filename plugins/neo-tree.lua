return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
        opts.commands.copy_locate_path = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            path = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h")
            
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
        
        opts.window.mappings.L = "copy_locate_path"
	opts.window.mappings.G = "grep_in_path"
    end
}
