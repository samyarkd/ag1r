return {
  'nvimdev/dashboard-nvim',
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  opts = function()
    local logo = [[
         ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
         ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
         ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
         ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
         ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
         ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    logo = string.rep('\n', 8) .. logo .. '\n\n'

    local opts = {
      theme = 'doom',
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, '\n'),
        -- stylua: ignore
        center = {
          {
            action = "Telescope find_files",
            desc = " Find File",
            icon = " ",
            key = "f"
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n"
          },
          {
            action = "Telescope oldfiles",
            desc = " Recent Files",
            icon = " ",
            key = "r"
          },
          {
            action = "Telescope live_grep",
            desc = " Find Text",
            icon = " ",
            key = "g"
          },
          {
            action = function()
              require("telescope.builtin").find_files { cwd = vim.fn.stdpath 'config' }
            end,
            desc = " Config",
            icon = " ",
            key = "c"
          },
          -- {
          --   action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
          -- {
          -- action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
          {
            action = "Lazy",
            desc = " Lazy",
            icon = "󰒲 ",
            key = "l"
          },
          {
            action = function() vim.api.nvim_input("<cmd>qa<cr>") end,
            desc = " Quit",
            icon = " ",
            key = "q"
          },
        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
      button.key_format = '  %s'
    end

    -- open dashboard after having no buffers
    vim.defer_fn(function()
      vim.api.nvim_create_autocmd('BufDelete', {
        group = vim.api.nvim_create_augroup('open-dashboard-after-last-buffer-close', { clear = true }),
        callback = function(event)
          for buf = 1, vim.fn.bufnr(0) do
            if buf ~= event.buf and vim.fn.buflisted(buf) == 1 then
              if vim.api.nvim_buf_get_name(buf) ~= '' and vim.bo[buf].filetype ~= 'dashboard' then
                return
              end
            end
          end

          vim.cmd 'Dashboard'
        end,
      })
    end, 0)

    -- open dashboard after closing lazy
    if vim.o.filetype == 'lazy' then
      vim.api.nvim_create_autocmd('WinClosed', {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds('UIEnter', { group = 'dashboard' })
          end)
        end,
      })
    end

    return opts
  end,
}
