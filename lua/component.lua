local M = {}

M.options = {
  separator = " ",
}

M.setup = function(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

M.snipe_files = function()
  local snipe_avail, Snipe = pcall(require, "snipe")
  if not snipe_avail then
    vim.notify("snipe not available", vim.log.levels.ERROR)
    return ""
  end
  local snipe_items = Snipe.global_items
  if not snipe_items or vim.tbl_isempty(snipe_items) then
    return ""
  end

  local current = vim.fn.expand("%:p")
  local files = {}
  for _, v in ipairs(snipe_items) do
    local is_current = current:match(v.name .. "$")
    local file_path = vim.fn.fnamemodify(v.name, ":p")
    local shortened = vim.fn.fnamemodify(file_path, ":t")
    local mini_avail, mini_icons = pcall(require, "mini.icons")
    local icon = ""
    if mini_avail then
      local ic, _, _ = mini_icons.get("file", shortened)
      icon = ic
    end
    local file = string.format("%s %s", icon, shortened)
    if is_current then
      file = "[" .. file .. "]"
    end
    table.insert(files, file)
  end
  return table.concat(files, M.options.separator)
end

return M
