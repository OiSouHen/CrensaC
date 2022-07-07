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
Tunnel.bindInterface("works",cRP)
vCLIENT = Tunnel.getInterface("works")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local works = {
	["Transportador"] = {
		["coords"] = { 229.16,231.91,97.04 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = true,
		["deliveryVehicle"] = 1747439474,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 10,
		["collectDuration"] = 10000,
		["collectText"] = "VASCULHAR",
		["deliveryText"] = "ENTREGAR",
		["collectAnim"] = { false,"amb@prop_human_atm@male@idle_a","idle_a",true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 3
		},
		["collectCoords"] = {
			{ 241.51,210.18,97.11,158.75 },
			{ 240.12,212.44,97.11,65.2 },
			{ 241.23,215.58,97.11,70.87 },
			{ 245.03,214.28,97.11,249.45 },
			{ 244.04,211.34,97.11,249.45 },
			{ 252.59,240.44,97.11,343.0 },
			{ 253.79,238.11,97.11,246.62 },
			{ 252.86,235.53,97.11,252.29 },
			{ 248.75,236.38,97.11,68.04 },
			{ 249.78,239.2,97.11,68.04 }
		},
		["deliveryItem"] = "pouch",
		["deliveryName"] = "Malotes",
		["deliveryConsume"] = {
			["min"] = 2,
			["max"] = 3
		},
		["deliveryCoords"] = {
			{ 285.47,143.37,104.17,158.75 },
			{ 527.36,-160.7,57.09,272.13 },
			{ 1153.64,-326.75,69.2,99.22 },
			{ 1167.01,-456.07,66.79,345.83 },
			{ 1138.25,-468.9,66.73,73.71 },
			{ 1077.71,-776.5,58.23,187.09 },
			{ 315.09,-593.65,43.29,65.2 },
			{ 296.46,-894.25,29.23,249.45 },
			{ 295.76,-896.14,29.22,252.29 },
			{ 147.58,-1035.79,29.34,161.58 },
			{ 145.93,-1035.19,29.34,161.58 },
			{ 289.1,-1256.87,29.44,277.8 },
			{ 288.82,-1282.36,29.64,272.13 },
			{ 126.85,-1296.59,29.27,25.52 },
			{ 127.84,-1296.03,29.27,28.35 },
			{ 33.16,-1348.25,29.49,175.75 },
			{ 24.48,-945.95,29.35,343.0 },
			{ 5.24,-919.83,29.55,252.29 },
			{ 112.58,-819.4,31.34,158.75 },
			{ 114.44,-776.41,31.41,343.0 },
			{ 111.25,-775.25,31.44,345.83 },
			{ -27.99,-724.54,44.23,345.83 },
			{ -30.19,-723.71,44.23,343.0 },
			{ -203.8,-861.37,30.26,31.19 },
			{ -301.7,-830.01,32.42,351.5 },
			{ -303.24,-829.74,32.42,354.34 },
			{ -258.87,-723.38,33.48,70.87 },
			{ -256.2,-715.99,33.53,73.71 },
			{ -254.41,-692.49,33.6,161.58 },
			{ -537.85,-854.49,29.28,178.59 },
			{ -660.73,-854.07,24.48,187.09 },
			{ -710.01,-818.9,23.72,0.0 },
			{ -712.89,-818.92,23.72,0.0 },
			{ -717.7,-915.65,19.21,85.04 },
			{ -821.63,-1081.88,11.12,31.19 },
			{ -1315.71,-834.75,16.95,314.65 },
			{ -1314.75,-836.03,16.95,314.65 },
			{ -1305.41,-706.37,25.33,127.56 },
			{ -1570.14,-546.72,34.95,218.27 },
			{ -1571.06,-547.39,34.95,215.44 },
			{ -1415.94,-212.04,46.51,235.28 },
			{ -1430.18,-211.06,46.51,113.39 },
			{ -1409.76,-100.47,52.39,104.89 },
			{ -1410.32,-98.75,52.42,110.56 },
			{ -1282.52,-210.92,42.44,306.15 },
			{ -1286.28,-213.44,42.44,119.06 },
			{ -1285.54,-224.32,42.44,306.15 },
			{ -1289.31,-226.78,42.44,124.73 },
			{ -1205.02,-326.3,37.83,113.39 },
			{ -1205.78,-324.8,37.86,116.23 },
			{ -866.69,-187.74,37.84,121.89 },
			{ -867.63,-186.07,37.84,119.06 },
			{ -846.31,-341.26,38.67,113.39 },
			{ -846.81,-340.2,38.67,116.23 },
			{ -721.06,-415.58,34.98,269.3 },
			{ -556.18,-205.18,38.22,119.06 },
			{ -57.66,-92.65,57.78,294.81 },
			{ 89.73,2.46,68.29,343.0 },
			{ -165.17,232.77,94.91,90.71 },
			{ -165.16,234.8,94.91,85.04 },
			{ 158.6,234.23,106.63,343.0 },
			{ 228.18,338.38,105.56,158.75 },
			{ 380.76,323.4,103.56,158.75 },
			{ 357.01,173.54,103.07,340.16 }
		},
		["deliveryPayment"] = {
			["min"] = 28,
			["max"] = 34,
			["item"] = "dollars"
		}
	},
	["Lenhador"] = {
		["coords"] = { 2433.45,5013.46,46.99 },
		["upgradeStress"] = 2,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "CORTAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1.50,
		["collectShowDistance"] = 150,
		["collectDuration"] = 3000,
		["collectAnim"] = { false,"melee@hatchet@streamed_core","plyr_front_takedown_b",true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 3
		},
		["collectCoords"] = {
			{ 2477.13,5066.43,48.66,0.0 },
			{ 2455.07,5100.11,46.86,328.82 },
			{ 2422.96,5106.0,46.3,337.33 },
			{ 2412.18,5129.13,47.33,325.99 },
			{ 2440.87,5059.06,46.24,323.15 },
			{ 2478.99,5022.1,44.84,294.81 },
			{ 2462.14,5032.09,45.75,317.49 },
			{ 2529.88,5060.21,47.77,286.3 },
			{ 2424.66,5079.68,46.81,323.15 },
			{ 2399.04,5092.74,47.25,348.67 },
			{ 2541.86,5021.0,45.39,345.83 },
			{ 2489.1,4999.1,45.98,306.15 },
			{ 2487.83,5079.83,46.1,340.16 },
			{ 2515.24,5065.22,46.39,311.82 },
			{ 2412.23,5056.28,46.51,323.15 },
			{ 2583.21,5007.84,50.16,314.65 },
			{ 2620.75,4984.55,44.6,317.49 },
			{ 2582.67,4951.55,38.59,294.81 },
			{ 2422.32,5020.33,46.64,314.65 },
			{ 2473.82,4994.42,46.2,311.82 }
		},
		["deliveryItem"] = {
			"woodlog"
		}
	},
	["Minerador"] = {
		["coords"] = { 2964.43,2752.88,43.32 },
		["upgradeStress"] = 3,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "MINERAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 500,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@world_human_const_drill@male@drill@base","base",true },
		["collectCoords"] = {
			{ 2959.2,2819.94,43.73,65.2 },
			{ 2956.05,2819.97,43.19,93.55 },
			{ 2950.91,2816.4,42.85,357.17 },
			{ 2948.17,2820.81,43.59,127.56 },
			{ 2944.54,2820.16,43.54,198.43 },
			{ 2944.26,2818.67,43.54,161.58 },
			{ 2938.44,2813.13,43.46,147.41 },
			{ 2936.71,2814.08,44.01,175.75 },
			{ 2931.18,2816.95,45.7,215.44 },
			{ 2926.25,2813.29,45.61,289.14 },
			{ 2918.15,2800.09,41.85,65.2 },
			{ 2921.21,2799.06,42.14,204.1 },
			{ 2925.57,2796.28,41.47,235.28 },
			{ 2925.34,2794.94,41.5,195.6 },
			{ 2925.86,2792.42,41.28,206.93 },
			{ 2928.12,2790.6,40.86,277.8 },
			{ 2928.28,2789.03,40.61,113.39 },
			{ 2930.6,2786.87,40.12,257.96 },
			{ 2934.52,2784.27,40.17,136.07 },
			{ 2937.04,2774.52,39.7,218.27 },
			{ 2938.37,2774.23,39.77,266.46 },
			{ 2937.35,2771.71,39.93,229.61 },
			{ 2939.83,2770.54,39.73,218.27 },
			{ 2939.0,2769.14,39.7,158.75 },
			{ 2947.51,2765.82,40.46,343.0 },
			{ 2948.1,2767.44,39.83,124.73 },
			{ 2952.48,2767.8,40.0,68.04 },
			{ 2953.53,2770.22,39.6,161.58 },
			{ 2956.16,2773.09,40.24,218.27 },
			{ 2957.73,2772.77,40.32,45.36 },
			{ 2964.33,2773.9,40.07,133.23 },
			{ 2968.58,2773.65,38.72,308.98 },
			{ 2969.44,2775.79,39.66,53.86 },
			{ 2972.23,2775.18,39.24,291.97 },
			{ 2980.9,2781.9,40.12,240.95 },
			{ 2982.0,2786.89,41.18,294.81 },
			{ 2979.17,2790.98,41.67,82.21 },
			{ 2977.18,2792.37,41.4,39.69 },
			{ 2976.37,2794.84,41.65,229.61 },
			{ 2976.72,2796.2,41.55,269.3 },
			{ 2972.18,2799.39,42.14,354.34 },
			{ 2991.38,2776.52,43.79,79.38 },
			{ 3002.92,2773.51,43.74,65.2 },
			{ 2983.39,2763.71,43.59,172.92 },
			{ 2980.99,2764.29,43.22,107.72 },
			{ 2988.26,2754.15,43.52,238.12 },
			{ 2993.57,2751.79,44.13,68.04 },
			{ 2993.75,2753.27,43.73,28.35 },
			{ 2959.46,2759.03,42.51,127.56 },
			{ 2955.49,2756.5,44.43,136.07 },
			{ 2954.1,2754.28,43.96,158.75 },
			{ 2947.5,2754.43,44.01,343.0 },
			{ 2943.41,2756.52,43.66,153.08 },
			{ 2942.35,2760.44,42.73,325.99 },
			{ 2937.35,2757.3,44.69,334.49 },
			{ 2931.0,2761.97,45.07,42.52 },
			{ 2928.76,2765.45,44.65,343.0 },
			{ 2928.2,2767.79,44.35,348.67 },
			{ 2939.94,2746.5,43.83,51.03 },
			{ 2939.45,2741.82,44.69,266.46 },
			{ 2948.96,2738.84,45.12,150.24 },
			{ 2948.37,2732.15,45.88,255.12 },
			{ 2945.11,2733.7,46.07,19.85 },
			{ 2948.14,2728.15,47.13,277.8 },
			{ 2972.23,2739.51,44.18,289.14 }
		}
	},
	["Mergulhador"] = {
		["coords"] = { 1520.56,3780.08,34.46 },
		["upgradeStress"] = 1,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "VASCULHAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 500,
		["collectDuration"] = 12500,
		["collectAnim"] = { false,"amb@prop_human_parking_meter@female@idle_a","idle_a_female",true },
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 3
		},
		["collectCoords"] = {
			{ 1018.69,4095.91,12.7 },
			{ 963.91,4036.36,3.35 },
			{ 960.66,3973.73,1.11 },
			{ 1015.39,3959.19,-3.0 },
			{ 1064.1,3974.58,-12.5 },
			{ 1045.07,4008.94,-12.45 },
			{ 995.48,4048.54,4.52 },
			{ 961.85,4034.99,2.95 },
			{ 907.1,3958.09,-4.3 },
			{ 935.89,3911.83,-9.69 },
			{ 927.22,3836.77,3.79 },
			{ 935.42,3791.86,16.85 },
			{ 975.34,3800.73,16.55 },
			{ 1030.63,3823.97,9.64 },
			{ 1068.02,3863.78,-7.23 },
			{ 1138.51,3991.73,-4.28 },
			{ 1093.69,4050.16,0.86 },
			{ 1045.61,4141.31,21.85 }
		},
		["deliveryItem"] = {
			"key",
			"octopus",
			"shrimp",
			"carp",
			"codfish",
			"catfish",
			"goldenfish",
			"horsefish",
			"tilapia",
			"pacu",
			"pirarucu",
			"tambaqui",
			"bait",
			"emptybottle",
			"plastic",
			"glass",
			"rubber",
			"aluminum",
			"copper",
			"silvercoin",
			"goldcoin"
		}
	},
	["Agricultor"] = {
		["coords"] = { 2129.11,5084.23,45.01 },
		["upgradeStress"] = 2,
		["routeCollect"] = false,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["collectText"] = "COLETAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 100,
		["collectDuration"] = 10000,
		["collectAnim"] = { false,"amb@prop_human_movie_bulb@base","base",true },
		["collectConsume"] = {
			["min"] = 3,
			["max"] = 4
		},
		["collectCoords"] = {
			{ 2002.46,5128.21,44.85,300.48 },
			{ 2015.2,5138.37,46.39,351.5 },
			{ 2026.28,5148.23,47.53,291.97 },
			{ 2037.51,5157.57,48.53,317.49 },
			{ 2046.23,5147.16,47.47,345.83 },
			{ 2035.01,5137.77,46.71,2.84 },
			{ 2023.88,5128.29,45.58,48.19 },
			{ 2010.88,5117.93,44.31,308.98 },
			{ 2057.41,5133.32,46.49,68.04 },
			{ 2045.0,5123.91,45.85,308.98 },
			{ 2034.15,5114.22,45.16,45.36 },
			{ 2021.17,5103.99,43.83,291.97 },
			{ 2065.94,5122.94,45.54,291.97 },
			{ 2055.26,5113.31,46.56,8.51 },
			{ 2043.22,5103.99,44.65,280.63 },
			{ 2031.28,5093.28,43.49,343.0 },
			{ 2077.17,5110.53,45.01,303.31 },
			{ 2066.01,5100.98,44.33,300.48 },
			{ 2054.64,5091.43,43.46,317.49 },
			{ 2042.22,5081.1,42.48,303.31 },
			{ 2089.24,5096.47,44.58,0.0 },
			{ 2077.59,5087.31,43.81,289.14 },
			{ 2066.17,5077.5,42.6,317.49 },
			{ 2054.42,5067.17,41.72,51.03 },
			{ 2099.97,5085.01,44.28,343.0 },
			{ 2088.39,5075.93,43.37,280.63 },
			{ 2077.14,5066.02,42.55,325.99 },
			{ 2064.84,5055.66,41.77,345.83 },
			{ 2109.04,5074.09,43.69,345.83 },
			{ 2074.0,5044.73,41.57,0.0 },
			{ 2086.09,5055.09,41.79,323.15 },
			{ 2097.79,5064.72,42.56,331.66 }
		},
		["deliveryItem"] = {
			"tomato",
			"banana",
			"passion",
			"grape",
			"tange",
			"orange",
			"apple",
			"strawberry",
			"coffee2"
		}
	},
	["Motorista"] = {
		["coords"] = { 453.05,-607.72,28.59 },
		["upgradeStress"] = 1,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		["collectVehicle"] = -713569950,
		["usingVehicle"] = true,
		["collectRandom"] = false,
		["collectText"] = "PEGAR",
		["deliveryText"] = "ENTREGAR",
		["collectButtonDistance"] = 15,
		["collectShowDistance"] = 100,
		["collectConsume"] = {
			["min"] = 40,
			["max"] = 45
		},
		["collectCoords"] = {
			{ 418.92,-571.03,28.68 },
			{ 923.78,186.7,75.81 },
			{ 1644.11,1166.89,84.26 },
			{ 2104.23,2630.44,51.76 },
			{ 2402.38,2918.04,49.31 },
			{ 1786.57,3356.21,40.51 },
			{ 1620.82,3813.85,34.94 },
			{ 1911.6,3793.09,32.31 },
			{ 2493.37,4088.69,38.04 },
			{ 2068.51,4693.82,41.19 },
			{ 1676.39,4822.41,42.02 },
			{ 2250.19,4986.36,42.23 },
			{ 1667.97,6397.56,30.12 },
			{ 235.51,6574.7,31.57 },
			{ -85.11,6584.3,29.47 },
			{ -137.53,6440.85,31.42 },
			{ -235.39,6304.34,31.39 },
			{ -422.67,6031.56,31.34 },
			{ -756.66,5515.02,35.49 },
			{ -1538.42,4976.01,62.28 },
			{ -2246.9,4283.26,46.68 },
			{ -2731.13,2292.23,19.05 },
			{ -3233.06,1009.3,12.18 },
			{ -3002.44,416.76,14.97 },
			{ -1960.25,-504.23,11.82 },
			{ -1371.7,-982.24,8.43 },
			{ -1166.92,-1471.31,4.34 },
			{ -1052.56,-1511.78,5.09 },
			{ -900.75,-1206.71,4.94 },
			{ -628.94,-924.13,23.28 },
			{ -557.24,-845.49,27.61 },
			{ -1059.11,-2066.85,13.2 },
			{ -543.79,-2194.84,6.01 },
			{ -60.68,-1806.51,27.21 },
			{ 228.64,-1837.9,26.73 },
			{ 291.46,-2002.07,20.31 },
			{ 739.81,-2233.34,29.24 },
			{ 1045.03,-2384.93,30.28 },
			{ 1200.9,-685.64,60.6 },
			{ 954.37,-146.43,74.45 },
			{ 566.42,218.64,102.54 },
			{ -429.1,252.36,83.02 },
			{ -732.3,3.21,37.88 },
			{ -1244.38,-302.64,37.32 },
			{ -1403.93,-566.3,30.22 },
			{ -1202.05,-876.7,13.28 },
			{ -691.37,-961.63,19.79 },
			{ -387.71,-851.57,31.5 },
			{ 149.9,-1028.06,29.25 },
			{ 120.26,-1356.98,29.19 },
			{ 118.29,-785.88,31.3 },
			{ 98.34,-628.98,31.57 }
		},
		["deliveryItem"] = "dollars"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collectAmount = {}
local paymentAmount = {}
local deliveryAmount = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.collectConsume(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if works[serviceName]["collectRandom"] then
			local amountItem = 0
			local selectItem = ""

			if serviceName == "Minerador" then
				local randomItem = math.random(100)

				if randomItem <= 1 then
					amountItem = 1
					selectItem = "emerald"
				elseif randomItem >= 2 and randomItem <= 3 then
					selectItem = "diamond"
					amountItem = math.random(2)
				elseif randomItem >= 4 and randomItem <= 8 then
					selectItem = "ruby"
					amountItem = math.random(2)
				elseif randomItem >= 9 and randomItem <= 16 then
					selectItem = "sapphire"
					amountItem = math.random(3)
				elseif randomItem >= 17 and randomItem <= 27 then
					selectItem = "amethyst"
					amountItem = math.random(3)
				elseif randomItem >= 28 and randomItem <= 44 then
					selectItem = "amber"
					amountItem = math.random(3)
				elseif randomItem >= 45 and randomItem <= 60 then
					selectItem = "turquoise"
					amountItem = math.random(3)
				elseif randomItem >= 61 and randomItem <= 79 then
					selectItem = "aluminum"
					amountItem = math.random(2)
				elseif randomItem >= 80 then
					selectItem = "copper"
					amountItem = math.random(2)
				end
			else
				local randomItem = math.random(#works[serviceName]["deliveryItem"])
				selectItem = works[serviceName]["deliveryItem"][randomItem]
				amountItem = math.random(works[serviceName]["collectConsume"]["min"],works[serviceName]["collectConsume"]["max"])
			end

			if (vRP.inventoryWeight(user_id) + (itemWeight(selectItem) * parseInt(amountItem))) <= vRP.getWeight(user_id) then
				vRP.generateItem(user_id,selectItem,amountItem,true)

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		else
			local deliveryItem = works[serviceName]["deliveryItem"]
			collectAmount[user_id] = math.random(works[serviceName]["collectConsume"]["min"],works[serviceName]["collectConsume"]["max"])

			if (vRP.inventoryWeight(user_id) + (itemWeight(deliveryItem) * parseInt(collectAmount[user_id]))) <= vRP.getWeight(user_id) then
				vRP.generateItem(user_id,deliveryItem,collectAmount[user_id],true)

				if deliveryItem == "dollars" then
					if vRP.userPremium(user_id) then
						vRP.generateItem(user_id,deliveryItem,collectAmount[user_id] * 0.10,true)
					end
				end

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id,works[serviceName]["upgradeStress"])
				end

				collectAmount[user_id] = nil

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERYCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deliveryConsume(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local deliveryItem = works[serviceName]["deliveryPayment"]["item"]
		deliveryAmount[user_id] = math.random(works[serviceName]["deliveryConsume"]["min"],works[serviceName]["deliveryConsume"]["max"])
		paymentAmount[user_id] = math.random(works[serviceName]["deliveryPayment"]["min"],works[serviceName]["deliveryPayment"]["max"])

		if (vRP.inventoryWeight(user_id) + (itemWeight(deliveryItem) * parseInt(paymentAmount[user_id]))) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,works[serviceName]["deliveryItem"],deliveryAmount[user_id]) then
				local paymentPrice = parseInt(paymentAmount[user_id] * deliveryAmount[user_id])

				vRP.generateItem(user_id,deliveryItem,paymentPrice,true)

				if deliveryItem == "dollars" then
					if vRP.userPremium(user_id) then
						vRP.generateItem(user_id,deliveryItem,paymentPrice * 0.10,true)
					end
				end

				deliveryAmount[user_id] = nil
				paymentAmount[user_id] = nil

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>"..parseFormat(deliveryAmount[user_id]).."x "..itemName(works[serviceName]["deliveryItem"]).."</b> para entregar.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if works[serviceName]["perm"] == nil then
			return true
		end

		if vRP.hasGroup(user_id,works[serviceName]["perm"]) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	vCLIENT.updateWorks(source,works)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ensureworks
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ensureworks",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			vCLIENT.updateWorks(-1,works)
			vCLIENT.updateWorks(source,works)
			TriggerClientEvent("Notify",source,"amarelo","Ensure.",3000)
		end
	end
end)