Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale = 'en'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
		Pos   = { x = -1167.25, y = -1695.12, z = 3.56 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 22,
	},

	ShopInside = {
		Pos     = { x = -1154.53, y = -1699.4, z = 4.56 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 190.34,
		Type    = -1,
	},

	ShopOutside = {
		Pos     = { x = -1173.41, y = -1718.25, z = 3.46 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 330.0,
		Type    = -1,
	},

	BossActions = {
		Pos   = { x = -1177.03, y = -1699.91, z = 3.45 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 22,
	},

	GiveBackVehicle = {
		Pos   = { x = -1207.27, y = -1744.61, z = 3.45 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = (Config.EnablePlayerManagement and 1 or -1),
	},

	ResellVehicle = {
		Pos   = { x = -1910.6, y = -43.82, z = 108.15 }, 
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 1
	}

}
