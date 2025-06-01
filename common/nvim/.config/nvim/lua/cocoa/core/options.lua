vim.opt.runtimepath:remove('usr/share/vim/vimfiles')
vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)

-- [[ Line Numbers ]]
vim.wo.number = true
vim.o.relativenumber = true

-- [[ Formatting ]]
vim.o.wrap = false
vim.o.linebreak = true
vim.o.autoindent = true -- Copy indent from current line
vim.o.shiftwidth = 2 -- Num spaces for each indent
vim.o.tabstop = 2 -- Insert n spaces for a tab
vim.o.softtabstop = 2 -- Num spaces tab counts when performing operations
vim.o.expandtab = true -- Convert tab to spaces
vim.o.numberwidth = 2 -- Column Width
vim.o.smartindent = true
vim.o.showtabline = 2 -- Always show tabs
vim.o.breakindent = true

-- [[ Search ]]
vim.o.ignorecase = true -- Case insensitive searching unless \C in search
vim.o.smartcase = true
vim.opt.iskeyword:append('-') -- Hyphenated words recognized by searches

-- [[ Navigation ]]
vim.o.scrolloff = 4 -- Minimal number of screen lines to keep above & below cursor
vim.o.sidescrolloff = 8 -- Minimal number of screen columns either side of the cursor if wrap is false
vim.o.cursorline = false -- Highlight the current line
vim.o.splitbelow = true -- Force all horizontal splits to go below the current window
vim.o.splitright = true -- Force all vertical splits to go to the right of the current window
vim.o.hlsearch = true -- Highlight on search
vim.o.showmode = false
vim.o.whichwrap = 'bs<>[]hl' -- Which "horizontal" keys are allowed to travel to prev/next line
vim.o.backspace = 'indent,eol,start' -- Allow backspace
vim.o.pumheight = 10 -- Pop up menu height
vim.o.cmdheight = 1 -- More space in the Neovim command line for displaying messages
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience

-- [[ Misc ]]
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.autoread = true -- Automatically reload files on external changes
vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS & Neovim
vim.o.swapfile = false
vim.o.fileencoding = 'utf-8' -- The encoding written to a file
vim.o.conceallevel = 0 -- So that `` is visible in markdown files
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds)
vim.o.backup = false -- Creates a backup file
vim.o.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.undofile = true -- Save undo history
vim.opt.shortmess:append('c') -- Don't give |ins-completion-menu| messages
vim.opt.formatoptions:remove({ 'c', 'r', 'o' }) -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
