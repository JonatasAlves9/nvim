-- Garantir instalação de todas as ferramentas necessárias via Mason
-- Apenas ferramentas ESSENCIAIS - o LazyVim já instala automaticamente
-- os LSPs configurados nos extras (typescript, json, etc.)
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Formatters
        "prettier", -- JS/TS/Vue/CSS/JSON/etc (essencial)
        "stylua", -- Lua

        -- Linters
        "eslint_d", -- ESLint (daemon - mais rápido)
      })
    end,
  },
}
