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
cRP = {}
Tunnel.bindInterface("inventory",cRP)
vPLAYER = Tunnel.getInterface("player")
vGARAGE = Tunnel.getInterface("garages")
vTASKBAR = Tunnel.getInterface("taskbar")
vDELIVER = Tunnel.getInterface("deliver")
vPARAMEDIC = Tunnel.getInterface("paramedic")
vKEYBOARD = Tunnel.getInterface("keyboard")
vSKINSHOP = Tunnel.getInterface("skinshop")
vCLIENT = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Carry = {}
local Ammos = {}
local Loots = {}
local Boxes = {}
local Active = {}
local Trashs = {}
local Armors = {}
local Plates = {}
local Trunks = {}
local Objects = {}
local Healths = {}
local Animals = {}
local Attachs = {}
local Scanners = {}
local Stockade = {}
local Megaphone = {}
local userAmount = {}

local openIdentity = {}
local verifyObjects = {}
local verifyAnimals = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
local dismantleProgress = {}
local dismantleTimer = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local tableSelect = {}
local tableList = {
	["tablecoke"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = "sulfuric", ["needAmount"] = 1 },
		[2] = { ["timer"] = 10, ["need"] = "cokeleaf", ["needAmount"] = 1 },
		[3] = { ["timer"] = 10, ["item"] = "cocaine", ["itemAmount"] = 3 }
	},
	["tablemeth"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = "saline", ["needAmount"] = 1 },
		[2] = { ["timer"] = 10, ["need"] = "acetone", ["needAmount"] = 1 },
		[3] = { ["timer"] = 10, ["item"] = "meth", ["itemAmount"] = 3 }
	},
	["tableweed"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = "silk", ["needAmount"] = 1 },
		[2] = { ["timer"] = 10, ["need"] = "weedleaf", ["needAmount"] = 1 },
		[3] = { ["timer"] = 10, ["item"] = "joint", ["itemAmount"] = 3 }
	},
	["burgershot1"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["item"] = "burgershot1", ["itemAmount"] = 1 }
	},
	["burgershot2"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["item"] = "burgershot2", ["itemAmount"] = 1 }
	},
	["burgershot3"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "burgershot2", ["amount"] = 1 },
			{ ["item"] = "burgershot1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "burgershot3", ["itemAmount"] = 1 }
	},
	["burgershot4"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "drugtoy", ["amount"] = 1 },
			{ ["item"] = "burgershot3", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "burgershot4", ["itemAmount"] = 1 }
	},
	["pizzathis1"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["item"] = "pizzathis1", ["itemAmount"] = 1 }
	},
	["pizzathis2"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["item"] = "pizzathis2", ["itemAmount"] = 1 }
	},
	["pizzathis3"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "pizzathis2", ["amount"] = 1 },
			{ ["item"] = "pizzathis1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "pizzathis3", ["itemAmount"] = 1 }
	},
	["pizzathis4"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "drugtoy", ["amount"] = 1 },
			{ ["item"] = "pizzathis3", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "pizzathis4", ["itemAmount"] = 1 }
	},
	["uwucoffee1"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["item"] = "uwucoffee1", ["itemAmount"] = 1 }
	},
	["uwucoffee2"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["item"] = "uwucoffee2", ["itemAmount"] = 1 }
	},
	["uwucoffee3"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "uwucoffee2", ["amount"] = 1 },
			{ ["item"] = "uwucoffee1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "uwucoffee3", ["itemAmount"] = 1 }
	},
	["uwucoffee4"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "drugtoy", ["amount"] = 1 },
			{ ["item"] = "uwucoffee3", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "uwucoffee4", ["itemAmount"] = 1 }
	},
	["beanmachine1"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["item"] = "beanmachine1", ["itemAmount"] = 1 }
	},
	["beanmachine2"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["item"] = "beanmachine2", ["itemAmount"] = 1 }
	},
	["beanmachine3"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "beanmachine2", ["amount"] = 1 },
			{ ["item"] = "beanmachine1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "beanmachine3", ["itemAmount"] = 1 }
	},
	["beanmachine4"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "drugtoy", ["amount"] = 1 },
			{ ["item"] = "beanmachine3", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "beanmachine4", ["itemAmount"] = 1 }
	},
	["milkBottle"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = "emptybottle", ["needAmount"] = 1,  ["item"] = "milkbottle", ["itemAmount"] = 1 }
	},
	["scanner"] = {
		[1] = { ["timer"] = 5, ["item"] = "sheetmetal", ["itemAmount"] = 1 },
		[2] = { ["timer"] = 5, ["item"] = "roadsigns", ["itemAmount"] = 1 },
		[3] = { ["timer"] = 5, ["item"] = "syringe", ["itemAmount"] = 1 },
		[4] = { ["timer"] = 5, ["item"] = "fishingrod", ["itemAmount"] = 1 },
		[5] = { ["timer"] = 5, ["item"] = "plate", ["itemAmount"] = 1 },
		[6] = { ["timer"] = 5, ["item"] = "aluminum", ["itemAmount"] = 1 },
		[7] = { ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 1 },
		[8] = { ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		[9] = { ["timer"] = 5, ["item"] = "battery", ["itemAmount"] = 1 },
		[10] = { ["timer"] = 5, ["item"] = "metalcan", ["itemAmount"] = 1 }
	},
	["cemitery"] = {
		[1] = { ["timer"] = 5, ["item"] = "silk", ["itemAmount"] = 1 },
		[2] = { ["timer"] = 5, ["item"] = "cotton", ["itemAmount"] = 1 },
		[3] = { ["timer"] = 5, ["item"] = "plaster", ["itemAmount"] = 1 },
		[4] = { ["timer"] = 5, ["item"] = "pouch", ["itemAmount"] = 1 },
		[5] = { ["timer"] = 5, ["item"] = "switchblade", ["itemAmount"] = 1 },
		[6] = { ["timer"] = 5, ["item"] = "joint", ["itemAmount"] = 1 },
		[7] = { ["timer"] = 5, ["item"] = "weedclone", ["itemAmount"] = 1 },
		[8] = { ["timer"] = 5, ["item"] = "cokeseed", ["itemAmount"] = 1 },
		[9] = { ["timer"] = 5, ["item"] = "acetone", ["itemAmount"] = 1 },
		[10] = { ["timer"] = 5, ["item"] = "water", ["itemAmount"] = 1 },
		[11] = { ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 1 },
		[12] = { ["timer"] = 5, ["item"] = "cigarette", ["itemAmount"] = 1 },
		[13] = { ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		[14] = { ["timer"] = 5, ["item"] = "dollars", ["itemAmount"] = 1 },
		[15] = { ["timer"] = 5, ["item"] = "elastic", ["itemAmount"] = 1 },
		[16] = { ["timer"] = 5, ["item"] = "rose", ["itemAmount"] = 1 },
		[17] = { ["timer"] = 5, ["item"] = "teddy", ["itemAmount"] = 1 },
		[18] = { ["timer"] = 5, ["item"] = "binoculars", ["itemAmount"] = 1 },
		[19] = { ["timer"] = 5, ["item"] = "camera", ["itemAmount"] = 1 },
		[20] = { ["timer"] = 5, ["item"] = "silverring", ["itemAmount"] = 1 },
		[21] = { ["timer"] = 5, ["item"] = "goldring", ["itemAmount"] = 1 },
		[22] = { ["timer"] = 5, ["item"] = "silvercoin", ["itemAmount"] = 1 },
		[23] = { ["timer"] = 5, ["item"] = "goldcoin", ["itemAmount"] = 1 },
		[24] = { ["timer"] = 5, ["item"] = "watch", ["itemAmount"] = 1 },
		[25] = { ["timer"] = 5, ["item"] = "bracelet", ["itemAmount"] = 1 },
		[26] = { ["timer"] = 5, ["item"] = "dices", ["itemAmount"] = 1 },
		[27] = { ["timer"] = 5, ["item"] = "cup", ["itemAmount"] = 1 },
		[28] = { ["timer"] = 5, ["item"] = "slipper", ["itemAmount"] = 1 }
	},
	["fishfillet"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 20, ["need"] = "fishfillet", ["needAmount"] = 1, ["item"] = "cookedfishfillet", ["itemAmount"] = 1 }
	},
	["marshmallow"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 20, ["need"] = "sugar", ["needAmount"] = 4, ["item"] = "marshmallow", ["itemAmount"] = 1 }
	},
	["animalmeat"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 20, ["need"] = "meat", ["needAmount"] = 1,  ["item"] = "cookedmeat", ["itemAmount"] = 1 }
	},
	["emptybottle"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 3, ["need"] = "emptybottle", ["needAmount"] = 1,  ["item"] = "water", ["itemAmount"] = 1 }
	},
	["dollars100"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = "dollarsroll", ["needAmount"] = 100, ["item"] = "dollars100", ["itemAmount"] = 1 }
	},
	["dollars500"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = "dollarsroll", ["needAmount"] = 500, ["item"] = "dollars500", ["itemAmount"] = 1 }
	},
	["dollars1000"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["need"] = "dollarsroll", ["needAmount"] = 1000, ["item"] = "dollars1000", ["itemAmount"] = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local stealItens = {
	[1] = { ["item"] = "pendrive", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[2] = { ["item"] = "slipper", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[3] = { ["item"] = "soap", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[4] = { ["item"] = "pliers", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[5] = { ["item"] = "deck", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[6] = { ["item"] = "floppy", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[7] = { ["item"] = "domino", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[8] = { ["item"] = "brush", ["min"] = 1, ["max"] = 4, ["rand"] = 225 },
	[9] = { ["item"] = "rimel", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	[10] = { ["item"] = "WEAPON_SHOES", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[11] = { ["item"] = "dices", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	[12] = { ["item"] = "spray04", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[13] = { ["item"] = "spray03", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[14] = { ["item"] = "spray02", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[15] = { ["item"] = "spray01", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[16] = { ["item"] = "bracelet", ["min"] = 2, ["max"] = 4, ["rand"] = 200 },
	[17] = { ["item"] = "xbox", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[18] = { ["item"] = "playstation", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[19] = { ["item"] = "watch", ["min"] = 2, ["max"] = 3, ["rand"] = 200 },
	[20] = { ["item"] = "goldcoin", ["min"] = 4, ["max"] = 6, ["rand"] = 175 },
	[21] = { ["item"] = "silvercoin", ["min"] = 4, ["max"] = 8, ["rand"] = 175 },
	[22] = { ["item"] = "goldring", ["min"] = 1, ["max"] = 2, ["rand"] = 175 },
	[23] = { ["item"] = "silverring", ["min"] = 1, ["max"] = 2, ["rand"] = 175 },
	[24] = { ["item"] = "oxy", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[25] = { ["item"] = "analgesic", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	[26] = { ["item"] = "firecracker", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[27] = { ["item"] = "pager", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[28] = { ["item"] = "GADGET_PARACHUTE", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[29] = { ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 1, ["rand"] = 50 },
	[30] = { ["item"] = "WEAPON_WRENCH", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[31] = { ["item"] = "WEAPON_POOLCUE", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[32] = { ["item"] = "WEAPON_BAT", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[33] = { ["item"] = "notebook", ["min"] = 1, ["max"] = 1, ["rand"] = 75 },
	[34] = { ["item"] = "camera", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[35] = { ["item"] = "binoculars", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[36] = { ["item"] = "hennessy", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[37] = { ["item"] = "dewars", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[38] = { ["item"] = "teddy", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	[39] = { ["item"] = "chocolate", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[40] = { ["item"] = "lighter", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	[41] = { ["item"] = "divingsuit", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[42] = { ["item"] = "cellphone", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[43] = { ["item"] = "tyres", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[44] = { ["item"] = "notepad", ["min"] = 1, ["max"] = 5, ["rand"] = 225 },
	[45] = { ["item"] = "plate", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[46] = { ["item"] = "emptybottle", ["min"] = 2, ["max"] = 5, ["rand"] = 225 },
	[47] = { ["item"] = "bait", ["min"] = 1, ["max"] = 6, ["rand"] = 225 },
	[48] = { ["item"] = "switchblade", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[49] = { ["item"] = "card01", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	[50] = { ["item"] = "card02", ["min"] = 1, ["max"] = 1, ["rand"] = 200 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local lootItens = {
	["Medic"] = {
		["null"] = 75,
		["cooldown"] = 3600,
		["list"] = {
			[1] = { ["item"] = "alcohol", ["min"] = 1, ["max"] = 3 },
			[2] = { ["item"] = "syringe", ["min"] = 1, ["max"] = 3 },
			[3] = { ["item"] = "codeine", ["min"] = 1, ["max"] = 3 },
			[4] = { ["item"] = "amphetamine", ["min"] = 1, ["max"] = 3 },
			[5] = { ["item"] = "acetone", ["min"] = 1, ["max"] = 3 },
			[6] = { ["item"] = "cotton", ["min"] = 1, ["max"] = 3 },
			[7] = { ["item"] = "plaster", ["min"] = 1, ["max"] = 3 },
			[8] = { ["item"] = "saline", ["min"] = 1, ["max"] = 3 },
			[9] = { ["item"] = "sulfuric", ["min"] = 1, ["max"] = 3 }
		}
	},
	["Weapons"] = {
		["null"] = 50,
		["cooldown"] = 7200,
		["list"] = {
			[1] = { ["item"] = "roadsigns", ["min"] = 1, ["max"] = 1 },
			[2] = { ["item"] = "techtrash", ["min"] = 1, ["max"] = 1 },
			[3] = { ["item"] = "pistolbody", ["min"] = 1, ["max"] = 1 },
			[4] = { ["item"] = "smgbody", ["min"] = 1, ["max"] = 1 },
			[5] = { ["item"] = "riflebody", ["min"] = 1, ["max"] = 1 },
			[6] = { ["item"] = "sheetmetal", ["min"] = 1, ["max"] = 2 },
			[7] = { ["item"] = "explosives", ["min"] = 1, ["max"] = 2 },
			[8] = { ["item"] = "aluminum", ["min"] = 2, ["max"] = 3 },
			[9] = { ["item"] = "copper", ["min"] = 2, ["max"] = 3 },
			[10] = { ["item"] = "nitro", ["min"] = 1, ["max"] = 1 }
		}
	},
	["Supplies"] = {
		["null"] = 75,
		["cooldown"] = 3600,
		["list"] = {
			[1] = { ["item"] = "tarp", ["min"] = 1, ["max"] = 1 },
			[2] = { ["item"] = "sheetmetal", ["min"] = 1, ["max"] = 1 },
			[3] = { ["item"] = "roadsigns", ["min"] = 1, ["max"] = 1 },
			[4] = { ["item"] = "leather", ["min"] = 1, ["max"] = 3 },
			[5] = { ["item"] = "animalfat", ["min"] = 1, ["max"] = 2 },
			[6] = { ["item"] = "cotton", ["min"] = 1, ["max"] = 2 },
			[7] = { ["item"] = "plaster", ["min"] = 1, ["max"] = 2 },
			[8] = { ["item"] = "sulfuric", ["min"] = 1, ["max"] = 2 },
			[9] = { ["item"] = "saline", ["min"] = 1, ["max"] = 2 },
			[10] = { ["item"] = "alcohol", ["min"] = 1, ["max"] = 2 },
			[11] = { ["item"] = "syringe", ["min"] = 2, ["max"] = 3 },
			[12] = { ["item"] = "card01", ["min"] = 1, ["max"] = 1 },
			[13] = { ["item"] = "weedclone", ["min"] = 2, ["max"] = 3 },
			[14] = { ["item"] = "cokeseed", ["min"] = 2, ["max"] = 3 },
			[15] = { ["item"] = "silk", ["min"] = 1, ["max"] = 3 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myInventory = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			if (parseInt(v["amount"]) <= 0 or itemBody(v["item"]) == nil) then
				vRP.removeInventoryItem(user_id,v["item"],parseInt(v["amount"]),false)
			else
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
						v["serial"] = splitName[3]
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
		end

		return myInventory,vRP.inventoryWeight(user_id),vRP.getWeight(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.invUpdate(Slot,Target,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.invUpdate(user_id,Slot,Target,Amount) then
			TriggerClientEvent("inventory:Update",source,"updateMochila")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BADGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Badges")
AddEventHandler("inventory:Badges",function(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local Inventory = vRP.userInventory(user_id)
		if Inventory then
			for k,v in pairs(Inventory) do
				if string.sub(v["item"],1,5) == "badge" then
					local Amount = 1
					local Item = v["item"]

					if vRP.tryGetInventoryItem(user_id,Item,Amount,false,k) then
						local Days = 1
						local Number = 0
						local Durability = 0
						local splitName = splitString(Item,"-")

						repeat
							Number = Number + 1
						until Drops[tostring(Number)] == nil

						if splitName[2] ~= nil then
							if itemDurability(Item) then
								Durability = parseInt(os.time() - splitName[2])
								Days = itemDurability(Item)
							else
								Durability = 0
								Days = 1
							end
						else
							Durability = 0
							Days = 1
						end

						Drops[tostring(Number)] = {
							["key"] = Item,
							["amount"] = Amount,
							["coords"] = { x,y,z },
							["name"] = itemName(Item),
							["peso"] = itemWeight(Item),
							["index"] = itemIndex(Item),
							["days"] = Days,
							["durability"] = Durability
						}

						TriggerEvent("discordLogs","Badges","O passaporte **"..user_id.."** deixou sua badge cair.",3092790)
						TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])
						TriggerClientEvent("inventory:Update",source,"updateMochila")

						break
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drops")
AddEventHandler("inventory:Drops",function(Item,Slot,Amount,x,y,z)
	local source = source
	local Slot = tostring(Slot)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] == nil and not vPLAYER.getHandcuff(source) and not exports["hud"]:Wanted(user_id) and not vRPC.inVehicle(source) then
			if vRP.tryGetInventoryItem(user_id,Item,Amount,false,Slot) then
				local Days = 1
				local Number = 0
				local Durability = 0
				local splitName = splitString(Item,"-")

				repeat
					Number = Number + 1
				until Drops[tostring(Number)] == nil

				if splitName[2] ~= nil then
					if itemDurability(Item) then
						Durability = parseInt(os.time() - splitName[2])
						Days = itemDurability(Item)
					else
						Durability = 0
						Days = 1
					end
				else
					Durability = 0
					Days = 1
				end

				Drops[tostring(Number)] = {
					["key"] = Item,
					["amount"] = Amount,
					["coords"] = { x,y,z },
					["name"] = itemName(Item),
					["peso"] = itemWeight(Item),
					["index"] = itemIndex(Item),
					["days"] = Days,
					["durability"] = Durability
				}

				TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			end
		else
			TriggerClientEvent("inventory:Update",source,"updateMochila")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Pickup")
AddEventHandler("inventory:Pickup",function(Number,Amount,Slot)
	local source = source
	local Slot = tostring(Slot)
	local Number = tostring(Number)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] == nil then
			if Drops[Number] == nil then
				TriggerClientEvent("inventory:Update",source,"updateMochila")
				return
			else
				if (vRP.inventoryWeight(user_id) + (itemWeight(Drops[Number]["key"]) * Amount)) <= vRP.getWeight(user_id) then
					if Drops[Number] == nil or Drops[Number]["amount"] < Amount then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						return
					end

					if vRP.checkMaxItens(user_id,Drops[Number]["key"],Amount) then
						TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						return
					end

					if Drops[Number] then
						local inventory = vRP.userInventory(user_id)
						if inventory[Slot] and Drops[Number]["key"] then
							if inventory[Slot]["item"] == Drops[Number]["key"] then
								vRP.giveInventoryItem(user_id,Drops[Number]["key"],Amount,false,Slot)
							else
								vRP.giveInventoryItem(user_id,Drops[Number]["key"],Amount,false)
							end
						else
							if Drops[Number] then
								vRP.giveInventoryItem(user_id,Drops[Number]["key"],Amount,false,Slot)
							end
						end

						Drops[Number]["amount"] = Drops[Number]["amount"] - Amount
						if Drops[Number]["amount"] <= 0 then
							TriggerClientEvent("drops:Remover",-1,Number)
							Drops[Number] = nil
						else
							TriggerClientEvent("drops:Atualizar",-1,Number,Drops[Number]["amount"])
						end

						TriggerClientEvent("inventory:Update",source,"updateMochila")
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				end
			end
		else
			TriggerClientEvent("inventory:Update",source,"updateMochila")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:sendItem")
AddEventHandler("inventory:sendItem",function(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local Player = vRPC.ClosestPed(source,0.8)
		if Player then
			Active[user_id] = os.time() + 100

			local inventory = vRP.userInventory(user_id)
			if not inventory[Slot] or inventory[Slot]["item"] == nil then
				Active[user_id] = nil
				return
			end

			if Amount == 0 then Amount = 1 end
			local Item = inventory[Slot]["item"]

			local nuser_id = vRP.getUserId(Player)
			if not vRP.checkMaxItens(nuser_id,Item,Amount) then
				if not vRP.checkBroken(Item) then
					if (vRP.inventoryWeight(nuser_id) + itemWeight(Item) * Amount) <= vRP.getWeight(nuser_id) then
						if vRP.tryGetInventoryItem(user_id,Item,Amount,true,Slot) then
							vRPC.createObjects(source,"mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)

							Wait(3000)

							vRP.giveInventoryItem(nuser_id,Item,Amount,true)
							TriggerClientEvent("inventory:Update",source,"updateMochila")
							TriggerClientEvent("inventory:Update",Player,"updateMochila")
							vRPC.removeObjects(source)
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(Item).."</b> quebrado.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			end

			Active[user_id] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Deliver")
AddEventHandler("inventory:Deliver",function(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local user_id = vRP.getUserId(source)
	if user_id then
		local inventory = vRP.userInventory(user_id)
		if not inventory[Slot] or inventory[Slot]["item"] == nil then
			return
		end

		if Amount == 0 then Amount = 1 end
		local splitName = splitString(inventory[Slot]["item"],"-")
		local totalName = inventory[Slot]["item"]
		local nameItem = splitName[1]

		if nameItem == "newspaper" then
			if not vRPC.lastVehicle(source,"bmx") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo <b>BMX</b>.",3000)
				return
			end

			if exports["propertys"]:initNewspapers(source) then
				vRP.generateItem(user_id,"dollars",60,true)

				if vRP.userPremium(user_id) then
					vRP.generateItem(user_id,"dollars",6,true)
				end

				vRP.removeInventoryItem(user_id,totalName,1,true)
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			end
		return end

		if nameItem == "burgershot3" or nameItem == "burgershot4" or nameItem == "dollars100" or nameItem == "dollars500" or nameItem == "dollars1000" then
			if vDELIVER.Deliver(source,"BurgerShot") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					if nameItem == "burgershot3" then
						vRP.generateItem(user_id,"dollars",120,true)

						local burgershotReputation = vRP.checkReputation(user_id,"BurgerShot")
						if burgershotReputation >= 100 or vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",12,true)
						end

						if burgershotReputation <= 1001 then
							vRP.insertReputation(user_id,"BurgerShot",10)
						end
					elseif nameItem == "burgershot4" then
						vRP.generateItem(user_id,"dollars",270,true)

						local burgershotReputation = vRP.checkReputation(user_id,"BurgerShot")
						if burgershotReputation >= 100 or vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",27,true)
						end

						if burgershotReputation <= 1001 then
							vRP.insertReputation(user_id,"BurgerShot",10)
						end
					elseif nameItem == "dollars100" then
						vRP.generateItem(user_id,"dollars",math.random(90,100),true)
					elseif nameItem == "dollars500" then
						vRP.generateItem(user_id,"dollars",math.random(400,500),true)
					elseif nameItem == "dollars1000" then
						vRP.generateItem(user_id,"dollars",math.random(900,1000),true)
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
		
		if nameItem == "pizzathis3" or nameItem == "pizzathis4" or nameItem == "dollars100" or nameItem == "dollars500" or nameItem == "dollars1000" then
			if vDELIVER.Deliver(source,"PizzaThis") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					if nameItem == "pizzathis3" then
						vRP.generateItem(user_id,"dollars",120,true)

						local pizzathisReputation = vRP.checkReputation(user_id,"PizzaThis")
						if pizzathisReputation >= 100 or vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",12,true)
						end

						if pizzathisReputation <= 1001 then
							vRP.insertReputation(user_id,"PizzaThis",10)
						end
					elseif nameItem == "pizzathis4" then
						vRP.generateItem(user_id,"dollars",270,true)

						local pizzathisReputation = vRP.checkReputation(user_id,"PizzaThis")
						if pizzathisReputation >= 100 or vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",27,true)
						end

						if pizzathisReputation <= 1001 then
							vRP.insertReputation(user_id,"PizzaThis",10)
						end
					elseif nameItem == "dollars100" then
						vRP.generateItem(user_id,"dollars",math.random(90,100),true)
					elseif nameItem == "dollars500" then
						vRP.generateItem(user_id,"dollars",math.random(400,500),true)
					elseif nameItem == "dollars1000" then
						vRP.generateItem(user_id,"dollars",math.random(900,1000),true)
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
		
		if nameItem == "uwucoffee3" or nameItem == "uwucoffee4" or nameItem == "dollars100" or nameItem == "dollars500" or nameItem == "dollars1000" then
			if vDELIVER.Deliver(source,"UwuCoffee") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					if nameItem == "uwucoffee3" then
						vRP.generateItem(user_id,"dollars",120,true)
						
						local uwucoffeeReputation = vRP.checkReputation(user_id,"UwuCoffee")
						if uwucoffeeReputation >= 100 or vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",12,true)
						end

						if uwucoffeeReputation <= 1001 then
							vRP.insertReputation(user_id,"UwuCoffee",10)
						end
					elseif nameItem == "uwucoffee4" then
						vRP.generateItem(user_id,"dollars",270,true)

						local uwucoffeeReputation = vRP.checkReputation(user_id,"UwuCoffee")
						if uwucoffeeReputation >= 100 or vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",27,true)
						end

						if uwucoffeeReputation <= 1001 then
							vRP.insertReputation(user_id,"UwuCoffee",10)
						end
					elseif nameItem == "dollars100" then
						vRP.generateItem(user_id,"dollars",math.random(90,100),true)
					elseif nameItem == "dollars500" then
						vRP.generateItem(user_id,"dollars",math.random(400,500),true)
					elseif nameItem == "dollars1000" then
						vRP.generateItem(user_id,"dollars",math.random(900,1000),true)
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
		
		if nameItem == "beanmachine3" or nameItem == "beanmachine4" or nameItem == "dollars100" or nameItem == "dollars500" or nameItem == "dollars1000" then
			if vDELIVER.Deliver(source,"BeanMachine") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					if nameItem == "beanmachine3" then
						vRP.generateItem(user_id,"dollars",120,true)

						local beanmachineReputation = vRP.checkReputation(user_id,"BeanMachine")
						if beanmachineReputation >= 100 or vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",12,true)
						end

						if beanmachineReputation <= 1001 then
							vRP.insertReputation(user_id,"BeanMachine",10)
						end
					elseif nameItem == "beanmachine4" then
						vRP.generateItem(user_id,"dollars",270,true)

						local beanmachineReputation = vRP.checkReputation(user_id,"BeanMachine")
						if beanmachineReputation >= 100 or vRP.userPremium(user_id) then
							vRP.generateItem(user_id,"dollars",27,true)
						end

						if beanmachineReputation <= 1001 then
							vRP.insertReputation(user_id,"BeanMachine",10)
						end
					elseif nameItem == "dollars100" then
						vRP.generateItem(user_id,"dollars",math.random(90,100),true)
					elseif nameItem == "dollars500" then
						vRP.generateItem(user_id,"dollars",math.random(400,500),true)
					elseif nameItem == "dollars1000" then
						vRP.generateItem(user_id,"dollars",math.random(900,1000),true)
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
		
		if nameItem == "woodlog" then
			if vDELIVER.Deliver(source,"Lumberman") then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					vDELIVER.Update(source)

					vRP.generateItem(user_id,"dollars",120,true)

					local lumbermanReputation = vRP.checkReputation(user_id,"Lumberman")
					if lumbermanReputation >= 100 or vRP.userPremium(user_id) then
						vRP.generateItem(user_id,"dollars",12,true)
					end

					if lumbermanReputation <= 1001 then
						vRP.insertReputation(user_id,"Lumberman",10)
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:useItem")
AddEventHandler("inventory:useItem",function(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		if Amount == 0 then Amount = 1 end
		local inventory = vRP.userInventory(user_id)
		if not inventory[Slot] or inventory[Slot]["item"] == nil then
			return
		end

		local splitName = splitString(inventory[Slot]["item"],"-")
		local totalName = inventory[Slot]["item"]
		local nameItem = splitName[1]

		if itemDurability(totalName) then
			if vRP.checkBroken(totalName) then
				TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(nameItem).."</b> quebrado.",5000)
				return
			end
		end

		if vCLIENT.checkWater(source) and nameItem ~= "soap" then
			return
		end

		if vPLAYER.getHandcuff(source) and nameItem ~= "lockpick" then
			return
		end

		if itemType(totalName) == "Throwing" then
			if vRPC.inVehicle(source) then
				if not itemVehicle(totalName) then
					return
				end
			end

			local checkWeapon = vCLIENT.returnWeapon(source)
			if checkWeapon then
				local weaponStatus,weaponAmmo,hashItem = vCLIENT.storeWeaponHands(source)
				if weaponStatus then
					TriggerClientEvent("itensNotify",source,{ "guardou",itemIndex(hashItem),1,itemName(hashItem) })
				end
			else
				local consultItem = vRP.getInventoryItemAmount(user_id,nameItem)
				if consultItem[1] <= 0 then
					return
				end

				if vCLIENT.putWeaponHands(source,nameItem,1) then
					TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
					TriggerClientEvent("inventory:throwableWeapons",source,nameItem)
				end
			end
		return end

		if itemType(totalName) == "Armamento" then
			if vRPC.inVehicle(source) then
				if not itemVehicle(totalName) then
					return
				end
			end

			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				local weaponStatus,weaponAmmo,hashItem = vCLIENT.storeWeaponHands(source)

				if weaponStatus then
					local wHash = itemAmmo(hashItem)
					if wHash ~= nil then
						Ammos[user_id][wHash] = parseInt(weaponAmmo)
					end

					TriggerClientEvent("itensNotify",source,{ "guardou",itemIndex(hashItem),1,itemName(hashItem) })
				end
			else
				local wHash = itemAmmo(nameItem)
				if wHash ~= nil then
					if Ammos[user_id][wHash] == nil then
						Ammos[user_id][wHash] = 0
					end
				end

				if vCLIENT.putWeaponHands(source,nameItem,Ammos[user_id][wHash] or 0,Attachs[user_id][nameItem] or nil) then
					TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
					TriggerClientEvent("inventory:RemoveWeapon",nameItem)
					-- print(nameItem)
				end
			end
		return end

		if itemType(totalName) == "Munição" then
			local returnWeapon,weaponHash,weaponAmmo = vCLIENT.rechargeCheck(source,nameItem)

			if returnWeapon then
				if nameItem ~= itemAmmo(weaponHash) then
					return
				end

				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					Ammos[user_id][nameItem] = parseInt(weaponAmmo) + Amount

					TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),Amount,itemName(totalName) })
					vCLIENT.rechargeWeapon(source,weaponHash,Ammos[user_id][nameItem])
					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		return end

		if nameItem == "attachsFlashlight" or nameItem == "attachsCrosshair" or nameItem == "attachsSilencer" or nameItem == "attachsGrip" or nameItem == "attachsMagazine" then
			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				if Attachs[user_id][returnWeapon] == nil then
					Attachs[user_id][returnWeapon] = {}
				end

				if Attachs[user_id][returnWeapon][nameItem] == nil then
					local checkAttachs = vCLIENT.checkAttachs(source,nameItem,returnWeapon)
					if checkAttachs then
						if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
							TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
							TriggerClientEvent("inventory:Update",source,"updateMochila")
							vCLIENT.putAttachs(source,nameItem,returnWeapon)
							Attachs[user_id][returnWeapon][nameItem] = true
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","O armamento não possui suporte ao componente.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","O armamento já possui o componente equipado.",5000)
				end
			end
		return end

		if itemType(totalName) == "Usável" or itemType(totalName) == "Animal" then
			if nameItem == "backschool" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"101-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"101")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backcamping" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"102-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"102")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backcyclist" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"103-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"103")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backalohomorawhite" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"104-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"104")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backalohomorablack" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"104-1")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"104")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backalohomorared" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"104-2")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"104")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backrudolphpurple" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"105-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"105")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backrudolphred" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"105-1")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"105")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backtwitch" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"106-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"106")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backpolice" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"107-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"107")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "backwar" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"108-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"108")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "vehkey" then
				local vehicle,vehNet,vehPlate = vRPC.vehList(source,5)
				if vehicle then
					if vehPlate == splitName[2] then
						TriggerEvent("garages:keyVehicle",source,vehNet)
					end
				end
			return end

			if nameItem == "newchars" then
				if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
					vRP.upgradeChars(user_id)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					TriggerClientEvent("Notify",source,"verde","Personagem liberado.",5000)
				end
			return end

			if nameItem == "wheelchair" then
				local plateVehicle = "WCH"..math.random(10000,99999)
				TriggerEvent("plateEveryone",plateVehicle)
				vCLIENT.wheelChair(source,plateVehicle)
			return end

			if nameItem == "defibrillator" then
				local backpack = vRP.query("characters/getUsers",{ id = user_id })
				if backpack[1]["backpack"] == 0 then
					TriggerClientEvent("skinshop:toggleBackpack",source,"100-0")
					vRP.execute("characters/updateBackpack",{ backpack = 1, id = user_id })
				else
					TriggerClientEvent("skinshop:removeBackpack",source,"100")
					vRP.execute("characters/updateBackpack",{ backpack = 0, id = user_id })
				end
				
				TriggerClientEvent("inventory:Update",source,"updateMochila")
			return end

			if nameItem == "gemstone" then
				if vRP.tryGetInventoryItem(user_id,totalName,Amount,false,Slot) then
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.upgradeGemstone(user_id,Amount)
				end
			return end

			if nameItem == "rottweiler" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_rottweiler")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "husky" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_husky")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "shepherd" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_shepherd")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "retriever" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_retriever")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "poodle" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_poodle")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "pug" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_pug")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "westy" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_westy")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "cat" then
				TriggerClientEvent("dynamic:animalSpawn",source,"a_c_cat_01")
				vRPC.playAnim(source,true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
			return end

			if nameItem == "dismantle" then
				TriggerClientEvent("inventory:Close",source)
				if not vCLIENT.DismantleStatus(source) then
					local reputationValue = vRP.checkReputation(user_id,"Dismantle")
					if reputationValue >= 100 then
						vCLIENT.Dismantle(source,reputationValue)
					else
						vCLIENT.Dismantle(source,math.random(99))
					end

					vRP.removeInventoryItem(user_id,"dismantle",1,true)
				end
			return end

			if string.sub(nameItem,1,5) == "badge" then
				if openIdentity[user_id] then
					TriggerClientEvent("vRP:Identity",source)
					openIdentity[user_id] = nil
					vRPC.removeObjects(source)
				else
					local userIdentity = parseInt(splitName[2])
					local identity = vRP.userIdentity(userIdentity)
					if identity then
						openIdentity[user_id] = true
						TriggerClientEvent("inventory:Close",source)

						if nameItem == "badge02" then
							vRPC.createObjects(source,"paper_1_rcm_alt1-8","player_one_dual-8","prop_medic_badge",49,28422,0.065,0.029,-0.035,80.0,-1.90,75.0)
						else
							vRPC.createObjects(source,"paper_1_rcm_alt1-8","player_one_dual-8","prop_police_badge",49,28422,0.065,0.029,-0.035,80.0,-1.90,75.0)
						end

						TriggerClientEvent("vRP:Identity",source,{ mode = "fidentity", nome = identity["name"].." "..identity["name2"], porte = identity["port"], sangue = bloodTypes(identity["blood"]) })
					end
				end
			return end

			if nameItem == "fidentity" then
				if openIdentity[user_id] then
					TriggerClientEvent("vRP:Identity",source)
					openIdentity[user_id] = nil
				else
					local numberIdentity = parseInt(splitName[2])
					local identity = vRP.falseIdentity(numberIdentity)
					if identity then
						openIdentity[user_id] = true
						TriggerClientEvent("vRP:Identity",source,{ mode = "fidentity", nome = identity["name"].." "..identity["name2"], porte = identity["port"], sangue = bloodTypes(identity["blood"]) })
					end
				end
			return end

			if nameItem == "identity" then
				if openIdentity[user_id] then
					TriggerClientEvent("vRP:Identity",source)
					openIdentity[user_id] = nil
				else
					local numberIdentity = parseInt(splitName[2])
					local identity = vRP.userIdentity(numberIdentity)
					if identity then
						openIdentity[user_id] = true
						if numberIdentity == user_id then
							local premium = "Não"
							if identity["premium"] > os.time() then
								premium = minimalTimers(identity["premium"] - os.time())
							end

							TriggerClientEvent("vRP:Identity",source,{ mode = "identity", nome = identity["name"].." "..identity["name2"], veiculos = identity["garage"], gemas = vRP.userGemstone(identity["steam"]), porte = identity["port"], premium = premium, sangue = bloodTypes(identity["blood"]) })
						else
							TriggerClientEvent("vRP:Identity",source,{ mode = "fidentity", nome = identity["name"].." "..identity["name2"], porte = identity["port"], sangue = bloodTypes(identity["blood"]) })
						end
					end
				end
			return end

			if nameItem == "namechange" then
				TriggerClientEvent("inventory:Close",source)

				local changeName = vKEYBOARD.keyDouble(source,"Nome:","Sobrenome:")
				if not changeName then
					return
				end

				if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
					TriggerClientEvent("Notify",source,"verde","Passaporte atualizado.",5000)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.upgradeNames(user_id,changeName[1],changeName[2])
				end
			return end

			if nameItem == "chip" then
				TriggerClientEvent("inventory:Close",source)

				local newNumber = vKEYBOARD.keyDouble(source,"Três primeiros digitos:","Três ultimos digitos")
				if not newNumber then
					return
				end

				local initCheck = sanitizeString(newNumber[1],"0123456789",true)
				local finiCheck = sanitizeString(newNumber[2],"0123456789",true)

				if string.len(initCheck) == 3 and string.len(finiCheck) == 3 then
					local newPhone = newNumber[1].."-"..newNumber[2]
					if not vRP.userPhone(newPhone) then
						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("Notify",source,"verde","Telefone atualizado.",5000)
							TriggerEvent("smartphone:updatePhoneNumber",user_id,newPhone)
							vRP.upgradePhone(user_id,newPhone)
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","Número escolhido já possui um proprietário.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","O número telefônico deve conter 6 dígitos e somente números.",5000)
				end
			return end

			if nameItem == "dices" then
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,1750)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"anim@mp_player_intcelebrationmale@wank","wank"},true)

				Wait(1750)

				Active[user_id] = nil
				vRPC.stopAnim(source,false)
				TriggerClientEvent("inventory:Buttons",source,false)

				local Dice = math.random(6)
				local Players = vRPC.Players(source)
				for _,v in ipairs(Players) do
					async(function()
						TriggerClientEvent("showme:pressMe",v,source,"<img src='images/"..Dice..".png'>",10,true)
					end)
				end
			return end

			if nameItem == "deck" then
				TriggerClientEvent("inventory:Close",source)

				local card = math.random(13)
				local cards = { "A","2","3","4","5","6","7","8","9","10","J","Q","K" }

				local naipe = math.random(4)
				local naipes = { "de paus","de espada","de ouros","de copas" }

				local identity = vRP.userIdentity(user_id)
				TriggerClientEvent("chatME",source,"^5CARTAS^9"..identity["name"].." "..identity["name2"].."^0 tirou "..cards[card].." "..naipes[naipe].." do baralho.")

				local players = vRPC.ClosestPeds(source,5)
				for _,v in pairs(players) do
					TriggerClientEvent("chatME",v[2],"^5CARTAS^9"..identity["name"].." "..identity["name2"].."^0 tirou "..cards[card]..naipes[naipe].." do baralho.")
				end
			return end

			if nameItem == "bandage" then
				if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
					if vRP.getHealth(source) > 100 and vRP.getHealth(source) < 200 then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									TriggerClientEvent("sounds:source",source,"bandage",0.5)
									Healths[user_id] = os.time() + 60
									vRP.upgradeStress(user_id,3)
									vRPC.updateHealth(source,15)
								end
							end

							Wait(100)
						until Active[user_id] == nil
					else
						TriggerClientEvent("Notify",source,"amarelo","Não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				else
					local healTimers = parseInt(Healths[user_id] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..healTimers.." segundos</b>.",5000)
				end
			return end

			if nameItem == "sulfuric" then
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress",source,3000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_suicide","pill"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRPC.downHealth(source,100)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "analgesic" or nameItem == "oxy" then
				if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
					if vRP.getHealth(source) > 100 and vRP.getHealth(source) < 200 then
						Active[user_id] = os.time() + 3
						TriggerClientEvent("Progress",source,3000)
						TriggerClientEvent("inventory:Close",source)
						vRPC.playAnim(source,true,{"mp_suicide","pill"},true)
						TriggerClientEvent("inventory:Buttons",source,true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									Healths[user_id] = os.time() + 30
									vRP.upgradeStress(user_id,2)
									vRPC.updateHealth(source,8)
								end
							end

							Wait(100)
						until Active[user_id] == nil
					else
						TriggerClientEvent("Notify",source,"azul","Não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				else
					local healTimers = parseInt(Healths[user_id] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..healTimers.." segundos</b>.",5000)
				end
			return end

			if nameItem == "soap" then
				if vPLAYER.checkSoap(source) then
					Active[user_id] = os.time() + 20
					TriggerClientEvent("Progress",source,20000)
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)
					vRPC.playAnim(source,false,{"amb@world_human_bum_wash@male@high@base","base"},true)

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.removeObjects(source)
							TriggerClientEvent("inventory:Buttons",source,false)

							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								vPLAYER.cleanResidual(source)
							end
						end

						Wait(100)
					until Active[user_id] == nil
				end
			return end

			if nameItem == "joint" then
				local consultItem = vRP.getInventoryItemAmount(user_id,"lighter")
				if consultItem[1] <= 0 then
					return
				end

				Active[user_id] = os.time() + 30
				TriggerClientEvent("Progress",source,30000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.weedTimer(user_id,1)
							vRP.downgradeHunger(user_id,5)
							vRP.downgradeThirst(user_id,5)
							vRP.downgradeStress(user_id,20)
							vPLAYER.movementClip(source,"move_m@shadyped@a")
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cocaine" then
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.chemicalTimer(user_id,10)
							TriggerClientEvent("setCocaine",source)
							TriggerClientEvent("setEnergetic",source,15,1.20)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "meth" then
				if Armors[user_id] then
					if os.time() < Armors[user_id] then
						local armorTimers = parseInt(Armors[user_id] - os.time())
						TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..armorTimers.." segundos</b>.",5000)
						return
					end
				end

				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setMeth",source)
							Armors[user_id] = os.time() + 60
							vRP.chemicalTimer(user_id,10)
							vRP.setArmour(source,10)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cigarette" then
				local consultItem = vRP.getInventoryItemAmount(user_id,"lighter")
				if consultItem[1] <= 0 then
					return
				end

				Active[user_id] = os.time() + 60
				TriggerClientEvent("Progress",source,60000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,15)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "vape" then
				Active[user_id] = os.time() + 30
				TriggerClientEvent("Progress",source,30000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","ba_prop_battle_vape_01",49,18905,0.08,-0.00,0.03,-150.0,90.0,-10.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRP.downgradeStress(user_id,15)
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "medkit" then
				if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
					if vRP.getHealth(source) > 100 and vRP.getHealth(source) < 200 then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									TriggerClientEvent("paramedic:Reset",source)
									Healths[user_id] = os.time() + 120
									vRPC.updateHealth(source,40)
								end
							end

							Wait(100)
						until Active[user_id] == nil
					else
						TriggerClientEvent("Notify",source,"amarelo","Não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				else
					local healTimers = parseInt(Healths[user_id] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..healTimers.." segundos</b>.",5000)
				end
			return end

			if nameItem == "gauze" then
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress",source,3000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("sounds:source",source,"bandage",0.5)
							vPARAMEDIC.Bandage(source)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "binoculars" then
				local ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") then
					return
				end

				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						TriggerClientEvent("useBinoculos",source)
						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.createObjects(source,"amb@world_human_binoculars@male@enter","enter","prop_binoc_01",50,28422)
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "evidence01" or nameItem == "evidence02" or nameItem == "evidence03" or nameItem == "evidence04" then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local distance = #(coords - vec3(312.45,-562.14,43.29))

				if distance <= 1.0 then
					local userSerial = vRP.userSerial(splitName[2])
					if userSerial then
						local identity = vRP.userIdentity(userSerial["id"])
						if identity then
							TriggerClientEvent("Notify",source,"amarelo","Evidência de <b>"..identity["name2"].."</b>.",5000)
						end
					end
				end
			end

			if nameItem == "camera" then
				local ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") then
					return
				end

				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						TriggerClientEvent("useCamera",source)
						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.createObjects(source,"amb@world_human_paparazzi@male@base","base","prop_pap_camera_01",49,28422)
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "dessertspass" then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local distance = #(coords - vector3(-583.42,-1062.03,22.34))
				if distance <= 5 then
					local FoodsResult = vRP.getUsersByPermission("Desserts")
					if parseInt(#FoodsResult) >= 1 then
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Notify",source,"amarelo","Existem pessoas trabalhando no <b>Uwu Café</b>.",5000)
					else
						if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
							if math.random(10) >= 5 then
								vRP.generateItem(user_id,"hamburger",1,false)
								vRP.generateItem(user_id,"cola",1,false)
							else
								vRP.generateItem(user_id,"hamburger2",1,false)
								vRP.generateItem(user_id,"soda",1,false)
							end

							TriggerClientEvent("inventory:Update",source,"updateMochila")
						end
					end
				end
			return end

			if nameItem == "pizzathispass" then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local distance = #(coords - vector3(810.32,-752.82,26.77))
				if distance <= 5 then
					local FoodsResult = vRP.getUsersByPermission("PizzaThis")
					if parseInt(#FoodsResult) >= 1 then
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Notify",source,"amarelo","Existem pessoas trabalhando no <b>Pizza This</b>.",5000)
					else
						if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
							if math.random(10) >= 5 then
								vRP.generateItem(user_id,"hamburger",1,false)
								vRP.generateItem(user_id,"cola",1,false)
							else
								vRP.generateItem(user_id,"hamburger2",1,false)
								vRP.generateItem(user_id,"soda",1,false)
							end

							TriggerClientEvent("inventory:Update",source,"updateMochila")
						end
					end
				end
			return end

			if nameItem == "burgershotpass" then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local distance = #(coords - vector3(-1194.69,-891.85,13.99))
				if distance <= 5 then
					local FoodsResult = vRP.getUsersByPermission("BurgerShot")
					if parseInt(#FoodsResult) >= 1 then
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Notify",source,"amarelo","Existem pessoas trabalhando no <b>BurgerShot</b>.",5000)
					else
						if vRP.tryGetInventoryItem(user_id,totalName,1,false,Slot) then
							if math.random(10) >= 5 then
								vRP.generateItem(user_id,"hamburger",1,false)
								vRP.generateItem(user_id,"cola",1,false)
							else
								vRP.generateItem(user_id,"hamburger2",1,false)
								vRP.generateItem(user_id,"soda",1,false)
							end

							TriggerClientEvent("inventory:Update",source,"updateMochila")
						end
					end
				end
			return end

			if nameItem == "teddy" then
				TriggerClientEvent("inventory:Close",source)
				vRPC.createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","v_ilev_mr_rasberryclean",49,24817,-0.20,0.46,-0.016,-180.0,-90.0,0.0)
			return end

			if nameItem == "rose" then
				TriggerClientEvent("inventory:Close",source)
				vRPC.createObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","prop_single_rose",49,18905,0.13,0.15,0.0,-100.0,0.0,-20.0)
			return end

			if nameItem == "firecracker" then
				if not vRPC.inVehicle(source) and not vCLIENT.checkCracker(source) then
					Active[user_id] = os.time() + 3
					TriggerClientEvent("Progress",source,3000)
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)
					vRPC.playAnim(source,false,{"anim@mp_fireworks","place_firework_3_box"},true)

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.stopAnim(source,false)
							TriggerClientEvent("inventory:Buttons",source,false)

							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								TriggerClientEvent("inventory:Firecracker",source)
							end
						end

						Wait(100)
					until Active[user_id] == nil
				end
			return end

			if nameItem == "gsrkit" then
				local otherPlayer = vRPC.ClosestPed(source,1)
				if otherPlayer then
					Active[user_id] = os.time() + 10
					TriggerClientEvent("Progress",source,10000)
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							TriggerClientEvent("inventory:Buttons",source,false)

							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								if vPLAYER.gsrCheck(otherPlayer) then
									TriggerClientEvent("Notify",source,"verde","Resultado positivo.",5000)
								else
									TriggerClientEvent("Notify",source,"amarelo","Resultado negativo.",3000)
								end
							end
						end

						Wait(100)
					until Active[user_id] == nil
				end
			return end

			if nameItem == "gdtkit" then
				local otherPlayer = vRPC.ClosestPed(source,1)
				if otherPlayer then
					local nuser_id = vRP.getUserId(otherPlayer)
					local identity = vRP.userIdentity(nuser_id)
					if nuser_id and identity then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									local weed = vRP.weedReturn(nuser_id)
									local chemical = vRP.chemicalReturn(nuser_id)
									local alcohol = vRP.alcoholReturn(nuser_id)

									local chemStr = ""
									local alcoholStr = ""
									local weedStr = ""

									if chemical == 0 then
										chemStr = "Nenhum"
									elseif chemical == 1 then
										chemStr = "Baixo"
									elseif chemical == 2 then
										chemStr = "Médio"
									elseif chemical >= 3 then
										chemStr = "Alto"
									end

									if alcohol == 0 then
										alcoholStr = "Nenhum"
									elseif alcohol == 1 then
										alcoholStr = "Baixo"
									elseif alcohol == 2 then
										alcoholStr = "Médio"
									elseif alcohol >= 3 then
										alcoholStr = "Alto"
									end

									if weed == 0 then
										weedStr = "Nenhum"
									elseif weed == 1 then
										weedStr = "Baixo"
									elseif weed == 2 then
										weedStr = "Médio"
									elseif weed >= 3 then
										weedStr = "Alto"
									end

									openIdentity[user_id] = true
									TriggerClientEvent("vRP:Identity",source,{ mode = "fidentity", nome = identity["name"].." "..identity["name2"], porte = identity["port"], sangue = bloodTypes(identity["blood"]) })
									TriggerClientEvent("Notify",source,"azul","<b>Químicos:</b> "..chemStr.."<br><b>Álcool:</b> "..alcoholStr.."<br><b>Drogas:</b> "..weedStr,8000)
								end
							end

							Wait(100)
						until Active[user_id] == nil
					end
				end
			return end

			if nameItem == "nitro" then
				if not vRPC.inVehicle(source) then
					local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if vehicle then
						vRPC.stopActived(source)
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						local Players = vRPC.Players(source)
						for _,v in ipairs(Players) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"open")
							end)
						end

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								TriggerClientEvent("inventory:Buttons",source,false)

								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									local Nitro = GlobalState["Nitro"]
									Nitro[vehPlate] = 2000
									GlobalState["Nitro"] = Nitro
								end
							end

							Wait(100)
						until Active[user_id] == nil

						local Players = vRPC.Players(source)
						for _,v in ipairs(Players) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"close")
							end)
						end
					end
				end
			return end

			if nameItem == "vest" then
				if Armors[user_id] then
					if os.time() < Armors[user_id] then
						local armorTimers = parseInt(Armors[user_id] - os.time())
						TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..armorTimers.." segundos</b>.",5000)
						return
					end
				end

				Active[user_id] = os.time() + 30
				TriggerClientEvent("Progress",source,30000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"clothingtie","try_tie_negative_a"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							Armors[user_id] = os.time() + 1800
							vRP.setArmour(source,100)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "GADGET_PARACHUTE" then
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vCLIENT.parachuteColors(source)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "advtoolbox" then
				if not vRPC.inVehicle(source) then
					local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if vehicle then
						vRPC.stopActived(source)
						Active[user_id] = os.time() + 100
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						local Players = vRPC.Players(source)
						for _,v in ipairs(Players) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"open")
							end)
						end

						if vTASKBAR.taskMechanic(source) then
							local numberItem = splitName[2]
							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								numberItem = numberItem - 1

								if numberItem > 0 then
									vRP.giveInventoryItem(user_id,"advtoolbox-"..numberItem,1,false)
								end

								local Players = vRPC.Players(source)
								for _,v in ipairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle",v,vehNet,vehPlate)
									end)
								end

								vRP.upgradeStress(user_id,2)
							end
						end

						local Players = vRPC.Players(source)
						for _,v in ipairs(Players) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"close")
							end)
						end

						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.stopAnim(source,false)
						Active[user_id] = nil
					end
				end
			return end

			if nameItem == "toolbox" then
				if not vRPC.inVehicle(source) then
					local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if vehicle then
						vRPC.stopActived(source)
						Active[user_id] = os.time() + 100
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						local Players = vRPC.Players(source)
						for _,v in ipairs(Players) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"open")
							end)
						end

						if vTASKBAR.taskMechanic(source) then
							if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _,v in ipairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle",v,vehNet,vehPlate)
									end)
								end

								vRP.upgradeStress(user_id,2)
							end
						end

						local Players = vRPC.Players(source)
						for _,v in ipairs(Players) do
							async(function()
								TriggerClientEvent("player:syncHoodOptions",v,vehNet,"close")
							end)
						end

						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.stopAnim(source,false)
						Active[user_id] = nil
					end
				end
			return end

			if nameItem == "lockpick" then
				if not vPLAYER.getHandcuff(source) then
					local vehicle,vehNet,vehPlate,vehName,vehBlock,vehHealth,vehClass = vRPC.vehList(source,4)
					if vehicle then
						if vehClass == 15 or vehClass == 16 or vehClass == 19 then
							return
						end

						if vRPC.inVehicle(source) and not vCLIENT.DismantleStatus(source) then
							vRPC.stopActived(source)
							vGARAGE.startAnimHotwired(source)
							Active[user_id] = os.time() + 100
							TriggerClientEvent("inventory:Close",source)
							TriggerClientEvent("inventory:Buttons",source,true)

							if vTASKBAR.taskLockpick(source) then
								if math.random(100) >= 20 then
									vRP.upgradeStress(user_id,2)
									TriggerEvent("plateEveryone",vehPlate)
									TriggerEvent("platePlayers",vehPlate,user_id)

									local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
									if GetVehicleDoorLockStatus(idNetwork) == 2 then
										SetVehicleDoorsLocked(idNetwork,1)
									end
									
									if vCLIENT.DismantleStatus(source) then
										TriggerClientEvent("target:Dismantles",source)
									end
								end

								if math.random(100) >= 75 then
									local Players = vRPC.Players(source)
									for _,v in ipairs(Players) do
										async(function()
											TriggerClientEvent("inventory:vehicleAlarm",v,vehNet,vehPlate)
										end)
									end

									local coords = vRPC.getEntityCoords(source)
									local policeResult = vRP.numPermission("Police")
									for k,v in pairs(policeResult) do
										async(function()
											TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
										end)
									end
									
									if vCLIENT.DismantleStatus(source) then
										TriggerClientEvent("inventory:DisPed",source)
									end
								end
							end

							if parseInt(math.random(1000)) >= 900 then
								vRP.removeInventoryItem(user_id,totalName,1,false)
								TriggerClientEvent("itensNotify",source,{ "quebrou","lockpick",1,"Lockpick de Alumínio" })
							end

							TriggerClientEvent("inventory:Buttons",source,false)
							vGARAGE.stopAnimHotwired(source,vehicle)
							Active[user_id] = nil
						else
							vRPC.stopActived(source)
							Active[user_id] = os.time() + 100
							TriggerClientEvent("inventory:Close",source)
							TriggerClientEvent("inventory:Buttons",source,true)
							vRPC.playAnim(source,false,{"missfbi_s4mop","clean_mop_back_player"},true)

							if vCLIENT.DismantleStatus(source) and vehPlate == "DISM"..(1000 + user_id) then
								if vTASKBAR.UpgradeVehicle(source) then
									vRPC.stopActived(source)
									Active[user_id] = os.time() + 30
									TriggerClientEvent("Progress",source,30000)
									TriggerClientEvent("inventory:Close",source)
									TriggerClientEvent("inventory:Buttons",source,true)
									vRPC.playAnim(source,false,{"missfbi_s4mop","clean_mop_back_player"},true)

									TriggerClientEvent("inventory:DisPed",source)

									repeat
										if os.time() >= parseInt(Active[user_id]) then
											Active[user_id] = nil
											TriggerClientEvent("inventory:Buttons",source,false)

											vRP.upgradeStress(user_id,2)
											TriggerEvent("plateEveryone",vehPlate)
											local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
											if GetVehicleDoorLockStatus(idNetwork) == 2 then
												SetVehicleDoorsLocked(idNetwork,1)
											end

											TriggerClientEvent("target:Dismantles",source)

											local Players = vRPC.Players(source)
											for _,v in ipairs(Players) do
												async(function()
													TriggerClientEvent("inventory:vehicleAlarm",v,vehNet,vehPlate)
												end)
											end

											if math.random(100) >= 75 then
												local coords = vRPC.getEntityCoords(source)
												local policeResult = vRP.numPermission("Police")
												for k,v in pairs(policeResult) do
													async(function()
														TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
													end)
												end
											end
										end
										
										Wait(100)
									until Active[user_id] == nil
								end
							else
								if vTASKBAR.taskLockpick(source) then
									if math.random(100) >= 75 then
										vRP.upgradeStress(user_id,2)
										TriggerEvent("plateEveryone",vehPlate)
										local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
										if GetVehicleDoorLockStatus(idNetwork) == 2 then
											SetVehicleDoorsLocked(idNetwork,1)
										end
									end
									
									if math.random(100) >= 75 then
										local Players = vRPC.Players(source)
										for _,v in ipairs(Players) do
											async(function()
												TriggerClientEvent("inventory:vehicleAlarm",v,vehNet,vehPlate)
											end)
										end
										
										local coords = vRPC.getEntityCoords(source)
										local policeResult = vRP.numPermission("Police")
										for k,v in pairs(policeResult) do
											async(function()
												TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
											end)
										end
									end
								end
							end

							if parseInt(math.random(1000)) >= 900 then
								vRP.removeInventoryItem(user_id,totalName,1,false)
								TriggerClientEvent("itensNotify",source,{ "quebrou","lockpick",1,"Lockpick de Alumínio" })
							end

							TriggerClientEvent("inventory:Buttons",source,false)
							vRPC.stopAnim(source,false)
							Active[user_id] = nil
						end
					end
				end
			return end

			if nameItem == "propertys" then
				if not vPLAYER.getHandcuff(source) then
					if exports["hud"]:Wanted(user_id) then
						return
					end

					local homeName = exports["propertys"]:homesTheft(source)
					if homeName then
						vRPC.stopActived(source)
						vRP.upgradeStress(user_id,2)
						Active[user_id] = os.time() + 100
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("inventory:Buttons",source,true)
						vRPC.playAnim(source,false,{"missheistfbi3b_ig7","lift_fibagent_loop"},false)

						if vTASKBAR.taskLockpick(source) then
							exports["propertys"]:enterHomes(source,user_id,homeName,true)
						else
							exports["propertys"]:resetTheft(homeName)

							if math.random(100) >= 50 then
								TriggerClientEvent("Notify",source,"amarelo","A vizinhança foi avisada de um suposto roubo.",5000)
								TriggerClientEvent("inventory:DisPed",source)
								local Players = vRPC.Players(source)
								for _,v in ipairs(Players) do
									async(function()
										TriggerClientEvent("sounds:source",source,"alarm",1.0)
									end)
								end
							end
						end

						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.stopAnim(source,false)
						Active[user_id] = nil
					else
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("homes:toggleMyPropertys",source)
					end
				end
			return end

			if nameItem == "blocksignal" then
				if not vPLAYER.getHandcuff(source) then
					local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if vehicle and vRPC.inVehicle(source) then
						if exports["garages"]:vehSignal(vehPlate) == nil then
							vRPC.stopActived(source)
							vGARAGE.startAnimHotwired(source)
							Active[user_id] = os.time() + 100
							TriggerClientEvent("inventory:Close",source)
							TriggerClientEvent("inventory:Buttons",source,true)

							if vTASKBAR.taskLockpick(source) then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									TriggerClientEvent("Notify",source,"verde","<b>Bloqueador de Sinal</b> instalado.",5000)
									TriggerEvent("signalRemove",vehPlate)
								end
							end

							TriggerClientEvent("inventory:Buttons",source,false)
							vGARAGE.stopAnimHotwired(source)
							Active[user_id] = nil
						else
							TriggerClientEvent("Notify",source,"amarelo","<b>Bloqueador de Sinal</b> já instalado.",5000)
						end
					end
				end
			return end

			if nameItem == "postit" then
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("postit:initPostit",source)
			return end

			if nameItem == "absolut" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,90)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "hennessy" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "chandon" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "dewars" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "megaphone" then
				vRPC.stopActived(source)
				Megaphone[user_id] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("player:Megaphone",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				TriggerClientEvent("pma-voice:Megaphone",source,true)
				vRPC.createObjects(source,"anim@random@shop_clothes@watches","base","prop_megaphone_01",49,60309,0.10,0.04,0.012,-60.0,100.0,-30.0)
			return end

			if nameItem == "scanner" then
				vRPC.stopActived(source)
				Scanners[user_id] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				TriggerClientEvent("inventory:updateScanner",source,true)
				vRPC.createObjects(source,"mini@golfai","wood_idle_a","w_am_digiscanner",49,18905,0.15,0.1,0.0,-270.0,-180.0,-170.0)
			return end

			if nameItem == "orangejuice" or nameItem == "passionjuice" or nameItem == "tangejuice" or nameItem == "grapejuice" or nameItem == "strawberryjuice" or nameItem == "bananajuice" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,50)
							vRP.generateItem(user_id,"emptybottle",1)

							if nameItem == "passionjuice" then
								vRP.downgradeStress(user_id,10)
							end
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "orange" or nameItem == "apple" or nameItem == "strawberry" or nameItem == "coffee2" or nameItem == "grape" or nameItem == "tange" or nameItem == "banana" or nameItem == "passion" or nameItem == "tomato" or nameItem == "mushroom" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,3)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "mushroomtea" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						TriggerClientEvent("inventory:Buttons",source,false)
						vRPC.removeObjects(source,"one")
						Active[user_id] = nil

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("player:MushroomTea",source)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "water" or nameItem == "milkbottle" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,20)
							vRP.generateItem(user_id,"emptybottle",1)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "guarananatural" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","prop_plastic_cup_02",49,60309,0.0,0.0,0.1,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeThirst(user_id,20)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "sinkalmy" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,5)
							vRP.chemicalTimer(user_id,3)
							vRP.downgradeStress(user_id,25)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "ritmoneury" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,5)
							vRP.chemicalTimer(user_id,3)
							vRP.downgradeStress(user_id,40)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cola" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","prop_ecola_can",49,60309,0.01,0.01,0.05,0.0,0.0,90.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,15)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "soda" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","ng_proc_sodacan_01b",49,60309,0.0,0.0,-0.04,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeThirst(user_id,15)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "fishingrod" then
				if vCLIENT.fishingCoords(source) then
					Active[user_id] = os.time() + 100
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)

					if not vCLIENT.fishingAnim(source) then
						vRPC.stopActived(source)
						vRPC.createObjects(source,"amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",49,60309)
					end

					if vTASKBAR.taskFishing(source) then
						local fishList = { "octopus","shrimp","carp","horsefish","tilapia","codfish","catfish","goldenfish","pirarucu","pacu","tambaqui" }
						local fishRandom = math.random(#fishList)
						local fishSelects = fishList[fishRandom]

						if (vRP.inventoryWeight(user_id) + itemWeight(fishSelects)) <= vRP.getWeight(user_id) then
							if vRP.tryGetInventoryItem(user_id,"bait",1,false) then
								vRP.generateItem(user_id,fishSelects,1,true)
								vRP.downgradeStress(user_id,2)
							else
								TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("bait").."</b>.",5000)
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
						end
					end

					TriggerClientEvent("inventory:Buttons",source,false)
					Active[user_id] = nil
				end
			return end

			if nameItem == "coffee" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,10,1.05)
							vRP.upgradeThirst(user_id,15)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "coffeemilk" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeThirst(user_id,15)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "pizza" or nameItem == "pizza2" or nameItem == "sushi" or nameItem == "nigirizushi" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							if nameItem == "pizza" then
								vRP.upgradeHunger(user_id,40)
							elseif nameItem == "pizza2" then
								vRP.upgradeHunger(user_id,40)
							elseif nameItem == "sushi" then
								vRP.upgradeHunger(user_id,30)
							elseif nameItem == "nigirizushi" then
								vRP.upgradeHunger(user_id,25)
							end
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "hamburger" or nameItem == "hamburger2" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							if nameItem == "hamburger" then
								vRP.upgradeHunger(user_id,15)
							elseif nameItem == "hamburger2" then
								vRP.upgradeHunger(user_id,50)
							end
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cannedsoup" or nameItem == "canofbeans" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,20)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "miner" then
				if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
					vRP.generateItem(user_id,"notebook",1)
					vRP.generateItem(user_id,"techtrash",50)
					vRP.generateItem(user_id,"aluminum",125)
					vRP.generateItem(user_id,"sheetmetal",15)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			return end

			if nameItem == "weedclone" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords = vRPC.objectCoords(source,"bkr_prop_weed_med_01a")
				if application then
					if vTASKBAR.Weeds(source) then
						local Route = GetPlayerRoutingBucket(source)
						vRP.removeInventoryItem(user_id,totalName,1,false)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						exports["plants"]:initPlants("weedclone",coords,Route,"bkr_prop_weed_med_01a",user_id)
					else
						vRP.removeInventoryItem(user_id,totalName,1,true)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "cokeseed" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords = vRPC.objectCoords(source,"bkr_prop_weed_med_01a")
				if application then
					if vTASKBAR.Weeds(source) then
						local Route = GetPlayerRoutingBucket(source)
						vRP.removeInventoryItem(user_id,totalName,1,false)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						exports["plants"]:initPlants("cokeseed",coords,Route,"bkr_prop_weed_med_01a",user_id)
					else
						vRP.removeInventoryItem(user_id,totalName,1,true)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "tablecoke" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords,heading = vRPC.objectCoords(source,"bkr_prop_coke_table01a")
				if application then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil

						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "bkr_prop_coke_table01a", item = "tablecoke", distance = 50, mode = "1" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						TriggerClientEvent("inventory:Close",source)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "tablemeth" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords,heading = vRPC.objectCoords(source,"bkr_prop_meth_table01a")
				if application then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil

						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "bkr_prop_meth_table01a", item = totalName, distance = 50, mode = "1" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						TriggerClientEvent("inventory:Close",source)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "tableweed" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords,heading = vRPC.objectCoords(source,"bkr_prop_weed_table_01a")
				if application then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil

						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "bkr_prop_weed_table_01a", item = totalName, distance = 50, mode = "1" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						TriggerClientEvent("inventory:Close",source)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "campfire" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords,heading = vRPC.objectCoords(source,"prop_beach_fire")
				if application then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil

						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]) - 0.6, h = heading, object = "prop_beach_fire", item = totalName, distance = 50, mode = "2" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						TriggerClientEvent("inventory:Close",source)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "barrier" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords,heading = vRPC.objectCoords(source,"prop_mp_barrier_02b")
				if application then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil

						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "prop_mp_barrier_02b", item = totalName, distance = 100, mode = "3" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						TriggerClientEvent("inventory:Close",source)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "medicbag" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords,heading = vRPC.objectCoords(source,"xm_prop_x17_bag_med_01a")
				if application then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil

						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "xm_prop_x17_bag_med_01a", item = totalName, distance = 50, mode = "5" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						TriggerClientEvent("inventory:Close",source)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "chair01" then
				TriggerClientEvent("inventory:Close",source)

				TriggerClientEvent("inventory:Buttons",source,true)
				local application,coords,heading = vRPC.objectCoords(source,"prop_off_chair_01")
				if application then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil

						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "prop_off_chair_01", item = totalName, distance = 50, mode = "4" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						TriggerClientEvent("inventory:Close",source)
					end
				end

				TriggerClientEvent("inventory:Buttons",source,false)
			return end

			if nameItem == "carp" or nameItem == "codfish" or nameItem == "catfish" or nameItem == "goldenfish" or nameItem == "horsefish" or nameItem == "tilapia" or nameItem == "pacu" or nameItem == "pirarucu" or nameItem == "tambaqui" then
				if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						vRP.generateItem(user_id,"fishfillet",2)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			return end

			if nameItem == "cookedfishfillet" or nameItem == "cookedmeat" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							if nameItem == "cookedfishfillet" then
								vRP.upgradeHunger(user_id,20)
							else
								vRP.upgradeHunger(user_id,30)
							end
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "hotdog" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_hotdog_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,10)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "sandwich" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_sandwich_01",49,18905,0.13,0.05,0.02,-50.0,16.0,60.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,10)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "tacos" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_taco_01",49,18905,0.16,0.06,0.02,-50.0,220.0,60.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,15)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "fries" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_food_bs_chips",49,18905,0.10,0.0,0.08,150.0,320.0,160.0)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,10)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "milkshake" or nameItem == "cappuccino" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,30)
							vRP.upgradeThirst(user_id,10)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "applelove" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.downgradeStress(user_id,10)
							vRP.upgradeHunger(user_id,8)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cupcake" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.downgradeStress(user_id,25)
							vRP.upgradeHunger(user_id,10)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "marshmallow" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress",source,3000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_suicide","pill"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source)
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,8)
							vRP.upgradeHunger(user_id,4)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "chocolate" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.downgradeStress(user_id,10)
							vRP.upgradeHunger(user_id,5)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "donut" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_amb_donut",49,28422)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.downgradeStress(user_id,10)
							vRP.upgradeHunger(user_id,5)
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "onionrings" or nameItem == "chickenfries" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeHunger(user_id,10)

							local ped = GetPlayerPed(source)
							local coords = GetEntityCoords(ped)
							local distance = #(coords - vector3(-1194.69,-891.85,13.99))
							if distance <= 5 then
								vRP.upgradeHunger(user_id,5)
								vRP.insertReputation(user_id,"BurgerShot",5)
							end
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "calzone" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							vRP.upgradeHunger(user_id,10)

							local ped = GetPlayerPed(source)
							local coords = GetEntityCoords(ped)
							local distance = #(coords - vector3(810.32,-752.82,26.77))
							if distance <= 5 then
								vRP.upgradeHunger(user_id,5)
								vRP.insertReputation(user_id,"PizzaThis",5)
							end
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "cookies" then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.removeObjects(source,"one")
						TriggerClientEvent("inventory:Buttons",source,false)

						if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeHunger(user_id,10)

							local ped = GetPlayerPed(source)
							local coords = GetEntityCoords(ped)
							local distance = #(coords - vector3(-583.42,-1062.03,22.34))
							if distance <= 5 then
								vRP.downgradeStress(user_id,10)
								vRP.insertReputation(user_id,"UwuCoffee",5)
							end
						end
					end

					Wait(100)
				until Active[user_id] == nil
			return end

			if nameItem == "notepad" then
				if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("notepad:createNotepad",source)
				end
			return end

			if nameItem == "notebook" then
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("notebook:openSystem",source)
			return end

			if nameItem == "tyres" then
				if not vRPC.inVehicle(source) then
					if not vCLIENT.checkWeapon(source,"WEAPON_WRENCH") then
						TriggerClientEvent("Notify",source,"amarelo","<b>Chave Inglesa</b> não encontrada.",5000)
						return
					end

					local tyreStatus,Tyre,vehNet,vehPlate = vCLIENT.tyreStatus(source)
					if tyreStatus then
						local Vehicle = NetworkGetEntityFromNetworkId(vehNet)
						if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
							if vCLIENT.tyreHealth(source,vehNet,Tyre) ~= 1000.0 then
								vRPC.stopActived(source)
								Active[user_id] = os.time() + 100
								TriggerClientEvent("inventory:Close",source)
								TriggerClientEvent("inventory:Buttons",source,true)
								vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

								if vTASKBAR.taskTyre(source) then
									if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
										local Players = vRPC.Players(source)
										for _,v in ipairs(Players) do
											async(function()
												TriggerClientEvent("inventory:repairTyre",v,vehNet,Tyre,vehPlate)
											end)
										end
									end
								end

								TriggerClientEvent("inventory:Buttons",source,false)
								vRPC.stopAnim(source,false)
								Active[user_id] = nil
							end
						end
					end
				end
			return end

			if nameItem == "premiumplate" then
				if vRPC.inVehicle(source) then
					TriggerClientEvent("inventory:Close",source)

					local vehModel = vRPC.vehicleName(source)
					local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehModel })
					if vehicle[1] then
						local vehPlate = vKEYBOARD.keySingle(source,"Placa:")
						if not vehPlate or string.upper(vehPlate[1]) == "CREATIVE" then
							return
						end

						local namePlate = string.sub(vehPlate[1],1,8)
						local plateCheck = sanitizeString(namePlate,"abcdefghijklmnopqrstuvwxyz0123456789",true)

						if string.len(plateCheck) ~= 8 then
							TriggerClientEvent("Notify",source,"amarelo","O nome de definição para a placa deve conter 8 caracteres.",5000)
							return
						else
							if vRP.userPlate(namePlate) then
								TriggerClientEvent("Notify",source,"vermelho","A placa escolhida já está sendo registrada em outro veículo.",5000)
								return
							else
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.execute("vehicles/plateVehiclesUpdate",{ user_id = user_id, vehicle = vehModel, plate = string.upper(namePlate) })
									TriggerClientEvent("Notify",source,"verde","Placa atualizada.",5000)
								end
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Modelo de veículo não encontrado.",5000)
					end
				end
			return end

			if nameItem == "radio" then
				vRPC.stopActived(source)
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("radio:openSystem",source)
			return end

			if nameItem == "divingsuit" then
				TriggerClientEvent("hud:Diving",source)
			return end

			if nameItem == "handcuff" then
				if not vRPC.inVehicle(source) then
					local otherPlayer = vRPC.ClosestPed(source,0.8)
					if otherPlayer then
						if vPLAYER.getHandcuff(otherPlayer) then
							vPLAYER.toggleHandcuff(otherPlayer)
							TriggerClientEvent("sounds:source",source,"uncuff",0.5)
							TriggerClientEvent("sounds:source",otherPlayer,"uncuff",0.5)
							TriggerClientEvent("player:Commands",otherPlayer,false)
						else
							if not vTASKBAR.taskDoors(otherPlayer) then
								TriggerClientEvent("player:playerCarry",otherPlayer,source,"handcuff")
								vRPC.playAnim(otherPlayer,false,{"mp_arrest_paired","crook_p2_back_left"},false)
								vRPC.playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)

								Wait(3500)

								vRPC.stopAnim(source,false)
								vPLAYER.toggleHandcuff(otherPlayer)
								TriggerClientEvent("inventory:Close",otherPlayer)
								TriggerClientEvent("sounds:source",source,"cuff",0.5)
								TriggerClientEvent("player:Commands",otherPlayer,true)
								TriggerClientEvent("sounds:source",otherPlayer,"cuff",0.5)
								TriggerClientEvent("player:playerCarry",otherPlayer,source)
							end
						end
					end
				end
			return end

			if nameItem == "hood" then
				local otherPlayer = vRPC.ClosestPed(source,0.8)
				if otherPlayer and vPLAYER.getHandcuff(otherPlayer) then
					TriggerClientEvent("hud:toggleHood",otherPlayer)
					TriggerClientEvent("inventory:Close",otherPlayer)
				end
			return end

			if nameItem == "rope" then
				if not vRPC.inVehicle(source) then
					if Carry[user_id] then
						TriggerClientEvent("player:ropeCarry",Carry[user_id],source)
						TriggerClientEvent("player:Commands",Carry[user_id],false)
						vRPC.removeObjects(Carry[user_id])
						vRPC.removeObjects(source)
						Carry[user_id] = nil
					else
						local otherPlayer = vRPC.ClosestPed(source,0.8)
						if otherPlayer and (vRP.getHealth(otherPlayer) <= 101 or vPLAYER.getHandcuff(otherPlayer)) then
							Carry[user_id] = otherPlayer

							TriggerClientEvent("player:ropeCarry",Carry[user_id],source)
							TriggerClientEvent("player:Commands",Carry[user_id],true)
							TriggerClientEvent("inventory:Close",Carry[user_id])

							vRPC.playAnim(source,true,{"missfinale_c2mcs_1","fin_c2_mcs_1_camman"},true)
							vRPC.playAnim(otherPlayer,false,{"nm","firemans_carry"},true)
						end
					end
				end
			return end

			if nameItem == "premium" then
				if not vRP.userPremium(user_id) then
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						vRP.setPremium(user_id)
					end
				else
					if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						vRP.upgradePremium(user_id)
					end
				end
			return end

			if nameItem == "pager" then
				local otherPlayer = vRPC.ClosestPed(source,1)
				if otherPlayer then
					if vPLAYER.getHandcuff(otherPlayer) then
						local nuser_id = vRP.getUserId(otherPlayer)
						if nuser_id then
							if vRP.hasGroup(nuser_id,"Ranger") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("radio:outServers",otherPlayer)
									vRP.updatePermission(nuser_id,"Ranger","waitRanger")
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									TriggerClientEvent("service:Label",otherPlayer,"Ranger","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"State") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("radio:outServers",otherPlayer)
									vRP.updatePermission(nuser_id,"State","waitState")
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									TriggerClientEvent("service:Label",otherPlayer,"State","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"Lspd") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									vRP.updatePermission(nuser_id,"Lspd","waitLspd")
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("radio:outServers",otherPlayer)
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									TriggerClientEvent("service:Label",otherPlayer,"Lspd","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"Sheriff") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("radio:outServers",otherPlayer)
									vRP.updatePermission(nuser_id,"Sheriff","waitSheriff")
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									TriggerClientEvent("service:Label",otherPlayer,"Sheriff","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"Corrections") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(nuser_id,"Police")
									TriggerClientEvent("radio:outServers",otherPlayer)
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									TriggerClientEvent("vRP:PoliceService",otherPlayer,false)
									vRP.updatePermission(nuser_id,"Corrections","waitCorrections")
									TriggerClientEvent("service:Label",otherPlayer,"Corrections","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(nuser_id,"Paramedic") then
								if vRP.tryGetInventoryItem(user_id,totalName,1,true,Slot) then
									vRP.removePermission(user_id,"Paramedic")
									TriggerClientEvent("radio:outServers",otherPlayer)
									TriggerEvent("blipsystem:serviceExit",otherPlayer)
									vRP.updatePermission(nuser_id,"Paramedic","waitParamedic")
									TriggerClientEvent("service:Label",otherPlayer,"Paramedic","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end
						end
					end
				end
			return end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if Ammos[user_id] then
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "weaponAttachs", value = json.encode(Attachs[user_id]) })
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "weaponAmmos", value = json.encode(Ammos[user_id]) })
		Attachs[user_id] = nil
		Ammos[user_id] = nil
	end

	if Active[user_id] then
		Active[user_id] = nil
	end

	if verifyObjects[user_id] then
		verifyObjects[user_id] = nil
	end

	if verifyAnimals[user_id] then
		verifyAnimals[user_id] = nil
	end

	if Loots[user_id] then
		Loots[user_id] = nil
	end

	if Healths[user_id] then
		Healths[user_id] = nil
	end

	if Armors[user_id] then
		Armors[user_id] = nil
	end

	if Scanners[user_id] then
		Scanners[user_id] = nil
	end

	if Megaphone[user_id] then
		Megaphone[user_id] = nil
	end

	if openIdentity[user_id] then
		openIdentity[user_id] = nil
	end

	if dismantleProgress[user_id] then
		local vehName = dismantleProgress[user_id]
		dismantleProgress[user_id] = nil
	end

	if Carry[user_id] then
		TriggerClientEvent("player:Commands",Carry[user_id],false)
		vRPC.removeObjects(Carry[user_id])
		Carry[user_id] = nil
	end
	
	if userAmount[user_id] then
		userAmount[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	Ammos[user_id] = vRP.userData(user_id,"weaponAmmos")
	Attachs[user_id] = vRP.userData(user_id,"weaponAttachs")

	TriggerClientEvent("objects:Table",source,Objects)
	TriggerClientEvent("drops:Table",source,Drops)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] ~= nil then
			Active[user_id] = nil
			vGARAGE.updateHotwired(source,false)
			TriggerClientEvent("Progress",source,1000)
			TriggerClientEvent("inventory:Buttons",source,false)

			if verifyObjects[user_id] then
				local model = verifyObjects[user_id][1]
				local hash = verifyObjects[user_id][2]

				Trashs[model][hash] = nil
				verifyObjects[user_id] = nil
			end

			if verifyAnimals[user_id] then
				local model = verifyAnimals[user_id][1]
				local netObjects = verifyAnimals[user_id][2]

				Animals[model][netObjects] = Animals[model][netObjects] - 1
				verifyAnimals[user_id] = nil
			end

			if Loots[user_id] then
				Boxes[Loots[user_id]][user_id] = nil
			end

			if dismantleProgress[user_id] then
				local vehName = dismantleProgress[user_id]
				dismantleProgress[user_id] = nil
			end
		end

		if openIdentity[user_id] then
			TriggerClientEvent("vRP:Identity",source)
			openIdentity[user_id] = nil
		end

		if Carry[user_id] then
			TriggerClientEvent("player:ropeCarry",Carry[user_id],source)
			TriggerClientEvent("player:Commands",Carry[user_id],false)
			vRPC.removeObjects(Carry[user_id])
			Carry[user_id] = nil
		end

		if Scanners[user_id] then
			TriggerClientEvent("inventory:updateScanner",source,false)
			TriggerClientEvent("inventory:Buttons",source,false)
			Scanners[user_id] = nil
		end

		if Megaphone[user_id] then
			TriggerClientEvent("inventory:Buttons",source,false)
			Megaphone[user_id] = nil
		end

		vRPC.removeObjects(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] ~= nil then
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.verifyWeapon(Item,Ammo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,Item)
		if consultItem[1] <= 0 then
			local wHash = itemAmmo(Item)

			if wHash ~= nil then
				if Ammos[user_id][wHash] then
					Ammos[user_id][wHash] = parseInt(Ammo)

					if Attachs[user_id][Item] ~= nil then
						for nameAttachs,_ in pairs(Attachs[user_id][Item]) do
							vRP.generateItem(user_id,nameAttachs,1)
						end

						Attachs[user_id][Item] = nil
					end

					if Ammos[user_id][wHash] > 0 then
						vRP.generateItem(user_id,wHash,Ammos[user_id][wHash])
						Ammos[user_id][wHash] = nil
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end

			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXISTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.existWeapon(Item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,Item)
		if consultItem[1] <= 0 then
			local wHash = itemAmmo(Item)

			if wHash ~= nil then
				if Ammos[user_id][wHash] then
					if Attachs[user_id][Item] ~= nil then
						for nameAttachs,_ in pairs(Attachs[user_id][Item]) do
							vRP.generateItem(user_id,nameAttachs,1)
						end

						Attachs[user_id][Item] = nil
					end

					if Ammos[user_id][wHash] > 0 then
						vRP.generateItem(user_id,wHash,Ammos[user_id][wHash])
						Ammos[user_id][wHash] = nil
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.dropWeapons(Item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,Item)
		if consultItem[1] <= 0 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.preventWeapon(Item,Ammo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local wHash = itemAmmo(Item)

		if wHash ~= nil then
			if Ammos[user_id][wHash] then
				if Ammo > 0 then
					Ammos[user_id][wHash] = Ammo
				else
					Ammos[user_id][wHash] = nil
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeThrowable(nameItem)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.removeInventoryItem(user_id,nameItem,1,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDSITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local stealpedsitens = {
	{ item = "notepad", min = 1, max = 5 },
	{ item = "mouse", min = 1, max = 1 },
	{ item = "silverring", min = 1, max = 1 },
	{ item = "goldring", min = 1, max = 1 },
	{ item = "watch", min = 1, max = 2 },
	{ item = "ominitrix", min = 1, max = 1 },
	{ item = "bracelet", min = 1, max = 1 },
	{ item = "spray01", min = 1, max = 2 },
	{ item = "spray02", min = 1, max = 2 },
	{ item = "spray03", min = 1, max = 2 },
	{ item = "spray04", min = 1, max = 2 },
	{ item = "dices", min = 1, max = 2 },
	{ item = "dish", min = 1, max = 3 },
	{ item = "WEAPON_SHOES", min = 1, max = 2 },
	{ item = "rimel", min = 1, max = 3 },
	{ item = "blender", min = 1, max = 1 },
	{ item = "switch", min = 1, max = 3 },
	{ item = "brush", min = 1, max = 2 },
	{ item = "domino", min = 1, max = 3 },
	{ item = "floppy", min = 1, max = 4 },
	{ item = "deck", min = 1, max = 2 },
	{ item = "pliers", min = 1, max = 2 },
	{ item = "slipper", min = 1, max = 1 },
	{ item = "soap", min = 1, max = 1 },
	{ item = "dollarsz", min = 425, max = 525 },
	{ item = "card01", min = 1, max = 1 },
	{ item = "card02", min = 1, max = 1 },
	{ item = "card03", min = 1, max = 1 },
	{ item = "card04", min = 1, max = 1 },
	{ item = "card05", min = 1, max = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.StealPeds()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if (vRP.inventoryWeight(user_id) + 1) <= vRP.getBackpack(user_id) then
			local rand = math.random(#stealpedsitens)
			local value = math.random(stealpedsitens[rand]["min"],stealpedsitens[rand]["max"])

			vRP.generateItem(user_id,stealpedsitens[rand]["item"],value,true)
			vRP.upgradeStress(user_id,2)
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:CleanWeapons")
AddEventHandler("inventory:CleanWeapons",function(user_id)
	if Ammos[user_id] then
		Ammos[user_id] = {}
		Attachs[user_id] = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:verifyObjects")
AddEventHandler("inventory:verifyObjects",function(Entity,Service)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		if Service == "Lixeiro" then
			if not vRPC.lastVehicle(source,"trash") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Lixeiro</b>.",3000)
				return
			end
		end

		if Entity[1] ~= nil and Entity[2] ~= nil and Entity[4] ~= nil then
			local hash = Entity[1]
			local model = Entity[2]
			local coords = Entity[4]

			if verifyObjects[user_id] == nil then
				if Trashs[model] == nil then
					Trashs[model] = {}
				end

				if Trashs[model][hash] then
					TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
					return
				end

				for k,v in pairs(Trashs[model]) do
					if #(v["coords"] - coords) <= 0.75 and os.time() <= v["timer"] then
						TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
						return
					end
				end

				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress",source,5000)
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

				verifyObjects[user_id] = { model,hash }
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				Trashs[model][hash] = { ["coords"] = coords, ["timer"] = os.time() + 3600 }

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)

						local itemSelect = { "",1 }

						if Service == "Lixeiro" then
							local randItem = math.random(90)
							if parseInt(randItem) >= 61 and parseInt(randItem) <= 70 then
								itemSelect = { "metalcan",math.random(2) }
							elseif parseInt(randItem) >= 51 and parseInt(randItem) <= 60 then
								itemSelect = { "battery",math.random(2) }
							elseif parseInt(randItem) >= 41 and parseInt(randItem) <= 50 then
								itemSelect = { "elastic",math.random(2) }
							elseif parseInt(randItem) >= 21 and parseInt(randItem) <= 40 then
								itemSelect = { "plasticbottle",math.random(2) }
							elseif parseInt(randItem) <= 20 then
								itemSelect = { "glassbottle",math.random(2) }
							end
						elseif Service == "Jornaleiro" then
							itemSelect = { "newspaper",math.random(2) }
						end

						if itemSelect[1] == "" then
							TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
						else
							if (vRP.inventoryWeight(user_id) + (itemWeight(itemSelect[1]) * itemSelect[2])) <= vRP.getWeight(user_id) then
								vRP.generateItem(user_id,itemSelect[1],itemSelect[2],true)
								vRP.upgradeStress(user_id,1)
							else
								TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
								Trashs[model][hash] = nil
							end
						end

						verifyObjects[user_id] = nil
					end

					Wait(100)
				until Active[user_id] == nil
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:LOOTSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:lootSystem")
AddEventHandler("inventory:lootSystem",function(Entity,Service)
	local source = source
	local Entity = tostring(Entity)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Loots[user_id] == nil and Active[user_id] == nil then
			if Boxes[Entity] == nil then
				Boxes[Entity] = {}
			end

			if Boxes[Entity][user_id] then
				if os.time() <= Boxes[Entity][user_id] then
					TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
					return
				end
			end

			Loots[user_id] = Entity
			Active[user_id] = os.time() + 5
			TriggerClientEvent("Progress",source,5000)
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("inventory:Buttons",source,true)
			Boxes[Entity][user_id] = os.time() + lootItens[Service]["cooldown"]
			vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					vRPC.stopAnim(source,false)
					TriggerClientEvent("inventory:Buttons",source,false)

					local itemSelect = { "",1 }

					if math.random(100) <= lootItens[Service]["null"] then
						local randItem = math.random(#lootItens[Service]["list"])
						local randAmount = math.random(lootItens[Service]["list"][randItem]["min"],lootItens[Service]["list"][randItem]["max"])

						itemSelect = { lootItens[Service]["list"][randItem]["item"],randAmount }
					end

					if itemSelect[1] == "" then
						TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
					else
						if (vRP.inventoryWeight(user_id) + (itemWeight(itemSelect[1]) * parseInt(itemSelect[2]))) <= vRP.getWeight(user_id) then
							vRP.generateItem(user_id,itemSelect[1],itemSelect[2],true)
							vRP.upgradeStress(user_id,2)
						else
							TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
							Boxes[Entity][user_id] = nil
						end
					end

					Loots[user_id] = nil
				end

				Wait(100)
			until Active[user_id] == nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:applyPlate")
AddEventHandler("inventory:applyPlate",function(Entity)
	local source = source
	local consultItem = {}
	local vehPlate = Entity[1]
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		if Plates[vehPlate] == nil then
			consultItem = vRP.getInventoryItemAmount(user_id,"plate")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("plate").."</b>.",5000)
				return
			end
		end

		local consultPliers = vRP.getInventoryItemAmount(user_id,"pliers")
		if consultPliers[1] <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("pliers").."</b>.",5000)
			return
		end

		if Plates[vehPlate] ~= nil then
			if os.time() < Plates[vehPlate][1] then
				local plateTimers = parseInt(Plates[vehPlate][1] - os.time())
				if plateTimers ~= nil then
					TriggerClientEvent("Notify",source,"azul","Aguarde "..completeTimers(plateTimers)..".",5000)
				end

				return
			end
		end

		Active[user_id] = os.time() + 30
		TriggerClientEvent("Progress",source,30000)
		TriggerClientEvent("inventory:Buttons",source,true)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source,false)
				TriggerClientEvent("inventory:Buttons",source,false)

				if Plates[vehPlate] == nil then
					if vRP.tryGetInventoryItem(user_id,consultItem[2],1,true) then
						local newPlate = vRP.generatePlate()
						TriggerEvent("plateEveryone",newPlate)
						TriggerClientEvent("player:applyGsr",source)
						Plates[newPlate] = { os.time() + 3600,vehPlate }

						local idNetwork = NetworkGetEntityFromNetworkId(Entity[4])
						if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
							SetVehicleNumberPlateText(idNetwork,newPlate)
						end
					end
				else
					local idNetwork = NetworkGetEntityFromNetworkId(Entity[4])
					if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
						SetVehicleNumberPlateText(idNetwork,Plates[vehPlate][2])
					end

					if math.random(100) >= 50 then
						vRP.generateItem(user_id,"plate",1,true)
					else
						TriggerClientEvent("Notify",source,"azul","Após remove-la a mesma quebrou.",5000)
					end

					TriggerEvent("plateReveryone",vehPlate)
					Plates[vehPlate] = nil
				end
			end

			Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CHECKSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:checkStockade")
AddEventHandler("inventory:checkStockade",function(Entity)
	local policeResult = vRP.numPermission("Police")
	if parseInt(#policeResult) <= 6 then
		TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
		return false
	else
		local source = source
		local vehPlate = Entity[1]
		local user_id = vRP.getUserId(source)
		if user_id and Active[user_id] == nil then
			if Plates[vehPlate] then
				TriggerClientEvent("Notify",source,"vermelho","Não foi encontrado o registro do veículo no sistema.",5000)
				return
			end

			if Stockade[vehPlate] == nil then
				Stockade[vehPlate] = 0
			end

			if Stockade[vehPlate] >= 15 then
				TriggerClientEvent("Notify",source,"amarelo","Vazio.",5000)
				return
			end

			if vRP.userPlate(vehPlate) then
				TriggerClientEvent("Notify",source,"amarelo","Veículo protegido pela seguradora.",5000)
				return
			end

			local stockadeItens = { "WEAPON_CROWBAR","lockpick" }
			for k,v in pairs(stockadeItens) do
				local consultItem = vRP.getInventoryItemAmount(user_id,v)
				if consultItem[1] < 1 then
					TriggerClientEvent("Notify",source,"amarelo","<b>"..itemName(v).."</b> não encontrado.",5000)
					return
				end

				if vRP.checkBroken(consultItem[2]) then
					TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(v).."</b> quebrado.",5000)
					return
				end
			end

			Stockade[vehPlate] = Stockade[vehPlate] + 1

			if vTASKBAR.taskHandcuff(source) then
				vRP.upgradeStress(user_id,10)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress",source,15000)
				TriggerClientEvent("player:applyGsr",source)
				TriggerClientEvent("inventory:Buttons",source,true)
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
						TriggerClientEvent("inventory:Buttons",source,false)
						vRP.generateItem(user_id,"dollars",math.random(225,275),true)
					end

					Wait(100)
				until Active[user_id] == nil
			else
				local coords = vRPC.getEntityCoords(source)
				Stockade[vehPlate] = Stockade[vehPlate] - 1

				for k,v in pairs(policeResult) do
					async(function()
						vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Roubo ao Carro Forte", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stealTrunk(Entity)
	local source = source
	local vehNet = Entity[4]
	local vehPlate = Entity[1]
	local vehModels = Entity[2]
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local userPlate = vRP.userPlate(vehPlate)
		if not userPlate then
			if Trunks[vehPlate] == nil then
				Trunks[vehPlate] = os.time()
			end

			if os.time() >= Trunks[vehPlate] then
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
				Active[user_id] = os.time() + 100

				if vTASKBAR.stealTrunk(source) then
					Active[user_id] = os.time() + 30
					TriggerClientEvent("Progress",source,30000)
					TriggerClientEvent("inventory:Buttons",source,true)

					local Players = vRPC.Players(source)
					for _,v in ipairs(Players) do
						async(function()
							TriggerClientEvent("player:syncDoorsOptions",v,vehNet,"open")
						end)
					end

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.stopAnim(source,false)
							TriggerClientEvent("inventory:Buttons",source,false)

							local Players = vRPC.Players(source)
							for _,v in ipairs(Players) do
								async(function()
									TriggerClientEvent("player:syncDoorsOptions",v,vehNet,"close")
								end)
							end

							if os.time() >= Trunks[vehPlate] then
								local randItens = math.random(#stealItens)
								if math.random(250) <= stealItens[randItens]["rand"] then
									local randAmounts = math.random(stealItens[randItens]["min"],stealItens[randItens]["max"])

									if (vRP.inventoryWeight(user_id) + (itemWeight(stealItens[randItens]["item"]) * randAmounts)) <= vRP.getWeight(user_id) then
										vRP.generateItem(user_id,stealItens[randItens]["item"],randAmounts,true)
										Trunks[vehPlate] = os.time() + 3600
										vRP.upgradeStress(user_id,2)
									else
										TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
									end
								else
									TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
									Trunks[vehPlate] = os.time() + 3600
									vRP.upgradeStress(user_id,1)
								end
							end
						end

						Wait(100)
					until Active[user_id] == nil
				else
					local Players = vRPC.Players(source)
					for _,v in ipairs(Players) do
						async(function()
							TriggerClientEvent("inventory:vehicleAlarm",v,vehNet,vehPlate)
						end)
					end

					vRPC.stopAnim(source,false)
					Active[user_id] = nil

					local coords = vRPC.getEntityCoords(source)
					local policeResult = vRP.numPermission("Police")
					for k,v in pairs(policeResult) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehModels).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
						end)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Veículo protegido pela seguradora.",1000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Animals")
AddEventHandler("inventory:Animals",function(Entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Entity[2] ~= nil and Entity[3] ~= nil then
			local nameItem = "switchblade"
			local consultItem = vRP.getInventoryItemAmount(user_id,nameItem)
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Necessário possuir um <b>"..itemName(nameItem).."</b>.",5000)
				return
			end

			if vRP.checkBroken(consultItem[2]) then
				TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(nameItem).."</b> quebrado.",5000)
				return
			end

			local model = Entity[2]
			local netObjects = Entity[3]

			if Animals[model] == nil then
				Animals[model] = {}
			end

			if Animals[model][netObjects] == nil then
				Animals[model][netObjects] = 0
			end

			if verifyAnimals[user_id] == nil and Active[user_id] == nil and Animals[model][netObjects] < 5 then
				if (vRP.inventoryWeight(user_id) + itemWeight("meat")) <= vRP.getWeight(user_id) then
					if vTASKBAR.taskOne(source) then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)
						vRPC.playAnim(source,false,{"amb@medic@standing@kneel@base","base"},true)
						vRPC.playAnim(source,true,{"anim@gangops@facility@servers@bodysearch@","player_search"},true)

						TriggerClientEvent("inventory:Close",source)
						verifyAnimals[user_id] = { model,netObjects }
						TriggerClientEvent("inventory:Buttons",source,true)
						Animals[model][netObjects] = Animals[model][netObjects] + 1

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source,false)
								verifyAnimals[user_id] = nil
								TriggerClientEvent("inventory:Buttons",source,false)

								if Animals[model] then
									if parseInt(Animals[model][netObjects]) <= 1 then
										vRP.generateItem(user_id,"meat",1,true)
									elseif parseInt(Animals[model][netObjects]) == 2 then
										vRP.generateItem(user_id,"meat",1,true)
									elseif parseInt(Animals[model][netObjects]) == 3 then
										local randItens = math.random(8)
										vRP.generateItem(user_id,"animalfat",randItens,true)
									elseif parseInt(Animals[model][netObjects]) == 4 then
										local randItens = math.random(4)
										vRP.generateItem(user_id,"leather",randItens,true)
									elseif parseInt(Animals[model][netObjects]) >= 5 then
										local randItens = math.random(2)
										Animals[model][netObjects] = nil
										TriggerEvent("tryDeletePed",netObjects)
										vRP.generateItem(user_id,"animalpelt",randItens,true)
									end
								end
							end

							Wait(100)
						until Active[user_id] == nil
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local stealpedsList = {
	{ item = "notepad", min = 1, max = 5 },
	{ item = "mouse", min = 1, max = 1 },
	{ item = "silverring", min = 1, max = 1 },
	{ item = "goldring", min = 1, max = 1 },
	{ item = "watch", min = 1, max = 2 },
	{ item = "ominitrix", min = 1, max = 1 },
	{ item = "bracelet", min = 1, max = 1 },
	{ item = "spray01", min = 1, max = 2 },
	{ item = "spray02", min = 1, max = 2 },
	{ item = "spray03", min = 1, max = 2 },
	{ item = "spray04", min = 1, max = 2 },
	{ item = "dices", min = 1, max = 2 },
	{ item = "dish", min = 1, max = 3 },
	{ item = "WEAPON_SHOES", min = 1, max = 2 },
	{ item = "rimel", min = 1, max = 3 },
	{ item = "blender", min = 1, max = 1 },
	{ item = "switch", min = 1, max = 3 },
	{ item = "brush", min = 1, max = 2 },
	{ item = "domino", min = 1, max = 3 },
	{ item = "floppy", min = 1, max = 4 },
	{ item = "deck", min = 1, max = 2 },
	{ item = "pliers", min = 1, max = 2 },
	{ item = "slipper", min = 1, max = 1 },
	{ item = "soap", min = 1, max = 1 },
	{ item = "dollarsz", min = 425, max = 525 },
	{ item = "card01", min = 1, max = 1 },
	{ item = "card02", min = 1, max = 1 },
	{ item = "card03", min = 1, max = 1 },
	{ item = "card04", min = 1, max = 1 },
	{ item = "card05", min = 1, max = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:StealPeds")
AddEventHandler("inventory:StealPeds",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if (vRP.inventoryWeight(user_id) + 1) <= vRP.getWeight(user_id) then
			vRP.upgradeStress(user_id,3)
			local rand = math.random(#stealpedsList)
			local value = math.random(stealpedsList[rand]["min"],stealpedsList[rand]["max"])
			vRP.generateItem(user_id,stealpedsList[rand]["item"],value,true)
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local drugsList = {
	{ item = "cocaine", priceMin = 45, priceMax = 60, randMin = 2, randMax = 5 },
	{ item = "meth", priceMin = 45, priceMax = 60, randMin = 2, randMax = 5 },
	{ item = "joint", priceMin = 45, priceMax = 60, randMin = 2, randMax = 5 },
	{ item = "oxy", priceMin = 55, priceMax = 65, randMin = 1, randMax = 3 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.AmountDrugs()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(drugsList) do
			local randAmount = math.random(v["randMin"],v["randMax"])
			local randPrice = math.random(v["priceMin"],v["priceMax"])
			local consultItem = vRP.getInventoryItemAmount(user_id,v["item"])
			if consultItem[1] >= parseInt(randAmount) then
				userAmount[user_id] = { v["item"],randAmount,randPrice * randAmount }

				return true
			end
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRUGSPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:DrugsPeds")
AddEventHandler("inventory:DrugsPeds",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,userAmount[user_id][1],userAmount[user_id][2],true) then
			vRP.upgradeStress(user_id,3)
			TriggerClientEvent("player:applyGsr",source)
			vRP.generateItem(user_id,"dollarsroll",userAmount[user_id][3],true)

			if math.random(100) >= 75 then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local policeResult = vRP.numPermission("Police")
				for k,v in pairs(policeResult) do
					async(function()
						vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Venda de Drogas", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Ligação Anônima", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:GUARDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("objects:Guardar")
AddEventHandler("objects:Guardar",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Objects[Number] then
			vRP.giveInventoryItem(user_id,Objects[Number]["item"],1,true)
			TriggerClientEvent("objects:Remover",-1,Number)

			if tableSelect[Objects[Number]["item"]] then
				if tableSelect[Objects[Number]["item"]][Number] then
					tableSelect[Objects[Number]["item"]][Number] = nil
				end
			end

			Objects[Number] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:makeProducts")
AddEventHandler("inventory:makeProducts",function(Entity,Table)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local typeTable = splitString(Table,"-")[1]

		if tableList[typeTable] then
			if typeTable == "cemitery" then
				if not vTASKBAR.taskOne(source) then
					local coords = vRPC.getEntityCoords(source)
					local policeResult = vRP.numPermission("Police")

					for k,v in pairs(policeResult) do
						async(function()
							vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Roubo de Pertences", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
						end)
					end
				end
			end

			local model = Table
			local id = Entity[1] or Table

			if tableSelect[model] == nil then
				tableSelect[model] = {}
			end

			if tableSelect[model][id] == nil then
				tableSelect[model][id] = 0
			end

			local numberProgress = tableSelect[model][id] + 1

			if typeTable == "scanner" or typeTable == "cemitery" then
				numberProgress = math.random(#tableList[typeTable])
			end

			if tableList[typeTable][numberProgress]["item"] ~= nil then
				if vRP.checkMaxItens(user_id,tableList[typeTable][numberProgress]["item"],tableList[typeTable][numberProgress]["itemAmount"]) then
					TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					return
				end

				if (vRP.inventoryWeight(user_id) + (itemWeight(tableList[typeTable][numberProgress]["item"]) * tableList[typeTable][numberProgress]["itemAmount"])) > vRP.getWeight(user_id) then
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					return
				end
			end

			local tableNeed = {}
			local consultItem = {}
			if tableList[typeTable][numberProgress]["need"] ~= nil then
				local needItem = tableList[typeTable][numberProgress]["need"]

				if type(needItem) == "table" then
					for k,v in pairs(needItem) do
						consultItem = vRP.getInventoryItemAmount(user_id,v["item"])
						if consultItem[1] < v["amount"] then
							TriggerClientEvent("Notify",source,"amarelo","Necessário possuir <b>"..v["amount"].."x "..itemName(v["item"]).."</b>.",5000)
							return
						end

						tableNeed[k] = { consultItem[2],v["amount"] }
					end
				else
					needAmount = tableList[typeTable][numberProgress]["needAmount"]
					consultItem = vRP.getInventoryItemAmount(user_id,needItem)
					if consultItem[1] < needAmount then
						TriggerClientEvent("Notify",source,"amarelo","Necessário possuir <b>"..needAmount.."x "..itemName(needItem).."</b>.",5000)
						return
					end
				end
			end

			TriggerClientEvent("inventory:Buttons",source,true)
			Active[user_id] = os.time() + tableList[typeTable][numberProgress]["timer"]
			TriggerClientEvent("Progress",source,tableList[typeTable][numberProgress]["timer"] * 1000)

			if typeTable ~= "scanner" then
				if typeTable == "cemitery" then
					vRPC.playAnim(source,false,{"amb@medic@standing@tendtodead@idle_a","idle_a"},true)
				else
					vRPC.playAnim(source,false,{ tableList[typeTable]["anim"][1],tableList[typeTable]["anim"][2] },true)
				end
			end

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					TriggerClientEvent("inventory:Buttons",source,false)

					if typeTable ~= "scanner" then
						vRPC.stopAnim(source,false)
					end

					if tableSelect[model] then
						if tableSelect[model][id] then
							tableSelect[model][id] = tableSelect[model][id] + 1

							if tableSelect[model][id] <= #tableList[typeTable] then
								if tableList[typeTable][numberProgress]["need"] ~= nil then
									local needItem = tableList[typeTable][numberProgress]["need"]

									if type(needItem) == "table" then
										for k,v in pairs(tableNeed) do
											vRP.removeInventoryItem(user_id,v[1],v[2],false)
										end
									else
										vRP.removeInventoryItem(user_id,consultItem[2],needAmount,false)
									end
								end

								if tableList[typeTable][numberProgress]["item"] ~= nil then
									vRP.generateItem(user_id,tableList[typeTable][numberProgress]["item"],tableList[typeTable][numberProgress]["itemAmount"],true)
								end

								if tableSelect[model][id] >= #tableList[typeTable] then
									tableSelect[model][id] = nil
									tableSelect[model] = nil
								end
							end
						end
					end
				end

				Wait(100)
			until Active[user_id] == nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drink")
AddEventHandler("inventory:Drink",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 10
		TriggerClientEvent("Progress",source,10000)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("inventory:Buttons",source,true)
		vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","prop_plastic_cup_02",49,60309,0.0,0.0,0.1,0.0,0.0,130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRP.upgradeThirst(user_id,20)
				vRPC.removeObjects(source,"one")
				TriggerClientEvent("inventory:Buttons",source,false)
			end

			Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Dismantle")
AddEventHandler("inventory:Dismantle",function(Entity)
	local source = source
	local vehName = Entity[2]
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		dismantleProgress[user_id] = vehName
		Active[user_id] = os.time() + 15

		TriggerClientEvent("Progress",source,15000)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("inventory:Buttons",source,true)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source)
				dismantleProgress[user_id] = nil

				TriggerClientEvent("player:applyGsr",source)
				TriggerClientEvent("inventory:Buttons",source,false)
				TriggerEvent("garages:deleteVehicle",Entity[4],Entity[1])
				
				local Players = vRPC.Players(source)
				for _,v in ipairs(Players) do
					async(function()
						vRP.generateItem(v,"dollarsroll",math.random(95,165),true)
					end)
				end

				vRP.generateItem(user_id,"dismantle",1,true)

				if math.random(1000) <= 25 then
					vRP.generateItem(user_id,"plate",1,true)
				end

				TriggerClientEvent("inventory:Disreset",source)
				TriggerClientEvent("Notify",source,"amarelo","O veículo do seu contrato foi encaminhado para o <b>Impound</b> e o <b>Lester</b> disse que você poe assinar um novo contrato quando quiser.",10000)

				local reputationValue = vRP.checkReputation(user_id,"Dismantle")
				if reputationValue <= 1001 then
					vRP.insertReputation(user_id,"Dismantle",20)
				end

				vRP.upgradeStress(user_id,10)
			end
			Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:removeTyres")
AddEventHandler("inventory:removeTyres",function(Entity,Tyre)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source,Entity[4],Tyre) == 1000.0 then
				if vRP.checkMaxItens(user_id,"tyres",1) then
					TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					return
				end

				if vRP.userPlate(Entity[1]) then
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("inventory:Buttons",source,true)
					vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

					if vTASKBAR.taskTyre(source) then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress",source,10000)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil

								local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
								if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
									if vCLIENT.tyreHealth(source,Entity[4],Tyre) == 1000.0 then
										vRP.generateItem(user_id,"tyres",1,true)

										local Players = vRPC.Players(source)
										for _,v in ipairs(Players) do
											async(function()
												TriggerClientEvent("inventory:explodeTyres",v,Entity[4],Entity[1],Tyre)
											end)
										end
									end
								end
							end

							Wait(100)
						until Active[user_id] == nil
					end

					TriggerClientEvent("inventory:Buttons",source,false)
					vRPC.removeObjects(source)
				end
			end
		end
	end
end)