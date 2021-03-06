-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local utils = require "utils"
local skynet = require "skynet"
local packet = require "packet"
local msg = require "msg"

local M = {}

function M:login(fd, cmd, sessionid, param)
	param.mid = sessionid
	param.fd = fd
	param.cmd = cmd
	param.sid = param.sid or 1
	param.lid = param.lid or 1
	param.channel = param.channel or 1

	local res = skynet.call("login", "lua", "login", param)
    local rb = {}
    rb.msgtype = 101
    rb.status = 0
    rb.data = {}
    if res.row ~= nil then
        rb.msgtype = 102
        rb.status = 1
        rb.data = res
        rb.serverlist = res.serverlist
    end
    local packet = packet:pack(0x101, sessionid, msg:conversion(rb))
    return packet
end

function M:info(fd, cmd, sessionid, param)
end

function M:update(fd, cmd, sessionid, param)
end

return M
