-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 100
		if LocalPlayer["state"]["Route"] < 900000 then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) and IsPedJumping(ped) then
				timeDistance = 1

				if IsControlJustReleased(1,51) then
					local tackled = {}
					local coords = GetEntityForwardVector(ped)

					SetPedToRagdollWithFall(ped,2500,1500,0,coords,1.0,0.0,0.0,0.0,0.0,0.0,0.0)

					while IsPedRagdoll(ped) do
						for _,v in ipairs(touchedPlayers()) do
							if not tackled[v] then
								tackled[v] = true
								TriggerServerEvent("inventory:Cancel")
								TriggerServerEvent("tackle:Update",GetPlayerServerId(v),{ coords["x"],coords["y"],coords["z"] })
							end
						end

						Wait(1)
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tackle:Player")
AddEventHandler("tackle:Player",function(coords)
	SetPedToRagdollWithFall(PlayerPedId(),5000,5000,0,coords[1],coords[2],coords[3],10.0,0.0,0.0,0.0,0.0,0.0,0.0)
	TriggerServerEvent("inventory:Cancel")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOUCHEDPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function touchedPlayers()
	local players = {}
	local ped = PlayerPedId()
	for k,v in ipairs(GetActivePlayers()) do
		local uPed = GetPlayerPed(v)
		if IsEntityTouchingEntity(ped,uPed) and not IsPedInAnyVehicle(uPed) then
			table.insert(players,v)
		end
	end

	return players
end