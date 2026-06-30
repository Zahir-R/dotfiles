return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        csharp_ls = {
          cmd_env = {
            DOTNET_ROOT = "/run/current-system/sw/share/dotnet"
          }
        },
        gdscript = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
}
