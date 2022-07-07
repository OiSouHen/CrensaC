-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("robberys:Init")
AddEventHandler("robberys:Init",function(Robberys)
	for Number,v in pairs(Robberys) do
		exports["target"]:AddCircleZone("Robberys:"..Number,v["Coords"],0.5,{
			name = "Robberys:"..Number,
			heading = 3374176,
			useZ = true
		},{
			shop = Number,
			Distance = 1.0,
			options = {
				{
					event = "robberys:Init",
					tunnel = "shopserver",
					label = "Roubar"
				}
			}
		})
	end
end)