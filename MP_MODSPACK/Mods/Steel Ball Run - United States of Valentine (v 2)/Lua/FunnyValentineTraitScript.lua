-- Funny Valentine's Trait Script
-- Author: Vice
-- DateCreated: 2/9/2015 8:49:03 PM
--------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------------------------------------------------------------------------------

MapModData.FValentine = {} -- empty the table

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
print("Valentine script loaded.")

--Find out if there are any Valentine players in the game, and get their player IDs.-------------------------
local tWhoIsValentine = MapModData.gFValentinePlayers or {}
local bAnyValentines;

if not MapModData.gFValentinePlayers then
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
			leadertraitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
			traitType = GameInfo.Traits[leadertraitType]
			if traitType.EnableD4CSystem == 1 or traitType.EnableD4CSystem == true then
				tWhoIsValentine[i] = true
				bAnyValentines = true
			end
		end
	end
else
	bAnyValentines = true
end

if not bAnyValentines then
	print("Valentine not present in the game. No functions will run.")
else
	local string = ""
	for k, v in pairs(tWhoIsValentine) do
		if string == "" then
			string = k
		else
			string = string..", "..k
		end
	end
	local string = "Valentine player IDs: "..string
	print(string)
end


MapModData.FValentine.LastD4CTurn = {}
MapModData.FValentine.NumGenericNamedD4CUnits = {}
MapModData.FValentine.DiscoveredCorpsePartLocation = {}
MapModData.FValentine.NumEverObtainedCorpseParts = {}
MapModData.FValentine.AUPairs = {}
MapModData.FValentine.SteelBallRunnersThatFoundCorpseParts = {} -- for Events & Decisions use
MapModData.FValentine.NumCorpsePartsSpawned = 0 
FValentine = MapModData.FValentine


include("TableSaverLoader016.lua")
include("FunnyValentineTSLSerializer.lua")
include("PlotIterators.lua")
include("FLuaVector")

function OnModLoaded() --called from end of last mod file to load
	
	local bNewGame = not TableLoad(FValentine, "FValentineMod")

	TableSave(FValentine, "FValentineMod")  --before the initial autosave that runs for both new and loaded games

	FValentine = MapModData.FValentine
end


if bAnyValentines then
	OnModLoaded()
end

--More variables
local iTurnsBetweenD4C = math.ceil((GameInfo.GameSpeeds[PreGame.GetGameSpeed()].TrainPercent / 100) * 20)
local iSteelBallRunner = GameInfoTypes.UNIT_STEEL_BALL_RUNNER
local iProphet = GameInfoTypes.UNIT_PROPHET

local iCPChanceFromKills = 7
local iCPChanceFromMovementTimes100 = 5

--Precache every Corpse Part in the database to speed things up.
local tCorpseParts = {}
local iMaxCorpseParts = 0
for work in GameInfo.GreatWorks() do
	if string.find(work.Type, "_CORPSE_PART_") then
		tCorpseParts[work.ID] = work.Type
		iMaxCorpseParts = iMaxCorpseParts + 1
	end
end

--Precache all buildings that have Great Works of Art to speed things up more.
local tGreatArtBuildings = {};
for pBuilding in GameInfo.Buildings() do
	if pBuilding.GreatWorkSlotType == "GREAT_WORK_SLOT_ART_ARTIFACT" and pBuilding.GreatWorkCount > 0 then
		local pBuildingClass = GameInfo.BuildingClasses("Type = '" ..pBuilding.BuildingClass.. "'")()
		--Save BuildingClasses instead of BuildingTypes since GetBuildingGreatWork() calls for Classes
		tGreatArtBuildings[pBuildingClass.ID] = pBuildingClass.Type
	end
end

