local skynet = require "skynet"
local MongoLib = require "mongolib"

local mongo_host = "127.0.0.1"
local mongo_db = "mj_server"
local mongo

local CMD = {}

function dispatch(src, session, cmd, ...)
    local f = CMD[cmd]
    if not f then
        return
    end

    skynet.ret(skynet.pack(f(...)))
end

function main()
    mongo = MongoLib.new()
    mongo:connect(mongo_host)
    mongo:use(mongo_db)
    mongo:insert("account", {name = "jack", lv = 20})
    skynet.dispatch("lua", dispatch)
end

skynet.start(main)
