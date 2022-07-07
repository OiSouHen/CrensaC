-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("paramedic",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Damaged = {}
local Bleeding = 0
local BloodTick = 0
local Injuried = GetGameTimer()
local BloodTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,args)
	if LocalPlayer["state"]["Route"] < 900000 then
		if name == "CEventNetworkEntityDamage" then
			if PlayerPedId() == args[1] and LocalPlayer["state"]["Active"] then
				if args[7] == 126349499 or args[7] == 1064738331 or args[7] == 85055149 then
					SetPedToRagdoll(PlayerPedId(),2500,2500,0,0,0,0)
				else
					if GetGameTimer() >= Injuried then
						if not IsPedInAnyVehicle(args[1]) and GetEntityHealth(args[1]) > 100 then
							Injuried = GetGameTimer() + 1000

							local Hit,Mark = GetPedLastDamageBone(args[1])
							if Hit and not Damaged[Mark] and Mark ~= 0 then
								TriggerServerEvent("evidence:dropEvidence","yellow")
								Bleeding = Bleeding + 1
								Damaged[Mark] = true
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOODTICK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if GetGameTimer() >= BloodTimers and LocalPlayer["state"]["Route"] < 900000 and GetEntityHealth(Ped) > 100 then
			BloodTimers = GetGameTimer() + 10000
			BloodTick = BloodTick + 1

			if BloodTick >= 3 and Bleeding >= 3 then
				BloodTick = 0
				local Nocaute = Bleeding * 1000

				if not IsPedInAnyVehicle(Ped) then
					SetPedToRagdoll(Ped,Nocaute,Nocaute,0,0,0,0)
					TriggerServerEvent("inventory:Cancel")
				end

				DoScreenFadeOut(1000)
				Wait(Nocaute)
				DoScreenFadeIn(1000)
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Reset")
AddEventHandler("paramedic:Reset",function()
	Damaged = {}
	Bleeding = 0
	BloodTick = 0
	Injuried = GetGameTimer()
	BloodTimers = GetGameTimer()
	ClearPedBloodDamage(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Bleeding()
	return Bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Bandage()
	local Humanes = ""
	for k,v in pairs(Damaged) do
		TriggerEvent("Notify","amarelo","Passou ataduras no(a) <b>"..Bone(k).."</b>.",3000)
		TriggerEvent("sounds:source","bandage",0.5)
		Bleeding = Bleeding - 1
		Humanes = Bone(k)
		Damaged[k] = nil
		BloodTick = 0
		break
	end

	if Bleeding <= 0 then
		ClearPedBloodDamage(PlayerPedId())
	end

	return Humanes
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:INJURIES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:Injuries")
AddEventHandler("paramedic:Injuries",function()
	local Number = 0
	local Injuries = ""
	local Damages = false

	for k,v in pairs(Damaged) do
		if not Damages then
			Injuries = Injuries.."<b>Danos Superficiais:</b><br>"
			Damages = true
		end

		Number = Number + 1
		Injuries = Injuries.."<b>"..Number.."</b>: "..Bone(k).."<br>"
	end

	if Injuries == "" then
		TriggerEvent("Notify","amarelo","Nenhum ferimento encontrado.",5000)
	else
		TriggerEvent("Notify","amarelo",Injuries,10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Diagnostic()
	return Damaged,Bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Arms",function()
	if Damaged[18905] or Damaged[18905] or Damaged[60309] or Damaged[36029] or Damaged[57005] or Damaged[28422] or Damaged[6286] then
		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEGS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Legs",function()
	if Damaged[14201] or Damaged[65245] or Damaged[57717] or Damaged[52301] or Damaged[35502] or Damaged[24806] then
		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOPE
-----------------------------------------------------------------------------------------------------------------------------------------
local Hope = GetGameTimer()
local Warning = GetGameTimer()
CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			if exports["paramedic"]:Legs() then
				timeDistance = 1
				DisableControlAction(1,22,true)

				if IsDisabledControlJustPressed(1,22) and GetGameTimer() >= Warning then
					TriggerEvent("Notify","amarelo","Perna machucada.",3000)
					Warning = GetGameTimer() + 5000
				end
			elseif GetGameTimer() <= Hope then
				timeDistance = 1
				DisableControlAction(1,22,true)
			else
				if IsPedJumping(Ped) then
					Hope = GetGameTimer() + 5000
				end
			end
		end

		Wait(timeDistance)
	end
end)