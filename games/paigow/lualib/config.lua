-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local M = {}
M.environment = 0

M.mysql_ini = {
    host = "127.0.0.1",
    port = 3306,
    database = "zsq_game",
    user = "root",
    password = "123456",
    max_packet_size = 1024 * 1024
    --on_connect = on_connect
}

M.redis_ini = {
    host = "127.0.0.1",
    port = 6379,
    db = 0
}

M.msg = {
    [101] = "登录失败",
    [102] = "登录成功",
    [901] = "数据包长度不够",
    [902] = "数据包解包失败",
    [903] = "服务CMD不存在",
    [903] = "验证不通过",
    [905] = "服务返回错误",
}
return M
