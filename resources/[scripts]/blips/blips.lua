local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	-- Postes de polices
  {title="Aircraft Robbery", colour=1, id=16, x=3082.06, y=-4687.42, z=27.25},
  {title="Mafia House", colour=1, id=78, x=-1545.83, y=123.09, z=56.78},
  {title="Auction House", colour=3, id=595, x=683.77, y=570.46, z=129.81}, 
{title="Chickens Lab", colour=1, id=478, x=-86.17, y=6236.45, z=31.09},
  {title="Deer Selling ", colour=1, id=141, x=968.86, y=-2107.81, z=31.47},
  {title="Deer Hunting ", colour=1, id=141, x=-769.12, y=5595.75, z=33.49},
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)