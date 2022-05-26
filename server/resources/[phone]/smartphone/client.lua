_G.Summerz = true
IsNuiOpen = false

src = {
	close = function()
		IsNuiOpen = false
		SetNuiFocus(false)

		LocalPlayer["state"]["Phone"] = false
		LocalPlayer["state"]["Cancel"] = false
		LocalPlayer["state"]["Commands"] = false
	end,open = function()
		IsNuiOpen = true
		SetNuiFocus(true,true)
		SendNUIMessage({ event = "open", args = {} })

		LocalPlayer["state"]["Phone"] = true
		LocalPlayer["state"]["Cancel"] = true
		LocalPlayer["state"]["Commands"] = true
	end,eval = function(code)
		return load(code)()
	end
}

RegisterNUICallback("client",function(data,cb)
	local res = src[data.member](table.unpack(data.args))

	if res == nil then
		res = true
	end

	cb(res)
end)

RegisterNUICallback("backend",function(data,cb)
	requestToBackend(data.member,data.args,cb)
end)

local backend_promises = { id = 1 }
RegisterNetEvent("backend:res")
AddEventHandler("backend:res",function(rid,res)
	if backend_promises[rid] then
		backend_promises[rid](res)
		backend_promises[rid] = nil
	end
end)

function requestToBackend(member,args,cb)
	local id = backend_promises.id
	backend_promises.id = id + 1

	backend_promises[id] = cb
	TriggerServerEvent("backend:req",id,member,args or {})
end

function NoPhoneCallback()
end

exports("callPlayer",function(phone)
	TriggerNuiEvent("pusher","CALL_TO",phone)
end)

local inPhone = false
local inCall = false
RegisterNetEvent("hup:phoneObject")
AddEventHandler("hup:phoneObject",function()
	local Keyboard = exports["keyboard"]:keySingle("Número do Telefone:")
	if Keyboard then
		inPhone = true
		exports["smartphone"]:callPlayer("*"..Keyboard[1])
	end
end)

RegisterNetEvent("smartphone:callEnd",function()
	inCall = false
	inPhone = false
	SetNuiFocusKeepInput(false)
	FreezeEntityPosition(PlayerPedId(),false)
end)

RegisterNetEvent("smartphone:callStart",function()
	if inPhone then
		FreezeEntityPosition(PlayerPedId(),true)
	end
end)

RegisterNetEvent("smartphone:callReady",function()
	if inPhone then
		inCall = true

		while inCall do
			Wait(0)
			drawTxt("PRESSIONE  ~g~G~w~  PARA DESLIGAR A CHAMADA")

			if IsControlJustPressed(1,47) then
				TriggerServerEvent("smartphone:end_call")
				TriggerEvent("smartphone:callEnd")
			end

			if not inCall then
				break
			end
		end
	end
end)

function drawTxt(text)
	SetTextFont(4)
	SetTextScale(0.4,0.4)
	SetTextColour(255,255,255,175)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5,0.93)
end

RegisterNetEvent("smartphone:Close")
AddEventHandler("smartphone:Close",function()
	if IsNuiOpen then
		IsNuiOpen = false
		SetNuiFocus(false)
		LocalPlayer["state"]["Phone"] = false
		LocalPlayer["state"]["Cancel"] = false
		LocalPlayer["state"]["Commands"] = false
	end
end)

RegisterNetEvent("smartphone:callParamedic",function(text)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	requestToBackend("service_request",{ "Efetue um chamado aos paramédicos.",text,{ coords["x"],coords["y"],coords["z"] } },function(response) end)
end)

RegisterNetEvent("smartphone:callTaxi",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	requestToBackend("service_request",{ "Efetue um chamado aos taxistas.","Preciso de um taxi no aeroporto, acabei de chegar de viagem.",{ coords["x"],coords["y"],coords["z"] } },function(response) end)
	TriggerEvent("Notify","verde","Chamado efetuado.",5000)
end)