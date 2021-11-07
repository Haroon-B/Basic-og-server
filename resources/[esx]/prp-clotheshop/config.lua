Config = {}
Config.Locale = 'en'

Config.Price = 50

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 3.5, y = 3.5, z = 0.5}
Config.MarkerColor  = {r = 0, g = 0, b = 200}
Config.MarkerType   = 1

Config.Zones = {}

Config.Shops = {
	vector3(72.3, -1399.1, 28.4),
	vector3(-703.8, -152.3, 36.4),
	vector3(-167.9, -299.0, 38.7),
	vector3(428.7, -800.1, 28.5),
	vector3(-829.4, -1073.7, 10.3),
	vector3(-1447.8, -242.5, 48.8),
	vector3(123.6, -219.4, 53.6),
	vector3(-1193.4, -772.3, 16.3),
	vector3(-3172.5, 1048.1, 19.9)
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
