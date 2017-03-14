local skynet = require "skynet"


skynet.start(function()
    skynet.dispatch("lua", function(src, session, cmd, ...)
        local f = CMD[cmd]
        assert(f, "can't find dispatch handler cmd = "..cmd)

        if session > 0 then
            return skynet.ret(skynet.pack(f(...)))
        else
            f(...)
        end
    end)
end)
