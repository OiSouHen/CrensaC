-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("tablet",cRP)
vCLIENT = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
GlobalState["Cars"] = {}
GlobalState["Bikes"] = {}
GlobalState["Rental"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Cars = {}
	local Bikes = {}
	local Rental = {}
	local vehicles = vehicleGlobal()

	for k,v in pairs(vehicles) do
		if v[4] == "cars" then
			table.insert(Cars,{ k = k, name = v[1], price = v[3], chest = v[2], tax = parseInt(v[3] * 0.10) })
		elseif v[4] == "bikes" then
			table.insert(Bikes,{ k = k, name = v[1], price = v[3], chest = v[2], tax = parseInt(v[3] * 0.10) })
		elseif v[4] == "rental" then
			table.insert(Rental,{ k = k, name = v[1], price = v[5], chest = v[2], tax = parseInt(v[3] * 0.10) })
		end
	end

	GlobalState["Cars"] = Cars
	GlobalState["Bikes"] = Bikes
	GlobalState["Rental"] = Rental
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestRental(vehName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true

			if vRP.getFines(user_id) > 0 then
				TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
				actived[user_id] = nil
				return
			end

			local vehPrice = vehicleGems(vehName)
			if vRP.request(source,"Alugar o veículo <b>"..vehicleName(vehName).."</b> por <b>"..parseFormat(vehPrice).." gemas</b>?") then
				if vRP.paymentGems(user_id,vehPrice) then
					local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehName })
					if vehicle[1] then
						if vehicle[1]["rental"] <= os.time() then
							vRP.execute("vehicles/rentalVehiclesUpdate",{ user_id = user_id, vehicle = vehName })
							TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..vehicleName(vehName).."</b> atualizado.",5000)
						else
							vRP.execute("vehicles/rentalVehiclesDays",{ user_id = user_id, vehicle = vehName })
							TriggerClientEvent("Notify",source,"verde","Adicionado <b>30 Dias</b> de aluguel no veículo <b>"..vehicleName(vehName).."</b>.",5000)
						end
					else
						vRP.execute("vehicles/rentalVehicles",{ user_id = user_id, vehicle = vehName, plate = vRP.generatePlate(), work = "false" })
						TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..vehicleName(vehName).."</b> concluído.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
				end
			end

			actived[user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestBuy(vehName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true

			if vRP.getFines(user_id) > 0 then
				TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
				actived[user_id] = nil
				return
			end

			local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehName })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..vehicleName(vehName).."</b>.",3000)
				actived[user_id] = nil
				return
			else
				if vehicleType(vehName) == "work" then
					if vRP.paymentFull(user_id,vehiclePrice(vehName)) then
						vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = vehName, plate = vRP.generatePlate(), work = "true" })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				else
					if vehicleType(vehName) == "bikes" then
						if not vRP.hasGroup(user_id,"TheLost") then
							TriggerClientEvent("Notify",source,"amarelo","Veículo vendido pelos membros dos <b>Motoqueiros</b>.",3000)
							actived[user_id] = nil
							return
						end
					end

					local vehPrice = vehiclePrice(vehName)
					if vRP.request(source,"Comprar <b>"..vehicleName(vehName).."</b> por <b>$"..parseFormat(vehPrice).."</b> dólares?") then
						if vRP.paymentFull(user_id,vehPrice) then
							vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = vehName, plate = vRP.generatePlate(), work = "false" })
							TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						end
					end
				end
			end

			actived[user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local plateVehs = {}
function cRP.startDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true

			if not exports["hud"]:Wanted(user_id) then
				if vRP.request(source,"Iniciar o teste por <b>$100</b> dólares?") then
					if vRP.paymentFull(user_id,100) then
						plateVehs[user_id] = "PDMS"..(1000 + user_id)

						TriggerEvent("engine:tryFuel",plateVehs[user_id],100)
						TriggerClientEvent("update:Route",source,user_id)
						TriggerEvent("plateEveryone",plateVehs[user_id])
						SetPlayerRoutingBucket(source,user_id)
						actived[user_id] = nil

						return true,plateVehs[user_id]
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end

			actived[user_id] = nil
		end
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("plateReveryone",plateVehs[user_id])
		TriggerClientEvent("update:Route",source,0)
		SetPlayerRoutingBucket(source,0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if actived[user_id] then
		actived[user_id] = nil
	end

	if plateVehs[user_id] then
		plateVehs[user_id] = nil
	end
end)