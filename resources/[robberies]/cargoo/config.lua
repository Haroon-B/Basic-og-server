Config                        	= {}
Config.CopsScaleReward			= true

-- Change this to false if you want clean / legit money
Config.UsesBlackMoney			= true

--Hash of the npc ped. Change only if you know what you are doing.
Config.NPCHash					= 349680864 			

--Random time societies will get alerted. This is a range in seconds.
Config.AlertCopsDelayRangeStart	= 60
Config.AlertCopsDelayRangeEnd	= 70

--If you want to notify more societies add them here. example { "mafia", "bikers" }
Config.AlertExtraSocieties 		= { }

--Self Explained
Config.CargoProviderLocation	= { x = 483.6, y = -3382.69, z = 5.1, h = 355.02 }


Config.CargoDeliveryLocations 	= {

		{ x = 731.89, y = 4172.27, z = 39.3 },
		{ x = 1959.28, y = 3845.48, z = 31.2 },
		{ x = 388.76, y = 3591.34, z = 32.09},
		{ x = 97.24, y = 3739.86, z = 38.8}

}


Config.Scenarios = {
	
	{ 
		SpawnPoint = { x = 478.92, y = -3371.19, z = 5.5, h = 5.77 }, 
		DeliveryPoint = 6.0,
		VehicleName = "burrito3",
		MinCopsOnline = 2,
		CargoCost = 20000,
		CargoReward = 35000
	
	},

	{ 
		SpawnPoint = { x = 478.92, y = -3371.19, z = 5.5, h = 5.77 }, 
		DeliveryPoint = 6.0,
		VehicleName = "burrito3",
		MinCopsOnline = 3,
		CargoCost = 150000,
		CargoReward = 270000
	
	},
	{ 
		SpawnPoint = { x = 478.92, y = -3371.19, z = 5.5, h = 5.77 },  
		DeliveryPoint = 6.0,
		VehicleName = "burrito3",
		MinCopsOnline = 4,
		CargoCost = 300000,
		CargoReward = 550000
	
	}
}