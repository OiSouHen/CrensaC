-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("register")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARS
-----------------------------------------------------------------------------------------------------------------------------------------
local registers = {
	{ 24.49,-1344.99,29.49,265.0,"Sul" },
	{ 24.50,-1347.34,29.49,267.0,"Sul" },
	{ 2554.90,380.94,108.62,349.0,"Sul" },
	{ 2557.23,380.83,108.62,354.0,"Sul" },
	{ 1165.07,-324.50,69.20,127.0,"Sul" },
	{ 1164.67,-322.76,69.20,94.0,"Sul" },
	{ -706.10,-915.43,19.21,116.0,"Sul" },
	{ -706.16,-913.65,19.21,85.0,"Sul" },
	{ -47.96,-1759.34,29.42,74.0,"Sul" },
	{ -46.80,-1757.94,29.42,45.0,"Sul" },
	{ 372.58,326.39,103.56,252.0,"Sul" },
	{ 373.10,328.64,103.56,255.0,"Sul" },
	{ -3242.24,1000.01,12.83,352.0,"Sul" },
	{ -3244.56,1000.20,12.83,354.0,"Sul" },
	{ 1727.88,6415.21,35.03,239.0,"Norte" },
	{ 1728.90,6417.25,35.03,240.0,"Norte" },
	{ 549.03,2671.36,42.15,93.0,"Norte" },
	{ 549.33,2669.04,42.15,93.0,"Norte" },
	{ 1958.96,3742.01,32.34,298.0,"Norte" },
	{ 1960.12,3740.01,32.34,295.0,"Norte" },
	{ 2678.07,3279.42,55.24,327.0,"Norte" },
	{ 2676.03,3280.56,55.24,327.0,"Norte" },
	{ 1696.57,4923.95,42.06,353.0,"Norte" },
	{ 1698.06,4922.96,42.06,323.0,"Norte" },
	{ -1818.89,792.94,138.08,161.0,"Sul" },
	{ -1820.12,794.16,138.08,129.0,"Sul" },
	{ 1392.87,3606.39,34.98,195.0,"Norte" },
	{ -2966.44,390.89,15.04,84.0,"Sul" },
	{ -3038.95,584.55,7.90,16.0,"Sul" },
	{ -3041.19,583.84,7.90,14.0,"Sul" },
	{ 1134.25,-982.47,46.41,273.0,"Sul" },
	{ 1165.93,2710.77,38.15,177.0,"Norte" },
	{ -1486.29,-378.02,40.16,132.0,"Sul" },
	{ -1221.99,-908.29,12.32,28.0,"Sul" },
	{ 73.97,-1392.13,29.37,267.0,"Sul" },
	{ 74.86,-1387.70,29.37,182.0,"Sul" },
	{ 78.02,-1387.69,29.37,177.0,"Sul" },
	{ 426.96,-806.99,29.49,91.0,"Sul" },
	{ 426.08,-811.44,29.49,358.0,"Sul" },
	{ 422.91,-811.44,29.49,358.0,"Sul" },
	{ -816.56,-1073.25,11.32,122.0,"Sul" },
	{ -818.14,-1070.52,11.32,122.0,"Sul" },
	{ -822.41,-1071.94,11.32,206.0,"Sul" },
	{ -1195.24,-768.03,17.31,215.0,"Sul" },
	{ -1193.86,-767.00,17.31,215.0,"Sul" },
	{ -1192.44,-765.93,17.31,215.0,"Sul" },
	{ 5.21,6510.88,31.87,41.0,"Norte" },
	{ 1.34,6508.52,31.87,309.0,"Norte" },
	{ -0.80,6510.80,31.87,309.0,"Norte" },
	{ 1695.38,4822.23,42.06,92.0,"Norte" },
	{ 1695.10,4817.71,42.06,4.0,"Norte" },
	{ 1691.98,4817.31,42.06,4.0,"Norte" },
	{ 127.50,-222.58,54.55,70.0,"Sul" },
	{ 126.93,-224.18,54.55,70.0,"Sul" },
	{ 126.30,-225.88,54.55,70.0,"Sul" },
	{ 613.14,2760.96,42.08,273.0,"Norte" },
	{ 612.99,2762.69,42.08,273.0,"Norte" },
	{ 612.85,2764.46,42.08,273.0,"Norte" },
	{ 1197.42,2711.63,38.22,175.0,"Norte" },
	{ 1201.88,2710.74,38.22,85.0,"Norte" },
	{ 1201.87,2707.60,38.22,85.0,"Norte" },
	{ -3168.76,1044.80,20.86,65.0,"Sul" },
	{ -3169.46,1043.22,20.86,65.0,"Sul" },
	{ -3170.17,1041.60,20.86,65.0,"Sul" },
	{ -1101.80,2712.10,19.10,216.0,"Norte" },
	{ -1097.90,2714.40,19.10,125.0,"Norte" },
	{ -1095.82,2712.08,19.10,125.0,"Norte" },
	{ -821.91,-183.32,37.56,213.0,"Sul" },
	{ 134.39,-1707.83,29.29,136.0,"Sul" },
	{ -1284.26,-1115.05,6.99,89.0,"Sul" },
	{ 1930.56,3727.93,32.84,205.0,"Norte" },
	{ 1211.52,-470.31,66.20,72.0,"Sul" },
	{ -30.42,-151.77,57.07,336.0,"Sul" },
	{ -277.76,6230.73,31.69,38.0,"Norte" },
	{ -1127.19,-1439.41,5.22,303.31,"Sul" },
	{ 1594.88,6454.87,26.02,311.82,"Norte" },
	{ 1588.91,6457.69,26.02,331.66,"Norte" },
	{ 162.19,6643.24,31.69,226.78,"Norte" },
	{ 160.55,6641.6,31.69,223.94,"Norte" },
	{ -161.07,6321.37,31.58,314.65,"Norte" },
	{ 756.32,-767.39,26.34,79.38,"Sul" },
	{ -1658.98,-1061.67,12.15,51.03,"Sul" },
	{ 1951.68,3764.0,32.59,28.35,"Norte" },
	{ 1947.41,3762.53,32.59,300.48,"Norte" },
	{ 1945.81,3765.25,32.59,300.48,"Norte" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for k,v in pairs(registers) do
		exports["target"]:AddCircleZone("Register:"..k,vec3(v[1],v[2],v[3]),1.0,{
			name = "Register:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.0,
			options = {
				{
					event = "register:openSystem",
					label = "Roubar",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTER:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("register:openSystem",function(shopId)
	if vSERVER.applyTimers(shopId) then
		SetEntityHeading(ped,registers[shopId][4])
		SetEntityCoords(ped,registers[shopId][1],registers[shopId][2],registers[shopId][3] - 1,1,0,0,0)

		local safeCracking = exports["safecrack"]:safeCraking(1)
		if safeCracking then
			vSERVER.paymentMethod(registers[shopId][5])
		end
	end
end)