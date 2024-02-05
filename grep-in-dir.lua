local builtin = require("telescope.builtin")
local extensions =  require('telescope').extensions.live_grep_args
local get_dirs = require("dir-telescope.util").get_dirs

local M = {}

M.GrepInDirectory = function(opts)
  --get_dirs(opts, builtin.live_grep)
	get_dirs(opts, extensions.live_grep_args)
end

return M
