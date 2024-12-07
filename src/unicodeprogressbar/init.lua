--!strict

--[[ Unicode Progress-Bar Generator © 2024 by khanmenthe is licensed under CC BY-SA 4.0 ]]

local unicodeProgressBar = {}

--- CONSTANTS
local BLOCKS						=	{[0] = "" --[[ Necessary as indices start at 1 ]], "▏","▎","▍","▌","▋","▊","▉","█"} -- to self: smooth right to left bars are not possible as the necessary characters do not exist in unicode
local BACKGROUND_BLOCKS: {string}	=	{["NONE"] = "", ["MINIMAL"] = "░", ["MEDIUM"] = "▒", ["MEDIUM_REVERSED"] = "�", ["FULL"] = "▓"}

local INTERVAL: number				=	1/8
local INTERVAL_DENOMINATOR: number	=	8


local function quantize(value: number, interval: number): number
	
	if value % interval >= interval / 2 then
		return value + (interval - value % interval)
	elseif value % interval < interval / 2 then
		return value - value % interval
	else
		error(`Couldn't quantize {value} to {interval} -- Unhandled exception.`)
	end

end

-- Generates a text progress bar 
function unicodeProgressBar.generateBar(value: number, minRangeValue: number, maxRangeValue: number, length: number, background_blocks: keyof<typeof(BACKGROUND_BLOCKS)>): string
	local bar: string = ""

	local normalizedValue: number = (value - minRangeValue) / (maxRangeValue - minRangeValue)
	local scaledToLengthValue: number = length * normalizedValue

	local scaledToLengthValueWhole: number, scaledToLengthValueMantissa: number = math.modf(scaledToLengthValue)

	local quantizedScaledValueMantissa: number = quantize(scaledToLengthValueMantissa, INTERVAL)

	for _ = 1, scaledToLengthValueWhole, 1 do
		bar ..= BLOCKS[8]
	end
	bar ..= BLOCKS[quantizedScaledValueMantissa * INTERVAL_DENOMINATOR]
	
	for _ = 1, length - scaledToLengthValueWhole, 1 do
		bar ..= BACKGROUND_BLOCKS[background_blocks]
	end
	
	return bar
end

return unicodeProgressBar