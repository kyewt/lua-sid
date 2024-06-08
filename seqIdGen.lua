local FIND = table.find
local CONCAT = table.concat
local CREATE = function(count, value)
    if type(count) ~= "number" then
        error("invalid argument #1 to 'create' (number expected, got "..typeof(count)..")")
    end
    if count < 0 then
        error("invalid argument #1 to 'create' (size out of range)")
    end
    local t = {}
    for i = 1, count do
        t[i] = value
    end
    return t
end
local DEFAULT_ID_LENGTH = 16
local DEFAULT_CHAR_SET = {
    '0','1','2','3','4','5','6','7','8','9','q','w','e','r','t','y','u','i','o','p',
    'a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m','Q','W','E','R',
    'T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Z','X','C','V','B',
    'N','M'
}
local TYPE_NAME = "sequentialIdGenerator"
local TOSTRING = function()
    return TYPE_NAME
end
local NEWINDEX = function()
    print("Cannot set values of "..TYPE_NAME)
end
local INDEX = function()
    print("Cannot index "..TYPE_NAME)
end
local METACONCAT = function()
    print("Cannot concatenate "..TYPE_NAME)
end
local LEN = function()
    print("Cannot get length of "..TYPE_NAME)
end

local NEW = function(ID_LENGTH, CHAR_SET)
    if ID_LENGTH == nil then
        ID_LENGTH = DEFAULT_ID_LENGTH
    elseif type(ID_LENGTH) ~= "number" or ID_LENGTH < 1 or math.floor(ID_LENGTH) ~= ID_LENGTH then
        error("Bad type to ID_LENGTH expected integer greater than 0.")
    end
    if CHAR_SET == nil then
        CHAR_SET = DEFAULT_CHAR_SET
    elseif type(CHAR_SET) ~= "table" or #CHAR_SET < 1 then
        error("Bad type to CHAR_SET expected non-empty array.")
    end
    
    local SET_LENGTH = #CHAR_SET
    local FIRST_CHAR = CHAR_SET[1]
    local prevId = CREATE(ID_LENGTH, FIRST_CHAR)
    local charIndex = 0
    local GET_CHAR_INDEX = function(digit)
        return FIND(CHAR_SET, prevId[digit])
    end

    local NEW_ID = function()
        local ID = prevId
        local INC_DIGIT INC_DIGIT = function(digit)
            charIndex = GET_CHAR_INDEX(digit) + 1
            if charIndex <= SET_LENGTH then
                ID[digit] = CHAR_SET[charIndex]
            else
                charIndex = 0
                for i = digit, 1, -1 do
                    ID[i] = FIRST_CHAR
                end
                digit = digit + 1
                if digit <= ID_LENGTH then
                    INC_DIGIT(digit)
                else
                    error("Out of ids.")
                end
            end
        end
        INC_DIGIT(1)
        prevId = ID
        return CONCAT(ID)
    end

    local proxy = {}
    local proxyMT = {
        __call = NEW_ID,
        __tostring = TOSTRING,
        __newindex = NEWINDEX,
        __index = INDEX,
        __len = LEN,
        __concat = METACONCAT
    }
    setmetatable(proxy, proxyMT)
    return proxy
end

return NEW
