local mongo = require "mongo"

local M = {}

M.__index = M

function M.new()
    local o = {
        db = nil
    }
    setmetatable(o, M)
    return o
end

function M:connect(host)
    self.conn = mongo.client({host = host})
end

function M:use(db_name)
    self.db = self.conn[db_name]
end

function M:find_one(coll_name, cond_tbl)
    self.db[coll_name]:findOne(cond_tbl)
end

function M:insert(coll_name, obj)
    self.db[coll_name]:insert(obj)
end

return M
