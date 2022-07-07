-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tools = module("lib/Tools")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local requests = {}
local request_ids = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.request(source,text,accept,reject)
	local r = async()
	local id = request_ids:gen()
	local request = { source = source, cb_ok = r, done = false }
	requests[id] = request

	vRPC.request(source,id,text,accept,reject)

	SetTimeout(30000,function()
		if not request.done then
			request.cb_ok(false)
			request_ids:free(id)
			requests[id] = nil
		end
	end)

	return r:wait()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRESULT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.requestResult(id,ok)
	local request = requests[id]
	if request and request.source == source then
		request.done = true
		request.cb_ok(not not ok)
		request_ids:free(id)
		requests[id] = nil
	end
end