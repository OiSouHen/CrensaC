-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("races")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Races = {}
local Selected = 1
local raceTyres = {}
local savePoints = 0
local racePoints = 0
local Checkpoints = 1
local CheckBlip = nil
local Progress = false
local ExplodeTimers = 0
local ExplodeRace = false
local inativeRaces = false
local displayRanking = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRACES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if not inativeRaces then
			local ped = PlayerPedId()

			if IsPedInAnyVehicle(ped) then
				if Progress then
					timeDistance = 100
					racePoints = (GetGameTimer() - savePoints)

					SendNUIMessage({ Points = racePoints, Explosive = (ExplodeTimers - GetGameTimer()) })

					local vehicle = GetVehiclePedIsUsing(ped)
					if GetPedInVehicleSeat(vehicle,-1) ~= ped then
						leaveRace()
					end

					if ExplodeRace and GetGameTimer() >= ExplodeTimers then
						leaveRace()
					end

					local coords = GetEntityCoords(ped)
					local distance = #(coords - vec3(Races[Selected]["coords"][Checkpoints][1][1],Races[Selected]["coords"][Checkpoints][1][2],Races[Selected]["coords"][Checkpoints][1][3]))
					if distance <= 5 then
						if Checkpoints >= #Races[Selected]["coords"] then
							PlaySoundFrontend(-1,"CHECKPOINT_UNDER_THE_BRIDGE","HUD_MINI_GAME_SOUNDSET",false)
							vSERVER.finishRace(Selected,racePoints)
							SendNUIMessage({ show = false })
							Progress = false
							cleanObjects()
							cleanBlips()

							Selected = 1
							raceTyres = {}
							savePoints = 0
							racePoints = 0
							Checkpoints = 1
							CheckBlip = nil
							ExplodeTimers = 0
							ExplodeRace = false
							displayRanking = false
						else
							SendNUIMessage({ upCheckpoint = true })
							Checkpoints = Checkpoints + 1
							makeObjects()
							makeBlips()
						end
					end
				else
					local coords = GetEntityCoords(ped)
					for k,v in pairs(Races) do
						local distance = #(coords - vec3(v["init"][1],v["init"][2],v["init"][3]))
						if distance <= 25 then
							local vehicle = GetVehiclePedIsUsing(ped)
							if GetPedInVehicleSeat(vehicle,-1) == ped and not IsPedOnAnyBike(ped) then
								DrawMarker(23,v["init"][1],v["init"][2],v["init"][3] - 0.36,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,0.0,46,110,76,100,0,0,0,0)
								timeDistance = 1

								if distance <= 5 then
									if IsControlJustPressed(1,47) then
										if not displayRanking then
											SendNUIMessage({ ranking = vSERVER.requestRanking(k) })
											displayRanking = true
										else
											SendNUIMessage({ ranking = false })
											displayRanking = false
										end
									end

									if IsControlJustPressed(1,38) then
										local raceStatus,raceExplosive = vSERVER.checkPermission(k)
										if raceStatus then
											if displayRanking then
												SendNUIMessage({ ranking = false })
												displayRanking = false
											end

											SendNUIMessage({ show = true, maxCheckpoint = #Races[k]["coords"] })
											savePoints = GetGameTimer()
											Checkpoints = 1
											racePoints = 0
											Selected = k

											makeObjects()
											makeBlips()

											if raceExplosive then
												ExplodeTimers = GetGameTimer() + (v["explode"] * 1000)
												ExplodeRace = true
											end

											Progress = true
										end
									end
								else
									if displayRanking then
										SendNUIMessage({ ranking = false })
										displayRanking = false
									end
								end
							end
						end
					end
				end
			else
				if Progress then
					leaveRace()
				end

				if displayRanking then
					SendNUIMessage({ ranking = false })
					displayRanking = false
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlips()
	if DoesBlipExist(CheckBlip) then
		RemoveBlip(CheckBlip)
		CheckBlip = nil
	end

	CheckBlip = AddBlipForCoord(Races[Selected]["coords"][Checkpoints][1][1],Races[Selected]["coords"][Checkpoints][1][2],Races[Selected]["coords"][Checkpoints][1][3])
	SetBlipSprite(CheckBlip,1)
	SetBlipAsShortRange(CheckBlip,true)
	SetBlipScale(CheckBlip,0.5)
	SetBlipColour(CheckBlip,59)
	SetBlipRoute(CheckBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Checkpoint")
	EndTextCommandSetBlipName(CheckBlip)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function makeObjects()
	for k,objects in pairs(raceTyres) do
		if DoesEntityExist(objects) then
			DeleteEntity(objects)
			raceTyres[k] = nil
		end
	end

	local mHash = GetHashKey("prop_offroad_tyres02")

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Wait(1)
	end

	raceTyres[1] = CreateObjectNoOffset(mHash,Races[Selected]["coords"][Checkpoints][2][1],Races[Selected]["coords"][Checkpoints][2][2],Races[Selected]["coords"][Checkpoints][2][3],false,false,false)
	raceTyres[2] = CreateObjectNoOffset(mHash,Races[Selected]["coords"][Checkpoints][3][1],Races[Selected]["coords"][Checkpoints][3][2],Races[Selected]["coords"][Checkpoints][3][3],false,false,false)

	PlaceObjectOnGroundProperly(raceTyres[1])
	PlaceObjectOnGroundProperly(raceTyres[2])

	SetEntityCollision(raceTyres[1],false,false)
	SetEntityCollision(raceTyres[2],false,false)

	SetEntityLodDist(raceTyres[1],0xFFFF)
	SetEntityLodDist(raceTyres[2],0xFFFF)

	SetModelAsNoLongerNeeded(mHash)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function cleanBlips()
	if DoesBlipExist(CheckBlip) then
		RemoveBlip(CheckBlip)
		CheckBlip = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cleanObjects()
	for k,objects in pairs(raceTyres) do
		if DoesEntityExist(objects) then
			DeleteEntity(objects)
			raceTyres[k] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVERACE
-----------------------------------------------------------------------------------------------------------------------------------------
function leaveRace()
	Progress = false
	SendNUIMessage({ show = false })
	cleanObjects()
	cleanBlips()

	Selected = 1
	raceTyres = {}
	savePoints = 0
	racePoints = 0
	Checkpoints = 1
	CheckBlip = nil
	ExplodeTimers = 0
	vSERVER.exitRace()
	displayRanking = false

	if ExplodeRace then
		Wait(3000)

		local vehicle = GetPlayersLastVehicle()
		NetworkExplodeVehicle(vehicle,true,true,false)
	end

	ExplodeRace = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES:INATIVERACES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("races:insertList")
AddEventHandler("races:insertList",function(status)
	inativeRaces = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("races:Table")
AddEventHandler("races:Table",function(table)
	Races = table

	for _,v in pairs(Races) do
		local blip = AddBlipForRadius(v["init"][1],v["init"][2],v["init"][3],10.0)
		SetBlipAlpha(blip,200)
		SetBlipColour(blip,59)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
local oldSpeed = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
local bikesModel = {
	[1131912276] = true,
	[448402357] = true,
	[-836512833] = true,
	[-186537451] = true,
	[1127861609] = true,
	[-1233807380] = true,
	[-400295096] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if not Progress then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				timeDistance = 1

				DisableControlAction(0,345,true)

				local Vehicle = GetVehiclePedIsUsing(Ped)
				if GetPedInVehicleSeat(Vehicle,-1) == Ped then
					if GetVehicleDirtLevel(Vehicle) ~= 0.0 then
						SetVehicleDirtLevel(Vehicle,0.0)
					end

					local Speed = GetEntitySpeed(Vehicle) * 3.6
					if Speed ~= oldSpeed then
						if (oldSpeed - Speed) >= 125 then
							vehicleTyreBurst(Vehicle)
						end

						oldSpeed = Speed
					end
				end
			else
				if oldSpeed ~= 0 then
					oldSpeed = 0
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleTyreBurst(Vehicle)
	local vehModel = GetEntityModel(Vehicle)
	if bikesModel[vehModel] == nil and GetVehicleClass(Vehicle) ~= 8 then
		local Tyre = math.random(4)
		if Tyre == 1 then
			if GetTyreHealth(Vehicle,0) == 1000.0 then
				SetVehicleTyreBurst(Vehicle,0,true,1000.0)
			end
		elseif Tyre == 2 then
			if GetTyreHealth(Vehicle,1) == 1000.0 then
				SetVehicleTyreBurst(Vehicle,1,true,1000.0)
			end
		elseif Tyre == 3 then
			if GetTyreHealth(Vehicle,4) == 1000.0 then
				SetVehicleTyreBurst(Vehicle,4,true,1000.0)
			end
		elseif Tyre == 4 then
			if GetTyreHealth(Vehicle,5) == 1000.0 then
				SetVehicleTyreBurst(Vehicle,5,true,1000.0)
			end
		end

		if math.random(100) < 25 then
			Wait(500)
			vehicleTyreBurst(Vehicle)
		end
	end
end