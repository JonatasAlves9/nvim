return {
	-- Vue LSP configuration
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- Configuração específica para highlight de componentes Vue
			setup = {
				vue_ls = function(_, opts)
					-- Configurar highlight groups para componentes Vue
					vim.api.nvim_create_autocmd("LspAttach", {
						group = vim.api.nvim_create_augroup("VueLspHighlight", {}),
						callback = function(args)
							local client = vim.lsp.get_client_by_id(args.data.client_id)
							if client and client.name == "vue_ls" then
								-- Configurar highlight para componentes Vue
								vim.api.nvim_set_hl(0, "@lsp.type.component", { link = "@type" })
							end
						end,
					})
				end,
			},
		},
	},
}