--Search the database for the toughest mounted unit of the Era to determine SBR strength
local tSBRStrength = {}
for era in GameInfo.Eras() do
	local iHighestStrength = 12
	for unit in GameInfo.Units() do
		if unit.PrereqTech and unit.PrereqTech ~= 'NONE' and unit.PrereqTech ~= 'NULL' then
			if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() ~= 'NONE' and GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() ~= 'NULL' then --i don't know why 'NONE' is a valid PrereqTech, but it's there and causes problems
				if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era then
					if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era == era.Type then
						if unit.CombatClass == 'UNITCOMBAT_MOUNTED' or unit.CombatClass == 'UNITCOMBAT_ARMOR' then
							if unit.Combat > iHighestStrength then
								local bIsUnique;
								for uniqueunit in GameInfo.Civilization_UnitClassOverrides() do
									if uniqueunit.UnitType == unit.Type then
										bIsUnique = true
										break
									end
								end
								if not bIsUnique then
									iHighestStrength = unit.Combat
								end
							end
						end
					end
				end
			end
		end
	end
	--look through what already exists in the table; we don't want the SBR getting weaker by era
	for k, v in pairs(tSBRStrength) do
		if v > iHighestStrength then iHighestStrength = v end
	end
	tSBRStrength[era.ID] = iHighestStrength
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FIND NUMBER OF CORPSE PARTS
--------------------------------------------------------------------------------------------------------------------------------------------------------
function GetNumCorpseParts(pPlayer)
	local iPlayer = pPlayer:GetID()
	local iNumCorpseParts = 0
	for pCity in pPlayer:Cities() do
		for iCorpsePart, pCorpsePart in pairs(tCorpseParts) do
			for iBuildingClass, pBuildingClass in pairs(tGreatArtBuildings) do
				local iCurrentWorks = pCity:GetNumGreatWorksInBuilding(iBuildingClass)
				if iCurrentWorks > 0 then
					for i = 0, iCurrentWorks - 1, 1 do
						local iWorkType = pCity:GetBuildingGreatWork(iBuildingClass, i)
						if Game.GetGreatWorkType(iWorkType, iPlayer) == iCorpsePart then
							iNumCorpseParts = iNumCorpseParts + 1
						end
					end
				end
			end
		end
	end
	return iNumCorpseParts
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNIT SPAWNER
--------------------------------------------------------------------------------------------------------------------------------------------------------

function SpawnD4CUnit(pPlayer, pUnit)
	--Copy this information from the unit:
	--Type
	--Name
	--Promotions
	--XP and Level

	local iPlayer = pPlayer:GetID()
	local iUnitType = pUnit:GetUnitType()
	local pCapital = pPlayer:GetCapitalCity()
	local iX, iY;
	if pCapital then
		iX = pCapital:GetX()
		iY = pCapital:GetY()
	else
		iX = pPlayer:GetStartingPlot():GetX()
		iY = pPlayer:GetStartingPlot():GetY()
	end
	local iAIType = pUnit:GetUnitAIType()

	--v2: Push the new unit 3 more tiles away if the original is near the capital
	if Map.PlotDistance(iX, iY, pUnit:GetX(), pUnit:GetY()) <= 1 then
		iX = iX + 3
		iY = iY + 3
	end

	local pNewUnit = pPlayer:InitUnit(iUnitType, iX, iY, iAIType)
	pNewUnit:JumpToNearestValidPlot()

	local sName;
	local sAUName;
	if pUnit:HasName() then
		sAUName = Locale.ConvertTextKey(pUnit:GetNameNoDesc()).." "..Locale.ConvertTextKey("TXT_KEY_FUNNY_VALENTINE_D4C_UNIT_APPEND")
	else
		if not FValentine.NumGenericNamedD4CUnits[iPlayer] then FValentine.NumGenericNamedD4CUnits[iPlayer] = 0 end
		FValentine.NumGenericNamedD4CUnits[iPlayer] = FValentine.NumGenericNamedD4CUnits[iPlayer] + 1
		sName = Locale.ConvertTextKey("TXT_KEY_FUNNY_VALENTINE_D4C_UNIT_NAME", FValentine.NumGenericNamedD4CUnits[iPlayer])
		sAUName = sName.." "..Locale.ConvertTextKey("TXT_KEY_FUNNY_VALENTINE_D4C_UNIT_APPEND")
	end
	if sName then pUnit:SetName(sName) end
	if sAUName then pNewUnit:SetName(sAUName) end

	for row in GameInfo.UnitPromotions() do
		if pUnit:IsHasPromotion(row.ID) then
			pNewUnit:SetHasPromotion(row.ID, true)
		end
	end

	pNewUnit:SetExperience(pUnit:GetExperience())
	pNewUnit:SetLevel(pUnit:GetLevel())

	local sText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_FUNNY_VALENTINE_D4C_TEXT")
	local sTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_FUNNY_VALENTINE_D4C_TITLE")

	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, sText, sTitle, iX, iY, iUnitType)
	
	FValentine.LastD4CTurn[iPlayer] = Game:GetGameTurn()
	
	if iUnitType == iSteelBallRunner then
		DoUpdateSBRStrength(pPlayer, pNewUnit, true)
	end


	
	--Pair up the two units as AU pairs. This means:
	--Neither of them are eligible to be D4C copies again
	--If they move next to each other, they die
	local sUnit1 = GetSpecialID(iPlayer, pUnit:GetID())
	local sUnit2 = GetSpecialID(iPlayer, pNewUnit:GetID())
	FValentine.AUPairs[sUnit1] = sUnit2
	FValentine.AUPairs[sUnit2] = sUnit1
