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
Tunnel.bindInterface("shops",cRP)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["Weeds"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["silk"] = 3
		}
	},
	["Imoveis"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["contract1"] = 125000,
			["contract2"] = 300000,
			["contract3"] = 75000,
			["contract4"] = 175000,
			["contract5"] = 125000,
			["contract6"] = 250000,
			["contract7"] = 75000,
			["contract8"] = 250000,
			["contract9"] = 175000,
			["contract10"] = 100000
		}
	},
	["Identity"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 5000
		}
	},
	["Identity2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["fidentity"] = 10000
		}
	},
	["Petz"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["rottweiler"] = 25000,
			["husky"] = 25000,
			["shepherd"] = 25000,
			["retriever"] = 25000,
			["poodle"] = 25000,
			["pug"] = 25000,
			["westy"] = 25000,
			["cat"] = 25000
		}
	},
	["OldDepartament"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["sugar"] = 6,
			["cheese"] = 10,
			["postit"] = 20,
			["notepad"] = 10,
			["hamburger"] = 25,
			["emptybottle"] = 30,
			["cigarette"] = 10,
			["lighter"] = 175,
			["chocolate"] = 15,
			["sandwich"] = 15,
			["chandon"] = 15,
			["dewars"] = 15,
			["hennessy"] = 15,
			["absolut"] = 15,
			["tacos"] = 22,
			["cola"] = 15,
			["soda"] = 15,
			["coffee"] = 20,
			["bread"] = 5
		}
	},
	["Departament"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["sugar"] = 5,
			["binoculars"] = 275,
			["notepad"] = 10,
			["cellphone"] = 575,
			["cigarette"] = 10,
			["rope"] = 875,
			["camera"] = 275,
			["firecracker"] = 100,
			["emptybottle"] = 30,
			["lighter"] = 175,
			["postit"] = 20,
			["rose"] = 25,
			["radio"] = 975,
			["scanner"] = 6750,
			["vape"] = 4750
		}
	},
	["Clothes"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["teddy"] = 75,
			["WEAPON_BRICK"] = 25,
			["WEAPON_SHOES"] = 25,
			["rope"] = 875
		}
	},
	["Mechanic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_WRENCH"] = 725,
			["toolbox"] = 625,
			["advtoolbox"] = 1525,
			["tyres"] = 225,
			["WEAPON_CROWBAR"] = 725
		}
	},
	["mechanicBuy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Mechanic",
		["list"] = {
			["WEAPON_WRENCH"] = 365,
			["toolbox"] = 315,
			["advtoolbox"] = 765,
			["tyres"] = 115,
			["WEAPON_CROWBAR"] = 365
		}
	},
	["Weapons"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["pistolbody"] = 425,
			["smgbody"] = 525,
			["riflebody"] = 625
		}
	},
	["Oxy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["oxy"] = 35
		}
	},
	["Pharmacy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["analgesic"] = 125,
			["gauze"] = 100,
			["bandage"] = 225,
			["medkit"] = 575
		}
	},
	["Paramedic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["badge04"] = 10,
			["syringe"] = 2,
			["gauze"] = 175,
			["medkit"] = 525,
			["sinkalmy"] = 325,
			["analgesic"] = 100,
			["ritmoneury"] = 425,
			["wheelchair"] = 2750,
			["defibrillator"] = 325,
			["medicbag"] = 425,
			["badge02"] = 10
		}
	},
	["Ammunation"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["GADGET_PARACHUTE"] = 475,
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BAT"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_HAMMER"] = 725,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_KATANA"] = 975,
			["WEAPON_KARAMBIT"] = 975,
			["WEAPON_POOLCUE"] = 975,
			["WEAPON_STONE_HATCHET"] = 975,
			["WEAPON_KNUCKLE"] = 975,
			["WEAPON_FLASHLIGHT"] = 675
		}
	},
	["Premium"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["newchars"] = 75,
			["chip"] = 60,
			["gemstone"] = 1,
			-- ["subscriber"] = 10,
			["backalohomorawhite"] = 75,
			["backalohomorablack"] = 75,
			["backalohomorared"] = 75,
			["backrudolphpurple"] = 75,
			["backrudolphred"] = 75,
			["backpolice"] = 75,
			["backcamping"] = 50,
			["backcyclist"] = 50,
			["backschool"] = 50,
			["backwar"] = 75,
			["premiumplate"] = 50,
			["premium"] = 75,
			["namechange"] = 50
			-- ["newgarage"] = 30,
		}
	},
	["Fishing"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["octopus"] = 20,
			["shrimp"] = 20,
			["carp"] = 18,
			["horsefish"] = 18,
			["tilapia"] = 20,
			["codfish"] = 22,
			["catfish"] = 22,
			["goldenfish"] = 24,
			["pirarucu"] = 24,
			["pacu"] = 24,
			["tambaqui"] = 24
		}
	},
	["Fishing2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bait"] = 4,
			["fishingrod"] = 725
		}
	},
	["Hunting2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["switchblade"] = 525,
			["WEAPON_MUSKET"] = 3250,
			["WEAPON_MUSKET_AMMO"] = 7
		}
	},
	["Hunting"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["meat"] = 20,
			["animalpelt"] = 25,
			["tomato"] = 8,
			["banana"] = 6,
			["passion"] = 6,
			["grape"] = 6,
			["tange"] = 6,
			["orange"] = 6,
			["apple"] = 6,
			["strawberry"] = 6,
			["coffee2"] = 6,
			["animalfat"] = 10,
			["leather"] = 25
		}
	},
	["Recycle"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["key"] = 45,
			["notepad"] = 5,
			["plastic"] = 8,
			["glass"] = 8,
			["rubber"] = 8,
			["aluminum"] = 10,
			["copper"] = 10,
			["radio"] = 485,
			["rope"] = 435,
			["cellphone"] = 285,
			["binoculars"] = 135,
			["emptybottle"] = 15,
			["switchblade"] = 215,
			["camera"] = 135,
			["vape"] = 2375,
			["rose"] = 15,
			["lighter"] = 75,
			["teddy"] = 35,
			["tyres"] = 50,
			["bait"] = 2,
			["firecracker"] = 50,
			["fishingrod"] = 365,
			["divingsuit"] = 485,
			["newspaper"] = 15,
			["silvercoin"] = 5,
			["goldcoin"] = 10
		}
	},
	["Miners"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["emerald"] = 75,
			["diamond"] = 55,
			["ruby"] = 35,
			["sapphire"] = 30,
			["amethyst"] = 25,
			["amber"] = 20,
			["turquoise"] = 15
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 20
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["donut"] = 15,
			["chocolate"] = 15
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 25
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 15
		}
	},
	["Chihuahua"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 15,
			["hamburger"] = 25,
			["coffee"] = 20,
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 30
		}
	},
	["Police"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["vest"] = 325,
			["gsrkit"] = 35,
			["gdtkit"] = 35,
			["barrier"] = 125,
			["handcuff"] = 425,
			["WEAPON_SMG"] = 3250,
			["WEAPON_PUMPSHOTGUN"] = 4250,
			["WEAPON_CARBINERIFLE"] = 5250,
			["WEAPON_SMOKEGRENADE"] = 975,
			["WEAPON_CARBINERIFLE_MK2"] = 6250,
			["WEAPON_STUNGUN"] = 2250,
			["WEAPON_COMBATPISTOL"] = 3250,
			["WEAPON_HEAVYPISTOL"] = 3750,
			["WEAPON_NIGHTSTICK"] = 425,
			["WEAPON_PISTOL_AMMO"] = 8,
			["WEAPON_SMG_AMMO"] = 10,
			["WEAPON_RIFLE_AMMO"] = 12,
			["WEAPON_SHOTGUN_AMMO"] = 15,
			["badge01"] = 10
		}
	},
	["Criminal"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["keyboard"] = 45,
			["mouse"] = 45,
			["playstation"] = 50,
			["xbox"] = 50,
			["dish"] = 45,
			["pan"] = 70,
			["fan"] = 45,
			["blender"] = 45,
			["switch"] = 20,
			["cup"] = 70,
			["lampshade"] = 60
		}
	},
	["Criminal2"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["silverring"] = 45,
			["goldring"] = 70,
			["watch"] = 50,
			["bracelet"] = 50,
			["dildo"] = 45,
			["spray01"] = 45,
			["spray02"] = 45,
			["spray03"] = 45,
			["spray04"] = 45,
			["slipper"] = 40,
			["rimel"] = 45,
			["brush"] = 45,
			["soap"] = 40
		}
	},
	["Criminal3"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["eraser"] = 40,
			["legos"] = 45,
			["ominitrix"] = 45,
			["dices"] = 20,
			["domino"] = 35,
			["floppy"] = 30,
			["horseshoe"] = 45,
			["deck"] = 40
		}
	},
	["Criminal4"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["goldbar"] = 450,
			["brokenpick"] = 40,
			["pliers"] = 40,
			["pager"] = 110,
			["card01"] = 275,
			["card02"] = 275,
			["card03"] = 300,
			["card04"] = 225,
			["card05"] = 315,
			["pendrive"] = 275
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------
local nameMale = { "James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio" }
local nameFemale = { "Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna","Rebecca","Virginia","Kathleen","Pamela","Martha","Debra","Amanda","Stephanie","Carolyn","Christine","Marie","Janet","Catherine","Frances","Ann","Joyce","Diane","Alice","Julie","Heather","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred","Katherine","Joan","Ashley","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly","Denise","Tammy","Irene","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Louise","Sara","Anne","Jacqueline","Wanda","Bonnie","Julia","Ruby","Lois","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian","Emily","Robin" }
local userName2 = { "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			return false
		end

		if exports["hud"]:Wanted(user_id,source) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasGroup(user_id,shops[shopType]["perm"]) then
				return false
			end
		end
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local shopSlots = 20
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ key = k, price = parseInt(v), name = itemName(k), index = itemIndex(k), peso = itemWeight(k), type = itemType(k), max = itemMaxAmount(k), desc = itemDescription(k), economy = itemEconomy(k) })
		end

		local inventoryUser = {}
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

			inventoryUser[k] = v
		end

		if parseInt(#inventoryShop) > 20 then
			shopSlots = parseInt(#inventoryShop)
		end

		return inventoryShop,inventoryUser,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),shopSlots
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getShopType(name)
    return shops[name]["mode"]
end---------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shops[shopType] then
			if shopAmount == nil then shopAmount = 1 end
			if shopAmount <= 0 then shopAmount = 1 end

			local inventory = vRP.userInventory(user_id)
			if (inventory[tostring(slot)] and inventory[tostring(slot)]["item"] == shopItem) or inventory[tostring(slot)] == nil then
				if shops[shopType]["mode"] == "Buy" then
					if vRP.checkMaxItens(user_id,shopItem,shopAmount) then
						TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
						vCLIENT.updateShops(source,"requestShop")
						return
					end

					if (vRP.inventoryWeight(user_id) + (itemWeight(shopItem) * parseInt(shopAmount))) <= vRP.getWeight(user_id) then
						if shops[shopType]["type"] == "Cash" then
							if shops[shopType]["list"][shopItem] then
								if vRP.paymentFull(user_id,shops[shopType]["list"][shopItem] * shopAmount) then
									if shopItem == "identity" or string.sub(shopItem,1,5) == "badge" then
										vRP.generateItem(user_id,shopItem.."-"..user_id,parseInt(shopAmount),false,slot)
									elseif shopItem == "fidentity" then
										local identity = vRP.userIdentity(user_id)
										if identity then
											if identity["sex"] == "M" then
												vRP.execute("fidentity/newIdentity",{ name = nameMale[math.random(#nameMale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											else
												vRP.execute("fidentity/newIdentity",{ name = nameFemale[math.random(#nameFemale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											end

											local identity = vRP.userIdentity(user_id)
											local consult = vRP.query("fidentity/lastIdentity")
											if consult[1] then
												vRP.generateItem(user_id,shopItem.."-"..consult[1]["id"],parseInt(shopAmount),false,slot)
											end
										end
									else
										vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
									end

									TriggerClientEvent("sounds:source",source,"cash",0.1)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
								end
							end
						elseif shops[shopType]["type"] == "Consume" then
							if vRP.tryGetInventoryItem(user_id,shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem] * shopAmount)) then
								vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
								TriggerClientEvent("sounds:source",source,"cash",0.1)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(shops[shopType]["item"]).."</b> insuficiente.",5000)
							end
						elseif shops[shopType]["type"] == "Premium" then
							if vRP.paymentGems(user_id,shops[shopType]["list"][shopItem] * shopAmount) then
								TriggerClientEvent("sounds:source",source,"cash",0.1)
								vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
								TriggerClientEvent("Notify",source,"verde","Comprou <b>"..parseFormat(shopAmount).."x "..itemName(shopItem).."</b> por <b>"..parseFormat(shops[shopType]["list"][shopItem] * shopAmount).." Gemas</b>.",5000)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				elseif shops[shopType]["mode"] == "Sell" then
					local splitName = splitString(shopItem,"-")

					if shops[shopType]["list"][splitName[1]] then
						local itemPrice = shops[shopType]["list"][splitName[1]]

						if itemPrice > 0 then
							if vRP.checkBroken(shopItem) then
								TriggerClientEvent("Notify",source,"vermelho","Itens quebrados não podem ser vendidos.",5000)
								vCLIENT.updateShops(source,"requestShop")
								return
							end
						end

						if shops[shopType]["type"] == "Cash" then
							if vRP.tryGetInventoryItem(user_id,shopItem,parseInt(shopAmount),true,slot) then
								if itemPrice > 0 then
									vRP.generateItem(user_id,"dollars",parseInt(itemPrice * shopAmount),false)
									TriggerClientEvent("sounds:source",source,"cash",0.1)
								end
							end
						elseif shops[shopType]["type"] == "Consume" then
							if vRP.tryGetInventoryItem(user_id,shopItem,parseInt(shopAmount),true,slot) then
								if itemPrice > 0 then
									vRP.generateItem(user_id,shops[shopType]["item"],parseInt(itemPrice * shopAmount),false)
									TriggerClientEvent("sounds:source",source,"cash",0.1)
								end
							end
						end
					end
				end
			end
		else
			print(shopType,shopItem,shopAmount,slot)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
			vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			vCLIENT.updateShops(source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inventory = vRP.userInventory(user_id)
		if inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
				vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			end
		else
			vRP.swapSlot(user_id,slot,target)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DIVINGSUIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:divingSuit")
AddEventHandler("shops:divingSuit",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source,"Comprar <b>Roupa de Mergulho</b> por <b>$975</b>?") then
			if vRP.paymentFull(user_id,975) then
				vRP.generateItem(user_id,"divingsuit",1,true)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)