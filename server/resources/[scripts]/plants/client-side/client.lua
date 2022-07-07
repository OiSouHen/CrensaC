-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("plants",cRP)
vSERVER = Tunnel.getInterface("plants")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Route = 0
local Plants = {}
local Objects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(Plants) do
			local distance = #(coords - vec3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= 50 then
				if Objects[k] == nil and v["route"] == Route then
					exports["target"]:AddCircleZone("Plants:"..k,vec3(v["coords"][1],v["coords"][2],v["coords"][3] + 0.5),0.5,{
						name = "Plants:"..k,
						heading = 3374176
					},{
						shop = k,
						distance = 1.5,
						options = {
							{
								event = "plants:Informations",
								label = "Verificar",
								tunnel = "shop"
							}
						}
					})

					createModels(k,v["coords"])
				end
			else
				if Objects[k] then
					if DoesEntityExist(Objects[k]) then
						exports["target"]:RemCircleZone("Plants:"..k)
						DeleteEntity(Objects[k])
						Objects[k] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE:ROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("update:Route")
AddEventHandler("update:Route",function(Number)
	Route = Number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Informations")
AddEventHandler("plants:Informations",function(Number)
	exports["dynamic"]:AddButton("Coletar","Clique aqui para coletar.","plants:Collect",Number,false,true)
	exports["dynamic"]:AddButton("Clonagem","Clique aqui para clonar.","plants:Cloning",Number,false,true)

	exports["dynamic"]:openMenu()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
function createModels(Number,coords)
	local Model = "bkr_prop_weed_med_01a"
	local mHash = GetHashKey(Model)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Wait(1)
	end

	Objects[Number] = CreateObjectNoOffset(mHash,coords[1],coords[2],coords[3],false,false,false)
	PlaceObjectOnGroundProperly(Objects[Number])
	FreezeEntityPosition(Objects[Number],true)
	SetModelAsNoLongerNeeded(mHash)

	SetEntityLodDist(Objects[Number],0xFFFF)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Table")
AddEventHandler("plants:Table",function(table)
	Plants = table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:NEW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:New")
AddEventHandler("plants:New",function(Number,Table)
	Plants[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Remover")
AddEventHandler("plants:Remover",function(Number)
	Plants[Number] = nil

	if DoesEntityExist(Objects[Number]) then
		exports["target"]:RemCircleZone("Plants:"..Number)
		DeleteEntity(Objects[Number])
		Objects[Number] = nil
	end
end)