return {
  {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        extensions = {
          file_browser = {
            hidden = { file_browser = true, folder_browser = true },
          },
        },
      }
    end,
  },
}
