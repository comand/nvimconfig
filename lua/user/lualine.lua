local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local navic = require('nvim-navic')

lualine.setup {
  extensions = {
    "fugitive",
    "man",
    "mundo",
    "quickfix",
    "toggleterm"
  },
  disabled_filetypes = {
    statusline = {},
    winbar = {
      "help",
      "Trouble",
      "packer",
      "toggleterm",
    },
  },
	sections = {
    lualine_b = {
      "branch",
      "diagnostics"
    },
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 1,
				symbols = {
					modified = " ",
					readonly = " ",
				},
			},
      { navic.get_location, cond = navic.is_available },
		},
    lualine_x = {
      "filetype"
    },
	},
}
