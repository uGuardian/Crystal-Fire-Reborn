-- Nanoha_ArchHelper
-- Author: Vicevirtuoso
-- DateCreated: 2/19/2014 12:12:13 AM
--------------------------------------------------------------

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS

MapModData.Nanoha = {}
Nanoha = MapModData.Nanoha

include("TableSaverLoader016.lua")
include("TSLSerializerV2Nanoha.lua")

--set to true to enable print statements
local bDebug = false

function dprint(...)
  if (bDebug) then
    print(string.format(...))
  end
end

----------------------------------------------------------------------------------------------------------------------------------------------------
--Used for TableSaverLoader
----------------------------------------------------------------------------------------------------------------------------------------------------
function DataLoad() --called from end of last mod file to load	
	local bNewGame = not TableLoad(Nanoha, "NanohaMod")

	TableSave(Nanoha, "NanohaMod")  --before the initial autosave that runs for both new and loaded games
end

DataLoad()

-- from http://lua-users.org/wiki/SplitJoin
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function GetPlotSpecialID(iX, iY)
	return iX..":"..iY
end

function ReturnPlotFromSpecialID(ID)
	local temptable = split(ID, ":");
	local iX = tonumber(temptable[1])
	local iY = tonumber(temptable[2])
	local pPlot = Map.GetPlot(iX, iY)
	return pPlot
end

--Variable to detect if CultureOverview popup is up; this is the only time that the UpdateLostLogiaBuildingsUI() function should run
local bPopup;

--Precache all buildings that have Great Works of Art to make things go significantly faster
local tGreatArtBuildings = {};
for pBuilding in GameInfo.Buildings() do
	if pBuilding.GreatWorkSlotType == "GREAT_WORK_SLOT_ART_ARTIFACT" and pBuilding.GreatWorkCount > 0 then
		local pBuildingClass = GameInfo.BuildingClasses("Type = '" ..pBuilding.BuildingClass.. "'")()
		--Save BuildingClasses instead of BuildingTypes since GetBuildingGreatWork() calls for Classes
		tGreatArtBuildings[pBuildingClass.ID] = pBuildingClass.Type
		dprint("Added buildingclass " ..Locale.ConvertTextKey(pBuildingClass.Description).. " to Great Work building table")
	end
end


--Precache all Lost Logias to make things go faster
local tLostLogiaTypes = {}
local tLostLogiaBuildings = {}
local iMaxPossibleLostLogia = 0;


for work in GameInfo.GreatWorks() do
	if work.LostLogiaBuilding ~= nil then
		iMaxPossibleLostLogia = iMaxPossibleLostLogia + 1;
		tLostLogiaTypes[work.ID] = work.Type
		tLostLogiaBuildings[work.ID] = GameInfo.Buildings("Type = '" ..work.LostLogiaBuilding.. "'")().ID
	end
end

dprint("Maximum possible Lost Logia: " ..iMaxPossibleLostLogia)


--New version of function: Cache all Logia plots at the beginning. No more running chances per turn.
Nanoha.LostLogiaPlots = Nanoha.LostLogiaPlots or {}
local iNumLogiaSet = 0;

function PlaceLostLogia()
	if not Nanoha.AreLostLogiasPlacedYet then
		for iPlot = 0, Map:GetNumPlots() - 1 do
			local pPlot = Map.GetPlotByIndex(iPlot)
			if pPlot:GetResourceType() == GameInfoTypes.RESOURCE_ARTIFACTS or pPlot:GetResourceType() == GameInfoTypes.RESOURCE_HIDDEN_ARTIFACTS then
				local iChance = Game.Rand(99, "Lost Logia Chance") + 1;
				dprint("Random roll for Logia on plot at "..pPlot:GetX()..", "..pPlot:GetY()..": "..iChance)
				local iThreshold = 0;
				if pPlot:GetResourceType() == GameInfoTypes.RESOURCE_ARTIFACTS then
					dprint("Regular antiquity site")
					iThreshold = 25
				elseif pPlot:GetResourceType() == GameInfoTypes.RESOURCE_HIDDEN_ARTIFACTS then
					dprint("Hidden antiquity site")
					iThreshold = 50
				end
				if iThreshold > 0 and iThreshold <= iChance then
					dprint("Inserting Lost Logia on this plot.")
					Nanoha.AreLostLogiasPlacedYet = true
					local iKey = GetPlotSpecialID(pPlot:GetX(), pPlot:GetY())
					Nanoha.LostLogiaPlots[iKey] = true
					iNumLogiaSet = iNumLogiaSet + 1
					if iMaxPossibleLostLogia <= iNumLogiaSet then
						dprint("Max possible Lost Logia placed on map.")
						break
					end
				end
			end
		end
	end
end

Events.LoadScreenClose.Add(PlaceLostLogia)


function CanMapPlaceLostLogia(iTeam, iTech, iChange)
	if not Nanoha.AreLostLogiasPlacedYet then
		print(iTech)
		local tech = GameInfo.Technologies[iTech]
		print(tech.Description)
		if tech.TriggersArchaeologicalSites == true then
			print("Do PlaceLostLogia function")
			PlaceLostLogia()
		end
	end
