local M = {}
local component = require("component")

M.lualine_component = component.snipe_files

function M.setup(opts)
  component.setup(opts)
end

return M
