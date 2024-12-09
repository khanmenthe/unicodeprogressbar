--[[ do NOT touch this file ]]

local CONSTANTS = {}

CONSTANTS.BLOCKS			=	{[0] = "" --[[ Necessary as indices start at 1 ]], "▏","▎","▍","▌","▋","▊","▉","█"} -- to self: smooth right to left bars are not possible as the necessary characters do not exist in unicode
CONSTANTS.BACKGROUND_BLOCKS	=	{
    ["NONE"] = "", 
    ["TRANSPARENT"] = " ", 
    ["MINIMAL"] = "░", 
    ["MEDIUM"] = "▒", 
    ["MEDIUM_REVERSED"] = "�", 
    ["FULL"] = "▓"
}

CONSTANTS.INTERVAL		        =	1/8
CONSTANTS.INTERVAL_DENOMINATOR	=	8

return CONSTANTS