end
GameEvents.TeamTechResearched.Add(CanMapPlaceLostLogia) --antiquity sites are initialized upon discovery of Archaeology




--This is passed information from ChooseArchaeologyPopup to get the unit on the specific archaeology plot that the popup is referencing. Used to kill the unit upon
--successful execution of InitLostLogia
pLostLogiaUnitToDelete = nil;

function ClearLLToDelete()
	pLostLogiaUnitToDelete = nil;
end

Events.ActivePlayerTurnEnd.Add(ClearLLToDelete)

--Next four functions pass variables in this script to ChooseArchaeologyPopup
function ReturnRandomChance(pPlayer, iUnitID)
	pLostLogiaUnitToDelete = pPlayer:GetUnitByID(iUnitID)
	return iLostLogiaRandomChance[iUnitID]
end

function ReturnRandomThreshold(pPlayer, iUnitID)
	pLostLogiaUnitToDelete = pPlayer:GetUnitByID(iUnitID)
	return iLostLogiaRandomThreshold[iUnitID]
end

function ReturnExistingLostLogia()
	return iTotalExistingLostLogia
end

function ReturnMaxLostLogia()
	return iMaxPossibleLostLogia
end

--To avoid issues with players being unable to end turn with the Choose Archaeology popup blocking them, the Lost Logia function may spawn a Landmark. This table will
--store the plots where this happened and kill any improvements on them when the Great Work popup is closed. This is not necessary for AIs.
local tExtraLandmarkPlots = {};

function KillExtraLandmarks(iPopup)
	if iPopup == ButtonPopupTypes.BUTTONPOPUP_GREAT_WORK_COMPLETED_ACTIVE_PLAYER then
		for k, v in pairs(tExtraLandmarkPlots) do
			v:SetImprovementType(-1)
			table.remove(tExtraLandmarkPlots, k)
		end
	end
end

Events.SerialEventGameMessagePopupProcessed.Add(KillExtraLandmarks)

--Create a Lost Logia by creating the dummy unit and immediately pushing the "Make Great Work" mission to it. Appears seamless, even if it's a hokey way to make a GW appear.
--Thanks for not giving us a Player:InitGreatWork() function, Firaxis!
--Also refreshes the Logia bonuses for the player who dug it up
function InitLostLogia(pPlayer, pUnit)
	dprint("InitLostLogia function called")
	if not pUnit then
		dprint("pUnit blank, defaulting to pLostLogiaUnitToDelete")
		pUnit = pLostLogiaUnitToDelete
	end
	dprint("Unit ID: " ..pUnit:GetID())
	tExtraLandmarkPlots[pUnit:GetID()] = pUnit:GetPlot()
	local pPlot = pUnit:GetPlot()
	--only need to kill the unit if it is an AI player; otherwise, the DLL does it
	if not pPlayer:IsHuman() then
		pPlot:SetImprovementType(-1)
		pPlot:SetResourceType(-1)
		pUnit:Kill()
	end
	local pCapitalPlot = pPlayer:GetCapitalCity():Plot()
	local eLostLogia = pPlayer:InitUnit(GameInfoTypes.UNIT_LOSTLOGIADUMMY, pCapitalPlot:GetX(), pCapitalPlot:GetY())
	eLostLogia:PushMission(MissionTypes.MISSION_CREATE_GREAT_WORK, -1, -1, 0, 0, 0, 0, eLostLogia:GetPlot(), eLostLogia)
	local iKey = GetPlotSpecialID(pPlot:GetX(), pPlot:GetY())
	Nanoha.LostLogiaPlots[iKey] = false
	UpdateLostLogiaBuildings(pPlayer:GetID())
end



--For AI: check for units with the Find Lost Logia promotion at beginning of turn. If it has the promotion, then check if it is on a plot with an antiquity site.
--If it is, then check its turns left to finish. If it has one turn left, call InitLostLogia.
function AILostLogiaCheck(iPlayer)
--	if iMaxPossibleLostLogia <= iTotalExistingLostLogia then
--		return
--	end
	local pPlayer = Players[iPlayer]
	if iPlayer < iMaxCivs and not pPlayer:IsHuman() then
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_FIND_LOST_LOGIA) then
				local pPlot = pUnit:GetPlot()
				local iKey = GetPlotSpecialID(pPlot:GetX(), pPlot:GetY())
				if Nanoha.LostLogiaPlots[iKey] then
					if pPlot:GetResourceType(pPlayer:GetTeam()) == GameInfoTypes.RESOURCE_HIDDEN_ARTIFACTS or pPlot:GetResourceType(pPlayer:GetTeam()) == GameInfoTypes.RESOURCE_ARTIFACTS then
						if pPlot:GetBuildTurnsLeft(GameInfoTypes.BUILD_ARCHAEOLOGY_DIG, 0, 0) <= 1 then
							--pLostLogiaUnitToDelete = pUnit
							InitLostLogia(pPlayer, pUnit)
							ClearLLToDelete()
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(AILostLogiaCheck)

