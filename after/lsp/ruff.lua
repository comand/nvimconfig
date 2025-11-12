return {
  root_markers = {'.git', 'ruff.toml', 'pyproject.toml', 'buildMap.json' },
  init_options = {
    settings = {
      lint = {
        select = {"E", "F", "UP", "B", "SIM"},
      },
    },
  },
}
