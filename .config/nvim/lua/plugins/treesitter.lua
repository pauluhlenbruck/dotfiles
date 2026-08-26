return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "bash", "lua", "vimdoc", "markdown", "markdown_inline", "python" },
        auto_install = false,
        ignore_install = { "javascript" },
        indent = { enable = true },
        highlight = { enable = true },
      }
    end
  }
}
