-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local utils = require "utils"
local skynet = require "skynet"
local packet = require "packet"
local msg = require "msg"

local M = {}

function M:kick(fd, cmd, sessionid, param)
end

function M:ready(fd, cmd, sessionid, param)
end

function M:start(fd, cmd, sessionid, param)
end

function M:deal(fd, cmd, sessionid, param)
end

function M:play(fd, cmd, sessionid, param)
end

function M:take(fd, cmd, sessionid, param)
end

function M:finish(fd, cmd, sessionid, param)
end

return M
