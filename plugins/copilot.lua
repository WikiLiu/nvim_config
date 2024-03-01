return{
"zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup {
  filetypes = {
    markdown = true, -- overrides default
    terraform = false, -- disallow specific filetype
    sh = function ()
      if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
        -- disable for .env files
        return false
      end
      return true
    end,
  },
}
  end,

}