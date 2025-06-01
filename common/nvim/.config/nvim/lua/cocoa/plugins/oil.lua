return {
  'stevearc/oil.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
      natural_order = 'fast',
    },
    use_default_keymaps = false,
    keymaps = {
      ['<C-c>'] = false,
      ['g?'] = { 'actions.show_help', mode = 'n' },
      ['<CR>'] = 'actions.select',
      ['<C-_>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-|>'] = { 'actions.select', opts = { horizontal = true } },
      ['<C-p>'] = 'actions.preview',
      ['-'] = { 'actions.parent', mode = 'n' },
      ['_'] = { 'actions.open_cwd', mode = 'n' },
      ['`'] = { 'actions.cd', mode = 'n' },
      ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
      ['q'] = 'actions.close',
    },
    -- Configuration for the floating action confirmation window
    confirmation = {
      -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a single value or a list of mixed integer/float types.
      -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
      max_width = 0.9,
      -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
      min_width = { 40, 0.4 },
      -- optionally define an integer/float for the exact width of the preview window
      width = nil,
      -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_height and max_height can be a single value or a list of mixed integer/float types.
      -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
      max_height = 0.9,
      -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
      min_height = { 5, 0.1 },
      -- optionally define an integer/float for the exact height of the preview window
      height = nil,
      border = 'rounded',
      win_options = {
        winblend = 0,
      },
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 0,
    },
    win_options = {
      wrap = true,
      winblend = 0,
    },
  },
  keys = {
    { '-', '<CMD>Oil --float<CR>', desc = 'Open parent directory', mode = 'n' },
  },
}
