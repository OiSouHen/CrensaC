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
Tunnel.bindInterface("spawn",cRP)
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = {}
local Locate = {}
local Camera = nil
local Destroy = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedCoords = {
	{ -858.19,-109.25,28.19,209.77,"random@shop_tattoo","_idle_a" },
	{ -857.28,-108.79,28.19,209.77,"anim@heists@heist_corona@single_team","single_team_loop_boss" },
	{ -859.02,-109.78,28.19,209.77,"jh_1_ig_3-2","cs_jewelass_dual-2" },
	{ -856.44,-108.26,28.19,209.77,"oddjobs@taxi@","idle_a" },
	{ -859.95,-110.17,28.19,209.77,"amb@world_human_bum_standing@twitchy@base","base" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OTHERLOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local otherLocates = {
	{ -2205.92,-370.48,13.29,"Great Ocean Highway" },
	{ -250.35,6209.71,31.49,"Duluoz Avenue" },
	{ 1694.37,4794.66,41.92,"Grapedseed Avenue" },
	{ 1858.94,3741.78,33.09,"Armadillo Avenue" },
	{ 328.0,2617.89,44.48,"Senora Road" },
	{ 308.33,-232.25,54.07,"Hawick Avenue" },
	{ 449.71,-659.27,28.48,"Integrity Way" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	DoScreenFadeOut(0)
	ShutdownLoadingScreen()

	Wait(1000)

	local ped = PlayerPedId()
	SetEntityCoords(ped,-856.45,-112.15,28.19,false,false,false,false)
	LocalPlayer["state"]["Invisible"] = true
	SetEntityVisible(ped,false,false)
	FreezeEntityPosition(ped,true)
	SetEntityInvincible(ped,true)
	SetEntityHealth(ped,100)

	Wait(1000)

	local Characters = vSERVER.getCharacters()
	if parseInt(#Characters) > 0 then
		for k,v in pairs(Characters) do
			RequestModel(v["skin"])
			while not HasModelLoaded(v["skin"]) do
				Wait(1)
			end

			if HasModelLoaded(v["skin"]) then
				Peds[k] = CreatePed(4,v["skin"],pedCoords[k][1],pedCoords[k][2],pedCoords[k][3] - 1,pedCoords[k][4],false,false)
				SetEntityInvincible(Peds[k],true)
				FreezeEntityPosition(Peds[k],true)
				SetBlockingOfNonTemporaryEvents(Peds[k],true)
				SetModelAsNoLongerNeeded(v["skin"])

				RequestAnimDict(pedCoords[k][5])
				while not HasAnimDictLoaded(pedCoords[k][5]) do
					Wait(1)
				end

				TaskPlayAnim(Peds[k],pedCoords[k][5],pedCoords[k][6],8.0,8.0,-1,49,0,0,0,0)

				Clothes(Peds[k],v["clothes"])
				Barber(Peds[k],v["barber"])

				for k,v in pairs(v["tattoos"]) do
					SetPedDecoration(Peds[k],GetHashKey(v[1]),GetHashKey(k))
				end
			end
		end
	end

	Wait(1000)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamActive(Camera,true)
	RenderScriptCams(true,true,1,true,true)
	SetCamCoord(Camera,-856.45,-112.15,28.19)
	SetCamRot(Camera,0.0,0.0,30.0,2)

	SendNUIMessage({ action = "openSystem", infos = Characters })
	SetNuiFocus(true,true)

	DoScreenFadeIn(1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("generateDisplay",function(data,cb)
	cb({ result = vSERVER.initSystem() })
	
	DoScreenFadeIn(1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("characterChosen",function(data)
	for k,v in pairs(Peds) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end

	vSERVER.characterChosen(data["id"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("newCharacter",function(data)
	vSERVER.newCharacter(data["name"],data["name2"],data["sex"],data["loc"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("generateSpawn",function(data,cb)
	cb({ result = Locate })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JUSTSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:justSpawn")
AddEventHandler("spawn:justSpawn",function(Spawned)
	DoScreenFadeOut(0)

	local Ped = PlayerPedId()
	RenderScriptCams(false,false,0,true,true)
	SetCamActive(Camera,false)
	DestroyCam(Camera,true)
	Camera = nil

	if Spawned then
		LocalPlayer["state"]["Invisible"] = true
		SetEntityVisible(Ped,false,false)

		Locate = {}
		local Number = 0
		for k,v in pairs(otherLocates) do
			Number = Number + 1
			Locate[Number] = { x = v[1], y = v[2], z = v[3], name = v[4], hash = Number }
		end

		Wait(2000)

		local Coords = GetEntityCoords(Ped)
		Camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",Coords["x"],Coords["y"],Coords["z"] + 200.0,270.00,0.0,0.0,80.0,0,0)
		SetCamActive(Camera,true)
		RenderScriptCams(true,false,1,true,true)

		SendNUIMessage({ action = "openSpawn" })

		DoScreenFadeIn(1000)
	else
		LocalPlayer["state"]["Invisible"] = false
		SetEntityVisible(Ped,true,false)
		TriggerEvent("hud:Active",true)
		SetNuiFocus(false,false)
		Destroy = false

		Wait(1000)

		DoScreenFadeIn(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSENEW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.closeNew()
	SendNUIMessage({ action = "closeNew" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("spawnChosen",function(data)
	local ped = PlayerPedId()

	if data["hash"] == "spawn" then
		DoScreenFadeOut(0)

		SendNUIMessage({ action = "closeSpawn" })
		TriggerEvent("hud:Active",true)
		SetNuiFocus(false,false)

		LocalPlayer["state"]["Invisible"] = false
		RenderScriptCams(false,false,0,true,true)
		SetCamActive(Camera,false)
		DestroyCam(Camera,true)
		SetEntityVisible(ped,true,false)
		Camera = nil
		Destroy = false

		Wait(1000)

		DoScreenFadeIn(1000)
	else
		Destroy = false
		DoScreenFadeOut(0)

		Wait(1000)

		SetCamRot(Camera,270.0)
		SetCamActive(Camera,true)
		Destroy = true
		local speed = 0.7
		weight = 270.0

		DoScreenFadeIn(1000)

		SetEntityCoords(ped,Locate[data["hash"]]["x"],Locate[data["hash"]]["y"],Locate[data["hash"]]["z"],false,false,false,false)
		local coords = GetEntityCoords(ped)

		SetCamCoord(Camera,coords["x"],coords["y"],coords["z"] + 200.0)
		local i = coords["z"] + 200.0

		while i > Locate[data["hash"]]["z"] + 1.5 do
			i = i - speed
			SetCamCoord(Camera,coords["x"],coords["y"],i)

			if i <= Locate[data["hash"]]["z"] + 35.0 and weight < 360.0 then
				if speed - 0.0078 >= 0.05 then
					speed = speed - 0.0078
				end

				weight = weight + 0.75
				SetCamRot(Camera,weight)
			end

			if not Destroy then
				break
			end

			Wait(0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Clothes(ped,data)
    if data["backpack"] == nil then
        data["backpack"] = {}
        data["backpack"]["item"] = 0
        data["backpack"]["texture"] = 0
    end
	
    if data["pants"] == nil then
        data["pants"] = {}
        data["pants"]["item"] = 0
        data["pants"]["texture"] = 0
    end
	
    if data["arms"] == nil then
        data["arms"] = {}
        data["arms"]["arms"] = 0
        data["arms"]["arms"] = 0
    end
	
    if data["tshirt"] == nil then
        data["tshirt"] = {}
        data["tshirt"]["item"] = 0
        data["tshirt"]["texture"] = 0
    end
	
    if data["vest"] == nil then
        data["vest"] = {}
        data["vest"]["item"] = 0
        data["vest"]["texture"] = 0
    end
	
    if data["torso"] == nil then
        data["torso"] = {}
        data["torso"]["item"] = 0
        data["torso"]["texture"] = 0
    end
	
    if data["shoes"] == nil then
        data["shoes"] = {}
        data["shoes"]["item"] = 0
        data["shoes"]["texture"] = 0
    end
	
    if data["torso"] == nil then
        data["torso"] = {}
        data["torso"]["item"] = 0
        data["torso"]["texture"] = 0
    end
	
    if data["mask"] == nil then
        data["mask"] = {}
        data["mask"]["item"] = 0
        data["mask"]["texture"] = 0
    end
	
    if data["decals"] == nil then
        data["decals"] = {}
        data["decals"]["item"] = 0
        data["decals"]["texture"] = 0
    end
	
    if data["accessory"] == nil then
        data["accessory"] = {}
        data["accessory"]["item"] = 0
        data["accessory"]["texture"] = 0
    end
	
    if data["accessory"] == nil then
        data["accessory"] = {}
        data["accessory"]["item"] = 0
        data["accessory"]["texture"] = 0
    end
	
    if data["hat"] == nil then
        data["hat"] = {}
        data["hat"]["item"] = 0
        data["hat"]["texture"] = 0
    end
	
    if data["glass"] == nil then
        data["glass"] = {}
        data["glass"]["item"] = 0
        data["glass"]["texture"] = 0
    end
	
    if data["ear"] == nil then
        data["ear"] = {}
        data["ear"]["item"] = 0
        data["ear"]["texture"] = 0
    end
	
    if data["watch"] == nil then
        data["watch"] = {}
        data["watch"]["item"] = 0
        data["watch"]["texture"] = 0
    end
	
    if data["bracelet"] == nil then
        data["bracelet"] = {}
        data["bracelet"]["item"] = 0
        data["bracelet"]["texture"] = 0
    end

	SetPedComponentVariation(ped,4,data["pants"]["item"] or 0,data["pants"]["texture"] or 0,1)
	SetPedComponentVariation(ped,3,data["arms"]["item"] or 0,data["arms"]["texture"] or 0,1)
	SetPedComponentVariation(ped,5,data["backpack"]["item"] or 0,data["backpack"]["texture"] or 0,1)
	SetPedComponentVariation(ped,8,data["tshirt"]["item"] or 0,data["tshirt"]["texture"] or 0,1)
	SetPedComponentVariation(ped,9,data["vest"]["item"] or 0,data["vest"]["texture"] or 0,1)
	SetPedComponentVariation(ped,11,data["torso"]["item"] or 0,data["torso"]["texture"] or 0,1)
	SetPedComponentVariation(ped,6,data["shoes"]["item"] or 0,data["shoes"]["texture"] or 0,1)
	SetPedComponentVariation(ped,1,data["mask"]["item"] or 0,data["mask"]["texture"] or 0,1)
	SetPedComponentVariation(ped,10,data["decals"]["item"] or 0,data["decals"]["texture"] or 0,1)
	SetPedComponentVariation(ped,7,data["accessory"]["item"] or 0,data["accessory"]["texture"] or 0,1)

	if data["hat"]["item"] ~= -1 and data["hat"]["item"] ~= 0 then
		SetPedPropIndex(ped,0,data["hat"]["item"],data["hat"]["texture"],1)
	else
		ClearPedProp(ped,0)
	end

	if data["glass"]["item"] ~= -1 and data["glass"]["item"] ~= 0 then
		SetPedPropIndex(ped,1,data["glass"]["item"],data["glass"]["texture"],1)
	else
		ClearPedProp(ped,1)
	end

	if data["ear"]["item"] ~= -1 and data["ear"]["item"] ~= 0 then
		SetPedPropIndex(ped,2,data["ear"]["item"],data["ear"]["texture"],1)
	else
		ClearPedProp(ped,2)
	end

	if data["watch"]["item"] ~= -1 and data["watch"]["item"] ~= 0 then
		SetPedPropIndex(ped,6,data["watch"]["item"],data["watch"]["texture"],1)
	else
		ClearPedProp(ped,6)
	end

	if data["bracelet"]["item"] ~= -1 and data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(ped,7,data["bracelet"]["item"],data["bracelet"]["texture"],1)
	else
		ClearPedProp(ped,7)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
function Barber(ped,status)
	myClothes = {}
	myClothes = { status[1] or 0, status[2] or 0, status[3] or 0, status[4] or 0, status[5] or 0, status[6] or 0, status[7] or 0, status[8] or 0, status[9] or 0, status[10] or 0, status[11] or 0, status[12] or 0, status[13] or 0, status[14] or 0, status[15] or 0, status[16] or 0, status[17] or 0, status[18] or 0, status[19] or 0, status[20] or 0, status[21] or 0, status[22] or 0, status[23] or 0, status[24] or 0, status[25] or 0, status[26] or 0, status[27] or 0, status[28] or 0, status[29] or 0, status[30] or 0, status[31] or 0, status[32] or 0, status[33] or 0, status[34] or 0, status[35] or 0, status[36] or 0, status[37] or 0, status[38] or 0, status[39] or 0, status[40] or 0, status[41] or 0 }

    local weightFace = myClothes[2] / 100 + 0.0
    local weightSkin = myClothes[4] / 100 + 0.0

	SetPedHeadBlendData(ped,myClothes[41],myClothes[1],0,myClothes[41],myClothes[1],0,weightFace,weightSkin,0.0,false)

	SetPedEyeColor(ped,myClothes[3])

	if myClothes[5] == 0 then
		SetPedHeadOverlay(ped,0,myClothes[5],0.0)
	else
		SetPedHeadOverlay(ped,0,myClothes[5],1.0)
	end

	SetPedHeadOverlay(ped,6,myClothes[6],1.0)

	if myClothes[7] == 0 then
		SetPedHeadOverlay(ped,9,myClothes[7],0.0)
	else
		SetPedHeadOverlay(ped,9,myClothes[7],1.0)
	end

	SetPedHeadOverlay(ped,3,myClothes[8],1.0)

	SetPedComponentVariation(ped,2,myClothes[9],0,1)
	SetPedHairColor(ped,myClothes[10],myClothes[11])

	SetPedHeadOverlay(ped,4,myClothes[12],myClothes[13] * 0.1)
	SetPedHeadOverlayColor(ped,4,1,myClothes[14],myClothes[14])

	SetPedHeadOverlay(ped,8,myClothes[15],myClothes[16] * 0.1)
	SetPedHeadOverlayColor(ped,8,1,myClothes[17],myClothes[17])

	SetPedHeadOverlay(ped,2,myClothes[18],myClothes[19] * 0.1)
	SetPedHeadOverlayColor(ped,2,1,myClothes[20],myClothes[20])

	SetPedHeadOverlay(ped,1,myClothes[21],myClothes[22] * 0.1)
	SetPedHeadOverlayColor(ped,1,1,myClothes[23],myClothes[23])

	SetPedHeadOverlay(ped,5,myClothes[24],myClothes[25] * 0.1)
	SetPedHeadOverlayColor(ped,5,1,myClothes[26],myClothes[26])

	SetPedFaceFeature(ped,0,myClothes[27] * 0.1)
	SetPedFaceFeature(ped,1,myClothes[28] * 0.1)
	SetPedFaceFeature(ped,4,myClothes[29] * 0.1)
	SetPedFaceFeature(ped,6,myClothes[30] * 0.1)
	SetPedFaceFeature(ped,8,myClothes[31] * 0.1)
	SetPedFaceFeature(ped,9,myClothes[32] * 0.1)
	SetPedFaceFeature(ped,10,myClothes[33] * 0.1)
	SetPedFaceFeature(ped,12,myClothes[34] * 0.1)
	SetPedFaceFeature(ped,13,myClothes[35] * 0.1)
	SetPedFaceFeature(ped,14,myClothes[36] * 0.1)
	SetPedFaceFeature(ped,15,myClothes[37] * 0.1)
	SetPedFaceFeature(ped,16,myClothes[38] * 0.1)
	SetPedFaceFeature(ped,17,myClothes[39] * 0.1)
	SetPedFaceFeature(ped,19,myClothes[40] * 0.1)
end