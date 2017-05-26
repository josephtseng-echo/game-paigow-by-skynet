-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--
local mysql = require "mysql"
local config = require "config"

M = {}


local function on_connect(db)
    db:query("set charset utf8");
end

function M:new(o)
    o = o or {}
    local conf = config.mysql_ini
    conf["on_connect"] = on_connect
    o = mysql.connect(conf)
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
