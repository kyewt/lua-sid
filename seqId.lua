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
local CHAR_SET = {
    '0','1','2','3','4','5','6','7','8','9','q','w','e','r','t','y','u','i','o','p',
    'a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m','Q','W','E','R',
    'T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Z','X','C','V','B',
    'N','M',')','!','@','#','$','%','^','&','*','(','-','=','_','+','[',']','{','}'
}
local SET_LENGTH = #CHAR_SET
local ID_LENGTH = 16
local FIRST_CHAR = CHAR_SET[1]

local prevId = CREATE(ID_LENGTH, CHAR_SET[1])

local GET_CHAR_INDEX = function(digit)
    return FIND(CHAR_SET, prevId[digit])
end

local charIndex = 0

local NEW = function()
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

return NEW
