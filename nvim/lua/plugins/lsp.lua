local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Enhanced capabilities specifically for clangd
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" }
}

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
  -- Reduce clangd's aggressiveness to prevent buffer issues
  if client.name == "clangd" then
    -- Disable semantic highlighting which can cause buffer conflicts
    client.server_capabilities.semanticTokensProvider = nil
  end
  
  -- Buffer local mappings
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

-- Servers table: add/adjust server-specific config here
local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index=false",
      "--completion-style=bundled",
      "--header-insertion=never",
    },
    init_options = {
      usePlaceholders = false,
      completeUnimported = false,
      clangdFileStatus = false,
    },
    -- keep settings empty to avoid problematic features
    settings = {},
  },

  -- Java: simple lspconfig config assuming `jdtls` is on PATH
  -- Note: jdtls typically needs per-project workspace dirs and extra
  -- features; see the "nvim-jdtls" alternative below if you want a full Java IDE.
  jdtls = {
    -- if `jdtls` is on PATH this is enough for basic attach; for richer
    -- behavior prefer nvim-jdtls (ftplugin approach) shown later
    cmd = { "jdtls" },
    -- jdtls tends to like a project-specific workspace. nvim-jdtls helpers
    -- will create/choose one automatically — see notes below.
    root_dir = require('lspconfig.util').root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
    -- example basic settings (optional)
    settings = {
      java = {
        eclipse = { downloadSources = true },
        configuration = { updateBuildConfiguration = "interactive" },
        implementationsCodeLens = { enabled = true },
      },
    },
  },

  -- Assembly: asm-lsp (supports NASM/GAS, x86/x86_64 etc)
  asm_lsp = {
    cmd = { "asm-lsp" },
    filetypes = { "asm", "s", "S", "NASM", "nasm"}, -- extend if you use other extensions
    root_dir = lspconfig.util.root_pattern(".git", "."),
    settings = {
        ["asm-lsp"] = {
            dialect = "nasm",  -- 🟢 Force NASM-style assembly
            diagnostics = {
                enabled = true,
            },
        },
    },
  },
}

-- Commonize + setup
for name, config in pairs(servers) do
  config.capabilities = capabilities
  config.on_attach = on_attach
  -- ensure table exists
  config = vim.tbl_deep_extend("force", {}, config)
  -- `lspconfig[name]` must exist in lspconfig; most common servers are included.
  -- If a server name doesn't exist, lspconfig will error — see note below.
  pcall(function() lspconfig[name].setup(config) end)
end
