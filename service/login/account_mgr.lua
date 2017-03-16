local MongoLib = require "mongolib"

local mongo_host = "127.0.0.1"
local mongo_db = "mj_server"

local M = {}

function M:init()
    self.mongo = MongoLib.new()
    self.mongo:connect(mongo_host)
    self.mongo:use(mongo_db)
end

-- 验证账号密码
function M:verify(info)
    local record = mongo:find_one("account", {account = info.account})
    if not record then
        return
    end

    if record.passwd ~= info.passwd then
        return
    end

    return true
end

-- 注册账号
function M.register(info)
    local record = mongo:find_one("account", {account = info.account})
    if record then
        return
    end

    mongo:insert("account", {account = info.account, passwd = info.passwd})
end

return M
