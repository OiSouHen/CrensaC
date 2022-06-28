local wasProximityDisabledFromOverride = false
disableProximityCycle = false

RegisterCommand("setvoiceintent",function(source, args)
	local intent = args[1]
	if intent == "speech" then
		MumbleSetAudioInputIntent(`speech`)
	elseif intent == "music" then
		MumbleSetAudioInputIntent(`music`)
	end
	LocalPlayer.state:set("voiceIntent",intent,true)
end)

RegisterCommand("volume",function(source,args)
	if not args[1] then
		return
	end

	setVolume(tonumber(args[1]))
	TriggerEvent("Notify","amarelo","<b>Volume:</b> "..args[1].."%",5000)
end)

exports("setAllowProximityCycleState",function(state)
	type_check({ state,"boolean" })
	disableProximityCycle = state
end)

function setProximityState(proximityRange,isCustom)
	local voiceModeData = Cfg.voiceModes[mode]
	MumbleSetTalkerProximity(proximityRange + 0.0)
	LocalPlayer.state:set("proximity",{
		index = mode,
		distance = proximityRange,
		mode = isCustom and "Custom" or voiceModeData[2]
	},true)

	sendUIMessage({ voiceMode = isCustom and #Cfg.voiceModes or mode - 1 })
end

exports("overrideProximityRange",function(range,disableCycle)
	type_check({ range,"number" })
	setProximityState(range,true)
	if disableCycle then
		disableProximityCycle = true
		wasProximityDisabledFromOverride = true
	end
end)

exports("clearProximityOverride",function()
	local voiceModeData = Cfg.voiceModes[mode]
	setProximityState(voiceModeData[1],false)
	if wasProximityDisabledFromOverride then
		disableProximityCycle = false
	end
end)

local LastMode = 2

RegisterCommand("cycleproximity",function(source,args,rawCommand)
	if playerMuted then return end

	local newMode = mode + 1
	if newMode <= 4 then
		mode = newMode
	else
		mode = 1
	end

	setProximityState(Cfg.voiceModes[mode][1],false)
	TriggerEvent("pma-voice:setTalkingMode",mode)
	TriggerEvent("hud:Voip",mode)
	LastMode = mode
end,false)

RegisterNetEvent("pma-voice:Megaphone")
AddEventHandler("pma-voice:Megaphone",function(Status)
	if Status then
		mode = 5
		setProximityState(Cfg.voiceModes[5][1],false)
		TriggerEvent("pma-voice:setTalkingMode",5)
		TriggerEvent("hud:Voip",5)
	else
		setProximityState(Cfg.voiceModes[LastMode][1],false)
		TriggerEvent("pma-voice:setTalkingMode",LastMode)
		TriggerEvent("hud:Voip",LastMode)
		MumbleSetSubmixForServerId(plySource,-1)
		mode = LastMode
	end
end)

RegisterKeyMapping("cycleproximity","Distância de voz.","keyboard","HOME")