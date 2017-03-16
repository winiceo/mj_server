-- 桌子类
local M = {}

M.__index = M

function M.new()
    local o = {}
    setmetatable(o, M)
    return o
end

function M.init()

end

function M.add(player)

end

function M.remove(player)

end

return M
