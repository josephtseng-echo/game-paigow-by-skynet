-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local service = require "service"

service:main({
    uniqueservicelist = {
        { name = "hub", call = "start" },
        { name = "login" }
    }
})
