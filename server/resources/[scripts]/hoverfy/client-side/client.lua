-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zone = {}
local Select = {}
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v["x"] << 8) | v["y"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			if not Active then
				local gridZone = getGridzone(coords["x"],coords["y"])

				if Zone[gridZone] then
					for _,Table in pairs(Zone[gridZone]) do
						if #(coords - Table["coords"]) < Table["distance"] then
							SendNUIMessage({ show = true, key = Table["key"], title = Table["title"], legend = Table["legend"] })
							Select = Table
							Active = true
						end
					end
				end
			else
				if #(coords - Select["coords"]) > Select["distance"] then
					SendNUIMessage({ show = false })
					timeDistance = 100
					Active = false
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOVERFY:INSERT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hoverfy:Insert")
AddEventHandler("hoverfy:Insert",function(innerTable)
	for k,v in pairs(innerTable) do
		local gridZone = getGridzone(v[1],v[2])

		if Zone[gridZone] == nil then
			Zone[gridZone] = {}
		end

		Zone[gridZone][#Zone[gridZone] + 1] = {
			["coords"] = vec3(v[1],v[2],v[3]),
			["distance"] = v[4],
			["key"] = v[5],
			["title"] = v[6],
			["legend"] = v[7]
		}
	end
end)