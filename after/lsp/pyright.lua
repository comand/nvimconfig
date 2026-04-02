return {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = true
  end,

  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportArgumentType = false,
          reportAttributeAccessIssue = false,
          reportMissingImports = false,
          reportOperatorIssue = false,
          reportOptionalSubscript = false,
          reportUndefinedVariable = false,
          reportUnusedImport = false,
          reportUnusedVariable = false,
        },
        ignore = { '*' }, -- using Ruff for linting
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'off',
        diagnosticMode = 'off',
      },
    },
  },
}
