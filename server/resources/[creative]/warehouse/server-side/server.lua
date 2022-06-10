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
Tunnel.bindInterface("warehouse",cRP)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Warehouse(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consult = vRP.query("warehouses/getWarehouses",{ name = Number })
		if consult[1] == nil then
			local buyPrice = 350000

			if vRP.request(source,"Deseja comprar este <b>Armazém</b> por <b>$"..parseFormat(buyPrice).."</b>?") then
				local newWarehouses = vKEYBOARD.keyWord(source,"Crie uma senha:")
				if not newWarehouses then
					return
				end

				if vRP.paymentFull(user_id,buyPrice) then
					vRP.execute("warehouses/buyWarehouses",{ name = Number, weight = 350, password = newWarehouses[1], user_id = user_id })
					TriggerClientEvent("Notify",source,"verde","Armazém comprado.",5000)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		else
			local enterWarehouses = vKEYBOARD.keyWord(source,"Senha de acesso:")
			if not enterWarehouses then
				return
			end

			local consult = vRP.query("warehouses/checkpassWarehouses",{ name = Number, password = enterWarehouses[1] })
			if consult[1] then
				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Senha incorreta.",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:UPGRADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("warehouse:Upgrade")
AddEventHandler("warehouse:Upgrade",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultWarehouses = vRP.query("warehouses/getWarehouses",{ name = Number })
		if consultWarehouses[1] then

			local consultOwner = vRP.query("warehouses/getownerWarehouses",{ name = Number, user_id = user_id })
			if consultOwner[1] then
				local upgradePrice = 10000

				if vRP.request(source,"Aumentar <b>10Kg</b> por <b>$"..parseFormat(upgradePrice).."</b> dólares?","Comprar") then
					if vRP.paymentFull(user_id,upgradePrice) then
						vRP.execute("warehouses/upgradeWarehouses",{ name = Number })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("warehouse:Password")
AddEventHandler("warehouse:Password",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultWarehouses = vRP.query("warehouses/getWarehouses",{ name = Number })
		if consultWarehouses[1] then

			local consultOwner = vRP.query("warehouses/getownerWarehouses",{ name = Number, user_id = user_id })
			if consultOwner[1] then
				local newPassword = vKEYBOARD.keyWord(source,"Crie uma nova senha:")
				if not newPassword then
					return
				end

				vRP.execute("warehouses/updatepassWarehouses",{ name = Number, password = newPassword[1], user_id = user_id })
				TriggerClientEvent("Notify",source,"verde","Senha atualizada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENWAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openWarehouse(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myInventory = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = itemEconomy(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			myInventory[k] = v
		end

		local myWarehouse = {}
		local result = vRP.getSrvdata("stackWarehouses:"..Number)
		for k,v in pairs(result) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = itemEconomy(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			myWarehouse[k] = v
		end

		local consultWarehouses = vRP.query("warehouses/getWarehouses",{ name = Number })
		if consultWarehouses[1] then
			return myInventory,myWarehouse,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultWarehouses[1]["weight"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
local noStore = {
	["cheese"] = true,
	["foodburger"] = true,
	["foodjuice"] = true,
	["foodbox"] = true,
	["octopus"] = true,
	["shrimp"] = true,
	["carp"] = true,
	["codfish"] = true,
	["catfish"] = true,
	["goldenfish"] = true,
	["horsefish"] = true,
	["tilapia"] = true,
	["pacu"] = true,
	["pirarucu"] = true,
	["tambaqui"] = true,
	["milkbottle"] = true,
	["water"] = true,
	["coffee"] = true,
	["cola"] = true,
	["tacos"] = true,
	["fries"] = true,
	["soda"] = true,
	["orange"] = true,
	["apple"] = true,
	["strawberry"] = true,
	["coffee2"] = true,
	["grape"] = true,
	["tange"] = true,
	["banana"] = true,
	["passion"] = true,
	["tomato"] = true,
	["mushroom"] = true,
	["orangejuice"] = true,
	["tangejuice"] = true,
	["grapejuice"] = true,
	["strawberryjuice"] = true,
	["bananajuice"] = true,
	["passionjuice"] = true,
	["bread"] = true,
	["ketchup"] = true,
	["cannedsoup"] = true,
	["canofbeans"] = true,
	["meat"] = true,
	["fishfillet"] = true,
	["marshmallow"] = true,
	["cookedfishfillet"] = true,
	["cookedmeat"] = true,
	["hamburger"] = true,
	["hamburger2"] = true,
	["pizza"] = true,
	["pizza2"] = true,
	["hotdog"] = true,
	["donut"] = true,
	["chocolate"] = true,
	["sandwich"] = true,
	["absolut"] = true,
	["chandon"] = true,
	["dewars"] = true,
	["hennessy"] = true,
	["nigirizushi"] = true,
	["sushi"] = true,
	["cupcake"] = true,
	["milkshake"] = true,
	["cappuccino"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(item,slot,amount,target,Warehouse)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultWarehouses = vRP.query("warehouses/getWarehouses",{ name = Warehouse })
		if consultWarehouses[1] then
			if vRP.storeChest(user_id,"stackWarehouses:"..Warehouse,amount,consultWarehouses[1]["weight"],slot,target) then
				TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			else
				local result = vRP.getSrvdata("stackWarehouses:"..Warehouse)
				TriggerClientEvent("warehouse:Weight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultWarehouses[1]["weight"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(item,slot,amount,target,Warehouse)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultWarehouses = vRP.query("warehouses/getWarehouses",{ name = Warehouse })
		if consultWarehouses[1] then
			if vRP.tryChest(user_id,"stackWarehouses:"..Warehouse,amount,slot,target) then
				TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			else
				local result = vRP.getSrvdata("stackWarehouses:"..Warehouse)
				TriggerClientEvent("warehouse:Weight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultWarehouses[1]["weight"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount,Warehouse)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.updateChest(user_id,"stackWarehouses:"..Warehouse,slot,target,amount) then
			TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
		end
	end
end