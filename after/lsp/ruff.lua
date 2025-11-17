return {
  root_markers = {'.git', 'ruff.toml', 'pyproject.toml', 'buildMap.json' },
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
  init_options = {
    settings = {
      lint = {
        select = {"E", "F", "UP", "B", "SIM"},
      },
    },
  },
}
