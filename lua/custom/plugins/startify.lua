return {
  'mhinz/vim-startify', -- Fancy start screen for Neovim
  config = function()
    -- Custom startify sections
    vim.g.startify_lists = {
      { type = 'files', header = { '   Recent Files' } },
      { type = 'dir', header = { '   Current Directory: ' .. vim.fn.getcwd() } },
      { type = 'sessions', header = { '   Sessions' } },
      { type = 'bookmarks', header = { '   Bookmarks' } },
      { type = 'commands', header = { '   Commands' } },
    }

    -- Custom bookmarks
    vim.g.startify_bookmarks = {
      -- In load order
      { zp = '~/.zprofile' },
      { zr = '~/.zshrc' },
      { bp = '~/.bash_profile' },
      { br = '~/.bashrc' },
      { ba = '~/.bash_aliases' },
      -- other bookmarks
      { il = '~/.config/nvim/init.lua' },
      -- python
      { sp = './.venv/python-3.12/lib/python3.12/site-packages' },
      { pt = './pyproject.toml' },
      { env = './.envrc' },
      { pyright = './pyrightconfig.json' },
      { x = '~/optim/x' },
    }

    -- Other settings
    vim.g.startify_session_autoload = 1 -- Automatically load session if one exists
    vim.g.startify_session_delete_buffers = 1 -- Delete all buffers when loading/creating session
    vim.g.startify_change_to_vcs_root = 1 -- Change to project root when opening file
    vim.g.startify_fortune_use_unicode = 1 -- Use Unicode for fortune messages
    vim.g.startify_padding_left = 3 -- Add padding on the left
    vim.g.startify_session_persistence = 1 -- Automatically update sessions
    vim.g.startify_enable_special = 1 -- Show <empty buffer> and <quit> entries
    vim.g.startify_session_dir = '~/.config/nvim/session' -- Directory to store sessions

    vim.g.startify_custom_indices = vim.fn.map(vim.fn.range(1, 100), 'string(v:val)') -- start numbering from 1 instead of 0

    -- Open startify on new tab
    vim.g.startify_new_tab = 1

    vim.g.startify_commands = {
      { ch = { 'Health Check', ':checkhealth' } },
      { ps = { 'Plugin Sync', ':Lazy sync' } },
    }
  end,
}
