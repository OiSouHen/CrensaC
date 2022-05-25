-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("keyboard",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Status = ""
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUCESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("success",function(data)
	SetNuiFocus(false,false)
	Status = data["data"]
	Progress = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FAILURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("failure",function()
	SetNuiFocus(false,false)
	Status = "undefined"
	Progress = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYBOARD
-----------------------------------------------------------------------------------------------------------------------------------------
function Keyboard(Data)
	if Progress then return end

	Progress = true
	Citizen.Wait(100)
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "OPEN_MENU", data = Data })

	while Progress do
		Citizen.Wait(0)
	end

	if Status ~= "undefined" then
		return Status
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
function Password(First)
	local Array = Keyboard({
		rows = {
			{
				id = 0,
				txt = First,
				copy = "undefined",
				area = "undefined",
				word = true
			}
		}
	})

	if Array then
		if Array[1]["input"] == nil then
			return false
		end

		return { Array[1]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONESTEP
-----------------------------------------------------------------------------------------------------------------------------------------
function OneStep(First)
	local Array = Keyboard({
		rows = {
			{
				id = 0,
				txt = First,
				copy = "undefined",
				area = "undefined",
				word = "undefined"
			}
		}
	})

	if Array then
		if Array[1]["input"] == nil then
			return false
		end

		return { Array[1]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TWOSTEP
-----------------------------------------------------------------------------------------------------------------------------------------
function TwoStep(First,Second)
	local Array = Keyboard({
		rows = {
			{
				id = 0,
				txt = First,
				copy = "undefined",
				area = "undefined",
				word = "undefined"

			},{
				id = 1,
				txt = Second,
				copy = "undefined",
				area = "undefined",
				word = "undefined"

			}
		}
	})

	if Array then
		if Array[1]["input"] == nil or Array[2]["input"] == nil then
			return false
		end

		return { Array[1]["input"],Array[2]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREESTEP
-----------------------------------------------------------------------------------------------------------------------------------------
function ThreeStep(First,Second,Third)
	local Array = Keyboard({
		rows = {
			{
				id = 0,
				txt = First,
				copy = "undefined",
				area = "undefined",
				word = "undefined"

			},{
				id = 1,
				txt = Second,
				copy = "undefined",
				area = "undefined",
				word = "undefined"

			},{
				id = 2,
				txt = Third,
				copy = "undefined",
				area = "undefined",
				word = "undefined"

			}
		}
	})

	if Array then
		if Array[1]["input"] == nil or Array[2]["input"] == nil or Array[3]["input"] == nil then
			return false
		end

		return { Array[1]["input"],Array[2]["input"],Array[3]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREEFOURTH
-----------------------------------------------------------------------------------------------------------------------------------------
function ThreeFourth(First,Second,Third,Fourth)
	local Array = Keyboard({
		rows = {
			{
				id = 0,
				txt = First,
				copy = "undefined",
				area = "undefined",
				word = "undefined"

			},{
				id = 1,
				txt = Second,
				copy = "undefined",
				area = "undefined",
				word = "undefined"

			},{
				id = 2,
				txt = Third,
				copy = "undefined",
				area = "undefined",
				word = "undefined"

			},{
				id = 3,
				txt = Fourth,
				copy = "undefined",
				area = true,
				word = "undefined"

			}
		}
	})

	if Array then
		if Array[1]["input"] == nil or Array[2]["input"] == nil or Array[3]["input"] == nil or Array[4]["input"] == nil then
			return false
		end

		return { Array[1]["input"],Array[2]["input"],Array[3]["input"],Array[4]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COPYSTEP
-----------------------------------------------------------------------------------------------------------------------------------------
function CopyStep(First,Copy)
	local Array = Keyboard({
		rows = {
			{
				id = 0,
				txt = First,
				copy = Copy,
				area = "undefined",
				word = "undefined"

			}
		}
	})

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AREASTEP
-----------------------------------------------------------------------------------------------------------------------------------------
function AreaStep(First)
	local Array = Keyboard({
		rows = {
			{
				id = 0,
				txt = First,
				copy = "undefined",
				area = true,
				word = "undefined"

			}
		}
	})

	if Array then
		if Array[1]["input"] == nil then
			return false
		end

		return { Array[1]["input"] }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYWORD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.keyWord(First)
	return Password(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYSINGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.keySingle(First)
	return OneStep(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYDOUBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.keyDouble(First,Second)
	return TwoStep(First,Second)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYTRIPLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.keyTriple(First,Second,Third)
	return ThreeStep(First,Second,Third)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYFOURTH
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.keyFourth(First,Second,Third,Fourth)
	return ThreeFourth(First,Second,Third,Fourth)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.keyArea(First)
	return AreaStep(First)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYCOPY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.keyCopy(First,Copy)
	return CopyStep(First,Copy)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("keyCopy",CopyStep)
exports("keyArea",AreaStep)
exports("keyWord",Password)
exports("keySingle",OneStep)
exports("keyDouble",TwoStep)
exports("keyTriple",ThreeStep)
exports("keyFourth",ThreeFourth)