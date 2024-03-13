if vim.g.neovide then
  vim.o.guifont = "CommitMono,Symbols_Nerd_Font_Mono:h10.5"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_padding_top = 2
  vim.g.neovide_padding_bottom = 2
  -- vim.g.neovide_padding_left = 5
  -- vim.g.neovide_padding_right = 5
  vim.g.neovide_floating_z_height = 5

  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_hide_mouse_when_typing = true

  -- This only works when passing neovide --grid
  vim.opt.lines = 71
  vim.opt.columns = 122
end
