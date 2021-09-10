Config = {}

Config.ItemNeeded = "net_cracker"
Config.MaxLives = 5 -- this is the max lives in hacking thing don't set more than 5. thank you
Config.CopsNeeded = 5 -- number of cops required to start the robbery
Config.BlackMoney = true -- true for black_money and false for cash


Config.Trolley = {
    ["cash"] = { 1000, 2000 }, -- this is what you receive every cash stack math.random(1, 2)
    ["model"] = GetHashKey("hei_prop_hei_cash_trolly_01")
}

Config.EmptyTrolley = {
    ["model"] = GetHashKey("hei_prop_hei_cash_trolly_03")
}

Config.Bank = {
	["Principal bank"] = {
        ["start"] = { 
            ["pos"] = vector3(253.67, 228.26, 101.68), 
            ["heading"] = 74.31 
        },
        ["door"] = { 
            ["pos"] = vector3(254.12199291992, 225.50576782227, 101.87346405029),
            ["model"] = 961976194
        },
        ["device"] = {
            ["model"] = -160937700
        },
        ["trolleys"] = {
            ["left"] = { 
                ["pos"] = vector3(264.64, 212.0, 101.67), 
                ["heading"] = 338.37 + 0.0
            },
            ["right"] = { 
                ["pos"] = vector3(262.20, 212.88, 101.68), 
                ["heading"] = 338.37 + 0.0
            },
			["left2"] = { 
                ["pos"] = vector3(263.20, 216.39, 101.68), 
                ["heading"] = 338.37 + 180.0
            },
            ["right2"] = { 
                ["pos"] = vector3(266.17, 215.38, 101.68), 
                ["heading"] = 338.37 + 180.0
            },
        }
    }
}