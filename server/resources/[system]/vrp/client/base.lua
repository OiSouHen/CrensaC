-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
Tunnel.bindInterface("vRP",tvRP)
vRPS = Tunnel.getInterface("vRP")
Proxy.addInterface("vRP",tvRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local animFlags = 0
local animDict = nil
local animName = nil
local blipsPlayers = {}
local blipsAdmin = false
local animActived = false
local showPassports = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.blipsAdmin()
	blipsAdmin = not blipsAdmin

	while blipsAdmin do
		blipsPlayers = vRPS.userPlayers()
		Wait(10000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if blipsAdmin then
			timeDistance = 1

			local Ped = PlayerPedId()
			local userList = GetPlayers()
			local Coords = GetEntityCoords(Ped)

			for k,v in pairs(userList) do
				local uPlayer = GetPlayerFromServerId(k)
				if uPlayer ~= PlayerId() and NetworkIsPlayerConnected(uPlayer) then
					local uPed = GetPlayerPed(uPlayer)
					local uCoords = GetEntityCoords(uPed)
					local Distance = #(Coords - uCoords)
					if Distance <= 1000 and blipsPlayers[k] ~= nil then
						DrawText3D(uCoords["x"],uCoords["y"],uCoords["z"] + 1.10,"~o~ID:~w~ "..blipsPlayers[k].."     ~g~H:~w~ "..GetEntityHealth(uPed).."     ~y~A:~w~ "..GetPedArmour(uPed),0.275)
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPeds(Radius)
	local List = {}
	local Ped = PlayerPedId()
	local Players = GetPlayers()
	local Coords = GetEntityCoords(Ped)

	for Source,v in pairs(Players) do
		local uPlayer = GetPlayerFromServerId(Source)
		if uPlayer ~= PlayerId() and NetworkIsPlayerConnected(uPlayer) then
			local uPed = GetPlayerPed(uPlayer)
			local uCoords = GetEntityCoords(uPed)
			local Distance = #(Coords - uCoords)
			if Distance <= Radius then
				List[uPlayer] = { Distance,Source }
			end
		end
	end

	return List
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Players()
	local Players = {}
	for _,v in ipairs(GetActivePlayers()) do
		Players[#Players + 1] = GetPlayerServerId(v)
	end

	return Players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPed(Radius)
	local Selected = false
	local Min = Radius + 0.0001
	local List = tvRP.ClosestPeds(Radius)

	for _,v in pairs(List) do
		if v[1] <= Min then
			Selected = v[2]
			Min = v[1]
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Players = {}

	for _,v in ipairs(GetActivePlayers()) do
		Players[GetPlayerServerId(v)] = true
	end

	return Players
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playAnim(animUpper,animSequency,animLoop)
	local playFlags = 0
	local ped = PlayerPedId()
	if animSequency["task"] then
		tvRP.stopAnim(true)

		if animSequency["task"] == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local coords = GetEntityCoords(ped)
			TaskStartScenarioAtPosition(ped,animSequency["task"],coords["x"],coords["y"],coords["z"] - 1,GetEntityHeading(ped),0,0,false)
		else
			TaskStartScenarioInPlace(ped,animSequency["task"],0,false)
		end
	else
		tvRP.stopAnim(animUpper)

		if animUpper then
			playFlags = playFlags + 48
		end

		if animLoop then
			playFlags = playFlags + 1
		end

		CreateThread(function()
			RequestAnimDict(animSequency[1])
			while not HasAnimDictLoaded(animSequency[1]) do
				Wait(1)
			end

			if HasAnimDictLoaded(animSequency[1]) then
				animDict = animSequency[1]
				animName = animSequency[2]
				animFlags = playFlags

				if playFlags == 49 then
					animActived = true
				end

				TaskPlayAnim(ped,animSequency[1],animSequency[2],8.0,8.0,-1,playFlags,0,0,0,0)
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()
		if animActived then
			if not IsEntityPlayingAnim(Ped,animDict,animName,3) then
				TaskPlayAnim(Ped,animDict,animName,8.0,8.0,-1,animFlags,0,0,0,0)
				timeDistance = 1
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if animActived then
			timeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopAnim(animUpper)
	animActived = false
	local Ped = PlayerPedId()

	if animUpper then
		ClearPedSecondaryTask(Ped)
	else
		ClearPedTasks(Ped)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPACTIVED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopActived()
	animActived = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTENALBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function passportEnable()
	if showPassports or not MumbleIsConnected() then return end

	showPassports = true
	local playerList = vRPS.userPlayers()

	while showPassports do
		local Ped = PlayerPedId()
		local userList = GetPlayers()
		local Coords = GetEntityCoords(Ped)

		for k,v in pairs(userList) do
			local uPlayer = GetPlayerFromServerId(k)
			if NetworkIsPlayerConnected(uPlayer) then
				local uPed = GetPlayerPed(uPlayer)
				local uCoords = GetEntityCoords(uPed)
				local Distance = #(Coords - uCoords)
				if Distance <= 5 then
					DrawText3D(uCoords["x"],uCoords["y"],uCoords["z"] + 1.10,playerList[k],0.45)
				end
			end
		end

		Wait(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function passportDisable()
	showPassports = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+showPassports",passportEnable)
RegisterCommand("-showPassports",passportDisable)
RegisterKeyMapping("+showPassports","Visualizar passaportes.","keyboard","F7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,weight)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = (string.len(text) + 4) / 160 * weight
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop",function(resource)
	TriggerServerEvent("vRP:Print","pausou o resource "..resource)
end)