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
        clangd = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "love", "vim" },
              },
              workspace = {
                library = {
                  "${3rd}/love2d/library",
                },
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
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
