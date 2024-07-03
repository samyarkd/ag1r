return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {},
  config = function()
    local Terminal = require('toggleterm.terminal').Terminal

    local terminals = {}

    local function create_terminal(cmd, keymap, desc)
      local term = Terminal:new {
        cmd = cmd,
        direction = 'float',
        float_opts = {
          border = 'double',
        },
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', keymap, '<cmd>lua _G.' .. desc .. '_toggle()<CR>', { noremap = true, silent = true })
        end,
        on_close = function()
          vim.cmd 'startinsert!'
        end,
      }

      local function toggle_terminal()
        -- Close all other terminals
        for _, t in pairs(terminals) do
          if t ~= term and t:is_open() then
            t:close()
          end
        end
        -- Toggle the current terminal
        term:toggle()
      end

      -- Ensure the global function is unique by using a unique identifier
      local function_name = desc .. '_toggle'
      _G[function_name] = toggle_terminal

      vim.api.nvim_set_keymap('n', keymap, '<cmd>lua _G.' .. function_name .. '()<CR>', { noremap = true, silent = true, desc = desc })
      vim.api.nvim_set_keymap('t', keymap, '<cmd>lua _G.' .. function_name .. '()<CR>', { noremap = true, silent = true, desc = desc })

      -- Add the terminal to the list of terminals
      table.insert(terminals, term)

      return term
    end

    -- Create terminals
    create_terminal('lazygit', '<leader>gg', 'lazygit')
    -- TODO: change this in a way to  use the current open terminal
    create_terminal('powershell', '<A-1>', 'powerone')
    create_terminal('powershell', '<A-2>', 'powertwo')
    create_terminal('powershell', '<A-3>', 'powerthree')
  end,
}
