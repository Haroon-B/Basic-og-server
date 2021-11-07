Config 					= {}

Config.Locale 			= 'en'
Config.DrawDistance 	= 10

local second = 1000
local minute = 60 * second
local hour = 60 * minute

Config.Zones = {
	['taxi'] = {	
		Pos = { 
			{x = 895.35, y = -179.35, z = 74.5 - 0.8},
		},
		
		Jobs = {
			--'any', -- set to 'any' to allow the location for any player regardless of job
			'any'
		},
		TaxRate = 0.9, -- set taxrate per spot. Default is 0.5 or 50% of the dirty you will get back in clean
		enableTimer = false, -- Enable ONLY IF you want a timer on the money washing. Keep in mind the Player does not have to stay at the wash for it to actually wash the money.
		timer = 5 * second, -- Actual Timer for the spot. The * amount will determine if its hours, second, or minutes. which are found above. DEFAULT: 5 * second
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 125, g = 11, b = 212},
		Type = 27,
	
	}
}
