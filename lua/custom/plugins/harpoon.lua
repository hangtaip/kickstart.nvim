return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}

      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Add to List' })
      vim.keymap.set('n', '<C-e>', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open Harpoon Window' })

      vim.keymap.set('n', '<M-h>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<M-t>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<M-n>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<M-s>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<Tab>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<S-Tab>', function()
        harpoon:list():next()
      end)

      harpoon:extend {
        UI_CREATE = function(cx)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = cx.buf, desc = 'LSP: ' .. desc })
          end

          map('<M-\\>', harpoon.ui:select_menu_item { vsplit = true }, 'Open Vertical Tab', 'n')
          map('<M-->', harpoon.ui:select_menu_item { split = true }, 'Open Horizontal Tab', 'n')
          map('<M-t>', harpoon.ui:select_menu_item { tabedit = true }, 'Edit Tab', 'n')
        end,
      }
    end,
  },
}
