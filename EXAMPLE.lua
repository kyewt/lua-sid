local LZW = require("lualzw")
local gen = require("seqIdGen")()
local reverse = string.reverse

local ids = {}
for i = 1, 50000 do
    ids[i] = gen()
end
local str = table.concat(ids)
local l1 = #str
str = LZW.compress(str)
local l2 = #str
for i = 2, 50000, 2 do
    ids[i] = reverse(ids[i])
end
local str = table.concat(ids)
str = LZW.compress(str)
local l3 = #str
print(l1) -- 800000 (uncompressed)
print(l2) -- 168641 (compressed unreversed)
print(l3) -- 113495 (compressed reversed)
print(l1/l2) -- 4.743804887304985 (unreversed compression rate)
print(l1/l3) -- 7.0487686682232695 (reversed compression rate)
