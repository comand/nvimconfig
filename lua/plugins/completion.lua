return {
  -- Snippets
  {
    'L3MON4D3/LuaSnip',
    dependencies = { "rafamadriz/friendly-snippets" },
    version = 'v2.*',
    run = 'make install_jsregexp',
    config = function()
      pcall(require, "config.site.snippets")
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = 'InsertEnter',
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-nvim-lsp-signature-help',
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "xzbdmw/colorful-menu.nvim",
      "onsails/lspkind.nvim",
    },

    config = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

      local lspkind = require('lspkind')
      lspkind.init {
        symbol_map = require('config.icons').kinds,
      }

      local luasnip = require('luasnip')

      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Replace }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Replace }),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.config.disable, -- remove the default `<C-y>` mapping.
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),

          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        preselect = cmp.PreselectMode.None,
        formatting = {
          fields = { "kind", "abbr", "menu" },

          format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
              mode = "symbol",
            })(entry, vim.deepcopy(vim_item))

            -- highlight_info is nil means we are missing the ts parser, it's
            -- better to fallback to use default `vim_item.abbr`. What this plugin
            -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
            local highlights_info = require("colorful-menu").cmp_highlights(entry)
            if highlights_info ~= nil then
              vim_item.abbr_hl_group = highlights_info.highlights
              vim_item.abbr = highlights_info.text
            end

            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            vim_item.kind = " " .. (strings[1] or "") .. " "
            vim_item.menu = ""

            return vim_item
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require('clangd_extensions.cmp_scores'),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        sources = {
          { name = "nvim_lsp",                priority = 8 },
          { name = 'nvim_lsp_signature_help', priority = 8 },
          { name = "buffer",                  priority = 7, keyword_length = 5 },
          { name = "nvim_lua",                priority = 5 },
          { name = "luasnip",                 priority = 8 },
          { name = "path",                    priority = 4 },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        experimental = {
          ghost_text = { hl_group = "CmpGhostText" },
        },
      }
    end,
  },
}
