--[[
/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
										NET SYNC TOOLS
										  version 1
										  
	Utility for hijacking the Network.SendSellBuilding function and the GameEvents.CitySoldBuilding hook to send
data from custom UI elements through the network in a multiplayer game. Maintains a single table of integers and
keys used by all mods using the same utility, so there are no conflicts.
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\   
]]


---------------------------------------------------------------------------------------------------------------
-- DUPLICATE PREVENTION
---------------------------------------------------------------------------------------------------------------
if not MapModData.gNetSyncToolsInitialized then MapModData.gNetSyncToolsInitialized = false end

if MapModData.gNetSyncToolsInitialized == false then
	MapModData.gNetSyncToolsInitialized = true
else
	return
end


function OnGameLoaded()
	MapModData.gNetSyncToolsInitialized = false
end
Events.SequenceGameInitComplete.Add(OnGameLoaded)

---------------------------------------------------------------------------------------------------------------
-- DEBUG MODE
---------------------------------------------------------------------------------------------------------------
--Make print a nil-returning function if debug mode is off.
local bDebug = false
function dprint(str)
	if bDebug then print(str) end
end

---------------------------------------------------------------------------------------------------------------
-- TABLES AND CONSTANTS
---------------------------------------------------------------------------------------------------------------
local iMaximum = 2147483647   --maximum size accepted by CitySoldBuilding, equivalent to maximum size of a C++ int


local tNetSyncFunctions = {}  	--This table holds all the functions, and they are referenced by string keys.
local tKeyLookup = {}		--This table holds all of the string keys for the above table, and the keys for this table are integers. This is what will be used to look up the string key for a function in the above table.
local tInitialKeys = {}		--This table holds the first "building ID" integer for each string key. The script will look this up and subtract it from the actual number passed to it, so that we can do stuff like sneak Unit IDs through to the function.


--Assign the dummy key of "DONOTUSE" to everything that's actually a building in the database. When an *actual* building is *actually sold* by a player, nothing major here should happen!
for row in GameInfo.Buildings() do
	tKeyLookup[row.ID] = "DONOTUSE"
end
tKeyLookup[-1] = "DONOTUSE"

tNetSyncFunctions["DONOTUSE"] = (function() print("Actual building sold - no function called") end)



---------------------------------------------------------------------------------------------------------------
-- ADD FUNCTION TO TABLE
---------------------------------------------------------------------------------------------------------------
--Add a function to the table from LuaEvents.
--This requires the function itself, a string key to tag the function (since a single function can take up more than one "building ID" integers), and how many "building IDs" to reserve.
--iNumbersToReserve is generally 1 (and defaults to 1 if the user did not define it).
--However, in cases such as when the ID of a Unit must be passed, a large number of reserved numbers will be needed.
--The functions will be passed the lowest possible number of the function, so that they can subtract that from the actual building ID that was passed.
--example: a function's first reserved "buildingID" is 1000000, and it is used for a unit action button. The function must be called for a unit with UnitID 123456.
--The user's Lua script must have reserved roughly 8 digits worth of numbers, and will use Network.SendSellBuilding with buildingID 1123456.
--NetSyncTools will subtract 1000000 from the passed number to get 123456, so we have snuck a UnitID through to the function!
function AddNetSyncFunction(fFunc, sKey, iNumbersToReserve)
	if ((not iNumbersToReserve) or iNumbersToReserve <= 0) then iNumbersToReserve = 1 end
	dprint("Adding NetSyncFunction for key "..sKey.." and allocating "..iNumbersToReserve.." slot(s) for it.")
	tNetSyncFunctions[sKey] = fFunc
	local bInitialKey = false
	for i = #tKeyLookup + 1, #tKeyLookup + iNumbersToReserve, 1 do
		if i > iMaximum then
			dprint("Maximum number of NetSyncFunctions reached. Cannot add additional functions for key "..sKey..".")
			return
		else
			tKeyLookup[i] = sKey
			if not bInitialKey then
				bInitialKey = true
				tInitialKeys[sKey] = i
			end
		end
	end
end
LuaEvents.AddNetSyncFunction.Add(AddNetSyncFunction)


---------------------------------------------------------------------------------------------------------------
-- CALL NET SYNC LUA EVENT
---------------------------------------------------------------------------------------------------------------
--Other scripts will call this from LuaEvents to do a function which needs to be synced across the network.
function NetSyncCall(sKey, iCity, iData1)
	local iPlayer = Game:GetActivePlayer() 
	dprint("NetSyncCall made with key "..sKey.." from player "..iPlayer..".")
	if not iCity then
		dprint("iCity undefined. Getting ID of player's capital.")
		local pCity = Players[iPlayer]:GetCapitalCity()
		if pCity then
			iCity = pCity:GetID()
		else
			dprint("Error: Player "..iPlayer.." does not have a city. SendSellBuilding can't be called if the player doesn't have at least one city!")
		end
	end

	if iData1 then
		dprint("Has additional integer data with value "..iData1..".")
	end
	
	if tNetSyncFunctions[sKey] then
		dprint("A function was found with this key.")
		local iNumber = tInitialKeys[sKey]
		if iNumber then
			dprint("Fake building ID for this key is "..iNumber..".")
			if iData1 then
				local iNewNumber = iNumber + iData1
				if tKeyLookup[iNewNumber] and tKeyLookup[iNewNumber] == sKey then
					print("Additional data of "..iData1.." added.")
					iNumber = iNewNumber
				else
					dprint("Error: additional data makes the building ID not match its corresponding key. Will not be sent.")
				end
			end
			dprint("Sending SellBuilding with number "..iNumber..".")
			Network.SendSellBuilding(iCity, iNumber)
		end
	end
end
LuaEvents.NetSyncCall.Add(NetSyncCall)


---------------------------------------------------------------------------------------------------------------
-- CITY SOLD BUILDING NETWORK HANDLER
---------------------------------------------------------------------------------------------------------------
--This will be triggered on all machines due to Network.SendSellBuilding. It actually does the function which NetSyncCall sends through the network.
function DoNetSyncFunction(iPlayer, iCity, iBuildingID)
	dprint("SendSellBuilding called.")
	if tKeyLookup[iBuildingID] then
		local sKey = tKeyLookup[iBuildingID]
		dprint("Building ID "..iBuildingID.." has a matching key of "..sKey..".")
		if tNetSyncFunctions[sKey] then
			dprint("And the above key has a function.")
			local iData1 = iBuildingID - tInitialKeys[sKey]
			dprint("Executing this function for player ID "..iPlayer..", city ID "..iCity..", and additional integer data "..iData1..".")
			tNetSyncFunctions[sKey](iPlayer, iCity, iData1)
		end
	end
end
GameEvents.CitySoldBuilding.Add(DoNetSyncFunction)
