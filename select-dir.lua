local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local flatten = vim.tbl_flatten

local M = {}
-- 之后可以加上cache到vim内存中
local project_root = vim.fn.getcwd()
-- 将键值对持久化保存到文件
M.keep_dir = function(base_search_dir)
    local cache_dir = project_root .. '/.cache'
    local cache_file = cache_dir .. '/base_search_dir'
    if not vim.fn.isdirectory(cache_dir) then
        os.execute('mkdir -p ' .. cache_dir)
    end   
    -- 读取文件中的所有行
    local existing_lines = {}
    local file = io.open(cache_file, "r")
    if file then
        for line in file:lines() do
            table.insert(existing_lines, line)
        end
        file:close()
    end
    
    -- 检查新的 base_search_dir 是否已经存在
    local is_duplicate = false
    for i, line in ipairs(existing_lines) do
        if line == base_search_dir then
            is_duplicate = true
            -- 删除原来的行
            table.remove(existing_lines, i)
            break
        end
    end
    
    -- 将新的 base_search_dir 插入到 existing_lines 中
    table.insert(existing_lines, base_search_dir)
    
    -- 如果超过20行则删除第一行
    if #existing_lines > 20 then
        table.remove(existing_lines, 1)
    end
    
    -- 写入文件
    local f = io.open(cache_file, 'w')
    if f then
        for _, line in ipairs(existing_lines) do
            f:write(line .. '\n')
        end
        f:close()
        print("write" .. base_search_dir)
    end
end


-- 从文件加载键值对
M.load_dir = function()
    local cache_dir = project_root .. '/.cache'
    local cache_file = cache_dir .. '/base_search_dir'
    
    -- 如果文件不存在或为空，则返回空字符串
    if not vim.fn.filereadable(cache_file) then
        return vim.fn.getcwd()
    end
    local lines = {}
    for line in io.lines(cache_file) do
        lines[#lines + 1] = line
    end
    if lines[#lines] == nil or lines[#lines] == '' then
	return vim.fn.getcwd()
end
	vim.g.dir_history = lines
	print(#vim.g.dir_history)
    return lines[#lines]
end


local opts_in = {
	hidden = true,
	debug = false,
	no_ignore = false,
	show_preview = true,
}

M.get_dirs = function()

	local find_command = (function()
		if opts_in.find_command then
			if type(opts_in.find_command) == "function" then
				return opts_in.find_command(opts_in)
			end
			return opts_in.find_command
		elseif 1 == vim.fn.executable("fd") then
			return { "fd", "--type", "d", "--color", "never" }
		elseif 1 == vim.fn.executable("fdfind") then
			return { "fdfind", "--type", "d", "--color", "never" }
		elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
			return { "find", ".", "-type", "d" }
		end
	end)()

	if not find_command then
		vim.notify("dir-telescope", {
			msg = "You need to install either find, fd",
			level = vim.log.levels.ERROR,
		})
		return
	end

	local command = find_command[1]
	local hidden = opts_in.hidden
	local no_ignore = opts_in.no_ignore

	if opts_in.respect_gitignore then
		vim.notify("dir-telescope: respect_gitignore is deprecated, use no_ignore instead", vim.log.levels.ERROR)
	end

	if command == "fd" or command == "fdfind" or command == "rg" then
		if hidden then
			find_command[#find_command + 1] = "--hidden"
		end
		if no_ignore then
			find_command[#find_command + 1] = "--no-ignore"
		end
	elseif command == "find" then
		if not hidden then
			table.insert(find_command, { "-not", "-path", "*/.*" })
			find_command = flatten(find_command)
		end
		if no_ignore ~= nil then
			vim.notify(
				"The `no_ignore` key is not available for the `find` command in `get_dirs`.",
				vim.log.levels.WARN
			)
		end
	else
		vim.notify("dir-telescope: You need to install either find or fd/fdfind", vim.log.levels.ERROR)
	end

	local getPreviewer = function()
		if opts_in.show_preview then
			return conf.file_previewer(opts_in)
		else
			return nil
		end
	end
	vim.fn.jobstart(find_command, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				pickers
					.new(opts_in, {
						prompt_title = "Select a Directory",
						finder = finders.new_table({ results = data, entry_maker = make_entry.gen_from_file(opts_in) }),
						previewer = getPreviewer(),
						sorter = conf.file_sorter(opts_in),
						attach_mappings = function(prompt_bufnr)
							action_set.select:replace(function()
								local current_picker = action_state.get_current_picker(prompt_bufnr)
								local dirs = {}
								local selections = current_picker:get_multi_selection()
								if vim.tbl_isempty(selections) then
									table.insert(dirs, action_state.get_selected_entry().value)
								else
									for _, selection in ipairs(selections) do
										table.insert(dirs, selection.value)
									end
								end
								actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
								local root = vim.fn.getcwd()
								if #dirs == 1 then vim.g.base_search_dir = root .. '/' ..dirs[1] end
								M.keep_dir(root .. '/' ..dirs[1])
								table.insert(vim.g.dir_history,vim.g.base_search_dir)
								vim.fn.setreg('l', vim.g.base_search_dir)
								vim.notify(root .. '/' ..dirs[1],'info', {
  									title = "base seach dir",
      							}) 
							end)
							return true
						end,
					})
				:find()

			else
				vim.notify("No directories found", vim.log.levels.ERROR)
			end
		end,
	})
end


local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
   error "This plugins requires nvim-telescope/telescope.nvim"
end
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local entry_display = require "telescope.pickers.entry_display"
local conf = require("telescope.config").values
local config = require("bookmarks.config").config
local utils = require "telescope.utils"

local function get_text()
	    local cache_dir = project_root .. '/.cache'
   	 local cache_file = cache_dir .. '/base_search_dir'
	local file = io.open(cache_file, "r")
	local dirHistory = {}  -- 创建一个空的 table 来存储目录历史记录   这个目录还是不好 应该加上root判断条件
    if file then
    	for line in file:lines() do
		print(line)
        	table.insert(dirHistory, 1, line)
    	end
    	return dirHistory
    else
    	return nil
end
end

M.dir_history = function(opts)
    opts = opts or {}
    local dirlist = get_text()

    local picker = pickers.new(opts, {
        prompt_title = "folder_history",
        finder = finders.new_table(dirlist),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                if selection == nil or selection.value == '' then
                    vim.g.base_search_dir = vim.fn.getcwd()
                else
                    vim.g.base_search_dir = selection.value
                end
		M.keep_dir(vim.g.base_search_dir)
	   	 vim.fn.setreg('l', vim.g.base_search_dir)
		vim.notify(vim.g.base_search_dir,'info', {
  			title = "base seach dir",
      			})
		actions.close(prompt_bufnr)
            end)
            return true
        end,
    }):find()
end
return M
