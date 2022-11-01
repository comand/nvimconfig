status_ok, prettyfold = pcall(require, 'pretty-fold')
if not status_ok then
  return
end

prettyfold.setup {
  fill_char = '╌',
  process_comment_signs = 'delete',
  sections = {
    left = {
      '»', 'content',
    },
    right = {
      ' ', 'number_of_folded_lines', ' ',
    },
  },
}
require('pretty-fold.preview').setup()
