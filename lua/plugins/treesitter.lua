return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
    build = ":TSUpdate",
    lazy = false,
    branch = 'master',
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "doxygen",
        "glsl",
        "go",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "perl",
        "python",
        "query",
        "regex",
        "rst",
        "rust",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { "" }, -- List of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = { "python" },
      },
      indent = {
        enable = false,
        --disable = { "yaml", "python" },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["i,"] = "@parameter.inner",
            ["a,"] = "@parameter.outer",
            ["if"] = "@function.inner",
            ["af"] = "@function.outer",
            ["iC"] = "@class.inner",
            ["aC"] = "@class.outer",
            ["ic"] = "@call.inner",
            ["ac"] = "@call.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      { 'nvim-treesitter', branch = 'master' },
    },
    branch = 'master',
    event = { "BufNewFile", "BufReadPost" },
  },
}
