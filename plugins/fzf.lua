return{ 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf', build = ':call fzf#install()' ,"gfanto/fzf-lsp.nvim"},  event = "VimEnter",
	lazy=false,}