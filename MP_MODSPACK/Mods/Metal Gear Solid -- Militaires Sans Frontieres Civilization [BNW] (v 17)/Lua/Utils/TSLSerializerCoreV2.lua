-- TSLSerializerCore
-- Version: 2
-- Author: DarkScythe
-- DateCreated: 1/12/2015 2:24:51 PM
--------------------------------------------------------------
print("Loading TSLSerializerCoreV2.lua...")
--------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE.
--------------------------------------------------------------
--[[
WHAT THIS IS:

This script is a work-around for the game's inherent limitation of the input handler system interfering with TableSaverLoader across multiple mods / contexts.

Mods which use TableSaverLoader's Lua-only savegame interception system require the use of an input handler hooked up to its current context to catch game saves.

Unfortunately, only the last mod / context to load this input handler will be able to do so, and manual saves will only save that particular mod's data, leaving all other mods' data unsaved until the next autosave.
--------------------------------------------------------------
WHAT THIS DOES:

This script remedies the input handler limitation by invoking the use of LuaEvents to trigger all associated mods to execute a TableSave() from their own context.
--------------------------------------------------------------
HOW IT WORKS:

This file sets up a "Master" for the TSL Serializer which handles communication among all the "clients" which use this script. Clients request an ID from the Master, which is used to keep track of the various contexts they are calling. The clients also "register" their TSL tables with the Master, which allows the Master to conduct some basic logic to determine whether there are any issues or conflicts among mods and their data tables.

It is important that this file not be modified, unless you know what you are doing.

All modifications should be done in the "client" file, the accompanying TSLSerializer Lua file.
--------------------------------------------------------------
REQUIREMENTS:

This file must be included alongside the mod which uses TableSaverLoader.
It should work with any version, though it has only been tested with the latest (v0.16)
Note that if multiple mods use multiple versions of TableSaverLoader, there may be errors stemming from v0.16 being incompatible with older versions' table structures.

This file must be imported into VFS.

This file is automatically included and called by the client.
No further action is necessary for this file.

Please see the client file for full usage instructions.
--------------------------------------------------------------
VERSION HISTORY:

v2 (Jan 14, 2014)
	- Separated the code into 'Core' and 'Client' files
v1 (Jan 13, 2014)
	- Initial private beta testing release

--]]
--------------------------------------------------------------

--------------------------------------------------------------
-- REMINDER:
-- NO CHANGES ARE NECESSARY IN THIS FILE.
--------------------------------------------------------------

MapModData.TSLTriggers = MapModData.TSLTriggers or {}
TSLTriggers = MapModData.TSLTriggers

bBarbTurnSaved = TSLMaster.barbTurnSaved or false

-- MapModData is not cleared when reloading during a game
if TSLMaster.isActive and TSLMaster.gameBegun then
	print("Resetting TSL Master for a loaded game...")
	for data in pairs(MapModData.TSLMaster) do
		MapModData.TSLMaster[data] = nil
	end
	for data in pairs(MapModData.TSLTriggers) do
		MapModData.TSLTriggers[data] = nil
	end
	print("Reinitializing globals...")
	MapModData.TSLMaster = MapModData.TSLMaster or {}
	TSLMaster = MapModData.TSLMaster
	iTSLIndex = TSLMaster.tableIndex or 1
	bBarbTurnSaved = TSLMaster.barbTurnSaved or false
	MapModData.TSLTriggers = MapModData.TSLTriggers or {}
	TSLTriggers = MapModData.TSLTriggers
end

function TSLGameBegun()
	print("Game control acquired by player. TSL Master standing by...")
	MapModData.TSLMaster.gameBegun = true
end

function GetTSLTableIndex()
	print("Index is currently " .. tostring(iTSLIndex))
	local iNextIndex = #TSLTriggers + 1
	TSLMaster.tableIndex = iNextIndex
	print("TSL Master assigning index of " .. tostring(iNextIndex) .. " to ID request.")
end

function TriggerTableSaves()
	local iLastTurnSaved = TSLMaster.lastTurnSaved or 0
	local iCurrentTurn = Game.GetGameTurn()
	local bIsBarbTurn = Players[63]:IsTurnActive()
	if iCurrentTurn == iLastTurnSaved and bIsBarbTurn and bBarbTurnSaved then
		return
	else
		for i = 1, #TSLTriggers do
			local tTableToSave = TSLTriggers[i][1]
			local sTargetDBTableName = TSLTriggers[i][2]
			print("Processing data for save operation into '" .. tostring(sTargetDBTableName) .."'")
			TSLMaster.processTableID = i
			LuaEvents.TriggerTSLTableSave()
		end
		TSLMaster.lastTurnSaved = iCurrentTurn
		if not bIsBarbTurn and bBarbTurnSaved then
			bBarbTurnSaved = false
		elseif bIsBarbTurn and not bBarbTurnSaved then
			bBarbTurnSaved = true
		end
	end
end

function AddTableToTSLMaster(gTSLTable, sDBTableName)
	assert(type(gTSLTable) == "table", "Error! Defined global table is not a table! Received: " .. type(gTSLTable))
	assert(type(sDBTableName) == "string", "Error! Defined table name is not a string! Received: " .. type(sDBTableName))
	local bRegistered = false
	for i = 1, #TSLTriggers do
		if TSLTriggers[i][1] == gTSLTable and TSLTriggers[i][2] == sDBTableName then
			print("Table has already been registered. Duplicate registration ignored.")
			bRegistered = true
			break
		elseif TSLTriggers[i][1] == MapModData or TSLTriggers[i][1] == MapModData.gT then
			print("This is the default Global table! Unrelated data may cause issues!")
		elseif TSLTriggers[i][1] == gTSLTable then
			print("Global table is already being saved! Contents will be duplicated!")
		elseif TSLTriggers[i][2] == sDBTableName then
			print("Table name is already in use! This may result in undesirable consequences!")
		end
	end
	if not bRegistered then
		print("Registering table '" .. tostring(sDBTableName) .. "' for use with TSLSerializer...")
		TSLTriggers[#TSLTriggers + 1] = {gTSLTable, sDBTableName}
	end
end

-- Initiate Master code
if not TSLMaster.isActive then
	print("LuaEvents for TSL Master not yet active. Enabling...")
	TSLMaster.isActive = true
	LuaEvents.GetTSLIndex.Add(GetTSLTableIndex)
	LuaEvents.TSLTableSave.Add(TriggerTableSaves)
	LuaEvents.RegisterTSLTable.Add(AddTableToTSLMaster)
	Events.LoadScreenClose.Add(TSLGameBegun)
end

--------------------------------------------------------------
-- TableSaverLoader Hookup Code
--------------------------------------------------------------

local function InputHandler(uiMsg, wParam, lParam)
	if uiMsg == KeyEvents.KeyDown then
		if wParam == Keys.VK_F11 then
			QuickSaveIntercept()
	        return true
		elseif wParam == Keys.S and UIManager:GetControl() then
			SaveGameIntercept()
			return true
		end
	end
end

ContextPtr:SetInputHandler(InputHandler)

--------------------------------------------------------------
-- All functions loaded.
--------------------------------------------------------------
print("Core TSL Serializer components loaded successfully.")