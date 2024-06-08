local LZW = require("lualzw")
local gen = require("seqIdGen")()
local reverse = string.reverse

local ids = {}
for i = 1, 50000 do
    ids[i] = gen()
end
for i = 2, 50000, 2 do
    ids[i] = reverse(ids[i])
end
local str = table.concat(ids)
local l1 = #str
str = LZW.compress(str)
local l2 = #str
print(l1) -- 800000 (uncompressed)
print(l2) -- 113495 (compressed)
print(l1/l2) -- 7.0487686682232695 (compression rate)
