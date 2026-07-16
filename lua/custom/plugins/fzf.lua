return {
  'junegunn/fzf.vim', -- Faster fuzzy searching via fzf + ripgrep/Ag
  dependencies = { 'junegunn/fzf' },
  config = function()
    vim.keymap.set('n', '<leader>sa', ':Ag!<CR>', { desc = '[S]earch with [A]g' })
    vim.g.fzf_preview_window = { 'up', 'ctrl-p' }
  end,
}
