local skynet = require "skynet"
local socket = require "socket"
--local SockDispatch = require "sock_dispatch"

local WATCHDOG
local host
local send_request

local CMD = {}
local REQUEST = {}
local client_fd

local function request(name, args, response)
	local f = assert(REQUEST[name])
	local r = f(args)
	if response then
		return response(r)
	end
end

local function send_package(pack)
	local package = string.pack(">s2", pack)
	socket.write(client_fd, package)
end

skynet.register_protocol {
	name = "client",
	id = skynet.PTYPE_CLIENT,
	unpack = function (msg, sz)
		msg = skynet.tostring(msg, sz)
		local proto_id, params = string.unpack(">Hs2", msg)
		return proto_id, params
	end,
	dispatch = function (_, _, proto_id, params)
		print("recv msg proto_id =",proto_id,params)
	end
}

function CMD.start(conf)
	local fd = conf.client
	local gate = conf.gate
	WATCHDOG = conf.watchdog
	-- slot 1,2 set at main.lua
	client_fd = fd
	skynet.call(gate, "lua", "forward", fd)
end

function CMD.disconnect()
	-- todo: do something before exit
	skynet.exit()
end

skynet.start(function()
	skynet.dispatch("lua", function(_,_, command, ...)
		local f = CMD[command]
		skynet.ret(skynet.pack(f(...)))
	end)
end)
