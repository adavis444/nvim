-- Cursor Agent integration
return {
  'xTacobaco/cursor-agent.nvim',
  config = function()
    -- Cursor Agent keymaps
    vim.keymap.set('n', '<leader>ct', ':CursorAgent<CR>',          { desc = 'Cursor Agent: Toggle terminal' })
    vim.keymap.set('v', '<leader>cs', ':CursorAgentSelection<CR>', { desc = 'Cursor Agent: Send selection' })
    vim.keymap.set('n', '<leader>cb', ':CursorAgentBuffer<CR>',    { desc = 'Cursor Agent: Send buffer' })
  end,
}
