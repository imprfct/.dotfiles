return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "html", "cssls" 
      },
    },
  },

  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = true,
  },
}
