return {
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = false,
    opts = {
      automatic_installation = false,
      ensure_installed = {},
    },
  },
  {
    "mason-org/mason.nvim",
    enabled = false,
    opts = {
      auto_install = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {},
        nil_ls = {},
        bashls = {},
        gdscript = {},
        csharp_ls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
              }
            }
          }
        },
      },
    },
  },
}
