if vim.g.neovide then
  -- Gui font
  if vim.loop.os_uname().sysname == "Darwin" then
    vim.o.guifont = "CommitMono,Symbols_Nerd_Font_Mono:h14"
  else
    vim.o.guifont = "CommitMono,Symbols_Nerd_Font_Mono:h10.5"
  end

  -- Floating windows
  vim.g.neovide_floating_z_height = 5
  vim.g.neovide_floating_corner_radius = 0.5
  vim.g.neovide_floating_shadow = false

  vim.g.neovide_hide_mouse_when_typing = true

  -- No cursor animations
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00

  vim.g.neovide_remember_window_size = true
  -- This only works when passing neovide --grid
  vim.opt.lines = 71
  vim.opt.columns = 122
end
