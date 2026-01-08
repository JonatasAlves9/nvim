-- Overrides profissionais para Vue.js
-- O LazyVim extra (lazyvim.plugins.extras.lang.vue) já configura:
-- - Volar (vue_ls)
-- - TypeScript + Vue plugin
-- - Treesitter para Vue
--
-- Este arquivo adiciona apenas customizações extras

return {
  -- Override do Volar com configurações específicas
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Adiciona TailwindCSS para arquivos Vue
      if opts.servers.tailwindcss then
        vim.list_extend(opts.servers.tailwindcss.filetypes or {}, { "vue" })
        opts.servers.tailwindcss.init_options = vim.tbl_deep_extend("force", opts.servers.tailwindcss.init_options or {}, {
          userLanguages = {
            vue = "html",
          },
        })
      end

      -- Configurações avançadas do Volar
      opts.servers.volar = vim.tbl_deep_extend("force", opts.servers.volar or {}, {
        init_options = {
          vue = {
            hybridMode = false, -- Usar apenas Volar (não Vetur)
          },
          typescript = {
            tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
          },
        },
      })

      -- Melhorias no VTSLS para Vue
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
        settings = {
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
        },
      })

      -- Setup hook para configurar highlights personalizados
      opts.setup = opts.setup or {}
      opts.setup.volar = function()
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("VueCustomHighlights", { clear = true }),
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "volar" then
              -- Highlight customizado para componentes Vue
              vim.api.nvim_set_hl(0, "@lsp.type.component.vue", { link = "@constructor" })
              vim.api.nvim_set_hl(0, "@lsp.type.property.vue", { link = "@property" })
              vim.api.nvim_set_hl(0, "@tag.vue", { link = "@tag" })
            end
          end,
        })
      end

      return opts
    end,
  },

  -- Conform: formatação para Vue
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        vue = { "prettier" },
      },
    },
  },

  -- nvim-lint: linting para Vue
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        vue = { "eslint_d" },
      },
    },
  },
}
