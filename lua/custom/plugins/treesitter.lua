-- Highlight, edit, and navigate code
-- Uses the `main` branch of nvim-treesitter (the `master` branch is frozen and
-- incompatible with Neovim 0.12+). See `:help nvim-treesitter`.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- Parsers installed at setup; anything else is auto-installed on demand
    -- by the FileType autocmd below.
    ts.install {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
    }

    -- Languages that depend on vim's regex highlighting system (such as Ruby)
    -- for indent rules.
    local additional_vim_regex_highlighting = { 'ruby' }
    local indent_disable = { 'ruby', 'python' }

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true }),
      callback = function(args)
        local buf = args.buf
        local filetype = args.match

        local lang = vim.treesitter.language.get_lang(filetype)
        if not lang then
          return
        end

        local function start()
          vim.treesitter.start(buf, lang)
          if vim.tbl_contains(additional_vim_regex_highlighting, lang) then
            vim.bo[buf].syntax = 'on'
          end
          if not vim.tbl_contains(indent_disable, lang) then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end

        if vim.treesitter.language.add(lang) then
          start()
        elseif vim.tbl_contains(ts.get_available(), lang) then
          -- Auto-install missing parsers, then attach
          ts.install(lang):await(function(err)
            if not err and vim.api.nvim_buf_is_valid(buf) then
              start()
            end
          end)
        end
      end,
    })
  end,
}
