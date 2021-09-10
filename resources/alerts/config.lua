Config = {}

Config.Locale = 'en'

-- Set the time (in minutes) during the player is outlaw
Config.Timer = 1

-- Set if show alert when player use gun
Config.GunshotAlert = true

-- Set if show when player do carjacking
Config.CarJackingAlert = true

-- Set if show when player fight in melee
Config.MeleeAlert = false

-- In seconds
Config.BlipGunTime = 7 -- 15 saniye  boyunca blip gösterir.

-- Blip radius, in float value!
Config.BlipGunRadius = 50.0

-- In seconds
Config.BlipMeleeTime = 5 -- 10 saniye  boyunca blip gösterir.

-- Blip radius, in float value!
Config.BlipMeleeRadius = 50.0

-- In seconds
Config.BlipJackingTime = 5 -- 20 saniye  boyunca blip gösterir.

-- Blip radius, in float value!
Config.BlipJackingRadius = 50.0

-- Show notification when cops steal too?
Config.ShowCopsMisbehave = true

-- Jobs in this table are considered as cops
Config.WhitelistedCops = {
	'police'
}

Config.Colors = {
[0] = "Metallic Black",
[1] = "Metallic Graphite Black",
[2] = "Metallic Black Steel",
[3] = "Metallic Dark Silver",
[4] = "Metallic Silver",
[5] = "Metallic Blue Silver",
[6] = "Metallic Steel Grey",
[7] = "Metallic Shadow Silver",
[8] = "Metallic Stone Silver",
[9] = "Metallic Midnight Silver",
[10] = "Metallic Weapon Metal",
[11] = "Metallic Anthracite Grey",
[12] = "Matte Black",
[13] = "Matte Grey",
[14] = "Matte Light Grey",
	[15] = "Util Black",
	[16] = "Util Black Poly",
	[17] = "Util Dark silver",
	[18] = "Util Silver",
	[19] = "Util Gun Metal",
	[20] = "Util Shadow Silver",
	[21] = "Worn Black",
	[22] = "Worn Graphite",
	[23] = "Worn Silver Grey",
	[24] = "Worn Silver",
	[25] = "Worn Blue Silver",
	[26] = "Worn Shadow Silver",
	[27] = "Metallic Red",
	[28] = "Turin Red Metallic",
	[29] = "Metallic Formula Red",
	[30] = "Metallic Blaze Red",
	[31] = "Metallic Elegant Red",
	[32] = "Garnet Red Metallic",
	[33] = "Metallic Desert Red",
	[34] = "Metallic Cabernet Red",
	[35] = "Metallic Candy Red",
	[36] = "Metallic Sunrise Orange",
	[37] = "Metallic Classic Gold",
	[38] = "Metallic Orange",
	[39] = "Matte Red",
	[40] = "Matte Dark Red",
	[41] = "Matte Orange",
	[42] = "Matte Yellow",
	[43] = "Util Red",
	[44] = "Util Brilliant Red",
	[45] = "Util Garnet Red",
	[46] = "Worn Red",
	[47] = "Golden Red Worn",
	[49] = "Metallic Dark Green",
	[50] = "Race Green Metallic",
	[51] = "Metallic Sea Green",
	[52] = "Metallic Olive Green",
	[53] = "Metallic Green",
	[54] = "Metallic Gasoline Blue Green",
	[55] = "Matte Lime Green",
	[56] = "Util Dark Green",
	[57] = "Util Green",
	[58] = "Dark Worn Green",
	[59] = "Weathered Green",
	[60] = "Worn Sea Wash",
	[61] = "Metallic Midnight Blue",
	[62] = "Metallic Dark Blue",
	[63] = "Saxony Blue Metallic",
	[64] = "Metallic Blue",
	[65] = "Metallic Marine Blue",
	[66] = "Port Metallic Blue",
	[67] = "Metallic Diamond Blue",
	[68] = "Metallic Surf Blue",
	[69] = "Metallic Teal",
	[70] = "Metallic Brilliant Blue",
	[71] = "Metallic Purple Blue",
	[72] = "Metallic Spinnaker Blue",
	[73] = "Metallic Ultra Blue",
	[74] = "Metallic Brilliant Blue",
	[75] = "Util Dark Blue",
	[76] = "Util Midnight Blue",
	[77] = "Util Blue",
	[78] = "Util Sea Foam Blue",
	[79] = "Util Light blue",
	[80] = "Util Maui Blue Poly",
	[81] = "Util Brilliant Blue",
	[82] = "Matte Dark Blue",
	[83] = "Matte Blue",
	[84] = "Matte Midnight Blue",
	[85] = "Worn Dark blue",
	[86] = "Worn Blue",
	[87] = "Worn Light blue",
	[88] = "Metallic Taxi Yellow",
	[89] = "Race Metallic Yellow",
	[90] = "Metallic Bronze",
	[91] = "Metallic Yellow Bird",
	[92] = "Metallic Lime",
	[93] ="Metallic Champagne",
	[94] ="Metallic Pueblo Beige",
	[95] ="Metallic Dark Ivory",
	[96] ="Metallic Choco Brown",
[97] ="Metallic Gold Brown",
[98] ="Metallic Light Brown",
[99] ="Metallic Mesh Beige",
[100] ="Metallic Moss Brown",
[101] ="Metallic Biston Brown",
[102] ="Metallic Beech Wood",
[103] ="Metallic Dark Beech",
[104] ="Metallic Choco Orange",
[105] ="Metallic Beach Sand",
[106] ="Metallic Sun Bleeched Sand",
[107] ="Metallic Cream",
[108] ="Util Coffee",
[109] ="Util Medium Brown",
[110] ="Util Light Brown",
[111] ="Metallic White",
[112] ="Metallic Frost White",
[113] ="Weathered Honey Beige",
[114] ="Worn Brown",
[115] ="Worn Dark Brown",
[116] ="Worn straw beige",
[117] ="Brushed Steel",
[118] ="Brushed Black steel",
[119] ="Brushed Aluminum",
[120] ="Chrome",
[121] ="Worn White",
[122] ="Util Off-White",
[123] ="Worn Orange",
[124] ="Worn Light Orange",
[125] ="Metallic Securicor Green",
[126] ="Worn Taxi Yellow",
[127] ="police car blue",
[128] ="Matte Green",
[129] ="Matte Brown",
[130] ="Worn Orange",
[131] ="Matte White",
[132] ="Worn White",
[133] ="Worn Olive Army Green",
[134] ="Pure White",
[135] ="Hot Pink",
[136] ="Salmon pink",
[137] ="Metallic Vermillion Pink",
[138] ="Orange",
[139] ="Green",
[140] ="Blue",
[141] ="Metallic Black Blue",
[142] ="Metallic Black Purple",
[143] ="Metallic Black Red",
[144] ="hunter green",
[145]="Metallic Purple",
[146] ="Metallic V Dark Blue",
[147] ="MODSHOP BLACK",
[148] ="Matte Purple",
[149] ="Matte Dark Purple",
[150] ="Metallic Lava Red",
[151] ="Matte Forest Green",
[152] ="Matt Olive Green",
[153] ="Matte Desert Brown",
[154] ="Matte Desert Tan",
[155] ="Matte Foilage Green",
[156] ="DEFAULT ALLOY COLOR",
[157] ="Epsilon Blue",
[158] ="Pure Gold",
[159] ="Brushed Gold",
}