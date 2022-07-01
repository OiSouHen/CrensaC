-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local Selected = {}
local Sucess = false
LocalPlayer["state"]["Target"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXCLUSIVES
-----------------------------------------------------------------------------------------------------------------------------------------
local Exclusives = {
	{ 943.23,-1497.87,30.11,"Desmanche" },
	{ -1172.57,-2037.65,13.75,"Desmanche" },
	{ -574.2,-1669.71,19.23,"Desmanche" },
	{ 1358.14,-2095.41,52.0,"Desmanche" },
	{ 602.47,-437.82,24.75,"Desmanche" },
	{ -413.86,-2179.29,10.31,"Desmanche" },
	{ -142.24,-1174.19,23.76,"Reboque" },
	{ 1724.84,3715.31,34.22,"Reboque" },
	{ -305.45,6117.62,31.49,"Reboque" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Dismantles")
AddEventHandler("target:Dismantles",function()
	for k,v in pairs(Exclusives) do
		if v[4] == "Desmanche" then
			TriggerEvent("NotifyPush",{ code = 20, title = "Localização do Desmanche", x = v[1], y = v[2], z = v[3], blipColor = 60 })
			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Fuels = {
	{ 273.83,-1253.46,28.29 },
	{ 273.83,-1261.29,28.29 },
	{ 273.83,-1268.63,28.29 },
	{ 265.06,-1253.46,28.29 },
	{ 265.06,-1261.29,28.29 },
	{ 265.06,-1268.63,28.29 },
	{ 256.43,-1253.46,28.29 },
	{ 256.43,-1261.29,28.29 },
	{ 256.43,-1268.63,28.29 },
	{ 2680.90,3266.40,54.39 },
	{ 2678.51,3262.33,54.39 },
	{ -2104.53,-311.01,12.16 },
	{ -2105.39,-319.21,12.16 },
	{ -2106.06,-325.57,12.16 },
	{ -2097.48,-326.48,12.16 },
	{ -2096.81,-320.11,12.16 },
	{ -2096.09,-311.90,12.16 },
	{ -2087.21,-312.81,12.16 },
	{ -2088.08,-321.03,12.16 },
	{ -2088.75,-327.39,12.16 },
	{ -2551.39,2327.11,32.24 },
	{ -2558.02,2326.70,32.24 },
	{ -2558.48,2334.13,32.24 },
	{ -2552.60,2334.46,32.24 },
	{ -2558.77,2341.48,32.24 },
	{ -2552.39,2341.89,32.24 },
	{ 186.97,6606.21,31.06 },
	{ 179.67,6604.93,31.06 },
	{ 172.33,6603.63,31.06 },
	{ 818.99,-1026.24,25.44 },
	{ 810.7,-1026.24,25.44 },
	{ 810.7,-1030.94,25.44 },
	{ 818.99,-1030.94,25.44 },
	{ 818.99,-1026.24,25.44 },
	{ 827.3,-1026.24,25.64 },
	{ 827.3,-1030.94,25.64 },
	{ 1207.07,-1398.16,34.39 },
	{ 1204.2,-1401.03,34.39 },
	{ 1210.07,-1406.9,34.39 },
	{ 1212.94,-1404.03,34.39 },
	{ 1178.97,-339.54,68.37 },
	{ 1186.4,-338.23,68.36 },
	{ 1184.89,-329.7,68.31 },
	{ 1177.46,-331.01,68.32 },
	{ 1175.71,-322.3,68.36 },
	{ 1183.13,-320.99,68.36 },
	{ 629.64,263.84,102.27 },
	{ 629.64,273.97,102.27 },
	{ 620.99,273.97,102.27 },
	{ 621.0,263.84,102.27 },
	{ 612.44,263.84,102.27 },
	{ 612.43,273.96,102.27 },
	{ 2588.41,358.56,107.66 },
	{ 2588.65,364.06,107.66 },
	{ 2581.18,364.39,107.66 },
	{ 2580.94,358.89,107.66 },
	{ 2573.55,359.21,107.66 },
	{ 2573.79,364.71,107.66 },
	{ 174.99,-1568.44,28.33 },
	{ 181.81,-1561.96,28.33 },
	{ 176.03,-1555.91,28.33 },
	{ 169.3,-1562.26,28.33 },
	{ -329.81,-1471.63,29.73 },
	{ -324.74,-1480.41,29.73 },
	{ -317.26,-1476.09,29.73 },
	{ -322.33,-1467.31,29.73 },
	{ -314.92,-1463.03,29.73 },
	{ -309.85,-1471.79,29.73 },
	{ 1786.08,3329.86,40.42 },
	{ 1785.04,3331.48,40.35 },
	{ 50.31,2778.54,57.05 },
	{ 48.92,2779.59,57.05 },
	{ 264.98,2607.18,43.99 },
	{ 263.09,2606.8,43.99 },
	{ 1035.45,2674.44,38.71 },
	{ 1043.22,2674.45,38.71 },
	{ 1043.22,2667.92,38.71 },
	{ 1035.45,2667.91,38.71 },
	{ 1209.59,2658.36,36.9 },
	{ 1208.52,2659.43,36.9 },
	{ 1205.91,2662.05,36.9 },
	{ 2539.8,2594.81,36.96 },
	{ 2001.55,3772.21,31.4 },
	{ 2003.92,3773.48,31.4 },
	{ 2006.21,3774.96,31.4 },
	{ 2009.26,3776.78,31.4 },
	{ 1684.6,4931.66,41.23 },
	{ 1690.1,4927.81,41.23 },
	{ 1705.74,6414.61,31.77 },
	{ 1701.73,6416.49,31.77 },
	{ 1697.76,6418.35,31.77 },
	{ -97.06,6416.77,30.65 },
	{ -91.29,6422.54,30.65 },
	{ -1808.71,799.96,137.69 },
	{ -1803.62,794.4,137.69 },
	{ -1797.22,800.56,137.66 },
	{ -1802.31,806.12,137.66 },
	{ -1795.93,811.97,137.7 },
	{ -1790.83,806.41,137.7 },
	{ -1438.07,-268.69,45.41 },
	{ -1444.5,-274.23,45.41 },
	{ -1435.5,-284.68,45.41 },
	{ -1429.07,-279.15,45.41 },
	{ -732.64,-932.51,18.22 },
	{ -732.64,-939.32,18.22 },
	{ -724.0,-939.32,18.22 },
	{ -724.0,-932.51,18.22 },
	{ -715.43,-932.51,18.22 },
	{ -715.43,-939.32,18.22 },
	{ -532.28,-1212.71,17.33 },
	{ -529.51,-1213.96,17.33 },
	{ -524.92,-1216.15,17.33 },
	{ -522.23,-1217.42,17.33 },
	{ -518.52,-1209.5,17.33 },
	{ -521.21,-1208.23,17.33 },
	{ -525.8,-1206.04,17.33 },
	{ -528.57,-1204.8,17.33 },
	{ -72.03,-1765.1,28.53 },
	{ -69.45,-1758.01,28.55 },
	{ -77.59,-1755.05,28.81 },
	{ -80.17,-1762.14,28.8 },
	{ -63.61,-1767.93,28.27 },
	{ -61.03,-1760.85,28.31 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	AddCircleZone("makePaper",vec3(-533.18,5292.15,74.17),0.75,{
		name = "makePaper",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Produzir",
				tunnel = "products",
				service = "paper"
			}
		}
	})

	AddCircleZone("Yoga01",vec3(-492.83,-217.31,35.61),0.75,{
		name = "Yoga01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga02",vec3(-492.87,-219.03,36.55),0.75,{
		name = "Yoga02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga03",vec3(-492.89,-220.68,36.51),0.75,{
		name = "Yoga03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga04",vec3(-490.21,-220.91,36.51),0.75,{
		name = "Yoga04",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga05",vec3(-490.18,-219.24,36.58),0.75,{
		name = "Yoga05",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga06",vec3(-490.16,-217.33,36.63),0.75,{
		name = "Yoga06",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("callTaxi",vec3(-1038.98,-2731.16,20.17),0.75,{
		name = "callTaxi",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "smartphone:callTaxi",
				label = "Chamar Taxi",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary01",vec3(257.39,228.04,106.27),0.75,{
		name = "bankSalary01",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary02",vec3(259.59,227.25,106.27),0.75,{
		name = "bankSalary02",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary03",vec3(262.09,226.33,106.27),0.75,{
		name = "bankSalary03",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary04",vec3(264.31,225.55,106.27),0.75,{
		name = "bankSalary04",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary05",vec3(266.77,224.64,106.27),0.75,{
		name = "bankSalary05",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary06",vec3(268.99,223.82,106.27),0.75,{
		name = "bankSalary06",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary07",vec3(264.86,212.19,106.27),0.75,{
		name = "bankSalary07",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary08",vec3(262.63,213.02,106.27),0.75,{
		name = "bankSalary08",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary09",vec3(260.14,213.92,106.27),0.75,{
		name = "bankSalary09",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary10",vec3(257.94,214.7,106.27),0.75,{
		name = "bankSalary10",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary11",vec3(255.45,215.62,106.27),0.75,{
		name = "bankSalary11",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary12",vec3(253.23,216.44,106.27),0.75,{
		name = "bankSalary12",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary13",vec3(-110.72,6469.84,31.63),0.75,{
		name = "bankSalary13",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary14",vec3(-108.98,6471.57,31.63),0.75,{
		name = "bankSalary14",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("treatment01",vec3(-253.92,6331.07,32.42),0.75,{
		name = "treatment01",
		heading = 3374176
	},{
		shop = "Paleto",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment02",vec3(307.03,-595.12,43.29),0.75,{
		name = "treatment02",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment03",vec3(350.92,-587.68,28.8),0.75,{
		name = "treatment03",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment04",vec3(1768.67,2570.59,45.73),0.75,{
		name = "treatment04",
		heading = 3374176
	},{
		shop = "Bolingbroke",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment05",vec3(-469.26,6289.48,13.61),0.75,{
		name = "treatment05",
		heading = 3374176
	},{
		shop = "Clandestine",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddTargetModel({ -1691644768,-742198632 },{
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher",
				tunnel = "police",
				service = "emptybottle"
			},
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1631638868,2117668672,-1498379115,-1519439119,-289946279 },{
		options = {
			{
				event = "target:animDeitar",
				label = "Deitar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ -171943901,-109356459,1805980844,-99500382,1262298127,1737474779,2040839490,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-853526657,652816835 },{
		options = {
			{
				event = "target:animSentar",
				label = "Sentar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:coffeeMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:donutMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:sodaMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:burgerMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:hotdogMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -272361894 },{
		options = {
			{
				event = "shops:Chihuahua",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:waterMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -832573324,-1430839454,1457690978,1682622302,402729631,-664053099,1794449327,307287994,-1323586730,111281960,-541762431,-745300483,-417505688 },{
		options = {
			{
				event = "inventory:Animals",
				label = "Esfolar",
				tunnel = "police"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 684586828,577432224,-1587184881,-1426008804,-228596739,1437508529,-1096777189,-468629664,1143474856,-2096124444,-115771139,1329570871,-130812911 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			}
		},
		distance = 0.75
	})
	
	AddTargetModel({ -206690185,666561306,218085040,-58485588,1511880420,682791951 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			},
			{
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			},
			{
				event = "player:checkTrash",
				label = "Checar",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1211559620,1363150739,-1186769817,261193082,-756152956,-1383056703,720581693,1287257122,917457845,-838860344 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Jornaleiro"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -2007231801,1339433404,1694452750,1933174915,-462817101,-469694731,-164877493 },{
		options = {
			{
				event = "crafting:Fuels",
				label = "Combustível",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -1940238623,2108567945 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Roubar",
				tunnel = "police",
				service = "Parquimetro"
			}
		},
		distance = 0.75
	})
	
	AddCircleZone("dollarsRoll01",vec3(-610.87,-1089.48,25.86),0.5,{
		name = "dollarsRoll01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})
	
	AddCircleZone("dollarsRoll02",vec3(-1181.8,-888.09,19.97),0.5,{
		name = "dollarsRoll02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})
	
	AddCircleZone("dollarsRoll03",vec3(825.87,-828.52,26.34),0.5,{
		name = "dollarsRoll03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})
	
	AddCircleZone("Trucker",vec3(1239.87,-3257.2,7.09),0.5,{
		name = "Trucker",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "trucker:initVehicles",
				label = "Entrega de Veículos",
				tunnel = "client"
			},{
				event = "trucker:initDiesel",
				label = "Entrega de Diesel",
				tunnel = "client"
			},{
				event = "trucker:initFuel",
				label = "Entrega de Gasolina",
				tunnel = "client"
			},{
				event = "trucker:initWood",
				label = "Entrega de Madeira",
				tunnel = "client"
			}
		}
	})

	-- AddCircleZone("foodJuice01",vec3(-1190.78,-904.23,13.99),0.5,{
		-- name = "foodJuice01",
		-- heading = 3374176
	-- },{
		-- distance = 1.25,
		-- options = {
			-- {
				-- event = "inventory:makeProducts",
				-- label = "Encher Copo",
				-- tunnel = "police",
				-- service = "foodJuice"
			-- }
		-- }
	-- })
	
	AddCircleZone("Juice01",vec3(-1190.76,-904.24,13.99),0.5,{
		name = "Juice01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "burgershot1"
			}
		}
	})

	AddCircleZone("Burger01",vec3(-1202.09,-897.2,13.99),0.5,{
		name = "Burger01",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "burgershot2"
			}
		}
	})

	AddCircleZone("Box01",vec3(-1197.92,-892.28,13.99),0.5,{
		name = "Box01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Combo",
				tunnel = "police",
				service = "burgershot3"
			},{
				event = "inventory:makeProducts",
				label = "Montar Combo + Brinquedo",
				tunnel = "police",
				service = "burgershot4"
			}
		}
	})
	
	AddCircleZone("Juice02",vec3(810.69,-764.58,26.77),0.5,{
		name = "Juice02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "pizzathis1"
			}
		}
	})

	AddCircleZone("Burger02",vec3(807.68,-762.3,26.77),0.5,{
		name = "Burger02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "pizzathis2"
			}
		}
	})

	AddCircleZone("Box02",vec3(809.87,-761.15,26.77),0.5,{
		name = "Box02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Combo",
				tunnel = "police",
				service = "pizzathis3"
			},{
				event = "inventory:makeProducts",
				label = "Montar Combo + Brinquedo",
				tunnel = "police",
				service = "pizzathis4"
			}
		}
	})

	AddCircleZone("Juice03",vec3(-590.36,-1058.54,22.34),0.5,{
		name = "Juice03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "uwucoffee1"
			}
		}
	})

	AddCircleZone("Burger03",vec3(-590.49,-1056.51,22.36),0.5,{
		name = "Burger03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "uwucoffee2"
			}
		}
	})

	AddCircleZone("Box03",vec3(-590.5,-1063.02,22.36),0.5,{
		name = "Box03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Combo",
				tunnel = "police",
				service = "uwucoffee3"
			},{
				event = "inventory:makeProducts",
				label = "Montar Combo + Brinquedo",
				tunnel = "police",
				service = "uwucoffee4"
			}
		}
	})

	AddCircleZone("Juice04",vec3(126.28,-1035.83,29.27),0.5,{
		name = "Juice04",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "beanmachine1"
			}
		}
	})

	AddCircleZone("Burger04",vec3(122.31,-1038.35,29.27),0.5,{
		name = "Burger04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "beanmachine2"
			}
		}
	})

	AddCircleZone("Box04",vec3(122.79,-1044.03,29.27),0.5,{
		name = "Box04",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Combo",
				tunnel = "police",
				service = "beanmachine3"
			},{
				event = "inventory:makeProducts",
				label = "Montar Combo + Brinquedo",
				tunnel = "police",
				service = "beanmachine4"
			}
		}
	})

	AddCircleZone("PackSend01",vec3(1175.08,2706.9,38.1),0.75,{
		name = "PackSend01",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:Packs",
				label = "Entregar Pacote",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("PackSend02",vec3(-2962.52,483.05,15.7),0.75,{
		name = "PackSend02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:Packs",
				label = "Entregar Pacote",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("PackSend03",vec3(-1212.51,-330.75,37.78),0.75,{
		name = "PackSend03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:Packs",
				label = "Entregar Pacote",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("PackSend04",vec3(-351.05,-49.96,49.03),0.75,{
		name = "PackSend04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:Packs",
				label = "Entregar Pacote",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("PackSend05",vec3(314.23,-279.19,54.17),0.75,{
		name = "PackSend05",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:Packs",
				label = "Entregar Pacote",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("PackSend06",vec3(149.79,-1040.79,29.37),0.75,{
		name = "PackSend06",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:Packs",
				label = "Entregar Pacote",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry01",vec3(-626.67,-238.58,38.05),0.75,{
		name = "jewelry01",
		heading = 3374176
	},{
		shop = "1",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry02",vec3(-625.66,-237.86,38.05),0.75,{
		name = "jewelry02",
		heading = 3374176
	},{
		shop = "2",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry03",vec3(-626.84,-235.35,38.05),0.75,{
		name = "jewelry03",
		heading = 3374176
	},{
		shop = "3",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry04",vec3(-625.83,-234.6,38.05),0.75,{
		name = "jewelry04",
		heading = 3374176
	},{
		shop = "4",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry05",vec3(-626.9,-233.15,38.05),0.75,{
		name = "jewelry05",
		heading = 3374176
	},{
		shop = "5",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry06",vec3(-627.94,-233.92,38.05),0.75,{
		name = "jewelry06",
		heading = 3374176
	},{
		shop = "6",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry07",vec3(-620.22,-234.44,38.05),0.75,{
		name = "jewelry07",
		heading = 3374176
	},{
		shop = "7",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry08",vec3(-619.16,-233.7,38.05),0.75,{
		name = "jewelry08",
		heading = 3374176
	},{
		shop = "8",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry09",vec3(-617.56,-230.57,38.05),0.75,{
		name = "jewelry09",
		heading = 3374176
	},{
		shop = "9",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry10",vec3(-618.29,-229.49,38.05),0.75,{
		name = "jewelry10",
		heading = 3374176
	},{
		shop = "10",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry11",vec3(-619.68,-227.63,38.05),0.75,{
		name = "jewelry11",
		heading = 3374176
	},{
		shop = "11",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry12",vec3(-620.43,-226.56,38.05),0.75,{
		name = "jewelry12",
		heading = 3374176
	},{
		shop = "12",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry13",vec3(-623.92,-227.06,38.05),0.75,{
		name = "jewelry13",
		heading = 3374176
	},{
		shop = "13",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry14",vec3(-624.97,-227.84,38.05),0.75,{
		name = "jewelry14",
		heading = 3374176
	},{
		shop = "14",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry15",vec3(-624.42,-231.08,38.05),0.75,{
		name = "jewelry15",
		heading = 3374176
	},{
		shop = "15",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry16",vec3(-623.98,-228.18,38.05),0.75,{
		name = "jewelry16",
		heading = 3374176
	},{
		shop = "16",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry17",vec3(-621.08,-228.58,38.05),0.75,{
		name = "jewelry17",
		heading = 3374176
	},{
		shop = "17",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry18",vec3(-619.72,-230.43,38.05),0.75,{
		name = "jewelry18",
		heading = 3374176
	},{
		shop = "18",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry19",vec3(-620.14,-233.31,38.05),0.75,{
		name = "jewelry19",
		heading = 3374176
	},{
		shop = "19",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry20",vec3(-623.05,-232.95,38.05),0.75,{
		name = "jewelry20",
		heading = 3374176
	},{
		shop = "20",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelryHacker",vec3(-631.38,-230.24,38.05),0.75,{
		name = "jewelryHacker",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "robberys:initJewelry",
				label = "Hackear",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("divingStore",vec3(1521.08,3780.19,34.46),0.5,{
		name = "divingStore",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "shops:divingSuit",
				label = "Comprar Traje",
				tunnel = "server"
			},{
				event = "hud:rechargeOxigen",
				label = "Reabastecer Oxigênio",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles01",vec3(-38.9,-1100.22,27.26),0.75,{
		name = "tabletVehicles01",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles02",vec3(-40.37,-1094.57,27.26),0.75,{
		name = "tabletVehicles02",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles03",vec3(-46.87,-1095.5,27.26),0.75,{
		name = "tabletVehicles03",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles04",vec3(-51.59,-1094.98,27.26),0.75,{
		name = "tabletVehicles04",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles05",vec3(-51.15,-1087.13,27.26),0.75,{
		name = "tabletVehicles05",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles06",vec3(1224.78,2728.01,38.0),0.75,{
		name = "tabletVehicles06",
		heading = 3374176
	},{
		shop = "Sandy",
		distance = 2.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("cemiteryMan",vec3(-1745.57,-205.19,57.37),0.75,{
		name = "cemiteryMan",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "cemitery:initBody",
				label = "Conversar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("CassinoWheel",vec3(1112.05,228.11,-49.64),0.5,{
		name = "CassinoWheel",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "luckywheel:Target",
				label = "Roda da Fortuna",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetEnable()
	if LocalPlayer["state"]["Active"] then
		local ped = PlayerPedId()

		if LocalPlayer["state"]["Buttons"] or LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or Sucess or IsPedArmed(ped,6) or IsPedInAnyVehicle(ped) or not MumbleIsConnected() or LocalPlayer["state"]["Route"] > 900000 then
			return
		end

		LocalPlayer["state"]["Target"] = true
		SendNUIMessage({ response = "openTarget" })

		while LocalPlayer["state"]["Target"] do
			local hitZone,entCoords,entity = RayCastGamePlayCamera()

			if hitZone == 1 then
				local coords = GetEntityCoords(ped)

				for k,v in pairs(Zones) do
					if Zones[k]:isPointInside(entCoords) then
						if #(coords - Zones[k]["center"]) <= v["targetoptions"]["distance"] then

							if v["targetoptions"]["shop"] ~= nil then
								Selected = v["targetoptions"]["shop"]
							end

							if v["targetoptions"]["shopserver"] ~= nil then
								Selected = v["targetoptions"]["shopserver"]
							end

							SendNUIMessage({ response = "validTarget", data = Zones[k]["targetoptions"]["options"] })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if not Zones[k]:isPointInside(entCoords) or #(coords - Zones[k]["center"]) > v["targetoptions"]["distance"] then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					end
				end

				if GetEntityType(entity) ~= 0 then
					if IsEntityAVehicle(entity) then
						local vehPlate = GetVehicleNumberPlateText(entity)
						if #(coords - entCoords) <= 1.0 and vehPlate ~= "PDMSPORT" then
							local vehNet = nil
							local Combustivel = false
							local vehModel = GetEntityModel(entity)
							SetEntityAsMissionEntity(entity,true,true)

							if NetworkGetEntityIsNetworked(entity) then
								vehNet = VehToNet(entity)
							end

							Selected = { vehPlate,vRP.vehicleModel(vehModel),entity,vehNet }

							local Menu = {}

							for k,v in pairs(Fuels) do
								local Distance = #(coords - vec3(v[1],v[2],v[3]))
								if Distance <= 2.5 then
									Combustivel = true
									break
								end
							end

							if not Combustivel then
								if GetSelectedPedWeapon(ped) == 883325847 then
									Selected[5] = true
									table.insert(Menu,{ event = "engine:Supply", label = "Abastecer", tunnel = "client" })
								else
									if GlobalState["vehPlates"][vehPlate] then
										if GetVehicleDoorLockStatus(entity) == 1 then
											for k,Tyre in pairs(tyreList) do
												local Wheel = GetEntityBoneIndexByName(entity,k)
												if Wheel ~= -1 then
													local cWheel = GetWorldPositionOfEntityBone(entity,Wheel)
													local Distance = #(coords - cWheel)
													if Distance <= 1.0 then
														Selected[5] = Tyre
														table.insert(Menu,{ event = "inventory:removeTyres", label = "Retirar Pneu", tunnel = "client" })
													end
												end
											end

											table.insert(Menu,{ event = "trunkchest:openTrunk", label = "Abrir Porta-Malas", tunnel = "server" })
										end

										table.insert(Menu,{ event = "player:checkTrunk", label = "Checar Porta-Malas", tunnel = "server" })
										
										table.insert(Menu,{ event = "garages:vehicleKey", label = "Criar Chave Cópia", tunnel = "police" })
										table.insert(Menu,{ event = "inventory:applyPlate", label = "Trocar Placa", tunnel = "police" })
									else
										if Selected[2] == "stockade" then
											table.insert(Menu,{ event = "inventory:checkStockade", label = "Vasculhar", tunnel = "police" })
										end
									end

									if not IsThisModelABike(vehModel) then
										local Rolling = GetEntityRoll(entity)
										if Rolling > 75.0 or Rolling < -75.0 then
											table.insert(Menu,{ event = "player:RollVehicle", label = "Desvirar", tunnel = "server" })
										else
											if GetEntityBoneIndexByName(entity,"boot") ~= -1 then
												local Trunk = GetEntityBoneIndexByName(entity,"boot")
												local cTrunk = GetWorldPositionOfEntityBone(entity,Trunk)
												local Distance = #(coords - cTrunk)
												if Distance <= 1.25 then
													if GetVehicleDoorLockStatus(entity) == 1 then
														table.insert(Menu,{ event = "player:enterTrunk", label = "Entrar no Porta-Malas", tunnel = "client" })
													end

													table.insert(Menu,{ event = "inventory:stealTrunk", label = "Arrombar Porta-Malas", tunnel = "client" })
												end
											end
										end
									end

									if LocalPlayer["state"]["Police"] then
										table.insert(Menu,{ event = "police:runPlate", label = "Verificar Placa", tunnel = "police" })
										table.insert(Menu,{ event = "police:impound", label = "Registrar Veículo", tunnel = "police" })

										if GlobalState["vehPlates"][vehPlate] then
											table.insert(Menu,{ event = "police:runArrest", label = "Apreender Veículo", tunnel = "police" })
										end
									else
										for _,v in pairs(Exclusives) do
											local Distance = #(coords - vec3(v[1],v[2],v[3]))
											if Distance <= 10 then
												if v[4] == "Desmanche" and vehPlate == "DISM"..(1000 + LocalPlayer["state"]["Id"]) then
													table.insert(Menu,{ event = "inventory:Dismantle", label = "Desmanchar", tunnel = "police" })
												elseif v[4] == "Reboque" then
													table.insert(Menu,{ event = "towdriver:Tow", label = "Rebocar", tunnel = "client" })
													table.insert(Menu,{ event = "impound:Check", label = "Impound", tunnel = "police" })
												end
											end
										end
									end
								end
							else
								Selected[5] = false
								table.insert(Menu,{ event = "engine:Supply", label = "Abastecer", tunnel = "client" })
							end

							SendNUIMessage({ response = "validTarget", data = Menu })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords,entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					elseif IsPedAPlayer(entity) then
						if #(coords - entCoords) <= 1.0 then
							local index = NetworkGetPlayerIndexFromPed(entity)
							local source = GetPlayerServerId(index)
							local Menu = {}

							Selected = { source }

							if LocalPlayer["state"]["Police"] then
								table.insert(Menu,{ event = "police:runInspect", label = "Revistar", tunnel = "police" })
								table.insert(Menu,{ event = "police:prisonClothes", label = "Uniforme Presidiário", tunnel = "police" })
							elseif LocalPlayer["state"]["Paramedic"] then
								if GetEntityHealth(entity) <= 100 then
									table.insert(Menu,{ event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" })
								else
									table.insert(Menu,{ event = "paramedic:Treatment", label = "Tratamento", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:Repose", label = "Colocar de Repouso", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:Bandage", label = "Passar Ataduras", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:presetBurn", label = "Roupa de Queimadura", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:presetPlaster", label = "Colocar Gesso", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:extractBlood", label = "Extrair Sangue", tunnel = "paramedic" })
								end

								table.insert(Menu,{ event = "paramedic:Diagnostic", label = "Informações", tunnel = "paramedic" })
								table.insert(Menu,{ event = "paramedic:Bed", label = "Deitar Paciente", tunnel = "paramedic" })
							end

							if IsEntityPlayingAnim(entity,"random@mugging3","handsup_standing_base",3) then
								table.insert(Menu,{ event = "player:checkShoes", label = "Roubar Sapatos", tunnel = "paramedic" })
							end

							SendNUIMessage({ response = "validTarget", data = Menu })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords,entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					else
						for k,v in pairs(Models) do
							if DoesEntityExist(entity) then
								if k == GetEntityModel(entity) then
									if #(coords - entCoords) <= Models[k]["distance"] then
										local objNet = nil
										if NetworkGetEntityIsNetworked(entity) then
											objNet = ObjToNet(entity)
										end

										Selected = { entity,k,objNet,GetEntityCoords(entity) }

										SendNUIMessage({ response = "validTarget", data = Models[k]["options"] })

										Sucess = true
										while Sucess do
											local ped = PlayerPedId()
											local coords = GetEntityCoords(ped)
											local _,entCoords,entity = RayCastGamePlayCamera()

											if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
												SetCursorLocation(0.5,0.5)
												SetNuiFocus(true,true)
											end

											if GetEntityType(entity) == 0 or #(coords - entCoords) > Models[k]["distance"] then
												Sucess = false
											end

											Wait(1)
										end

										SendNUIMessage({ response = "leftTarget" })
									end
								end
							end
						end
					end
				end
			end

			Wait(100)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:RollVehicle")
AddEventHandler("target:RollVehicle",function(vehNet)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			SetVehicleOnGroundProperly(Vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
local bedAttach = false
local beds = {
	[1631638868] = { 0.0,0.0 },
	[2117668672] = { 0.0,0.0 },
	[-1498379115] = { 1.0,90.0 },
	[-1519439119] = { 1.0,0.0 },
	[-289946279] = { 1.0,0.0 },
	[-935625561] = { 0.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:animDeitar")
AddEventHandler("target:animDeitar",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 then
			local objCoords = GetEntityCoords(Selected[1])

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[Selected[2]][1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(Selected[1]) + beds[Selected[2]][2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)

			if Selected[2] == -935625561 then
				AttachEntityToEntity(ped,Selected[1],11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
				bedAttach = Selected[1]
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDPICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedPickup")
AddEventHandler("target:bedPickup",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 then
			local spawnObjects = 0
			local uObject = NetworkGetEntityFromNetworkId(Selected[3])
			local objectControl = NetworkRequestControlOfEntity(uObject)
			while not objectControl and spawnObjects <= 1000 do
				objectControl = NetworkRequestControlOfEntity(uObject)
				spawnObjects = spawnObjects + 1
				Wait(1)
			end

			AttachEntityToEntity(uObject,ped,11816,0.0,1.25,-0.15,0.0,0.0,0.0,false,false,false,false,2,true)
			bedAttach = Selected[1]
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDDETACH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedDetach")
AddEventHandler("target:bedDetach",function()
	if bedAttach then
		DetachEntity(PlayerPedId(),false,false)
		FreezeEntityPosition(bedAttach,true)
		DetachEntity(bedAttach,false,false)
		bedAttach = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedDestroy")
AddEventHandler("target:bedDestroy",function()
	if not LocalPlayer["state"]["Commands"] and LocalPlayer["state"]["Paramedic"] then
		TriggerServerEvent("tryDeleteObject",Selected[3])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PACIENTEDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:pacienteDeitar")
AddEventHandler("target:pacienteDeitar",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(coords["x"],coords["y"],coords["z"],0.9,k,0,0,0)
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + v[1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(object) + v[2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)

			if k == -935625561 then
				AttachEntityToEntity(ped,object,11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
				bedAttach = object
			end

			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[-171943901] = 0.0,
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7,
	[-853526657] = -0.1,
	[652816835] = 0.8
}

RegisterNetEvent("target:animSentar")
AddEventHandler("target:animSentar",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 then
			local objCoords = GetEntityCoords(Selected[1])

			FreezeEntityPosition(Selected[1],true)
			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[Selected[2]],1,0,0,0)
			if chairs[Selected[2]] == 0.7 then
				SetEntityHeading(ped,GetEntityHeading(Selected[1]))
			else
				SetEntityHeading(ped,GetEntityHeading(Selected[1]) - 180.0)
			end

			vRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetDisable()
	if Sucess or not LocalPlayer["state"]["Target"] then
		return
	end

	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ response = "closeTarget" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("selectTarget",function(data)
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ response = "closeTarget" })

	if data["tunnel"] == "client" then
		TriggerEvent(data["event"],Selected)
	elseif data["tunnel"] == "server" then
		TriggerServerEvent(data["event"],Selected)
	elseif data["tunnel"] == "shop" then
		TriggerEvent(data["event"],Selected)
	elseif data["tunnel"] == "shopserver" then
		TriggerServerEvent(data["event"],Selected)
	elseif data["tunnel"] == "boxes" then
		TriggerServerEvent(data["event"],Selected,data["service"])
	elseif data["tunnel"] == "paramedic" then
		TriggerServerEvent(data["event"],Selected[1])
	elseif data["tunnel"] == "police" then
		TriggerServerEvent(data["event"],Selected,data["service"])
	elseif data["tunnel"] == "products" then
		TriggerServerEvent(data["event"],data["service"])
	elseif data["tunnel"] == "objects" then
		TriggerServerEvent(data["event"],Selected[3])
	else
		TriggerServerEvent(data["event"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSETARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeTarget",function()
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:resetDebug")
AddEventHandler("target:resetDebug",function()
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local rotation = GetGameplayCamRot()
	local adjustedRotation = vec3((math.pi / 180) * rotation["x"],(math.pi / 180) * rotation["y"],(math.pi / 180) * rotation["z"])
	local direction = vec3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.sin(adjustedRotation[1]))

	return vec3(Coords[1] + direction[1] * Distance, Coords[2] + direction[2] * Distance, Coords[3] + direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera()
	local Ped = PlayerPedId()
	local Cam = GetGameplayCamCoord()
	local Cam2 = GetCoordsFromCam(10.0,Cam)
	local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,Cam2,-1,Ped,4)
	local a,Hit,Coords,b,Entity = GetShapeTestResult(Handle)

	return Hit,Coords,Entity
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(Name,Center,Radius,Options,Target)
	Zones[Name] = CircleZone:Create(Center,Radius,Options)
	Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(Name)
	if Zones[Name] then
		Zones[Name] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(Model,Options)
	for _,v in pairs(Model) do
		Models[v] = Options
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(Name,Center,Length,Width,Options,Target)
    Zones[Name] = BoxZone:Create(Center,Length,Width,Options)
    Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddBoxZone",AddBoxZone)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)