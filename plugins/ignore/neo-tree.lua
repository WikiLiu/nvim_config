return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
        opts.commands.open_terminal = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            path = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h")
            
            -- 设置寄存器
            local register = '*'
            vim.cmd('let @' .. register .. ' = ' .. vim.fn.string(path))
            
            -- 构建打开终端命令并执行
            local myCommand = "ToggleTerm  dir=" .. path
            local commandString = "vim.cmd[[" .. myCommand .. "]]"
            load(commandString)()
        end
        
        opts.window.mappings.T = "open_terminal"
    end
}
