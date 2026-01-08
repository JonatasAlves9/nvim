return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    ft = { "markdown", "mdx" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- Configurações básicas
      file_types = { "markdown", "mdx" },
      -- Renderiza markdown automaticamente ao abrir
      render_modes = { "n", "c" },
      -- Ativa anti-conceal para poder ver o código quando o cursor está na linha
      anti_conceal = {
        enabled = true,
      },
      -- Configuração de headings
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      -- Configuração de code blocks
      code = {
        enabled = true,
        sign = true,
        style = "full",
        position = "left",
        width = "full",
        left_pad = 0,
        right_pad = 0,
      },
      -- Configuração de listas
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      -- Checkbox
      checkbox = {
        enabled = true,
        unchecked = {
          icon = "󰄱 ",
        },
        checked = {
          icon = "󰱒 ",
        },
      },
      -- Quote blocks
      quote = {
        enabled = true,
        icon = "▋",
      },
      -- Pipe tables
      pipe_table = {
        enabled = true,
        style = "full",
      },
      -- Callouts (como no Obsidian)
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
      },
    },
    keys = {
      {
        "<leader>um",
        "<cmd>RenderMarkdown toggle<cr>",
        desc = "Toggle Render Markdown",
      },
    },
  },
}
