-- msg.lua
-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local config = require "config"

local M = {}

function M:conversion(msg)
    if msg == nil then
        return ""
    end
    if config.environment == 0 and msg.msgtype ~= nil then
        msg.msg = config.msg[msg.msgtype]
    end
    return msg
end

return M

