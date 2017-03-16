local M = {}

M.__index = M

function M.new()
    local o = {}
    setmetatable(o, M)
    return o
end

function M.init()

end

return M
