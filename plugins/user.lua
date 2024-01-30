return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    branch = "master",
    priority = 1000,
    config = function()
      local monokai = require("monokai-pro")
      monokai.setup({
        transparent_background = false,
        devicons = true,
        filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
        day_night = {
          enable = false,
          day_filter = "classic",
          night_filter = "spectrum",
        },
        inc_search = "background", -- underline | background
        background_clear = { "toggleterm" },
        plugins = {
          bufferline = {
            underline_selected = true,
            underline_visible = false,
            bold = false,
          },
          indent_blankline = {
            context_highlight = "pro", -- default | pro
            context_start_underline = true,
          },
        },
        override = function(c)
          return {
            ColorColumn = { bg = c.base.dimmed3 },
            -- Mine
            DashboardRecent = { fg = c.base.magenta },
            DashboardProject = { fg = c.base.blue },
            DashboardConfiguration = { fg = c.base.white },
            DashboardSession = { fg = c.base.green },
            DashboardLazy = { fg = c.base.cyan },
            DashboardServer = { fg = c.base.yellow },
            DashboardQuit = { fg = c.base.red },
          }
        end,
      })
      monokai.load()
    end,
  },
 {
    "preservim/tagbar",
    lazy = false,
},

{
    "goolord/alpha-nvim",
    opts = function(_, opts) -- override the options using lazy.nvim
        opts.section.header.val = {
"                    🟩🟩🟩🟩🟩",
"              🟩🟩🟩🟩🟩🟩🟩🟩⬛⬛⬛⬛⬛⬛",
"            🟩🟩🟩🟩🟩🟩🟩🟩🟩🟨🟨🟨🟨🟨⬛",
"          🟩🟩🟩🟩🟩🟩🟩🟩🟩🟨🟨🟨🟨🟨🟨⬛",
"      🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟨🟨🟨🟨🟨🟨⬛",
"  🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟨🟨🟨🟧🟨🟨⬛",
"🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟨🟨🟨🟨🟨🟫🟫",
"⬛🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟨🟨🟨🟨🟧🟨🟨⬛",
"  ⬛⬛⬛⬛🟩🟩🟩🟩🏻🟨🟩🟨🟨🟨🟨🏻🟨⬛",
"          ⬛⬛🟩🟩🏻🏻🟨⬛🟧🟨🏻⬛🟫⬛",
"          ⬛🟧⬛⬛🟧🏻🟨⬛🟨🟧🏻⬜🟦🟨⬛",
"          ⬛🟧🟫⬛⬛🟧⬛⬛🟨🟫🏻⬜🟦🟨⬛",
"          ⬛🟧🟫⬛⬛🟧⬛🟨🟨🟫🏻🏻🟨⬛",
"          ⬛🟧🟫⬛⬛⬛⬛🟨🟫🟧🟨🟨⬛      ⬛",
"          ⬛🟧🟧🟧⬛🟩⬛🟨⬛⬛⬛⬛⬜🟫🟫⬛🟦⬛🟦🟦🟦🟦🟦🟦",
"            ⬛🟧⬛⬛🟩🟩⬛🟩🟩🟩🟩🟩🏻🏻⬛🟦⬛🏽🏽🏽🏽🏽🏽🟦",
"              ⬛⬛⬛🟩🟩🟩🟩🟩🟩🟩🟩🏻🏻⬛🟦⬛🏽🏽🏽🏽🏽🏽🟦",
"              🟫⬛🟩⬛🟩🟩🟩🟩🟩🟩🟩⬛⬛⬛🟦⬛🟦🟦🟦🟦🟦🟦",
"            ⬛🟫⬛🟩🟩⬛⬛⬛⬛⬛🟩🟩⬛    ⬛⬛",
"            ⬛🟫⬛🟩🟩🟩🟩🟩🟩🟩🟩⬛⬛⬛",
"            ⬛⬛🟫⬛🟩🟩🟩🟩🟩🟩⬛🟥🟥🟥⬛",
"              ⬛⬛⬛⬛⬛⬛⬛⬛⬛🟥🟥🟥🟥🟥⬛",
"                                ⬛⬛⬛⬛⬛",
	}
    end,
},
{
  'stevearc/overseer.nvim',
  opts = {},
}

}
