-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local playerArena = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Enter")
AddEventHandler("arena:Enter",function(Number)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		SetPlayerRoutingBucket(source,Number)
		TriggerClientEvent("update:Route",source,Number)

		TriggerClientEvent("arena:Players",source,Number,1)

        local clearInventory = vRP.userInventory(user_id)
        playerArena[user_id] = clearInventory
        for k,v in pairs(clearInventory) do
            vRP.removeInventoryItem(user_id,v.item,v.amount)
        end
		
		vRP.downgradeStress(user_id,100)

        vRP.giveInventoryItem(user_id,"WEAPON_PISTOL_MK2",1)
        vRP.giveInventoryItem(user_id,"WEAPON_PISTOL_AMMO",150)
        vRP.giveInventoryItem(user_id,"WEAPON_KATANA",1)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Exit")
AddEventHandler("arena:Exit",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        RemoveWeaponFromPed(GetPlayerPed(source),GetHashKey("WEAPON_PISTOL_MK2"))

        vRP.removeInventoryItem(user_id,"WEAPON_PISTOL_MK2",vRP.getInventoryItemAmount(user_id,"WEAPON_PISTOL_MK2")[1])
        vRP.removeInventoryItem(user_id,"WEAPON_PISTOL_AMMO",vRP.getInventoryItemAmount(user_id,"WEAPON_PISTOL_AMMO")[1])
        vRP.removeInventoryItem(user_id,"WEAPON_KATANA",vRP.getInventoryItemAmount(user_id,"WEAPON_KATANA")[1])

        for k,v in pairs(playerArena[user_id]) do
            vRP.giveInventoryItem(user_id,v.item,v.amount)
        end

        playerArena[user_id] = {}

		TriggerClientEvent("update:Route",source,0)
		SetPlayerRoutingBucket(source,0)

        TriggerClientEvent("arena:Exit",source)
    end
end)