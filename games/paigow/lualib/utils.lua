-- Copyright (C) 2017 josephzeng <josephzeng36@gmail.com>
--
-- Distributed under terms of the MIT license.
--

local config = require "config"

local M = {}

function M:print_r(t)
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

function M:toInt(number)
    number = tonumber(number) or 0
    return math.floor(tonumber(number)) or 0
end

function M:intToHex(x)
    return string.format("%#x", x)
end

function M:hexToInt(hex)
    local l1 = string.byte(hex,1);
    local l2 = string.byte(hex,2);
    local l3 = string.byte(hex,3);
    local l4 = string.byte(hex,4);
    local res = l1 + l2*256 + l3*256*256 + l4*256*256*256;
    return res;
end

function M:tableIsEmpty(t)
    return _G.next(t) == nil
end

return M
