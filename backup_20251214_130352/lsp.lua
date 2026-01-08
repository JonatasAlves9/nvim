local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "dockerls",
          "html",
          "jsonls",
          "lua_ls",
          "marksman",
          "phpactor",
          "twiggy_language_server",
          "vimls",
          "pylsp",
          "volar",
          "vtsls",
          "tailwindcss",
          "bashls",
        },
        automatic_installation = true,
      })

      local vue_language_server_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
      }

      vim.lsp.config("vtsls", {
        capabilities = capabilities,
        filetypes = {
          "typescript",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "vue",
        },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },
      })

      vim.lsp.config("volar", {
        capabilities = capabilities,
        filetypes = { "vue" },
      })

      vim.lsp.enable("volar")
      vim.lsp.enable("vtsls")
    end,
  },
}
