local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local function lazy_fg(name)
  ---@type {foreground?:number}?
  ---@diagnostic disable-next-line: deprecated
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
    or vim.api.nvim_get_hl_by_name(name, true)
  ---@diagnostic disable-next-line: undefined-field
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format("#%06x", fg) } or nil
end
local status_utils = require "astronvim.utils.status.utils"
local utils = require "astronvim.utils"
local extend_tbl = utils.extend_tbl
local hl = require "astronvim.utils.status.hl"
local init = require "astronvim.utils.status.init"
function copilot_status(opts)
      local colors = {
        [""] = lazy_fg("Special"),
        ["Normal"] = lazy_fg("Special"),
        ["Warning"] = lazy_fg("DiagnosticError"),
        ["InProgress"] = lazy_fg("DiagnosticWarn"),
      }
    print(require("copilot.api").status.data.message)
  opts = extend_tbl({
    copilot_status = { str = require("copilot.api").status.data.message, icon = { kind = "Copilot", padding = { right = 1 } } },
    surround = {
      separator = "right",
      color = function()
          if not package.loaded["copilot"] then
            return
          end
          local status = require("copilot.api").status.data
          return colors[status.status] or colors[""]
        end,
      condition = function()
          if not package.loaded["copilot"] then
            return
          end
          local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
          if not ok then
            return false
          end
          return ok and #clients > 0
        end
    },
    hl = hl.get_attributes "treesitter",
    update = { "OptionSet", pattern = "syntax" },
    init = init.update_events { "InsertEnter", "LspAttach"},
  }, opts)
  return status_utils.setup_providers(opts, { "copilot_status" })
end



return {

    -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },


  -- copilot cmp source
  {
    "nvim-cmp",
    event = { "InsertEnter", "LspAttach" },
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
	
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)

-- lspkind.lua
local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

      table.insert(opts.sources, 1, {
        name = "copilot",
      group_index = 1,
      priority = 100,
      })
local cmp = require'cmp'
opts.mapping["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end)

    end,

  },


  -- {
  -- "rebelot/heirline.nvim",
  -- event = "BufEnter",
  --   opts = function(_, opts)
  --     table.insert(opts.statusline,11, copilot_status())
  --     return opts
  --   end,
  -- },
  --
}