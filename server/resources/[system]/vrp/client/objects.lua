-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Objects = {}
local initObjects = {}
local ContainerBlip = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Table")
AddEventHandler("objects:Table",function(Table)
	Objects = Table

	for k,v in pairs(Objects) do
		if tonumber(k) <= 61 then
			local Blip = AddBlipForRadius(v["x"],v["y"],v["z"],7.5)
			SetBlipAlpha(Blip,150)
			SetBlipColour(Blip,15)
		end
	end

	if Objects["9999"] then
		if DoesBlipExist(ContainerBlip) then
			RemoveBlip(ContainerBlip)
			ContainerBlip = nil
		end

		ContainerBlip = AddBlipForCoord(Objects["9999"]["x"],Objects["9999"]["y"],Objects["9999"]["z"])
		SetBlipSprite(ContainerBlip,478)
		SetBlipDisplay(ContainerBlip,4)
		SetBlipAsShortRange(ContainerBlip,true)
		SetBlipColour(ContainerBlip,47)
		SetBlipScale(ContainerBlip,0.8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Container")
		EndTextCommandSetBlipName(ContainerBlip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Adicionar")
AddEventHandler("objects:Adicionar",function(Number,Table)
	Objects[Number] = Table

	if Number == "9999" then
		if DoesBlipExist(ContainerBlip) then
			RemoveBlip(ContainerBlip)
			ContainerBlip = nil
		end

		ContainerBlip = AddBlipForCoord(Objects[Number]["x"],Objects[Number]["y"],Objects[Number]["z"])
		SetBlipSprite(ContainerBlip,478)
		SetBlipDisplay(ContainerBlip,4)
		SetBlipAsShortRange(ContainerBlip,true)
		SetBlipColour(ContainerBlip,47)
		SetBlipScale(ContainerBlip,0.8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Container")
		EndTextCommandSetBlipName(ContainerBlip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function targetLabel(x,y,z,Number,item,mode)
	if mode == "1" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),1.0,{
			name = "Objects:"..Number,
			heading = 3374176
		},{
			shop = Number,
			distance = 1.5,
			options = {
				{
					event = "objects:Guardar",
					label = "Guardar",
					tunnel = "shop"
				},{
					event = "inventory:makeProducts",
					label = "Produzir",
					tunnel = "police",
					service = item
				}
			}
		})
	elseif mode == "2" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),0.75,{
			name = "Objects:"..Number,
			heading = 3374176
		},{
			shop = Number,
			distance = 2.5,
			options = {
				{
					event = "inventory:makeProducts",
					label = "Cozinhar Filé de Peixe",
					tunnel = "police",
					service = "fishfillet"
				},{
					event = "inventory:makeProducts",
					label = "Cozinhar Carne Animal",
					tunnel = "police",
					service = "animalmeat"
				},{
					event = "inventory:makeProducts",
					label = "Assar Marshmallow",
					tunnel = "police",
					service = "marshmallow"
				}
			}
		})
	elseif mode == "3" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),1.0,{
			name = "Objects:"..Number,
			heading = 3374176
		},{
			shop = Number,
			distance = 1.5,
			options = {
				{
					event = "objects:Guardar",
					label = "Guardar",
					tunnel = "shop"
				}
			}
		})
	elseif mode == "4" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),1.0,{
			name = "Objects:"..Number,
			heading = 3374176
		},{
			shop = Number,
			distance = 1.5,
			options = {
				{
					event = "objects:Guardar",
					label = "Guardar",
					tunnel = "shop"
				},{
					event = "vRP:Sentar",
					label = "Sentar",
					tunnel = "shop"
				}
			}
		})
	elseif mode == "5" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),1.0,{
			name = "Objects:"..Number,
			heading = 3374176
		},{
			shop = Number,
			distance = 1.5,
			options = {
				{
					event = "objects:Guardar",
					label = "Guardar",
					tunnel = "shop"
				},{
					event = "shops:medicBag",
					label = "Abrir",
					tunnel = "client"
				}
			}
		})
	elseif mode == "Containers" then
		exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),2.0,{
			name = "Objects:"..Number,
			heading = 3374176
		},{
			shop = Number,
			distance = 2.75,
			options = {
				{
					event = "crafting:Containers",
					label = "Abrir",
					tunnel = "client"
				}
			}
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(Objects) do
			local distance = #(coords - vec3(v["x"],v["y"],v["z"]))
			if distance <= v["distance"] then
				if initObjects[k] == nil then
					local mHash = GetHashKey(v["object"])

					RequestModel(mHash)
					while not HasModelLoaded(mHash) do
						Wait(1)
					end

					if HasModelLoaded(mHash) then
						targetLabel(v["x"],v["y"],v["z"],k,v["item"],v["mode"])

						initObjects[k] = CreateObjectNoOffset(mHash,v["x"],v["y"],v["z"],false,false,false)
						FreezeEntityPosition(initObjects[k],true)
						SetEntityHeading(initObjects[k],v["h"])
						SetEntityLodDist(initObjects[k],0xFFFF)
						SetModelAsNoLongerNeeded(mHash)
					end
				end
			else
				if initObjects[k] then
					exports["target"]:RemCircleZone("Objects:"..k)

					if DoesEntityExist(initObjects[k]) then
						DeleteEntity(initObjects[k])
						initObjects[k] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:GUARDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Guardar")
AddEventHandler("objects:Guardar",function(Number)
	TriggerServerEvent("objects:Guardar",Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Remover")
AddEventHandler("objects:Remover",function(Number)
	Objects[Number] = nil

	if initObjects[Number] then
		exports["target"]:RemCircleZone("Objects:"..Number)

		if DoesEntityExist(initObjects[Number]) then
			DeleteEntity(initObjects[Number])
			initObjects[Number] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(distance,coords)
	local rotation = GetGameplayCamRot()
	local adjustedRotation = vec3((math.pi / 180) * rotation["x"],(math.pi / 180) * rotation["y"],(math.pi / 180) * rotation["z"])
	local direction = vec3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.sin(adjustedRotation[1]))

	return vec3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.objectCoords(model)
	local ped = PlayerPedId()
	local objectProgress = true
	local aplicationObject = false
	local mHash = GetHashKey(model)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Wait(1)
	end

	local coords = GetEntityCoords(ped)
	local pedHeading = GetEntityHeading(ped)
	local newObject = CreateObjectNoOffset(mHash,coords["x"],coords["y"],coords["z"],false,false,false)
	SetEntityCollision(newObject,false,false)
	SetEntityHeading(newObject,pedHeading)
	SetEntityAlpha(newObject,100,false)
	SetModelAsNoLongerNeeded(mHash)

	while objectProgress do
		local ped = PlayerPedId()
		local cam = GetGameplayCamCoord()
		local handle = StartExpensiveSynchronousShapeTestLosProbe(cam,GetCoordsFromCam(10.0,cam),-1,ped,4)
		local _,_,coords = GetShapeTestResult(handle)

		if model == "prop_ld_binbag_01" then
			SetEntityCoords(newObject,coords["x"],coords["y"],coords["z"] + 0.9,false,false,false,false)
		else
			SetEntityCoords(newObject,coords["x"],coords["y"],coords["z"],false,false,false,false)
		end

		dwText("~g~F~w~  CANCELAR",4,0.015,0.86,0.38,255,255,255,255)
		dwText("~g~E~w~  COLOCAR OBJETO",4,0.015,0.89,0.38,255,255,255,255)
		dwText("~y~SCROLL UP~w~  GIRA ESQUERDA",4,0.015,0.92,0.38,255,255,255,255)
		dwText("~y~SCROLL DOWN~w~  GIRA DIREITA",4,0.015,0.95,0.38,255,255,255,255)

		if IsControlJustPressed(1,38) then
			aplicationObject = true
			objectProgress = false
		end

		if IsControlJustPressed(1,49) then
			objectProgress = false
		end

		if IsControlJustPressed(1,180) then
			local headObject = GetEntityHeading(newObject)
			SetEntityHeading(newObject,headObject + 0.5)
		end

		if IsControlJustPressed(1,181) then
			local headObject = GetEntityHeading(newObject)
			SetEntityHeading(newObject,headObject - 0.5)
		end

		Wait(1)
	end

	local coordsObject = GetEntityCoords(newObject)
	local headObject = GetEntityHeading(newObject)

	DeleteEntity(newObject)

	return aplicationObject,coordsObject,headObject
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:EXPLOSION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Explosion")
AddEventHandler("vRP:Explosion",function(Coords)
	AddExplosion(Coords,2,1.0,true,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAIRS
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[536071214] = 0.5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Sentar")
AddEventHandler("vRP:Sentar",function(Number)
	local ped = PlayerPedId()
	local model = GetEntityModel(initObjects[Number])
	local heading = GetEntityHeading(initObjects[Number])
	local objCoords = GetEntityCoords(initObjects[Number])

	SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[model],1,0,0,0)
	SetEntityHeading(ped,heading - 180.0)

	tvRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
end)