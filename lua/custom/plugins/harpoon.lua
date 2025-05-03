return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      require('harpoon'):setup()

      harpoon:extend {
        UI_CREATE = function(cx)
          vim.schedule(function()
            local map = function(keys, func, desc, mode)
              mode = mode or 'n'
              vim.keymap.set(mode, keys, func, { buffer = cx.bufnr, desc = 'Harpoon: ' .. desc })
            end

            map('<M-\\>', function()
              harpoon.ui:select_menu_item { vsplit = true }
            end, 'Open Vertical Tab', 'n')
            map('<M-->', function()
              harpoon.ui:select_menu_item { split = true }
            end, 'Open Horizontal Tab', 'n')
            map('<M-t>', function()
              harpoon.ui:select_menu_item { tabedit = true }
            end, 'Edit Tab', 'n')
          end)
        end,
      }
    end,
    keys = function()
      local harpoon = require 'harpoon'

      return {
        {
          '<leader>a',
          function()
            harpoon:list():add()
          end,
          desc = 'Harpoon: Add',
        },
        -- {
        --   '<leader>ft',
        --   function()
        --     toggle_telescope(harpoon:list())
        --   end,
        --   desc = 'Harpoon (Telescope)',
        -- },
        {
          '<leader>fh',
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = 'Harpoon (Default)',
        },
        {
          '<M-h>',
          function()
            harpoon:list():select(1)
          end,
        },
        {
          '<M-t>',
          function()
            harpoon:list():select(2)
          end,
        },
        {
          '<M-n>',
          function()
            harpoon:list():select(3)
          end,
        },
        {
          '<M-s>',
          function()
            harpoon:list():select(4)
          end,
        },

        -- Toggle previous & next buffers stored within Harpoon list
        {
          '<M-j>',
          function()
            harpoon:list():prev()
          end,
        },
        {
          '<M-k>',
          function()
            harpoon:list():next()
          end,
        },
      }
    end,
  },
}
