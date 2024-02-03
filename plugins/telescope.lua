return{
	'nvim-telescope/telescope.nvim',
	dependencies = {
                { 
		{ "nvim-telescope/telescope-live-grep-args.nvim", },
                },
	 },
	 opts = function(_,opts)
	 	opts.defaults.mappings.i["<A-g>"] = require("telescope-live-grep-args.actions").quote_prompt()
	 	opts.defaults.mappings.i["<A-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " })
	 return opts
	 end,
}