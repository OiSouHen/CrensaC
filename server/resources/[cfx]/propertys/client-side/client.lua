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
	["vault"] = "",
	["garage"] = 0,
	["intern"] = {},
	["current"] = {},
	["called"] = false,
	["pressButton"] = GetGameTimer()
}
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
	Citizen.Wait(1000)
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
function cRP.entranceHomes(homeName,v,interior)
	DoScreenFadeOut(0)

	homes["current"] = v
	homes["open"] = homeName
	TriggerEvent("sounds:source","enterhouse",0.7)

	local ped = PlayerPedId()

	if interior == "creativeSquare" then
		SetEntityCoords(ped,86.41,-91.47,-24.2,1,0,0,0)
		
		table.insert(homes["intern"],{ 86.41,-91.47,-24.2,"exit","Saída" })
		table.insert(homes["intern"],{ 92.51,-105.44,-24.2,"vault","Baú" })
		table.insert(homes["intern"],{ 96.49,-98.25,-24.2,"fridge","Geladeira" })
	elseif interior == "creativeOneFloors" then
		SetEntityCoords(ped,68.64,67.3,-23.4,1,0,0,0)
		
		table.insert(homes["intern"],{ 68.64,67.3,-23.4,"exit","Saída" })
		table.insert(homes["intern"],{ 86.73,72.08,-24.01,"vault","Baú" })
		table.insert(homes["intern"],{ 82.78,78.77,-24.01,"fridge","Geladeira" })
		table.insert(homes["intern"],{ 60.02,69.87,-24.6,"wardrobe","Armário" })
	elseif interior == "creativeLostudios" then
		SetEntityCoords(ped,51.96,-38.46,-26.02,1,0,0,0)
		
		table.insert(homes["intern"],{ 51.96,-38.46,-26.02,"exit","Saída" })
		table.insert(homes["intern"],{ 54.55,-45.08,-24.01,"vault","Baú" })
		table.insert(homes["intern"],{ 45.92,-46.41,-24.01,"fridge","Geladeira" })
	elseif interior == "creativeThreeFloors" then
		SetEntityCoords(ped,118.28,-108.11,-23.59,1,0,0,0)
		
		table.insert(homes["intern"],{ 118.28,-108.11,-23.59,"exit","Saída" })
		table.insert(homes["intern"],{ 117.84,-111.99,-31.21,"vault","Baú" })
		table.insert(homes["intern"],{ 122.27,-110.1,-23.59,"fridge","Geladeira" })
		table.insert(homes["intern"],{ 124.41,-118.58,-27.4,"wardrobe","Armário" })
	elseif interior == "creativeTwoFloors" then
		SetEntityCoords(ped,166.78,-144.32,-17.79,1,0,0,0)
		
		table.insert(homes["intern"],{ 166.78,-144.32,-17.79,"exit","Saída" })
		table.insert(homes["intern"],{ 160.71,-149.67,-17.79,"vault","Baú" })
		table.insert(homes["intern"],{ 160.05,-156.6,-19.19,"fridge","Geladeira" })
	elseif interior == "creativeFranklin" then
		SetEntityCoords(ped,28.58,-24.35,-24.01,1,0,0,0)
		
		table.insert(homes["intern"],{ 28.58,-24.35,-24.01,"exit","Saída" })
		table.insert(homes["intern"],{ 30.93,-28.36,-24.01,"vault","Baú" })
		table.insert(homes["intern"],{ 18.89,-29.72,-24.01,"fridge","Geladeira" })
	end
	
	FreezeEntityPosition(ped,true)
	Citizen.Wait(1000)
	FreezeEntityPosition(ped,false)
	ClearPedTasks(ped)
	DoScreenFadeIn(1000)
end
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
									homes["called"] = false
									homes["intern"] = {}
									homes["open"] = ""

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
									exports["dynamic"]:AddButton("Permissões","Checar permissões da propriedade.","homes:invokeSystem","checar",false,true)
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
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$200.000</yellow> dólares.","","","Emerald",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>200Kg</yellow> no baú e <yellow>20Kg</yellow> na geladeira.","","","Emerald",false)
									-- [2]
									exports["dynamic"]:SubMenu("Diamond","Informações sobre o interior.","Diamond")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyDiamond",k,"Diamond",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$100.000</yellow> dólares.","","","Diamond",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>100Kg</yellow> no baú e <yellow>10Kg</yellow> na geladeira.","","","Diamond",false)
									-- [3]
									exports["dynamic"]:SubMenu("Sapphire","Informações sobre o interior.","Sapphire")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buySapphire",k,"Sapphire",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$350.000</yellow> dólares.","","","Sapphire",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>350Kg</yellow> no baú e <yellow>35Kg</yellow> na geladeira.","","","Sapphire",false)
									-- [4]
									exports["dynamic"]:SubMenu("Amber","Informações sobre o interior.","Amber")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyAmber",k,"Amber",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$650.000</yellow> dólares.","","","Amber",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>650Kg</yellow> no baú e <yellow>65Kg</yellow> na geladeira.","","","Amber",false)
									-- [5]
									exports["dynamic"]:SubMenu("Amethyst","Informações sobre o interior.","Amethyst")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyAmethyst",k,"Amethyst",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$500.000</yellow> dólares.","","","Amethyst",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>500Kg</yellow> no baú e <yellow>50Kg</yellow> na geladeira.","","","Amethyst",false)
									-- [6]
									exports["dynamic"]:SubMenu("Ruby","Informações sobre o interior.","Ruby")
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","homes:buyRuby",k,"Ruby",true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$200.000</yellow> dólares.","","","Ruby",false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>200Kg</yellow> no baú e <yellow>20Kg</yellow> na geladeira.","","","Ruby",false)

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