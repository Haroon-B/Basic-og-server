Config = {}

Config.VehicleMenu = true -- enable this if you wan't a vehicle menu.
Config.VehicleMenuButton = 344 -- change this to the key you want to open the menu with. buttons: https://docs.fivem.net/game-references/controls/
Config.RangeCheck = 25.0 -- this is the change you will be able to control the vehicle.

Config.Garages = {
    ["A"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-281.21, -888.22, 31.32)
            },
            ["vehicle"] = {
                ["position"] = vector3(-280.91, -902.52, 31.08), 
                ["heading"] = 335.09
            }
        },
        ["camera"] = {  -- camera is not needed just if you want cool effects.
            ["x"] = -287.57, 
            ["y"] = -897.66, 
            ["z"] = 34.61, 
            ["rotationX"] = -15.401574149728, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 243.40157422423 
        }
    },

    ["B"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1178.62, -1775.99, 3.91)
            },
            ["vehicle"] = {
                ["position"] = vector3(-1170.2, -1770.67, 3.26), 
                ["heading"] = 306.34
            }
        },
        ["camera"] = { 
            ["x"] = -1163.78, 
            ["y"] = -1764.64, 
            ["z"] = 4.97, 
            ["rotationX"] = -21.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 125.73228356242 
        }
    },

    ["C"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(1724.99, 3323.52, 41.22)
            },
            ["vehicle"] = {
                ["position"] = vector3(1732.8, 3304.99, 41.22), 
                ["heading"] = 194.0
            }
        },
        ["camera"] = { 
            ["x"] = 1727.58, 
            ["y"] = 3297.73, 
            ["z"] = 45.22, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -42.110235854983 
        }
    },
    ["Mafia Garage"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1533.74, 81.5, 56.77)
            },
            ["vehicle"] = {
                ["position"] = vector3(-1525.64, 91.49, 56.53), 
                ["heading"] = 27.82
            }
        },
        ["camera"] = { 
            ["x"] = -1532.85, 
            ["y"] = 80.46, 
            ["z"] = 61.37, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -42.110235854983 
        }
    },
  
    ["Police Garage"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(456.24, -1023.45, 28.43)
            },
            ["vehicle"] = {
                ["position"] = vector3(452.11, -1019.17, 29.75), 
                ["heading"] = 93.68
            }
        },
        ["camera"] = { 
            ["x"] = 441.76, 
            ["y"] = -1023.02, 
            ["z"] = 32.33, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -42.110235854983 
        }
    }
}

Config.Labels = {
    ["menu"] = "~INPUT_CONTEXT~ Open garage %s.",
    ["vehicle"] = "~INPUT_CONTEXT~ Put back '%s' to your garage."
}

Config.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

Config.AlignMenu = "right" -- this is where the menu is located [left, right, center, top-right, top-left etc.]