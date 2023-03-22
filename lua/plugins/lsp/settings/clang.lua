local status_ok, clangd_extensions = pcall(require, 'clangd_extensions')
if status_ok then
  clangd_extensions.setup {
    server = {
      cmd = {'clangd',
        '--enable-config',
        '--limit-results=0',
      },
    },
  }
end

return {}
