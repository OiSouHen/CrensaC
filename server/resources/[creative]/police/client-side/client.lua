-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("police",cRP)
vSERVER = Tunnel.getInterface("police")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function()
	SendNUIMessage({ action = "closeSystem" })
	SetNuiFocus(false,false)
	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("initPrison",function(data)
	vSERVER.initPrison(data["passaporte"],data["servicos"],data["multas"],data["texto"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("initFine",function(data)
	vSERVER.initFine(data["passaporte"],data["multas"],data["texto"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updatePort",function(data)
	vSERVER.updatePort(data["passaporte"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("searchUser",function(data,cb)
	cb({ result = vSERVER.searchUser(data["passaporte"]) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:openSystem")
AddEventHandler("police:openSystem",function()
	local ped = PlayerPedId()
	if not IsPedSwimming(ped) then
		SendNUIMessage({ action = "openSystem" })
		TriggerEvent("dynamic:closeSystem")
		SetNuiFocus(true,true)

		if not IsPedInAnyVehicle(ped) then
			vRP.removeObjects()
			vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:Update")
AddEventHandler("police:Update",function(action,data)
	SendNUIMessage({ action = action, data = data })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inSelect = 1
local inDeath = false
local inPrison = false
local inTimer = GetGameTimer()
local timeDeath = GetGameTimer()
local coordsIntern = { 1679.94,2513.07,45.56 }
local coordsExtern = { 1896.15,2604.44,45.75 }
local coordsLeaver = { 1834.09,2594.34,46.02 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("checkPrison",function()
	return inPrison
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
local inLocates = {
	{ 1772.89,2536.78,45.56,246.62 },
	{ 1760.7,2519.03,45.56,260.79 },
	{ 1758.27,2508.99,45.56,260.79 },
	{ 1757.89,2507.81,45.56,255.12 },
	{ 1737.37,2504.68,45.56,170.08 },
	{ 1719.86,2502.73,45.56,260.79 },
	{ 1706.99,2481.05,45.56,226.78 },
	{ 1700.22,2474.79,45.56,229.61 },
	{ 1679.53,2480.26,45.56,136.07 },
	{ 1643.86,2490.76,45.56,187.09 },
	{ 1635.7,2490.19,45.56,189.93 },
	{ 1634.68,2490.11,45.56,181.42 },
	{ 1622.39,2507.78,45.56,96.38 },
	{ 1618.41,2521.4,45.56,141.74 },
	{ 1609.77,2539.59,45.56,133.23 },
	{ 1607.37,2541.43,45.56,102.05 },
	{ 1606.28,2542.57,45.56,136.07 },
	{ 1608.95,2567.03,45.56,48.19 },
	{ 1624.83,2567.9,45.56,274.97 },
	{ 1624.78,2567.15,45.56,263.63 },
	{ 1629.9,2564.37,45.56,5.67 },
	{ 1642.2,2565.22,45.56,2.84 },
	{ 1643.98,2565.08,45.56,31.19 },
	{ 1652.52,2564.39,45.56,2.84 },
	{ 1665.09,2567.66,45.56,5.67 },
	{ 1716.03,2568.78,45.56,85.04 },
	{ 1715.95,2567.97,45.56,85.04 },
	{ 1715.97,2567.13,45.56,85.04 },
	{ 1768.78,2565.74,45.56,5.67 },
	{ 1695.25,2506.62,45.56,53.86 },
	{ 1630.53,2526.15,45.56,325.99 },
	{ 1627.89,2543.56,45.56,226.78 },
	{ 1636.13,2553.62,45.56,0.0 },
	{ 1657.59,2549.32,45.56,138.9 },
	{ 1649.73,2538.35,45.56,62.37 },
	{ 1699.07,2535.87,45.56,153.08 },
	{ 1699.63,2534.6,45.56,87.88 },
	{ 1699.35,2532.08,45.56,93.55 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		if inPrison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vec3(inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3]))

			if distance <= 150 then
				timeDistance = 1
				DrawText3D(inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3],"~g~E~w~   VASCULHAR")

				if distance <= 1 and GetGameTimer() >= inTimer and IsControlJustPressed(1,38) and not IsPedInAnyVehicle(ped) then
					inTimer = GetGameTimer() + 3000

					LocalPlayer["state"]["Cancel"] = true
					LocalPlayer["state"]["Commands"] = true
					SetEntityHeading(ped,inLocates[inSelect][4])
					vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
					SetEntityCoords(ped,inLocates[inSelect][1],inLocates[inSelect][2],inLocates[inSelect][3] - 1,1,0,0,0)

					Wait(10000)

					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Cancel"] = false
					vSERVER.reducePrison()
					vRP.removeObjects()
				end
			end

			if GetEntityHealth(ped) <= 100 then
				if not inDeath then
					timeDeath = GetGameTimer() + 60000
					inDeath = true
				else
					if GetGameTimer() >= timeDeath then
						vRP.revivePlayer(125)
						inDeath = false
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.syncPrison(status,teleport)
	if teleport then
		if status then
			SetEntityCoords(PlayerPedId(),coordsIntern[1],coordsIntern[2],coordsIntern[3],1,0,0,0)
		else
			SetEntityCoords(PlayerPedId(),coordsExtern[1],coordsExtern[2],coordsExtern[3],1,0,0,0)
		end
	end

	inPrison = status
	inSelect = math.random(#inLocates)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.asyncServices()
	inSelect = math.random(#inLocates)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end