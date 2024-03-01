return  {
    "iamcco/markdown-preview.nvim",
lazy = true,
    ft = { "markdown" },
    build = "cd app && yarn install",
    config = function() vim.g.mkdp_filetypes = { "markdown" } end,
  }