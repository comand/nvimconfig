local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local options = {
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
    lualine_b = {},
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
		},
	},
}

local has_navic, navic = pcall(require, "nvim-navic")
if has_navic then
	options["winbar"] = {
    lualine_b = { "diagnostics" },
		lualine_c = {
			{ navic.get_location, cond = navic.is_available },
		},
	}
end

lualine.setup(options)
