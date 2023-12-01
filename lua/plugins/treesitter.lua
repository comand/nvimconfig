return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "dockerfile",
        "glsl",
        "go",
        "html",
        "javascript",
        "json",
        "json5",
        "lua",
        "make",
        "markdown",
        "perl",
        "python",
        "regex",
        "rst",
        "ruby",
        "rust",
        "toml",
        "typescript",
        "vim",
        "yaml",
      },
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { "" }, -- List of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = true,
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
}
