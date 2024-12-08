--,!strict
--[[ Unicode Progress-Bar Generator © 2024 by khanmenthe is licensed under CC BY-SA 4.0 ]]

local unicodeProgressBar = {}


--- CONSTANTS
local CONSTANTS	=	require(script.CONSTANTS)
local SETTINGS	=	require(script.SETTINGS)

--- Private functions

local function quantize(value: number, interval: number): number
	
	if value % interval >= interval / 2 then
		return value + (interval - value % interval)
	elseif value % interval < interval / 2 then
		return value - value % interval
	else
		error(`Couldn't quantize {value} to {interval} -- Unhandled exception.`)
	end

end

--- Public functions
-- Generates a text progress bar 
function unicodeProgressBar.generateBar(value: number, minRangeValue: number, maxRangeValue: number, length: number, background_block: keyof<typeof(CONSTANTS.BACKGROUND_BLOCKS)>?): string
	background_block = 	background_block or SETTINGS.DEFAULT_BACKGROUND

	local bar: string = ""

	local normalizedValue: number = (value - minRangeValue) / (maxRangeValue - minRangeValue)
	local scaledToLengthValue: number = length * normalizedValue

	local scaledToLengthValueWhole: number, scaledToLengthValueMantissa: number = math.modf(scaledToLengthValue)

	local quantizedScaledValueMantissa: number = quantize(scaledToLengthValueMantissa, CONSTANTS.INTERVAL)

	for _ = 1, scaledToLengthValueWhole, 1 do
		bar ..= CONSTANTS.BLOCKS[8]
	end
	bar ..= CONSTANTS.BLOCKS[quantizedScaledValueMantissa * CONSTANTS.INTERVAL_DENOMINATOR]
	
	for _ = 1, length - scaledToLengthValueWhole, 1 do
		bar ..= CONSTANTS.BACKGROUND_BLOCKS[background_block]
	end
	
	return bar
end


return unicodeProgressBar