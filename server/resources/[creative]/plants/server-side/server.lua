-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("plants",cRP)
vCLIENT = Tunnel.getInterface("plants")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Plants = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
local plantTypes = {
	["weedclone"] = { "Maconha","weedleaf" },
	["cokeseed"] = { "Cocaína","cokeleaf" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPLANTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("initPlants",function(seedType,coords,route,prop,user_id)
	local Number = 0

	repeat
		Number = Number + 1
	until Plants[tostring(Number)] == nil

	Plants[tostring(Number)] = {
		["coords"] = { mathLegth(coords["x"]),mathLegth(coords["y"]),mathLegth(coords["z"]) },
		["time"] = os.time() + 12000,
		["type"] = seedType,
		["route"] = route,
		["prop"] = prop,
		["user_id"] = user_id
	}

	TriggerClientEvent("plants:New",-1,tostring(Number),Plants[tostring(Number)])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:COLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Collect")
AddEventHandler("plants:Collect",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Plants[Number] then
		local percPlants = 100
		if os.time() < Plants[Number]["time"] then
			local timePlants = parseInt((os.time() - Plants[Number]["time"]) / 120) + 100
			percPlants = timePlants
		end

		if os.time() >= Plants[Number]["time"] then
			if (vRP.inventoryWeight(user_id) + itemWeight(plantTypes[Plants[Number]["type"]][2]) * 3) <= vRP.getWeight(user_id) then
				TriggerClientEvent("dynamic:closeSystem",source)
				local Type = Plants[Number]["type"]
				Plants[Number] = nil

				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("vRP:Cancel",source,true)
				TriggerClientEvent("player:Commands",source,true)
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

				Wait(10000)

				vRP.generateItem(user_id,plantTypes[Type][2],2,true)
				TriggerClientEvent("player:Commands",source,false)
				TriggerClientEvent("plants:Remover",-1,Number)
				TriggerClientEvent("vRP:Cancel",source,false)
				vRPC.stopAnim(source,false)
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","<b>"..plantTypes[Plants[Number]["type"]][1].."</b> ainda em crescimento.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:CLONING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Cloning")
AddEventHandler("plants:Cloning",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Plants[Number] then
		local percPlants = 100
		if os.time() < Plants[Number]["time"] then
			local timePlants = parseInt((os.time() - Plants[Number]["time"]) / 120) + 100
			percPlants = timePlants
		end
			
		if (Plants[Number]["time"] - os.time()) <= 6000 then
			TriggerClientEvent("dynamic:closeSystem",source)
			local provPlants = Plants[Number]
			Plants[Number] = nil

			TriggerClientEvent("Progress",source,10000)
			TriggerClientEvent("vRP:Cancel",source,true)
			TriggerClientEvent("player:Commands",source,true)
			vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

			Wait(10000)

			vRP.generateItem(user_id,provPlants["type"],2,true)
			TriggerClientEvent("player:Commands",source,false)
			TriggerClientEvent("plants:Remover",-1,Number)
			TriggerClientEvent("vRP:Cancel",source,false)
			vRPC.stopAnim(source,false)
		else
			TriggerClientEvent("Notify",source,"amarelo","O progresso mínimo para a <b>Clonagem</b> é de <b>50%</b>.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Informations(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Plants[Number] then
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:KickAll")
AddEventHandler("admin:KickAll",function()
	SaveResourceFile("logsystem","plants.json",json.encode(Plants),-1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local coordsFile = LoadResourceFile("logsystem","plants.json")
	Plants = json.decode(coordsFile)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	TriggerClientEvent("plants:Table",source,Plants)
end)