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
Tunnel.bindInterface("propertys",cRP)
vSERVER = Tunnel.getInterface("propertys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local homes = {
	["list"] = {},
	["open"] = "",
	["theft"] = "",
	["vault"] = "",
	["garage"] = 0,
	["shell"] = nil,
	["intern"] = {},
	["current"] = {},
	["locker"] = nil,
	["blips"] = false,
	["called"] = false,
	["theftCoords"] = {},
	["blipsCoords"] = {},
	["police"] = GetGameTimer(),
	["pressButton"] = GetGameTimer()
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["homeName"] = 0
LocalPlayer["state"]["Theft"] = false
LocalPlayer["state"]["Propertys"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:UPDATECALLED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:UpdateCalled")
AddEventHandler("homes:UpdateCalled",function()
	homes["called"] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v["x"] << 8) | v["y"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCKERCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local lockerCoords = {
	["creativeFranklin"] = { 18.37,-27.71,-24.01,235.28 },
	["creativeLostudios"] = { 53.75,-52.0,-24.01,51.03 },
	["creativeOneFloors"] = { 91.43,74.91,-24.01,85.04 },
	["creativeThreeFloors"] = { 120.06,-122.07,-27.4,280.63 },
	["creativeTwoFloors"] = { 165.66,-151.71,-17.79,45.36 },
	["creativeSquare"] = { 93.0,-103.34,-24.2,221.11 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEFTCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local theftCoords = {
	["creativeFranklin"] = {
		["MOBILE01"] = { 25.09,-26.05,-24.01,226.78 },
		["MOBILE02"] = { 23.7,-21.95,-24.01,51.03 },
		["MOBILE03"] = { 25.47,-20.55,-24.01,5.67 },
		["MOBILE04"] = { 23.66,-27.66,-24.01,240.95 },
		["MOBILE05"] = { 18.94,-32.54,-24.01,136.07 },
		["MOBILE06"] = { 26.39,-33.44,-24.01,138.9 },
		["MOBILE07"] = { 26.8,-30.11,-24.01,325.99 },
		["MOBILE08"] = { 30.98,-28.27,-24.01,235.28 },
		["MOBILE09"] = { 30.94,-25.88,-24.01,51.03 },
		["LOCKER"] = { 18.37,-27.71,-24.01,235.28 }
	},
	["creativeLostudios"] = {
		["MOBILE01"] = { 46.82,-44.94,-24.01,51.03 },
		["MOBILE02"] = { 45.79,-49.21,-24.01,141.74 },
		["MOBILE03"] = { 52.71,-52.69,-24.01,235.28 },
		["MOBILE04"] = { 51.46,-53.39,-24.01,189.93 },
		["MOBILE05"] = { 47.36,-50.51,-24.01,51.03 },
		["MOBILE06"] = { 54.44,-45.08,-24.01,325.99 },
		["MOBILE07"] = { 52.37,-45.44,-24.01,141.74 },
		["LOCKER"] = { 53.75,-52.0,-24.01,51.03 }
	},
	["creativeOneFloors"] = {
		["MOBILE01"] = { 83.99,83.45,-24.01,274.97 },
		["MOBILE02"] = { 71.57,84.59,-24.2,2.84 },
		["MOBILE03"] = { 67.15,81.68,-24.2,93.55 },
		["MOBILE04"] = { 90.61,70.77,-24.01,181.42 },
		["MOBILE05"] = { 88.25,70.03,-24.01,175.75 },
		["MOBILE06"] = { 86.67,72.26,-24.01,90.71 },
		["MOBILE07"] = { 62.58,74.22,-24.6,184.26 },
		["MOBILE08"] = { 63.75,77.62,-24.57,272.13 },
		["MOBILE09"] = { 61.17,70.45,-24.6,274.97 },
		["MOBILE10"] = { 59.07,70.17,-24.6,90.71 },
		["MOBILE11"] = { 55.4,73.88,-24.6,181.42 },
		["LOCKER"] = { 91.43,74.91,-24.01,85.04 }
	},
	["creativeThreeFloors"] = {
		["MOBILE01"] = { 125.56,-109.76,-23.59,2.84 },
		["MOBILE02"] = { 125.79,-112.12,-23.59,201.26 },
		["MOBILE03"] = { 120.41,-119.23,-23.81,99.22 },
		["MOBILE04"] = { 120.73,-123.52,-23.99,99.22 },
		["MOBILE05"] = { 128.96,-124.18,-24.01,280.63 },
		["MOBILE06"] = { 120.9,-124.41,-27.4,90.71 },
		["MOBILE07"] = { 124.45,-118.37,-27.4,8.51 },
		["MOBILE08"] = { 126.99,-110.82,-27.38,5.67 },
		["MOBILE09"] = { 120.06,-105.46,-31.21,5.67 },
		["MOBILE10"] = { 117.99,-110.33,-31.21,187.09 },
		["MOBILE11"] = { 116.87,-116.05,-31.21,96.38 },
		["MOBILE12"] = { 115.94,-113.74,-31.21,96.38 },
		["MOBILE13"] = { 117.97,-111.98,-31.21,5.67 },
		["LOCKER"] = { 120.06,-122.07,-27.4,280.63 }
	},
	["creativeTwoFloors"] = {
		["MOBILE01"] = { 161.82,-153.82,-17.79,124.73 },
		["MOBILE02"] = { 159.91,-152.22,-17.79,121.89 },
		["MOBILE03"] = { 160.73,-149.65,-17.79,34.02 },
		["MOBILE04"] = { 149.39,-146.54,-19.19,306.15 },
		["MOBILE05"] = { 146.26,-152.24,-19.19,121.89 },
		["MOBILE06"] = { 139.23,-152.49,-19.19,34.02 },
		["MOBILE07"] = { 148.33,-165.83,-19.19,218.27 },
		["MOBILE08"] = { 154.11,-156.47,-19.19,39.69 },
		["MOBILE09"] = { 158.96,-154.89,-19.19,308.98 },
		["MOBILE10"] = { 148.58,-153.96,-24.01,218.27 },
		["MOBILE11"] = { 144.3,-151.02,-24.01,124.73 },
		["MOBILE12"] = { 156.26,-151.34,-24.01,31.19 },
		["MOBILE13"] = { 150.97,-158.78,-24.01,212.6 },
		["MOBILE14"] = { 149.4,-156.3,-24.01,39.69 },
		["LOCKER"] = { 165.66,-151.71,-17.79,45.36 }
	},
	["creativeSquare"] = {
		["MOBILE01"] = { 94.66,-99.23,-24.2,320.32 },
		["MOBILE02"] = { 103.77,-97.16,-24.2,317.49 },
		["MOBILE03"] = { 99.53,-103.18,-24.2,130.4 },
		["MOBILE04"] = { 96.24,-95.47,-24.2,45.36 },
		["MOBILE05"] = { 97.06,-94.19,-24.2,42.52 },
		["MOBILE06"] = { 98.38,-93.2,-24.2,45.36 },
		["MOBILE07"] = { 102.51,-99.54,-24.2,127.56 },
		["MOBILE08"] = { 92.6,-104.65,-24.2,45.36 },
		["MOBILE09"] = { 92.51,-105.44,-24.2,130.4 },
		["MOBILE10"] = { 97.01,-108.4,-24.2,229.61 },
		["MOBILE11"] = { 97.32,-106.37,-24.2,323.15 },
		["MOBILE12"] = { 99.17,-105.46,-24.2,323.15 },
		["LOCKER"] = { 93.0,-103.34,-24.2,221.11 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateHomes(homesTable)
	local innerTable = {}

	for k,v in pairs(homesTable) do
		local gridZone = getGridzone(v[1],v[2])

		if homes["list"][gridZone] == nil then
			homes["list"][gridZone] = {}
		end

		homes["list"][gridZone][k] = v

		table.insert(innerTable,{ v[1],v[2],v[3],1.25,"E","Propriedade","Pressione para acessar" })
	end

	TriggerEvent("hoverfy:Insert",innerTable)
	
	FreezeEntityPosition(ped,true)
	Wait(1000)
	FreezeEntityPosition(ped,false)
	ClearPedTasks(ped)
	DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	SendNUIMessage({ action = "hideMenu" })
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	if MumbleIsConnected() then
		vSERVER.takeItem(data["slot"],data["amount"],data["target"],homes["open"],homes["vault"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	if MumbleIsConnected() then
		vSERVER.storeItem(data["item"],data["slot"],data["amount"],data["target"],homes["open"],homes["vault"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateChest",function(data)
	if MumbleIsConnected() then
		vSERVER.updateChest(data["slot"],data["target"],data["amount"],homes["open"],homes["vault"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(data,cb)
	local myInventory,myChest,invPeso,invMaxpeso,chestPeso,chestMaxpeso = vSERVER.openChest(homes["open"],homes["vault"])
	if myInventory then
		cb({ myInventory = myInventory, myChest = myChest, invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Update")
AddEventHandler("homes:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:UPDATEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:UpdateWeight")
AddEventHandler("homes:UpdateWeight",function(invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ action = "updateWeight", invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRANCEHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.entranceHomes(homeName,v,interior,theft)
	DoScreenFadeOut(0)

	homes["current"] = v
	homes["open"] = homeName
	LocalPlayer["state"]["homeName"] = homeName
	LocalPlayer["state"]["Propertys"] = true
	TriggerEvent("sounds:source","enterhouse",0.7)

	local ped = PlayerPedId()

	if interior == "creativeSquare" then
		SetEntityCoords(ped,86.41,-91.47,-24.2,1,0,0,0)
		table.insert(homes["intern"],{ 86.41,-91.47,-24.2,"exit","Saída" })

		if not theft then
			table.insert(homes["intern"],{ 92.51,-105.44,-24.2,"vault","Baú" })
			table.insert(homes["intern"],{ 96.98,-108.39,-24.2,"wardrobe","Armário" })
			table.insert(homes["intern"],{ 96.49,-98.25,-24.2,"fridge","Geladeira" })
		end
	elseif interior == "creativeOneFloors" then
		SetEntityCoords(ped,68.64,67.3,-23.4,1,0,0,0)
		table.insert(homes["intern"],{ 68.64,67.3,-23.4,"exit","Saída" })

		if not theft then
			table.insert(homes["intern"],{ 86.73,72.08,-24.01,"vault","Baú" })
			table.insert(homes["intern"],{ 60.02,69.87,-24.6,"wardrobe","Armário" })
			table.insert(homes["intern"],{ 82.78,78.77,-24.01,"fridge","Geladeira" })
		end
	elseif interior == "creativeLostudios" then
		SetEntityCoords(ped,51.61,-39.05,-25.86,1,0,0,0)
		table.insert(homes["intern"],{ 51.61,-39.05,-25.86,"exit","Saída" })

		if not theft then
			table.insert(homes["intern"],{ 46.91,-44.83,-24.01,"vault","Baú" })
			table.insert(homes["intern"],{ 54.49,-45.03,-24.01,"wardrobe","Armário" })
			table.insert(homes["intern"],{ 45.92,-46.41,-24.01,"fridge","Geladeira" })
		end
	elseif interior == "creativeThreeFloors" then
		SetEntityCoords(ped,118.4,-108.39,-23.57,1,0,0,0)
		table.insert(homes["intern"],{ 118.4,-108.39,-23.57,"exit","Saída" })

		if not theft then
			table.insert(homes["intern"],{ 117.84,-111.99,-31.21,"vault","Baú" })
			table.insert(homes["intern"],{ 122.27,-110.1,-23.59,"fridge","Geladeira" })
			table.insert(homes["intern"],{ 124.41,-118.58,-27.4,"wardrobe","Armário" })
		end
	elseif interior == "creativeTwoFloors" then
		SetEntityCoords(ped,166.78,-144.32,-17.79,1,0,0,0)
		table.insert(homes["intern"],{ 166.78,-144.32,-17.79,"exit","Saída" })

		if not theft then
			table.insert(homes["intern"],{ 160.71,-149.67,-17.79,"vault","Baú" })
			table.insert(homes["intern"],{ 150.3,-157.6,-23.99,"wardrobe","Armário" })
			table.insert(homes["intern"],{ 160.05,-156.6,-19.19,"fridge","Geladeira" })
		end
	elseif interior == "creativeFranklin" then
		SetEntityCoords(ped,28.58,-24.35,-24.01,1,0,0,0)
		table.insert(homes["intern"],{ 28.58,-24.35,-24.01,"exit","Saída" })

		if not theft then
			table.insert(homes["intern"],{ 30.88,-25.88,-24.01,"vault","Baú" })
			table.insert(homes["intern"],{ 31.03,-28.21,-24.01,"wardrobe","Armário" })
			table.insert(homes["intern"],{ 18.89,-29.72,-24.01,"fridge","Geladeira" })
		end
	end

	FreezeEntityPosition(ped,true)
	Wait(1000)
	FreezeEntityPosition(ped,false)
	DoScreenFadeIn(1000)

	if theft then
		homes["theft"] = interior
		LocalPlayer["state"]["Theft"] = true
		homes["police"] = GetGameTimer() + 15000

		if math.random(100) >= 95 then
			homes["police"] = GetGameTimer() + 15000
			homes["called"] = true
			vSERVER.callPolice()
		end

		if math.random(100) >= 90 then
			if DoesEntityExist(homes["locker"]) then
				DeleteEntity(homes["locker"])
				homes["locker"] = nil
			end

			local mHash = GetHashKey("prop_ld_int_safe_01")

			RequestModel(mHash)
			while not HasModelLoaded(mHash) do
				Wait(1)
			end

			if HasModelLoaded(mHash) then
				homes["locker"] = CreateObjectNoOffset(mHash,v[1] + lockerCoords[interior][1],v[2] + lockerCoords[interior][2],lockerCoords[interior][3],false,false,false)

				SetEntityHeading(homes["locker"],lockerCoords[interior][4])
				FreezeEntityPosition(homes["locker"],true)
			end
		else
			homes["theftCoords"]["LOCKER"] = true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local innerTable = {}
		local timeDistance = 999
		if homes["theft"] ~= "" and homes["open"] ~= "" then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local speed = GetEntitySpeed(ped)
				local coords = GetEntityCoords(ped)

				if speed > 2 and GetGameTimer() >= homes["police"] and not homes["called"] then
					homes["police"] = GetGameTimer() + 15000
					vSERVER.callPolice()
				end

				if theftCoords[homes["theft"]] then
					for k,v in pairs(theftCoords[homes["theft"]]) do
						if not homes["theftCoords"][k] then
							local distance = #(coords - vector3(v[1],v[2],v[3]))

							if distance <= 1.25 then
								timeDistance = 1
								table.insert(innerTable,{ v[1],v[2],v[3],1.25,"E","Vasculhar","Pressione para vasculhar" })

								if IsControlJustPressed(1,38) and MumbleIsConnected() then
									if k == "LOCKER" then
										local safeCracking = exports["safecrack"]:safeCraking(3)
										if safeCracking then
											vSERVER.paymentTheft("LOCKER")
										end

										homes["theftCoords"][k] = true
									else
										LocalPlayer["state"]["Cancel"] = true
										vRP.playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

										local taskBar = exports["taskbar"]:taskThree()
										if taskBar then
											LocalPlayer["state"]["Commands"] = true
											vRP.playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

											TriggerEvent("Progress",10000)
											Citizen.Wait(10000)

											LocalPlayer["state"]["Commands"] = false
											vSERVER.paymentTheft("MOBILE")
											homes["theftCoords"][k] = true
										end

										LocalPlayer["state"]["Cancel"] = false
										vRP.removeObjects()
									end
								end
							end
						end
					end
				end
			end
		end

		TriggerEvent("hoverfy:Insert",innerTable)

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTERN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local innerTable = {}
		local timeDistance = 999
		if homes["open"] ~= "" then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)

				for k,v in pairs(homes["intern"]) do
					if coords[3] <= -1450 and v[4] == "exit" then
						SetEntityCoords(ped,v[1],v[2],v[3],1,0,0,0)
					end

					local distance = #(coords - vec3(v[1],v[2],v[3]))
					if distance <= 1.25 then
						timeDistance = 1.25
						table.insert(innerTable,{ v[1],v[2],v[3],1.25,"E",v[5],"Pressione para acessar" })

						if IsControlJustPressed(1,38) and MumbleIsConnected() then
							if v[4] == "exit" then
								if distance <= 1 then
									DoScreenFadeOut(0)

									SetEntityCoords(ped,homes["current"][1],homes["current"][2],homes["current"][3] - 0.75,1,0,0,0)

									TriggerEvent("sounds:source","outhouse",0.5)
									vSERVER.removeNetwork(homes["open"])
									LocalPlayer["state"]["Propertys"] = false
									LocalPlayer["state"]["Theft"] = false
									LocalPlayer["state"]["homeName"] = 0
									homes["theftCoords"] = {}
									homes["called"] = false
									homes["intern"] = {}
									homes["theft"] = ""
									homes["open"] = ""

									if DoesEntityExist(homes["locker"]) then
										DeleteEntity(homes["locker"])
										homes["locker"] = nil
									end

									FreezeEntityPosition(ped,true)
									Wait(1000)
									FreezeEntityPosition(ped,false)
									DoScreenFadeIn(1000)
								end
							elseif v[4] == "vault" or v[4] == "fridge" then
								table.insert(innerTable,{ v[1],v[2],v[3],1.25,"E",v[5],"Pressione para acessar" })

								if vSERVER.checkPermissions(homes["open"]) then
									TriggerEvent("sounds:source","chest",0.7)
									SendNUIMessage({ action = "showMenu" })
									SetNuiFocus(true,true)
									homes["vault"] = v[4]
								end
							elseif v[4] == "wardrobe" then
								table.insert(innerTable,{ v[1],v[2],v[3],1.25,"E",v[5],"Pressione para acessar" })

								exports["dynamic"]:AddButton("Shopping","Abrir a loja de vestimentas.","propertys:openShop","",false,true)
								exports["dynamic"]:openMenu()
							end
						end
					end
				end
			end
		end

		TriggerEvent("hoverfy:Insert",innerTable)

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:INVADEPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:invadePolice")
AddEventHandler("homes:invadePolice",function()
	LocalPlayer["state"]["Theft"] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:TOGGLEPROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:togglePropertys")
AddEventHandler("homes:togglePropertys",function()
	if homes["blips"] then
		homes["blips"] = false
		TriggerEvent("Notify","amarelo","<b>Propriedades</b> desmarcadas.",3000)

		for k,v in pairs(homes["blipsCoords"]) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
	else
		homes["blips"] = true
		local result = vSERVER.homeBlips()

		for k,v in pairs(result) do
			homes["blipsCoords"][k] = AddBlipForRadius(v["x"],v["y"],v["z"],10.0)
			SetBlipAlpha(homes["blipsCoords"][k],200)
			SetBlipColour(homes["blipsCoords"][k],v["color"])
		end

		SetTimeout(30000,function()
			homes["blips"] = false
			TriggerEvent("Notify","amarelo","<b>Propriedades</b> desmarcadas.",3000)

			for k,v in pairs(homes["blipsCoords"]) do
				if DoesBlipExist(v) then
					RemoveBlip(v)
				end
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMEGARAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.homeGarage(homeName)
	homes["garage"] = 0
	local homeCoords = {}
	homeCoords[homeName] = {}
	homeCoords[homeName]["1"] = {}

	CreateThread(function()
		while true do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			if homes["garage"] >= 2 then
				TriggerServerEvent("garages:updateGarages",homeName,homeCoords[homeName])
				break
			end

			if IsControlJustPressed(1,38) then
				homes["garage"] = homes["garage"] + 1

				if homes["garage"] <= 1 then
					TriggerEvent("Notify","amarelo","Fique no <b>local olhando</b> pra onde deseja que o veículo apareça e pressione a tecla <b>E</b> novamente.",10000)
					homeCoords[homeName] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]) }
				else
					TriggerEvent("Notify","verde","Garagem adicionada.",10000)
					homeCoords[homeName]["1"] = { mathLegth(coords["x"]),mathLegth(coords["y"]),mathLegth(coords["z"]),mathLegth(heading) }
				end
			end

			Wait(1)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADENTER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if homes["open"] == "" then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)
				local gridZone = getGridzone(coords["x"],coords["y"])

				if homes["list"][gridZone] then
					for k,v in pairs(homes["list"][gridZone]) do
						local distance = #(coords - vec3(v[1],v[2],v[3]))

						if distance <= 1.25 then
							timeDistance = 1

							if IsControlJustPressed(1,38) and GetGameTimer() >= homes["pressButton"] and MumbleIsConnected() then
								if vSERVER.checkOwner(k) then
									homes["pressButton"] = GetGameTimer() + 3000
									exports["dynamic"]:AddButton("Entrar","Adentrar a propriedade.","homes:Enter",k,false,true)
									exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","homes:invokeSystem","trancar",false,true)
									exports["dynamic"]:AddButton("Garagem","Adicionar uma garagem.","homes:invokeSystem","garagem",false,true)
									exports["dynamic"]:AddButton("Hipoteca","Realizar pagamento da hipoteca.","homes:invokeSystem","tax",false,true)
									exports["dynamic"]:AddButton("Vender","Se desfazer da propriedade.","homes:invokeSystem","vender",false,true)
									
									exports["dynamic"]:openMenu()
								else
									homes["pressButton"] = GetGameTimer() + 3000
									-- [1]
									exports["dynamic"]:SubMenu("Emerald","Informações sobre o interior.","Emerald")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyEmerald",k,"Emerald",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$"..parseFormat(config.EmeraldPrice).."</yellow> dólares.","","","Emerald",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>"..parseFormat(config.EmeraldVault).."Kg</yellow> no baú e <yellow>"..parseFormat(config.EmeraldFridge).."Kg</yellow> na geladeira.","","","Emerald",false)
									-- [2]
									exports["dynamic"]:SubMenu("Diamond","Informações sobre o interior.","Diamond")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyDiamond",k,"Diamond",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$"..parseFormat(config.DiamondPrice).."</yellow> dólares.","","","Diamond",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>"..parseFormat(config.DiamondVault).."Kg</yellow> no baú e <yellow>"..parseFormat(config.DiamondFridge).."Kg</yellow> na geladeira.","","","Diamond",false)
									-- [3]
									exports["dynamic"]:SubMenu("Sapphire","Informações sobre o interior.","Sapphire")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buySapphire",k,"Sapphire",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$"..parseFormat(config.SapphirePrice).."</yellow> dólares.","","","Sapphire",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>"..parseFormat(config.SapphireVault).."Kg</yellow> no baú e <yellow>"..parseFormat(config.SapphireFridge).."Kg</yellow> na geladeira.","","","Sapphire",false)
									-- [4]
									exports["dynamic"]:SubMenu("Amber","Informações sobre o interior.","Amber")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyAmber",k,"Amber",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$"..parseFormat(config.AmberPrice).."</yellow> dólares.","","","Amber",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>"..parseFormat(config.AmberVault).."Kg</yellow> no baú e <yellow>"..parseFormat(config.AmberFridge).."Kg</yellow> na geladeira.","","","Amber",false)
									-- [5]
									exports["dynamic"]:SubMenu("Amethyst","Informações sobre o interior.","Amethyst")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyAmethyst",k,"Amethyst",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$"..parseFormat(config.AmethystPrice).."</yellow> dólares.","","","Amethyst",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>"..parseFormat(config.AmethystVault).."Kg</yellow> no baú e <yellow>"..parseFormat(config.AmethystFridge).."Kg</yellow> na geladeira.","","","Amethyst",false)
									-- [6]
									exports["dynamic"]:SubMenu("Ruby","Informações sobre o interior.","Ruby")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyRuby",k,"Ruby",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$"..parseFormat(config.RubyPrice).."</yellow> dólares.","","","Ruby",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>"..parseFormat(config.RubyVault).."Kg</yellow> no baú e <yellow>"..parseFormat(config.RubyFridge).."Kg</yellow> na geladeira.","","","Ruby",false)

									exports["dynamic"]:openMenu()
								end
							end
						end
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:PROPERTYPANEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:propertyPanel")
AddEventHandler("propertys:propertyPanel",function()
	homes["pressButton"] = GetGameTimer() + 3000

	exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","homes:doorStatus",LocalPlayer["state"]["homeName"],false,true)

	exports["dynamic"]:SubMenu("Diagrama","Informações sobre o uso.","Diagram")
	exports["dynamic"]:AddButton("Aumentar Armário","Adiciona mais <yellow>10Kg</yellow> no <yellow>Armário</yellow>.","homes:upgradeVault",LocalPlayer["state"]["homeName"],"Diagram",true)
	exports["dynamic"]:AddButton("Aumentar Geladeira","Adiciona mais <yellow>10Kg</yellow> na <yellow>Geladeira</yellow>.","homes:upgradeFridge",LocalPlayer["state"]["homeName"],"Diagram",true)

	exports["dynamic"]:SubMenu("Permissões","Gerenciar a propriedade.","Permissions")
	exports["dynamic"]:AddButton("Permissões","Checar permissões da propriedade.","homes:permissionsCheck",LocalPlayer["state"]["homeName"],"Permissions",true)
	exports["dynamic"]:AddButton("Adicionar","Adicionar morador nesta propriedade.","homes:permissionsAdd",LocalPlayer["state"]["homeName"],"Permissions",true)

	exports["dynamic"]:openMenu()
end)