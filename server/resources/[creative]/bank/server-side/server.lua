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
Tunnel.bindInterface("bank",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local bankTime = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestWanted()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if exports["hud"]:Wanted(user_id,source) then
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankDeposit(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and actived[user_id] == nil then
		actived[user_id] = true

		if bankTime[user_id] then
			if GetGameTimer() < bankTime[user_id] then
				local bankTimes = parseInt((bankTime[user_id] - GetGameTimer()) / 1000)
				TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..bankTimes.." segundos</b>.",5000)
				return
			end
		end

		if parseInt(amount) > 0 then
			if vRP.tryGetInventoryItem(user_id,"dollars",amount,true) then
				bankTime[user_id] = GetGameTimer() + 60000
				vRP.addBank(user_id,amount,"Private")
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end

		actived[user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankWithdraw(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and actived[user_id] == nil then
		actived[user_id] = true

		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			actived[user_id] = nil

			return false
		end

		if bankTime[user_id] then
			if GetGameTimer() < bankTime[user_id] then
				local bankTimes = parseInt((bankTime[user_id] - GetGameTimer()) / 1000)
				TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..bankTimes.." segundos</b>.",5000)
				return
			end
		end

		local value = parseInt(amount)
		if (vRP.inventoryWeight(user_id) + (itemWeight("dollars") * value)) <= vRP.getWeight(user_id) then
			bankTime[user_id] = GetGameTimer() + 60000

			if not vRP.withdrawCash(user_id,value) then
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end

		actived[user_id] = nil
	end
end