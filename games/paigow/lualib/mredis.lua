-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local redis = require "redis"
local config = require "config"

M = {}

function M:new(o)
    o = o or {}
    if redis_conn ~= nil then
        return
    end
    local conf = config.redis_ini
    o = redis.connect(conf)  
    --setmetatable(o,self)
    --self.__index = self
    return o
end

function M:getInstance()
    if self.instance == nil then
        self.instance = self:new()
    end
    return self.instance
end

return M
