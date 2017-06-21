-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local utils = require "utils"
local skynet = require "skynet"
local packet = require "packet"
local msg = require "msg"

local M = {}

function M:create(fd, cmd, sessionid, param)
end

function M:join(fd, cmd, sessionid, param)
end

function M:delete(fd, cmd, sessionid, param)
end

return M
