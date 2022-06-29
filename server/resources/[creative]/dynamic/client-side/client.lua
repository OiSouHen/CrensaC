-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("dynamic")
vINVENTORY = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
local animalHash = nil
local spawnAnimal = false
local animalFollow = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,par,id,server)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu",function(title,description,id)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = id })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("openMenu",function()
	SendNUIMessage({ show = true })
	SetNuiFocus(true,true)
	menuOpen = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked",function(data)
	if data["trigger"] and data["trigger"] ~= "" then
		if data["server"] == "true" then
			TriggerServerEvent(data["trigger"],data["param"])
		else
			TriggerEvent(data["trigger"],data["param"])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function()
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	SendNUIMessage({ close = true })
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function(source,args,rawCommand)
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and MumbleIsConnected() and LocalPlayer["state"]["Route"] < 900000 then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if GetEntityHealth(Ped) > 100 then
			if LocalPlayer["state"]["Propertys"] and not LocalPlayer["state"]["Theft"] then
				TriggerEvent("propertys:propertyPanel")
				return
			end
			
			exports["dynamic"]:AddButton("Chapéu","Colocar/Retirar o chapéu.","player:outfitFunctions","Hat","clothes",true)
			exports["dynamic"]:AddButton("Máscara","Colocar/Retirar a máscara.","player:outfitFunctions","Mask","clothes",true)
			exports["dynamic"]:AddButton("Óculos","Colocar/Retirar o óculos.","player:outfitFunctions","Glasses","clothes",true)
			exports["dynamic"]:AddButton("Vestir","Vestir-se com as vestimentas guardadas.","player:outfitFunctions","aplicar","clothes",true)
			exports["dynamic"]:AddButton("Guardar","Salvar suas vestimentas do corpo.","player:outfitFunctions","salvar","clothes",true)

			if animalHash ~= nil then
				exports["dynamic"]:AddButton("Seguir","Seguir o proprietário.","dynamic:animalFunctions","seguir","animal",false)
				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar o animal no veículo.","dynamic:animalFunctions","colocar","animal",false)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover o animal no veículo.","dynamic:animalFunctions","remover","animal",false)
			end

			exports["dynamic"]:AddButton("Ferimentos","Verificar ferimentos no corpo.","paramedic:Injuries","","others",false)

			if not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddButton("Rebocar","Colocar veículo na prancha do reboque.","towdriver:invokeTow","","others",false)
				exports["dynamic"]:AddButton("Desbugar","Recarregar o personagem.","barbershop:debug","","others",true)

				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","ClosestPeds",true)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","ClosestPeds",true)
				
				exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","ClosestPeds")
			else
				exports["dynamic"]:AddButton("Banco Dianteiro Esquerdo","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
				exports["dynamic"]:AddButton("Banco Dianteiro Direito","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Esquerdo","Sentar no banco do passageiro.","player:seatPlayer","2","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Direito","Sentar no banco do passageiro.","player:seatPlayer","3","vehicle",false)
				exports["dynamic"]:AddButton("Levantar Vidros","Levantar todos os vidros.","player:winsFunctions","1","vehicle",true)
				exports["dynamic"]:AddButton("Abaixar Vidros","Abaixar todos os vidros.","player:winsFunctions","0","vehicle",true)

				exports["dynamic"]:SubMenu("Veículo","Funções do veículo.","vehicle")
			end

			exports["dynamic"]:SubMenu("Roupas","Colocar/Retirar roupas.","clothes")

			-- local Experience = vSERVER.Experience()
			-- for Name,Exp in pairs(Experience) do
				-- exports["dynamic"]:AddButton(Name,"Você possuí <yellow>"..Exp.." pontos</yellow> na classe <yellow>"..ClassCategory(Exp).."</yellow>.","","","Experience",false)
			-- end

			if animalHash ~= nil then
				exports["dynamic"]:SubMenu("Domésticos","Todas as funções dos animais domésticos.","animal")
			end
			
			-- exports["dynamic"]:SubMenu("Experiência","Todas as suas habilidades.","Experience")

			exports["dynamic"]:SubMenu("Outros","Todas as funções do personagem.","others")

			exports["dynamic"]:openMenu()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions",function(source,args,rawCommand)
	if LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Paramedic"] then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and MumbleIsConnected() and LocalPlayer["state"]["Route"] < 900000 then

			local Ped = PlayerPedId()
			if GetEntityHealth(Ped) > 100 then
				if not IsPedInAnyVehicle(Ped) then
					exports["dynamic"]:AddButton("Carregar","Carregar a pessoa mais próxima.","player:carryPlayer","","player",true)
					exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","player",true)
					exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","player",true)

					exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","player")
				end

				if LocalPlayer["state"]["Police"] then
					exports["dynamic"]:AddButton("Remover Chapéu","Remover da pessoa mais próxima.","skinshop:removeProps","Hat","player",true)
					exports["dynamic"]:AddButton("Remover Máscara","Remover da pessoa mais próxima.","skinshop:removeProps","Mask","player",true)
					exports["dynamic"]:AddButton("Remover Óculos","Remover da pessoa mais próxima.","skinshop:removeProps","Glasses","player",true)

					exports["dynamic"]:AddButton("Sheriff","Fardamento de oficial.","player:presetFunctions","1","prePolice",true)
					exports["dynamic"]:AddButton("State Police","Fardamento de oficial.","player:presetFunctions","2","prePolice",true)
					exports["dynamic"]:AddButton("Park Ranger","Fardamento de oficial.","player:presetFunctions","3","prePolice",true)
					exports["dynamic"]:AddButton("Los Santos Police","Fardamento de oficial.","player:presetFunctions","4","prePolice",true)
					exports["dynamic"]:AddButton("Los Santos Police","Fardamento de oficial.","player:presetFunctions","5","prePolice",true)

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos policiais.","prePolice")
					exports["dynamic"]:AddButton("Invadir","Invadir a residência.","homes:invadeSystem","",false,true)
					exports["dynamic"]:AddButton("Computador","Computador de bordo policial.","police:openSystem","",false,false)
				elseif LocalPlayer["state"]["Paramedic"] then
					exports["dynamic"]:AddButton("Medical Center","Fardamento de doutor.","player:presetFunctions","6","preMedic",true)
					exports["dynamic"]:AddButton("Medical Center","Fardamento de paramédico.","player:presetFunctions","7","preMedic",true)
					exports["dynamic"]:AddButton("Medical Center","Fardamento de paramédico interno.","player:presetFunctions","8","preMedic",true)
					exports["dynamic"]:AddButton("Fire departamentStore","Fardamento de atendimentos.","player:presetFunctions","9","preMedic",true)
					exports["dynamic"]:AddButton("Fire departamentStore","Fardamento de mergulhador.","player:presetFunctions","10","preMedic",true)

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos médicos.","preMedic")
				end

				exports["dynamic"]:openMenu()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("emergencyFunctions","Abrir menu de emergencial.","keyboard","F10")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalSpawn")
AddEventHandler("dynamic:animalSpawn",function(model)
	if animalHash == nil then
		if not spawnAnimal then
			spawnAnimal = true

			local Ped = PlayerPedId()
			local heading = GetEntityHeading(Ped)
			local coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,1.0,0.0)
			local myObject,objNet = vRPS.CreatePed(model,coords["x"],coords["y"],coords["z"],heading,28)
			if myObject then
				local spawnAnimal = 0
				animalHash = NetworkGetEntityFromNetworkId(objNet)
				while not DoesEntityExist(animalHash) and spawnAnimal <= 1000 do
					animalHash = NetworkGetEntityFromNetworkId(objNet)
					spawnAnimal = spawnAnimal + 1
					Wait(1)
				end

				spawnAnimal = 0
				local pedControl = NetworkRequestControlOfEntity(animalHash)
				while not pedControl and spawnAnimal <= 1000 do
					pedControl = NetworkRequestControlOfEntity(animalHash)
					spawnAnimal = spawnAnimal + 1
					Wait(1)
				end

				SetPedCanRagdoll(animalHash,false)
				SetEntityInvincible(animalHash,true)
				SetPedFleeAttributes(animalHash,0,0)
				SetEntityAsMissionEntity(animalHash,true,false)
				SetBlockingOfNonTemporaryEvents(animalHash,true)
				SetPedRelationshipGroupHash(animalHash,GetHashKey("k9"))
				GiveWeaponToPed(animalHash,GetHashKey("WEAPON_ANIMAL"),200,true,true)
		
				SetEntityAsNoLongerNeeded(animalHash)

				TriggerEvent("dynamic:animalFunctions","seguir")

				vSERVER.animalRegister(objNet)
			end

			spawnAnimal = false
		end
	else
		vSERVER.animalCleaner()
		animalFollow = false
		animalHash = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ANIMALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:animalFunctions")
AddEventHandler("dynamic:animalFunctions",function(functions)
	if animalHash ~= nil then
		local Ped = PlayerPedId()

		if functions == "seguir" then
			if not animalFollow then
				TaskFollowToOffsetOfEntity(animalHash,Ped,1.0,1.0,0.0,5.0,-1,2.5,1)
				SetPedKeepTask(animalHash,true)
				animalFollow = true
			else
				SetPedKeepTask(animalHash,false)
				ClearPedTasks(animalHash)
				animalFollow = false
			end
		elseif functions == "colocar" then
			if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) then
				local vehicle = GetVehiclePedIsUsing(Ped)
				if IsVehicleSeatFree(vehicle,0) then
					TaskEnterVehicle(animalHash,vehicle,-1,0,2.0,16,0)
				end
			end
		elseif functions == "remover" then
			if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) then
				TaskLeaveVehicle(animalHash,GetVehiclePedIsUsing(Ped),256)
				TriggerEvent("dynamic:animalFunctions","seguir")
			end
		elseif functions == "deletar" then
			vSERVER.animalCleaner()
			animalFollow = false
			animalHash = nil
		end
	end
end)