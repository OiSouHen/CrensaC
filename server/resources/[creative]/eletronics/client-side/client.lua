-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("eletronics")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTimers = 35
local inService = false
local currentTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local atmList = {
	{ 121.17,-3019.62,7.04,90.71,"Sul "},
	{ 797.69,-767.52,26.77,184.26,"Sul "},
	{ -1431.17,-447.73,35.91,31.19,"Sul "},
	{ 165.99,6634.8,31.69,133.23,"Norte "},
	{ -32.09,-1104.31,27.26,252.29,"Sul "},
	{ 228.18,338.4,105.56,158.75,"Sul" },
	{ 158.63,234.22,106.63,343.0,"Sul" },
	{ -57.67,-92.62,57.78,294.81,"Sul" },
	{ 356.97,173.54,103.07,340.16,"Sul" },
	{ -1415.94,-212.03,46.51,232.45,"Sul" },
	{ -1430.2,-211.08,46.51,113.39,"Sul" },
	{ -1282.54,-210.9,42.44,306.15,"Sul" },
	{ -1286.25,-213.44,42.44,124.73,"Sul" },
	{ -1289.32,-226.82,42.44,121.89,"Sul" },
	{ -1285.58,-224.28,42.44,306.15,"Sul" },
	{ -1109.8,-1690.82,4.36,124.73,"Sul" },
	{ 1686.84,4815.82,42.01,274.97,"Sul" },
	{ 1701.21,6426.57,32.76,65.2,"Norte" },
	{ 1822.66,3683.04,34.27,212.6,"Norte" },
	{ 1171.56,2702.58,38.16,0.0,"Norte" },
	{ 1172.5,2702.59,38.16,0.0,"Norte" },
	{ -1091.49,2708.66,18.96,42.52,"Norte" },
	{ -3144.38,1127.6,20.86,65.2,"Sul" },
	{ 527.36,-160.69,57.09,272.13,"Sul" },
	{ 285.45,143.39,104.17,158.75,"Sul" },
	{ -846.27,-341.28,38.67,113.39,"Sul" },
	{ -846.85,-340.2,38.67,113.39,"Sul" },
	{ -721.06,-415.56,34.98,269.3,"Sul" },
	{ -1410.34,-98.75,52.42,107.72,"Sul" },
	{ -1409.78,-100.49,52.39,107.72,"Sul" },
	{ -712.9,-818.92,23.72,0.0,"Sul" },
	{ -710.05,-818.9,23.72,0.0,"Sul" },
	{ -660.71,-854.07,24.48,178.59,"Sul" },
	{ -594.58,-1161.29,22.33,357.17,"Sul" },
	{ -596.09,-1161.28,22.33,0.0,"Sul" },
	{ -821.64,-1081.91,11.12,28.35,"Sul" },
	{ 155.93,6642.86,31.59,317.49,"Norte" },
	{ 174.14,6637.94,31.58,45.36,"Norte" },
	{ -283.01,6226.11,31.49,314.65,"Norte" },
	{ -95.55,6457.19,31.46,48.19,"Norte" },
	{ -97.3,6455.48,31.46,45.36,"Norte" },
	{ -132.93,6366.52,31.48,323.15,"Norte" },
	{ -386.74,6046.08,31.49,317.49,"Norte" },
	{ 24.47,-945.96,29.35,343.0,"Sul" },
	{ 5.24,-919.83,29.55,252.29,"Sul" },
	{ 295.77,-896.1,29.22,249.45,"Sul" },
	{ 296.47,-894.21,29.23,249.45,"Sul" },
	{ 1138.22,-468.93,66.73,73.71,"Sul" },
	{ 1166.97,-456.06,66.79,343.0,"Sul" },
	{ 1077.75,-776.54,58.23,175.75,"Sul" },
	{ 289.1,-1256.8,29.44,272.13,"Sul" },
	{ 288.81,-1282.37,29.64,274.97,"Sul" },
	{ -1571.05,-547.38,34.95,218.27,"Sul" },
	{ -1570.12,-546.72,34.95,218.27,"Sul" },
	{ -1305.4,-706.41,25.33,124.73,"Sul" },
	{ -2072.36,-317.28,13.31,263.63,"Sul" },
	{ -2295.48,358.13,174.6,116.23,"Sul" },
	{ -2294.7,356.46,174.6,113.39,"Sul" },
	{ -2293.92,354.8,174.6,116.23,"Sul" },
	{ 2558.75,351.01,108.61,85.04,"Sul" },
	{ 89.69,2.47,68.29,340.16,"Sul" },
	{ -866.69,-187.75,37.84,119.06,"Sul" },
	{ -867.62,-186.09,37.84,121.89,"Sul" },
	{ -618.22,-708.89,30.04,272.13,"Sul" },
	{ -618.23,-706.89,30.04,272.13,"Sul" },
	{ -614.58,-704.83,31.24,181.42,"Sul" },
	{ -611.93,-704.83,31.24,181.42,"Sul" },
	{ -537.82,-854.49,29.28,175.75,"Sul" },
	{ -526.62,-1222.98,18.45,153.08,"Sul" },
	{ -165.15,232.7,94.91,87.88,"Sul" },
	{ -165.17,234.78,94.91,90.71,"Sul" },
	{ -303.25,-829.74,32.42,351.5,"Sul" },
	{ -301.7,-830.01,32.42,351.5,"Sul" },
	{ -203.81,-861.37,30.26,25.52,"Sul" },
	{ 119.06,-883.72,31.12,68.04,"Sul" },
	{ 112.58,-819.4,31.34,161.58,"Sul" },
	{ 111.26,-775.25,31.44,343.0,"Sul" },
	{ 114.43,-776.38,31.41,340.16,"Sul" },
	{ -256.23,-715.99,33.53,70.87,"Sul" },
	{ -258.87,-723.38,33.48,70.87,"Sul" },
	{ -254.42,-692.49,33.6,161.58,"Sul" },
	{ -28.0,-724.52,44.23,343.0,"Sul" },
	{ -30.23,-723.69,44.23,343.0,"Sul" },
	{ -1315.75,-834.69,16.95,308.98,"Sul" },
	{ -1314.81,-835.96,16.95,308.98,"Sul" },
	{ -2956.86,487.64,15.47,178.59,"Sul" },
	{ -2956.89,487.63,15.47,184.26,"Sul" },
	{ -2958.98,487.73,15.47,178.59,"Sul" },
	{ -3043.97,594.56,7.73,198.43,"Sul" },
	{ -3241.17,997.6,12.55,39.69,"Sul" },
	{ -1205.78,-324.79,37.86,116.23,"Sul" },
	{ -1205.02,-326.3,37.84,116.23,"Sul" },
	{ 147.58,-1035.77,29.34,158.75,"Sul" },
	{ 146.0,-1035.17,29.34,155.91,"Sul" },
	{ 33.18,-1348.24,29.49,178.59,"Sul" },
	{ 2558.51,389.48,108.61,266.46,"Sul" },
	{ 1153.65,-326.78,69.2,96.38,"Sul" },
	{ -717.71,-915.66,19.21,90.71,"Sul" },
	{ -56.98,-1752.1,29.42,48.19,"Sul" },
	{ 380.75,323.39,103.56,164.41,"Sul" },
	{ -3240.58,1008.59,12.82,266.46,"Sul" },
	{ 1735.24,6410.52,35.03,150.24,"Norte" },
	{ 540.31,2671.14,42.16,5.67,"Norte" },
	{ 1968.07,3743.57,32.33,212.6,"Norte" },
	{ 2683.1,3286.55,55.23,240.95,"Norte" },
	{ 1703.0,4933.6,42.06,323.15,"Norte" },
	{ -1827.3,784.88,138.3,133.23,"Sul" },
	{ -3040.72,593.11,7.9,289.14,"Sul" },
	{ 238.32,215.99,106.29,294.81,"Sul" },
	{ 237.9,216.89,106.29,294.81,"Sul" },
	{ 237.47,217.81,106.29,294.81,"Sul" },
	{ 237.04,218.72,106.29,297.64,"Sul" },
	{ 236.62,219.64,106.29,300.48,"Sul" },
	{ 126.82,-1296.6,29.27,28.35,"Sul" },
	{ 127.81,-1296.03,29.27,28.35,"Sul" },
	{ -248.08,6327.53,32.42,317.49,"Norte" },
	{ 315.09,-593.68,43.29,70.87,"Sul" },
	{ 1836.24,3681.04,34.27,303.31,"Norte" },
	{ -677.36,5834.58,17.32,130.4,"Norte" },
	{ 472.3,-1001.57,30.68,90.71,"Sul" },
	{ 468.52,-990.55,26.27,266.46,"Sul" },
	{ 349.86,-594.51,28.8,161.58,"Sul" },
	{ -556.12,-205.21,38.22,116.23,"Sul" },
	{ 560.5,2742.61,42.87,93.55,"Norte" },
	{ 2564.5,2584.79,38.08,110.56,"Norte" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for k,v in pairs(atmList) do
		exports["target"]:AddCircleZone("Eletronics:"..k,vec3(v[1],v[2],v[3]),0.5,{
			name = "Eletronics:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.0,
			options = {
				{
					event = "bank:openSystem",
					label = "Abrir",
					tunnel = "client"
				},
				{
					event = "eletronics:openSystem",
					label = "Roubar",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ELETRONICS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("eletronics:openSystem",function(shopId)
	if vSERVER.checkSystems() then
		inTimers = 35
		inService = true
		TriggerEvent("Progress",36000)
		LocalPlayer["state"]["Cancel"] = true
		LocalPlayer["state"]["Commands"] = true
		SetEntityHeading(PlayerPedId(),atmList[shopId][4])
		vRP.playAnim(false,{"oddjobs@shop_robbery@rob_till","loop"},true)
		SetEntityCoords(PlayerPedId(),atmList[shopId][1],atmList[shopId][2],atmList[shopId][3] - 1,1,0,0,0)

		while inService do
			if inTimers > 0 and GetGameTimer() >= currentTimer then
				inTimers = inTimers - 1
				currentTimer = GetGameTimer() + 1000
				vSERVER.paymentSystems(atmList[shopId][5])

				if inTimers <= 0 then
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Cancel"] = false
					vRP.removeObjects()
					inService = false
					break
				end
			end

			Wait(1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999

		if inService then
			timeDistance = 1

			local ped = PlayerPedId()
			if IsControlJustPressed(1,167) or not IsEntityPlayingAnim(ped,"oddjobs@shop_robbery@rob_till","loop",3) then
				LocalPlayer["state"]["Commands"] = false
				LocalPlayer["state"]["Cancel"] = false
				TriggerEvent("Progress",1000)
				vRP.removeObjects()
				inService = false
			end
		end

		Wait(timeDistance)
	end
end)