return {
  on_attach = function(_, bufnr)
    vim.keymap.set('n', '<C-H>', ':ClangdSwitchSourceHeader<CR>',
      {
        remap = true,
        silent = true,
        buffer = bufnr,
        desc = 'Switch to source/header file'
      })
  end,
  settings = {
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--fallback-style=llvm',
      '--all-scopes-completion',
      '--completion-style=detailed',
      '--header-insertion=iwyu',
      '--header-insertion-decorators',
      '--pch-storage=memory',
      '--enable-config',
      '--limit-results=0'
    },
    filetypes = { 'c', 'cpp', 'cuda', 'proto' },
    root_markers = {
      'CMakeLists.txt',
      '.clangd',
      '.clang-tidy',
      '.clang-format',
      'compile_commands.json',
      '.git',
      'SConstruct.options',
    },
  },
}
