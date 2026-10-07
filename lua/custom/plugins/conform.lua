-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false, -- Disable error notifications
    format_on_save = function(bufnr)
      -- Don't autoformat this config's init.lua, to keep its hand-managed layout
      local filename = vim.api.nvim_buf_get_name(bufnr)
      if filename == vim.fn.stdpath 'config' .. '/init.lua' then
        return false
      end

      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 2000,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- oxfmt resolves from the project's node_modules, so repos that use it
      -- (e.g. ~/analytics) get their .oxfmtrc.json; others fall back to prettier.
      javascript = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
      json = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
      css = { 'stylelint' },
      less = { 'stylelint' },
      rust = { 'rustfmt' },
      sh = { 'shellcheck' },
      terraform = { 'terraform_fmt' },
      toml = { 'taplo' },
      typescript = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
    },
    formatters = {
      -- Match the repo's lint-staged invocation
      oxfmt = { prepend_args = { '--disable-nested-config' } },
    },
  },
}