end


function OnDoTurnD4C(iPlayer)
	if tWhoIsValentine[iPlayer] then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() then
			if not FValentine.LastD4CTurn[iPlayer] then FValentine.LastD4CTurn[iPlayer] = 0 end
			local iNumCorpseParts = GetNumCorpseParts(pPlayer)
			local iFaithModifier = 1
			if iNumCorpseParts >= 1 then
				local iMod = math.floor(pPlayer:GetFaith() / 50) / 100
				if iMod > 0 then
					if iMod > 0.33 then iMod = 0.33 end
					iFaithModifier = iFaithModifier - iMod
				end
			end
			local iTurnsNeeded = math.ceil(iFaithModifier * iTurnsBetweenD4C)
			if Game:GetGameTurn() - FValentine.LastD4CTurn[iPlayer] >= iTurnsNeeded then
				local iGPChance = 0
				if iNumCorpseParts >= 2 then iGPChance = 10 end
				if iGPChance > 0 then
					if Game.Rand(100, "FValentine D4C Great Person Roll") <= 9 then
						local tRandomTable = {}
						for pUnit in pPlayer:Units() do
							if pUnit:IsGreatPerson() and not pUnit:IsCombatUnit() then
								local sUnit = GetSpecialID(iPlayer, pUnit:GetID())
								if not FValentine.AUPairs[sUnit] then
									tRandomTable[#tRandomTable + 1] = pUnit
								end
							end
						end
						if #tRandomTable > 0 then
							local pSelectedUnit = tRandomTable[Game.Rand(#tRandomTable, "FValentine D4C Unit Roll") + 1]
							if pSelectedUnit then
								SpawnD4CUnit(pPlayer, pSelectedUnit)
								return
							end
						end
					end
				end
				local tRandomTable = {}
				for pUnit in pPlayer:Units() do
					if pUnit:IsCombatUnit() then
						if pUnit:GetUnitClassType() ~= GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL then  --WFTW needs an update to handle this, so for now it won't work with MGs
							local sUnit = GetSpecialID(iPlayer, pUnit:GetID())
							if not FValentine.AUPairs[sUnit] then
								tRandomTable[#tRandomTable + 1] = pUnit
							end
						end
					end
				end
				if #tRandomTable > 0 then
					local pSelectedUnit = tRandomTable[Game.Rand(#tRandomTable, "FValentine D4C Unit Roll") + 1]
					if pSelectedUnit then
						SpawnD4CUnit(pPlayer, pSelectedUnit)
						return
					end
				end
			end
			--Healing and damage from 4 corpse parts
			if iNumCorpseParts >= 4 then
				local pTeam = Teams[pPlayer:GetTeam()]
				local iNumUnitsHealed = 0
				for pUnit in pPlayer:Units() do
					if pUnit:GetDamage() > 0 then
						iNumUnitsHealed = iNumUnitsHealed + 1
						pUnit:ChangeDamage(math.max(-10, pUnit:GetDamage() * -1))
					end
				end
				if iNumUnitsHealed > 0 then
					local tRandomTable = {}
					for i = 0, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
						local pLoop = Players[i]
						if pLoop:IsAlive() and pTeam:IsAtWar(pLoop:GetTeam()) then
							for pUnit in pLoop:Units() do
								if pUnit:IsCombatUnit() then
									tRandomTable[#tRandomTable + 1] = pUnit
								end
							end
						end
					end
					if #tRandomTable > 0 then
						local iActivePlayer = Game:GetActivePlayer()
						local sValentineName = pPlayer:GetName()
						for i = 0, iNumUnitsHealed, 1 do
							local pRandomUnit = tRandomTable[Game.Rand(#tRandomTable, "FValentine D4C Love Train Damage Roll") + 1]
							pRandomUnit:ChangeDamage(10)
							if pRandomUnit:GetOwner() == iActivePlayer then
								Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_FUNNY_VALENTINE_D4C_LOVE_TRAIN_DAMAGE", sValentineName, pRandomUnit:GetName()))
							end
						end
					end
				end
			end
		end
		--AI Logic for going to Corpse Part Location is here
		if not pPlayer:IsHuman() then
			if FValentine.DiscoveredCorpsePartLocation[iPlayer] then
				local pPlot = ReturnPlotFromSpecialID(FValentine.DiscoveredCorpsePartLocation[iPlayer])
				for pUnit in pPlayer:Units() do
					if pUnit:GetUnitType() == iSteelBallRunner then
						pUnit:PopMission()
						pUnit:PushMission(MissionTypes.MISSION_MOVE_TO, pPlot:GetX(), pPlot:GetY(), 0, 0, 1)
						break
					end
				end
			end
		end
	end
end


--Units get new UnitIDs upon upgrade, so we need to make sure they update in the AU unit table
function OnUnitUpgradedD4C(iPlayer, iUnit, iNewUnit)
	if tWhoIsValentine[iPlayer] then
		local sOldID = GetSpecialID(iPlayer, iUnit)
		local sNewID = GetSpecialID(iPlayer, iNewUnit)
		if FValentine.AUPairs[sOldID] then
			FValentine.AUPairs[sNewID] = FValentine.AUPairs[sOldID]
			FValentine.AUPairs[sOldID] = nil
		end

		local sKeyToChange;
		for k, v in pairs(FValentine.AUPairs) do
			if v == sOldID then
				sKeyToChange = k
				break
			end
		end
		if sKeyToChange then
			FValentine.AUPairs[sKeyToChange] = sNewID
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- STEEL BALL RUNNER STRENGTH
--------------------------------------------------------------------------------------------------------------------------------------------------------

function DoUpdateSBRStrength(pPlayer, data, bSingleUnit)
	local iNumCorpseParts = GetNumCorpseParts(pPlayer)
	local iStrength = tSBRStrength[pPlayer:GetCurrentEra()]
	if iNumCorpseParts >= 3 then
		iStrength = iStrength + math.floor(pPlayer:GetFaith() / 100)	
	end
	--data may either be a single pUnit pointer, or a table full of them
	if not bSingleUnit then
		for _, pUnit in pairs(data) do
			pUnit:SetBaseCombatStrength(iStrength)
		end
	else
		data:SetBaseCombatStrength(iStrength)
	end
end

function OnTurnUpdateSBRStrength(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		--We'll make a temporary table with all SBRs, that way we only run DoUpdateSBRStrength if the player has at least one
		local tSBRs = {}
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iSteelBallRunner then
				tSBRs[#tSBRs + 1] = pUnit
			end
		end
		if #tSBRs > 0 then
			DoUpdateSBRStrength(pPlayer, tSBRs)
		end
	end
end

function OnTeamSetEraSetSBRStrength(iTeam, iEra)
	for iPlayer = 0, GameDefines.MAX_CIV_PLAYERS, 1 do
		local pPlayer = Players[iPlayer]
		if pPlayer and pPlayer:IsAlive() and pPlayer:GetTeam() == iTeam then
			local tSBRs = {}
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitType() == iSteelBallRunner then
					tSBRs[#tSBRs + 1] = pUnit
				end
			end
			if #tSBRs > 0 then
				DoUpdateSBRStrength(pPlayer, tSBRs)
			end
		end
	end
end

function OnUnitSetXYReplaceProphet(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and tWhoIsValentine[iPlayer] then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit and pUnit:GetUnitType() == iProphet then
			local pNewUnit = pPlayer:InitUnit(iSteelBallRunner, pUnit:GetX(), pUnit:GetY(), UNITAI_FAST_ATTACK)
			pUnit:Kill(true)
			DoUpdateSBRStrength(pPlayer, pNewUnit, true)
		else
			--This function will also handle the Menger Sponging deaths
			local sUnit = GetSpecialID(iPlayer, pUnit:GetID())
			if FValentine.AUPairs[sUnit] then
				for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1) do
					if pAreaPlot:IsUnit() then
						for c = 0, pAreaPlot:GetNumUnits() - 1 do
							local pPlotUnit = pAreaPlot:GetUnit(c)
							if pPlotUnit then
								local sUnit2 = GetSpecialID(pPlotUnit:GetOwner(), pPlotUnit:GetID())
								if sUnit2 == FValentine.AUPairs[sUnit] then
									local sText = Locale.ConvertTextKey("TXT_KEY_ALERT_FUNNY_VALENTINE_MENGER_SPONGED_TEXT", pUnit:GetName())
									local sTitle = Locale.ConvertTextKey("TXT_KEY_ALERT_FUNNY_VALENTINE_MENGER_SPONGED_TITLE")
									pPlayer:AddNotification(NotificationTypes.NOTIFICATION_UNIT_DIED, sText, sTitle, iX, iY, pUnit:GetUnitType())
									pUnit:Kill(true)
									pPlotUnit:Kill(true)
									FValentine.AUPairs[sUnit] = nil
									FValentine.AUPairs[sUnit2] = nil
									return
								end
							end
						end
					end
				end
			end
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- STEEL BALL RUNNER CORPSE PART STUFF
-- This only works for Valentine, even if another player gets an SBR
--------------------------------------------------------------------------------------------------------------------------------------------------------
function GetSpecialID(val1, val2)
	return val1..":"..val2
end

function ReturnPlotFromSpecialID(ID)
	local temptable = split(ID, ":");	
	local iX = tonumber(temptable[1]);
	local iY = tonumber(temptable[2]);
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot then
		return pPlot
	else
		return nil
	end
end

function ReturnUnitFromSpecialID(ID)
	local temptable = split(ID, ":");	
	local iPlayer = tonumber(temptable[1]);
	local iUnit = tonumber(temptable[2]);
	local pUnit = Players[iPlayer]:GetUnitByID(iUnit)
	if pUnit then
		return pUnit
	else
		return nil
	end
end

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

function DoSpawnCorpsePart(pPlayer)
	local pPlot;
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then
		pPlot = pCapital:Plot()
	else
		pPlot = pPlayer:GetStartingPlot()
	end


	local tPossiblePlots = {}
	for i = 0, Map.GetNumPlots() -1 do
		local k = Map.GetPlotByIndex(i)
		local iStartArea = pPlot:GetArea()
		if not k:IsCity() and not k:IsImpassable() and not k:IsMountain() and not k:IsWater() then
			--v2: The first part should always be on the same landmass as the player's starting location
			if GetNumCorpseParts(pPlayer) == 0 then
				if k:GetArea() == iStartArea then
					tPossiblePlots[#tPossiblePlots + 1] = k
				end
			else
				tPossiblePlots[#tPossiblePlots + 1] = k
			end
		end
	end

	local pChosenPlot = tPossiblePlots[Game.Rand(#tPossiblePlots, "FValentine Corpse Part Location Roll") + 1]
	FValentine.DiscoveredCorpsePartLocation[pPlayer:GetID()] = GetSpecialID(pChosenPlot:GetX(), pChosenPlot:GetY())

	local sText = Locale.ConvertTextKey("TXT_KEY_ALERT_FUNNY_VALENTINE_CORPSE_PART_DISCOVERED_TEXT")
	local sTitle = Locale.ConvertTextKey("TXT_KEY_ALERT_FUNNY_VALENTINE_CORPSE_PART_DISCOVERED_TITLE")

	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_EXPLORATION_RACE, sText, sTitle, pChosenPlot:GetX(), pChosenPlot:GetY())
end

function DoGenerateCorpsePartArtifact(pPlayer)
	local iPlayer = pPlayer:GetID()
	local pPlot;
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then
		pPlot = pCapital:Plot()
	else
		pPlot = pPlayer:GetStartingPlot()
	end

	local pDummyUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_CORPSEPART_DUMMY, pPlot:GetX(), pPlot:GetY())
	pDummyUnit:PushMission(MissionTypes.MISSION_CREATE_GREAT_WORK, -1, -1, 0, 0, 0, 0, pPlot, pDummyUnit)

	if not FValentine.NumCorpsePartsSpawned then 
		FValentine.NumCorpsePartsSpawned = 1 
	else
		FValentine.NumCorpsePartsSpawned = FValentine.NumCorpsePartsSpawned + 1
	end
	FValentine.DiscoveredCorpsePartLocation[iPlayer] = nil

	--First-time obtaining stuff
	if not FValentine.NumEverObtainedCorpseParts[iPlayer] then 
		FValentine.NumEverObtainedCorpseParts[iPlayer] = 0
		--Found a religion with a dummy unit
		if Game.GetNumReligionsStillToFound() > 0 then
			local pNewUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_VALENTINE_RELIGION_DUMMY, pPlot:GetX(), pPlot:GetY())
			pNewUnit:PushMission(MissionTypes.MISSION_FOUND_RELIGION, -1, -1, 0, 0, 0, 0, pPlot, pNewUnit)
		end
	elseif FValentine.NumEverObtainedCorpseParts[iPlayer] == 1 then
		--Enhance religion with a dummy unit
		if pPlayer:GetReligionCreatedByPlayer() > ReligionTypes.RELIGION_PANTHEON then
			local pNewUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_VALENTINE_RELIGION_DUMMY, pPlot:GetX(), pPlot:GetY())
			pNewUnit:PushMission(MissionTypes.MISSION_ENHANCE_RELIGION, -1, -1, 0, 0, 0, 0, pPlot, pNewUnit)
		end
	elseif FValentine.NumEverObtainedCorpseParts[iPlayer] == 2 then
		--Golden Age
		pPlayer:ChangeGoldenAgeTurns(pPlayer:GetGoldenAgeLength())
	elseif FValentine.NumEverObtainedCorpseParts[iPlayer] == 3 then
		--2 Free Policies
		pPlayer:SetNumFreePolicies(2)
	end
	FValentine.NumEverObtainedCorpseParts[iPlayer] =  FValentine.NumEverObtainedCorpseParts[iPlayer] + 1
end

function OnUnitPrekillDiscoverCorpsePart(iOwner, iUnitID, iUnitType, iX, iY, bDelay, iKiller)
	if FValentine.NumCorpsePartsSpawned and FValentine.NumCorpsePartsSpawned >= iMaxCorpseParts then return end --no need to do this if all Corpse Parts already exist
	if FValentine.DiscoveredCorpsePartLocation[iKiller] then return end --also no need if there is already a Corpse Part discovered
	if bDelay and tWhoIsValentine[iKiller] and iOwner ~= iKiller then
		local pPlayer = Players[iKiller]
		local pPlot = Map.GetPlot(iX, iY)
		for pAreaPlot in PlotAreaSpiralIterator(pPlot, 1) do
			if pAreaPlot:IsUnit() then
				for c = 0, pAreaPlot:GetNumUnits() - 1 do
					local pPlotUnit = pAreaPlot:GetUnit(c)
					if pPlotUnit then
						if pPlotUnit:GetOwner() == iKiller and pPlotUnit:GetUnitType() == iSteelBallRunner then
							if Game.Rand(100, "FValentine Corpse Part Kill Chance Roll") < iCPChanceFromKills then
								DoSpawnCorpsePart(pPlayer)
								return
							end
						end
					end
				end
			end
		end
	end
end

function OnSetXYDiscoverCorpsePart(iPlayer, iUnit, iX, iY)
	if FValentine.NumCorpsePartsSpawned and FValentine.NumCorpsePartsSpawned >= iMaxCorpseParts then return end --no need to do this if all Corpse Parts already exist
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:GetUnitType() == iSteelBallRunner then
		--If we know where one is, determine if we walked on that spot
		if FValentine.DiscoveredCorpsePartLocation[iPlayer] then
			local pPlot = ReturnPlotFromSpecialID(FValentine.DiscoveredCorpsePartLocation[iPlayer])
			if pPlot and pPlot == pUnit:GetPlot() then
				--Don't spawn it if we have nowhere to put it!
				if pPlayer:GetCityOfClosestGreatWorkSlot(iX, iY, GameInfoTypes.GREAT_WORK_SLOT_ART_ARTIFACT) == nil then 
					local sText = Locale.ConvertTextKey("TXT_KEY_ALERT_FUNNY_VALENTINE_NO_ROOM_FOR_CORPSE_TEXT")
					local sTitle = Locale.ConvertTextKey("TXT_KEY_ALERT_FUNNY_VALENTINE_NO_ROOM_FOR_CORPSE_TITLE")
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, iX, iY)
				else
					DoGenerateCorpsePartArtifact(pPlayer)
					if not FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer] then FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer] = {} end
					FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer][#FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer] + 1] = GetSpecialId(iPlayer, iUnit)
				end
			end
		else --If we don't, see if we've found where one is
			if iX > 0 and iY > 0 and tWhoIsValentine[iPlayer] then
				local pPlot = pUnit:GetPlot()
				if pPlot:GetOwner() == iPlayer and pPlot:IsRoute() then
					if Game.Rand(10000, "FValentine Corpse Part Move Chance Roll") < iCPChanceFromMovementTimes100 then
						DoSpawnCorpsePart(pPlayer)
						return
					end
				end
			end
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENT HOOKS
--------------------------------------------------------------------------------------------------------------------------------------------------------

GameEvents.PlayerDoTurn.Add(OnTurnUpdateSBRStrength)
GameEvents.TeamSetEra.Add(OnTeamSetEraSetSBRStrength)

if bAnyValentines then
	GameEvents.PlayerDoTurn.Add(OnDoTurnD4C)
	GameEvents.UnitUpgraded.Add(OnUnitUpgradedD4C)
	GameEvents.UnitSetXY.Add(OnUnitSetXYReplaceProphet)
	GameEvents.UnitPrekill.Add(OnUnitPrekillDiscoverCorpsePart)
	GameEvents.UnitSetXY.Add(OnSetXYDiscoverCorpsePart)
end



--------------------------------------------------------------------------------------------------------------------------------------------------------
-- DIPLOCORNER
-- Let players locate the Corpse Part.
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnDiploCornerPopup()
	if FValentine.DiscoveredCorpsePartLocation[Game:GetActivePlayer()] then
		local pPlot = ReturnPlotFromSpecialID(FValentine.DiscoveredCorpsePartLocation[Game:GetActivePlayer()])
		UI.LookAt(pPlot, 0)
		Events.SerialEventHexHighlight(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY())), true,  Vector4( 1.0, 0.0, 1.0, 1 ))
	else
		Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_FUNNY_VALENTINE_NO_CORPSE_PART_LOCATIONS_KNOWN"))
	end
end

function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
  table.insert(additionalEntries, {
    text=Locale.ConvertTextKey("TXT_KEY_FUNNY_VALENTINE_DIPLOCORNER_CORPSE"), 
    call=OnDiploCornerPopup
  })
end

if tWhoIsValentine[Game:GetActivePlayer()] then
	LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
	LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()
end