--Check all of a player's buildings at start of turn, and update the Logia bonus buildings accordingly
--Time-consuming function, should look into possibilities of reducing processor impact
function UpdateLostLogiaBuildings(iPlayer)
if iPlayer == 63 then return end
local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and not pPlayer:IsMinorCiv() then
		for pCity in pPlayer:Cities() do
			for iLogia, pLogia in pairs(tLostLogiaTypes) do
				dprint("Testing to see if " ..pLogia.. " is in " ..pCity:GetName())
				local bHasLogia = false;
				local bIsInfinityLibrary = false;
				for iBuildingClass, pBuildingClass in pairs(tGreatArtBuildings) do
					dprint("Checking building class " ..pBuildingClass)
					local iCurrentWorks = pCity:GetNumGreatWorksInBuilding(iBuildingClass)
					if iCurrentWorks > 0 then
						for i = 0, iCurrentWorks - 1, 1 do
							dprint("Testing work slot")
							local iWorkType = pCity:GetBuildingGreatWork(iBuildingClass, i)
							if Game.GetGreatWorkType(iWorkType, iPlayer) == iLogia then
								dprint("Found it!")
								bHasLogia = true;
								break
							end
						end
					else
						dprint("No works in this building!")
					end
					if bHasLogia then
						dprint("Was it in an Infinity Library?")
						if iBuildingClass == GameInfoTypes.BUILDINGCLASS_LIBRARY then
							if pCity:IsHasBuilding(GameInfoTypes.BUILDING_INFINITY_LIBRARY) then
								dprint("It was!")
								bIsInfinityLibrary = true;
							end
						end
						break
					end
				end
				if bHasLogia then
					if bIsInfinityLibrary then
						dprint("2 of Logia building set")
						pCity:SetNumRealBuilding(tLostLogiaBuildings[iLogia], 2)
					else
						dprint("1 of Logia building set")
						pCity:SetNumRealBuilding(tLostLogiaBuildings[iLogia], 1)
					end
				else
					dprint("0 of Logia building set")
					pCity:SetNumRealBuilding(tLostLogiaBuildings[iLogia], 0)
				end
			end
		end
	end
end


--Check all of a player's buildings when CultureOverview is updated (swapping Great Works around), and update the Logia bonus buildings accordingly
function UpdateLostLogiaBuildingsUI()
	--If bPopup is false then that will (should) mean that CultureOverview is not active, and that's the only screen this mod needs tracking for,
	--so quit this function if false
	if not bPopup then
		return
	end
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		for pCity in pPlayer:Cities() do
			for iLogia, pLogia in pairs(tLostLogiaTypes) do
				dprint("Testing to see if " ..pLogia.. " is in " ..pCity:GetName())
				local bHasLogia = false;
				local bIsInfinityLibrary = false;
				for iBuildingClass, pBuildingClass in pairs(tGreatArtBuildings) do
					dprint("Checking building class " ..pBuildingClass)
					local iCurrentWorks = pCity:GetNumGreatWorksInBuilding(iBuildingClass)
					if iCurrentWorks > 0 then
						for i = 0, iCurrentWorks - 1, 1 do
							dprint("Testing work slot")
							local iWorkType = pCity:GetBuildingGreatWork(iBuildingClass, i)
							dprint("iWorkType:" ..iWorkType)
							if Game.GetGreatWorkType(iWorkType, iPlayer) == iLogia then
								dprint("Found it!")
								bHasLogia = true;
								break
							end
						end
					else
						dprint("No works in this building!")
					end
					if bHasLogia then
						dprint("Was it in an Infinity Library?")
						if iBuildingClass == GameInfoTypes.BUILDINGCLASS_LIBRARY then
							if pCity:IsHasBuilding(GameInfoTypes.BUILDING_INFINITY_LIBRARY) then
								dprint("It was!")
								bIsInfinityLibrary = true;
							end
						end
						break
					end
				end
				if bHasLogia then
					if bIsInfinityLibrary then
						dprint("2 of Logia building set")
						pCity:SetNumRealBuilding(tLostLogiaBuildings[iLogia], 2)
					else
						dprint("1 of Logia building set")
						pCity:SetNumRealBuilding(tLostLogiaBuildings[iLogia], 1)
					end
				else
					dprint("0 of Logia building set")
					pCity:SetNumRealBuilding(tLostLogiaBuildings[iLogia], 0)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(UpdateLostLogiaBuildings)

Events.SerialEventCityInfoDirty.Add(UpdateLostLogiaBuildingsUI)


--When a popup screen appears, check if it is CultureOverview. If so, set bPopup to true, which lets UpdateLostLogiaBuildingsUI() fire
function SetCurrentPopupNanoha(popupInfo)
	local popupType = popupInfo.Type
	if popupType == ButtonPopupTypes.BUTTONPOPUP_CULTURE_OVERVIEW then
		bPopup = true
	end
end
Events.SerialEventGameMessagePopup.Add(SetCurrentPopupNanoha)


--When a popup is closed, delete bPopup so it doesn't keep refreshing Logia buildings when CultureOverview isn't open
function ClearCurrentPopupNanoha()
	bPopup = nil;
end
Events.SerialEventGameMessagePopupProcessed.Add(ClearCurrentPopupNanoha)




