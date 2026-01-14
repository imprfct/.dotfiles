local nvlsp = require("nvchad.configs.lspconfig")

local function apply_defaults(config)
  config.on_attach = nvlsp.on_attach
  config.on_init = nvlsp.on_init
  config.capabilities = nvlsp.capabilities
  return config
end

local servers = { "html", "cssls" }

for _, server in ipairs(servers) do
  vim.lsp.config[server] = apply_defaults({})
  vim.lsp.enable(server)
end

vim.lsp.config["omnisharp"] = apply_defaults({
  cmd = { [[C:\OmniSharp\OmniSharp.exe]], "-lsp" },
  
  settings = {
    RoslynExtensionsOptions = {
      enableDecompilationSupport = true,
      enableImportCompletion = true,
      enableAnalyzers = true,
    },
    FormattingOptions = {
      EnableEditorConfigSupport = true,
    }
  },
  
  handlers = {
    ["textDocument/definition"] = function(...)
      return require("omnisharp_extended").handler(...)
    end,
  },
})

vim.lsp.enable("omnisharp")
