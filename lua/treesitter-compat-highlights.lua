local M = {}

---@alias treesitter-compat-highlights.Highlight { old: string, new: string, compat?: table }

-- https://github.com/neovim/neovim/commit/f5dc45310941dff6efc02d955fc0c110190e9b85
-- and https://github.com/nvim-treesitter/nvim-treesitter/commit/1ae9b0e4558fe7868f8cda2db65239cfb14836d0
-- stylua: ignore
---@type treesitter-compat-highlights.Highlight[]
local hls = {
  { old = "@parameter", new = "@variable.parameter", compat = { link = "Identifier" } },
  { old = "@field", new = "@variable.member", compat = { link = "Identifier" } },
  { old = "@namespace", new = "@module", compat = { link = "Identifier" } },
  { old = "@float", new = "@number.float", compat = { link = "Float" } },
  { old = "@symbol", new = "@string.special.symbol", compat = { link = "Identifier" } },
  { old = "@string.regex", new = "@string.regexp", compat = { link = "SpecialChar" } },
  { old = "@text.strong", new = "@markup.strong", compat = { bold = true } },
  { old = "@text.italic", new = "@markup.italic", compat = { italic = true } },
  { old = "@text.strikethrough", new = "@markup.strikethrough", compat = { strikethrough = true } },
  { old = "@text.underline", new = "@markup.underline", compat = { underline = true } },
  { old = "@text.title", new = "@markup.heading", compat = { link = "Title" } },
  { old = "@text.literal", new = "@markup.raw", compat = { link = "Comment" } },
  { old = "@text.reference", new = "@markup.link", compat = { link = "Identifier" } },
  { old = "@text.uri", new = "@markup.link.url", compat = { link = "Underlined" } },
  { old = "@string.special", new = "@markup.link.label", compat = { link = "SpecialChar" } },
  { old = "@punctuation.special", new = "@markup.list", compat = { link = "Special" } },
  { old = "@method", new = "@function.method", compat = { link = "Function" } },
  { old = "@method.call", new = "@function.method.call", compat = { link = "@method" } },
  { old = "@text.todo", new = "@comment.todo", compat = { link = "Todo" } },
  { old = "@text.warning", new = "@comment.warning", compat = { link = "DiagnosticWarn" } },
  { old = "@text.note", new = "@comment.hint", compat = { link = "DiagnosticInfo" } },
  { old = "@text.danger", new = "@comment.info", compat = { link = "WarningMsg" } },
  { old = "@text.diff.add", new = "@diff.plus", compat = { link = "Added" } },
  { old = "@text.diff.delete", new = "@diff.minus", compat = { link = "Removed" } },
  { old = "@text.diff.change", new = "@diff.delta", compat = { link = "Changed" } },
  { old = "@text.uri", new = "@string.special.url" },
  { old = "@preproc", new = "@keyword.directive", compat = { link = "PreProc", } },
  { old = "@define", new = "@keyword.directive", compat = { link = "Define" } },
  { old = "@storageclass", new = "@keyword.storage", compat = { link = "StorageClass" } },
  { old = "@conditional", new = "@keyword.conditional", compat = { link = "Conditional" } },
  { old = "@debug", new = "@keyword.debug", compat = { link = "Debug" } },
  { old = "@exception", new = "@keyword.exception", compat = { link = "Exception" } },
  { old = "@include", new = "@keyword.import", compat = { link = "Include" } },
  { old = "@repeat", new = "@keyword.repeat", compat = { link = "Repeat" } },
  { old = "@macro", new = "@function.macro", compat = { link = "Macro" } },
}

function M.apply()
  for _, hl in ipairs(hls) do
    vim.api.nvim_set_hl(0, hl.new, { default = true, link = hl.old })
    if hl.compat then
      hl.compat.default = true
      vim.api.nvim_set_hl(0, hl.old, hl.compat)
    end
  end
end

return M
