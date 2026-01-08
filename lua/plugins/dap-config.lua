local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Dart adapter
      dap.adapters.dart = {
        type = "executable",
        command = "/Users/jonatas/development/flutter/bin/cache/dart-sdk/bin/dart",
        args = { "debug_adapter" },
      }

      -- Flutter adapter
      dap.adapters.flutter = {
        type = "executable",
        command = "/Users/jonatas/development/flutter/bin/flutter",
        args = { "debug_adapter" },
      }

      dap.configurations.dart = {
        -- Dart CLI apps
        {
          type = "dart",
          request = "launch",
          name = "Launch Dart (CLI)",
          dartSdkPath = "/Users/jonatas/development/flutter/bin/cache/dart-sdk/bin/dart",
          program = function()
            return vim.fn.input("Path to main.dart: ", vim.fn.getcwd() .. "/bin/main.dart", "file")
          end,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        -- Flutter apps
        {
          type = "flutter",
          request = "launch",
          name = "Launch Flutter",
          dartSdkPath = "/Users/jonatas/development/flutter/bin/cache/dart-sdk/bin/dart",
          flutterSdkPath = "/Users/jonatas/development/flutter/bin/flutter",
          program = function()
            return vim.fn.input("Path to main.dart: ", vim.fn.getcwd() .. "/lib/main.dart", "file")
          end,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      }

      ---------------------------------------------------------------------------
      --  Javascript/Typescript
      -----------------------------------------------------------------------------
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Debug single nodejs files
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug web applications (client side)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          },
          -- Divider for the launch.json derived configs
          {
            name = "----- ↓ launch.json configs ↓ -----",
            type = "",
            request = "launch",
          },
        }
      end

      dapui.setup()
      -- Configuração do DAP UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      -- Adicionando keymaps com descrições
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>da", dap.continue, { desc = "Continue Debugging" })

      -- Voltar (Close the UI)
      vim.keymap.set("n", "<Leader>dc", dapui.close, { desc = "Close DAP UI" })

      -- Abrir ou fechar o DAP UI
      vim.keymap.set("n", "<Leader>do", function()
        dapui.open()
      end, { desc = "Open DAP UI" })
    end,
  },
}
