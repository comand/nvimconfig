local pf_ok, prettyfold = pcall(require, 'pretty-fold')
if not pf_ok then
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

local fp_ok, fold_preview = pcall(require, 'fold-preview')
if fp_ok then
  fold_preview.setup()
end
