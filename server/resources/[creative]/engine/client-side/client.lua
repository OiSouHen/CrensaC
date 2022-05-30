-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("engine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehFuels = {}
local fuelLast = 0
local fuelPrice = 0
local fuelNui = false
local fuelSupply = false
local fuelEnter = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(resourceName)
	if GetCurrentResourceName() == resourceName then
		SetNuiFocus(false,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,args)
	if Event == "CEventNetworkPlayerEnteredVehicle" then
		if args[1] == PlayerId() and GetGameTimer() >= fuelEnter then
			fuelEnter = GetGameTimer() + 5000

			local vehPlate = GetVehicleNumberPlateText(args[2])
			vehFuels[vehPlate] = vSERVER.vehicleFuel(vehPlate)
			SetVehicleFuelLevel(args[2],vehFuels[vehPlate] + 0.0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASS
-----------------------------------------------------------------------------------------------------------------------------------------
local Class = {
	[0] = 1.0,
	[1] = 1.0,
	[2] = 1.0,
	[3] = 1.0,
	[4] = 1.0,
	[5] = 1.0,
	[6] = 1.0,
	[7] = 1.0,
	[8] = 1.0,
	[9] = 1.0,
	[10] = 1.0,
	[11] = 1.0,
	[12] = 1.0,
	[13] = 0.0,
	[14] = 0.0,
	[15] = 2.5,
	[16] = 1.0,
	[17] = 1.0,
	[18] = 1.0,
	[19] = 1.0,
	[20] = 1.0,
	[21] = 0.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
local Consume = {
	[1.0] = 0.95,
	[0.9] = 0.85,
	[0.8] = 0.75,
	[0.7] = 0.65,
	[0.6] = 0.55,
	[0.5] = 0.45,
	[0.4] = 0.35,
	[0.3] = 0.25,
	[0.2] = 0.15,
	[0.1] = 0.05,
	[0.0] = 0.00
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLOOR
-----------------------------------------------------------------------------------------------------------------------------------------
function floor(Number)
	local Mult = 10 ^ 1
	return math.floor(Number * Mult + 0.5) / Mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Route"] == 0 then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				if GetVehicleFuelLevel(Vehicle) >= 1 then
					if (GetEntitySpeed(Vehicle) * 3.6) >= 1 then
						local vehPlate = GetVehicleNumberPlateText(Vehicle)

						if vehFuels[vehPlate] ~= nil then
							vehFuels[vehPlate] = (vehFuels[vehPlate] - (Consume[floor(GetVehicleCurrentRpm(Vehicle))] or 1.0) * (Class[GetVehicleClass(Vehicle)] or 1.0) / 10)
							SetVehicleFuelLevel(Vehicle,vehFuels[vehPlate] + 0.0)
						end

						if GetPedInVehicleSeat(Vehicle,-1) == Ped then
							TriggerServerEvent("engine:tryFuel",vehPlate,vehFuels[vehPlate])
						end
					end
				else
					SetVehicleEngineOn(Vehicle,false,true,true)
					timeDistance = 1
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:SUPPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:Supply")
AddEventHandler("engine:Supply",function(Entity)
	local Vehicle = Entity[3]
	fuelLast = GetVehicleFuelLevel(Vehicle)

	if fuelLast < 99.0 then
		local Gallon = Entity[5]
		if not fuelNui and not Gallon then
			SendNUIMessage({ show = true })
			fuelNui = true
		end

		fuelSupply = true
		local vehPlate = Entity[1]
		local vehNet = Entity[4]
		local Ped = PlayerPedId()
		TaskTurnPedToFaceEntity(Ped,Vehicle,5000)

		RequestAnimDict("timetable@gardener@filling_can")
		while not HasAnimDictLoaded("timetable@gardener@filling_can") do
			Wait(1)
		end

		while fuelSupply do
			DisableControlAction(1,18,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,23,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,30,true)
			DisableControlAction(1,31,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)

			local vCoords = GetEntityCoords(Vehicle)
			local vFuel = GetVehicleFuelLevel(Vehicle)

			if not Gallon then
				fuelPrice = fuelPrice + 0.085
				SetVehicleFuelLevel(Vehicle,vFuel + 0.025)
				SendNUIMessage({ tank = floor(vFuel), price = fuelPrice, lts = 0.085 * 4 })
			else
				if GetAmmoInPedWeapon(Ped,883325847) - 0.02 * 100 > 1 then
					SetPedAmmo(Ped,883325847,math.floor(GetAmmoInPedWeapon(Ped,883325847) - 0.02 * 100))
					SetVehicleFuelLevel(Vehicle,vFuel + 0.025)
				end
			end

			text3D(vCoords["x"],vCoords["y"],vCoords["z"] + 1,"~g~E~w~   FINALIZAR")

			if not IsEntityPlayingAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
				TaskPlayAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",8.0,8.0,-1,50,0,0,0,0)
			end

			if vFuel >= 100.0 or GetEntityHealth(Ped) <= 100 or (Gallon and GetAmmoInPedWeapon(Ped,883325847) - 0.02 * 100 <= 1) or IsControlJustPressed(1,38) then
				finishFuel(Gallon,vehPlate,vFuel,vehNet)
			end

			Wait(1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function finishFuel(Gallon,vehPlate,vFuel,vehNet)
	if not Gallon then
		if vSERVER.paymentFuel(fuelPrice,vehPlate,vFuel,fuelLast,vehNet) then
			TriggerServerEvent("engine:tryFuel",vehPlate,vFuel)
			vehFuels[vehPlate] = vFuel
		else
			TriggerServerEvent("engine:tryFuel",vehPlate,fuelLast)
			vehFuels[vehPlate] = fuelLast
		end

		SendNUIMessage({ show = false })
	else
		TriggerServerEvent("engine:tryFuel",vehPlate,vFuel)
	end

	vRP.removeObjects()
	fuelSupply = false
	fuelNui = false
	fuelPrice = 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:SYNCFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:syncFuel")
AddEventHandler("engine:syncFuel",function(vehPlate,Result,vehNet)
	vehFuels[vehPlate] = Result

	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			SetVehicleFuelLevel(Vehicle,vehFuels[vehPlate] + 0.0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function text3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = (string.len(text) + 4) / 170 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:vehTuning")
AddEventHandler("engine:vehTuning",function()
	local vehicle = vRP.nearVehicle(5)
	if vehicle then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)
		local vehPlate = GetVehicleNumberPlateText(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 4 then
			suspensao = "Nível 5 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","default","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Lataria:</b> "..parseInt(body / 10).."%<br><b>Nitro:</b> "..parseInt((GlobalState["Nitro"][plate] or 0) / 20).."%<br><b>Motor:</b> "..parseInt(engine / 10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",10000)
	end
end)