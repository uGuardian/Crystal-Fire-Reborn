-- Big Boss Trait Script
-- Author: Vicevirtuoso
-- DateCreated: 7/22/2013 1:54:22 PM
--------------------------------------------------------------


include("BigBossUtils.lua")
include("TableSaverLoader016.lua")
include("TSLSerializerV2MSF.lua")

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local iMSFType = GameInfoTypes.CIVILIZATION_MSF
local iDiamondDogsType = GameInfoTypes.CIVILIZATION_DIAMOND_DOGS
print("MSF script loaded.")

function DataLoad()
	local bNewGame = not TableLoad(MSF, "MSFSubsistence")

	-- < mod-specific init code here depending on bNewGame >

	TableSave(MSF, "MSFSubsistence")  --before the initial autosave that runs for both new and loaded games
end

DataLoad()

print("Data load complete")

--Find out if there are any MSF players in the game, and get their player IDs.-------------------------
tWhoIsMSF = MSF.MSFPlayers or {}
tWhoIsDiamondDogs = MSF.DiamondDogsPlayers or {}

bAnyMSFs = false;

function RefreshSnakePlayers(bRefresh)
	print("Refreshing Snake Players")
	if #MSF.MSFPlayers <= 0 or bRefresh then
		for i = 0, iMaxCivs - 1, 1 do
			local pPlayer = Players[i]
			if pPlayer:IsEverAlive() then
				if pPlayer:GetCivilizationType() == iMSFType then
					tWhoIsMSF[i] = true
					tWhoIsDiamondDogs[i] = false
					bAnyMSFs = true
					if not MSF.MSFSalvage[i] then MSF.MSFSalvage[i] = 0 end
					if not MSF.MotherBaseLevel[i] then MSF.MotherBaseLevel[i] = 1 end
				elseif pPlayer:GetCivilizationType() == iDiamondDogsType then
					tWhoIsDiamondDogs[i] = true
					tWhoIsMSF[i] = false
					bAnyMSFs = true
				else
					tWhoIsMSF[i] = false
					tWhoIsDiamondDogs[i] = false
				end
			end
		end
	else
		bAnyMSFs = true
	end
	MSF.MSFPlayers = tWhoIsMSF
	MSF.DiamondDogsPlayers = tWhoIsDiamondDogs
end

LuaEvents.MSFRefreshSnakePlayers.Add(RefreshSnakePlayers)

RefreshSnakePlayers()

if not bAnyMSFs then
	print("MSF or Diamond Dogs are not present in the game. No further functions will run.")
	return
else
	local string = ""
	for k, v in pairs(tWhoIsMSF) do
		if string == "" then
			string = k
		else
			string = string..", "..k
		end
	end
	string = "MSF/Diamond Dogs player IDs: "..string
	print(string)
end

--End MSF discovery function----------------------------------------------------------------------------


--Give Snake his level 1 mother base when his city is founded, or higher if on a later start.
function InitMotherBase(iPlayer, iX, iY)
	if tWhoIsMSF[iPlayer] then
		local pPlayer = Players[iPlayer];
		local pCapital = pPlayer:GetCapitalCity();
		local iEra = Game.GetStartEra();
		if (iEra == GameInfoTypes.ERA_CLASSICAL) then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_MOTHER_BASE_L2, 1)
			MSF.MotherBaseLevel[iPlayer] = 2;
		elseif (iEra == GameInfoTypes.ERA_MEDIEVAL) then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_MOTHER_BASE_L4, 1)
			MSF.MotherBaseLevel[iPlayer] = 4;
		elseif (iEra == GameInfoTypes.ERA_RENAISSANCE) then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_MOTHER_BASE_L8, 1)
			MSF.MotherBaseLevel[iPlayer] = 8;
		elseif (iEra == GameInfoTypes.ERA_INDUSTRIAL) then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_MOTHER_BASE_L11, 1)
			MSF.MotherBaseLevel[iPlayer] = 11;
		elseif (iEra == GameInfoTypes.ERA_MODERN) then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_MOTHER_BASE_L14, 1)
			MSF.MotherBaseLevel[iPlayer] = 14;
		elseif (iEra == GameInfoTypes.ERA_FUTURE) then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_MOTHER_BASE_L19, 1)
			MSF.MotherBaseLevel[iPlayer] = 19;
		elseif (iEra == GameInfoTypes.ERA_POSTMODERN) then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_MOTHER_BASE_L17, 1)
			MSF.MotherBaseLevel[iPlayer] = 17;
		else
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_MOTHER_BASE_L1, 1)
			MSF.MotherBaseLevel[iPlayer] = 1;
		end
		LuaEvents.MSFRefreshSalvageDisplay()

		--The free units are now done on city founding.
		for pLoopUnit in pPlayer:Units() do
			if (pLoopUnit:GetUnitType() == GameInfoTypes.UNIT_CITYSTATEPUPPETER_DUMMY) then
				ReplaceDummyWithSiegeUnit(pLoopUnit, pPlayer);
			end
		end
		local iMeleeGunType;
		local iRangedType;
		if (Game.GetStartEra() == GameInfoTypes.ERA_FUTURE) then
			iMeleeGunType = GameInfoTypes.UNIT_STEALTH_OPERATIVE;
			iRangedType = GameInfoTypes.UNIT_BAZOOKA;
		elseif (Game.GetStartEra() == GameInfoTypes.ERA_POSTMODERN) then
			iMeleeGunType = GameInfoTypes.UNIT_INFANTRY;
			iRangedType = GameInfoTypes.UNIT_MACHINE_GUN;
		elseif (Game.GetStartEra() == GameInfoTypes.ERA_MODERN) then
			iMeleeGunType = GameInfoTypes.UNIT_RIFLEMAN;
			iRangedType = GameInfoTypes.UNIT_GATLING_GUN;
		elseif (Game.GetStartEra() == GameInfoTypes.ERA_INDUSTRIAL) then
			iMeleeGunType = GameInfoTypes.UNIT_MUSKETMAN;
			iRangedType = GameInfoTypes.UNIT_CROSSBOWMAN;
		elseif (Game.GetStartEra() == GameInfoTypes.ERA_RENAISSANCE) then
			iMeleeGunType = GameInfoTypes.UNIT_PIKEMAN;
			iRangedType = GameInfoTypes.UNIT_CROSSBOWMAN;
		elseif (Game.GetStartEra() == GameInfoTypes.ERA_MEDIEVAL) then
			iMeleeGunType = GameInfoTypes.UNIT_SPEARMAN;
			iRangedType = GameInfoTypes.UNIT_COMPOSITE_BOWMAN;
		elseif (Game.GetStartEra() == GameInfoTypes.ERA_CLASSICAL) then
			iMeleeGunType = GameInfoTypes.UNIT_SPEARMAN;
			iRangedType = GameInfoTypes.UNIT_ARCHER;
		else
			iMeleeGunType = GameInfoTypes.UNIT_WARRIOR;
			iRangedType = GameInfoTypes.UNIT_ARCHER;
		end
		pPlayer:AddFreeUnit(iMeleeGunType, UNITAI_ATTACK)
		pPlayer:AddFreeUnit(iMeleeGunType, UNITAI_ATTACK)
		--pPlayer:AddFreeUnit(iRangedType, UNITAI_ATTACK)
	end
end
		
--Function called if Snake takes the Collective Rule policy (normally gives free Settler and +50% Settler production in Capital). Due to silly DLL hardcoding, a dummy unit
--which can annex city-states was created, but is unbuildable. As soon as the unit is created, it is killed, and then MB is leveled up.
function CollectiveRuleLevelUpMotherBase(iPlayer, iPolicyID)
	if tWhoIsMSF[iPlayer] then
		local pPlayer = Players[iPlayer];
		if (iPolicyID == GameInfoTypes.POLICY_COLLECTIVE_RULE) then
			for pUnit in pPlayer:Units() do
				if (pUnit:GetUnitType() == GameInfoTypes.UNIT_CITYSTATEPUPPETER_DUMMY) then
					ReplaceDummyWithSiegeUnit(pUnit, pPlayer);
				end
			end
			local bFromPolicy = true;
			UpgradeMotherBase(bFromPolicy);
			LuaEvents.MSFRefreshSalvageDisplay()
		end
	end
end


				

--Called when a city is captured by Snake. Base formula is captured city's population times 75.
function AddMotherBaseProgressFromConquest(iPlayer, bCapital, iX, iY, iCapturingPlayer, iPopulation, bConquest)
	if tWhoIsMSF[iCapturingPlayer] then
		local pCapturingPlayer = Players[iCapturingPlayer];
		if bConquest then
			--print("Big Boss has captured an enemy city with " ..iPopulation.. " Population.")
			local iPerPop = GetMotherBaseProgressPerCapturePop();
			MSF.MSFSalvage[iCapturingPlayer] = MSF.MSFSalvage[iCapturingPlayer] + (iPopulation * iPerPop)
			--print("Progress to Mother Base upgrade: " ..tProgressToNextMotherBaseLevel[])
			sText = Locale.ConvertTextKey("TXT_KEY_MSF_CITY_CAPTURED_TEXT", (iPopulation * iPerPop))
			sTitle = Locale.ConvertTextKey("TXT_KEY_MSF_CITY_CAPTURED_TITLE")
			pCapturingPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, iX, iY)
			if (MSF.MSFSalvage[iCapturingPlayer] >= MSF.MSFLevelRequirements[GetMotherBaseLevel(iCapturingPlayer)]) then
				UpgradeMotherBase(bFromPolicy)
			end
			LuaEvents.MSFRefreshSalvageDisplay()
		end
	end			
end

--Called at the beginning of the turn to give Snake his MB progress plus his gold from units.
function AddMotherBaseProgressFromUnits(iPlayer)
	if tWhoIsMSF[iPlayer] then
		local pPlayer = Players[iPlayer];
		local iPreviousProgress = MSF.MSFSalvage[iPlayer]
		--Run separate processes for AI or human player since AI can't use the UA properly
		--Human player
		if pPlayer:IsHuman() then
			local iProgressFromUnitsInCS = GetMotherBaseProgressFromUnits(pPlayer);
			--print("Total XP gain from units in CS: " ..iProgressFromUnitsInCS)
			MSF.MSFSalvage[iPlayer] = MSF.MSFSalvage[iPlayer] + iProgressFromUnitsInCS;
		--AI player (formula: 20% of all units' combined combat strength times the number of protected City-States)
		else
			local iTotalStrength = 0;
			local iTotalProtCS = 0;
			for pUnit in pPlayer:Units() do
				iTotalStrength = iTotalStrength + pUnit:GetBaseCombatStrength();
			end
			--print("Total AI unit strength for Big Boss: "..iTotalStrength)
			for iCSID, pCSPlayer in pairs(Players) do
				if (pCSPlayer:IsMinorCiv() and pCSPlayer:IsProtectedByMajor(iPlayer)) then
					iTotalProtCS = iTotalProtCS + 1
				end
			end
			--print("Total CS protected by Big Boss: " ..iTotalProtCS)
			MSF.MSFSalvage[iPlayer] = math.ceil(MSF.MSFSalvage[iPlayer] + ((iTotalStrength * 0.2) * iTotalProtCS));
		end
		--local iProgressChange = tProgressToNextMotherBaseLevel[] - iPreviousProgress;
		--print("MSF gained a total of " ..iProgressChange.. " points towards the upgrading of Mother Base.")
		if (MSF.MSFSalvage[iPlayer] >= MSF.MSFLevelRequirements[GetMotherBaseLevel(iPlayer)]) then
			UpgradeMotherBase(bFromPolicy)
		else
			--print("XP needed to level up: " ..ctProgressToNextMBLevel[iMotherBaseLevel])
		end
		LuaEvents.MSFRefreshSalvageDisplay()
		GetGoldFromMercenaryUnits(pPlayer)
		Events.SerialEventCityInfoDirty()
	end
end


--Calls Outer Ops Missions if the game is at least at turn 30 and there are units in protected CSes. Base chance is 2% for every unit in prot CS territory per turn. Cannot
--have more than one mission active.
function OuterOpsSpawn(iPlayer)
	local pBarbarian = Players[63]
	if (iPlayer == 63) then
		--print("Beginning Outer Ops start function.")
		for _, pPlayer in pairs(Players) do
		if pPlayer:IsEverAlive() and tWhoIsMSF[_] then
			--print("MSF Civilization is in game")
			for pExistingBarbUnits in pBarbarian:Units() do
				if (pExistingBarbUnits:IsHasPromotion(GameInfoTypes.PROMOTION_OUTEROPSENEMY, true)) then
					return;
				end
			end
				--print("No outer ops mission currently active.")
				for pUnit in pPlayer:Units() do
					if (pUnit:IsCombatUnit()) then
					--print("Combat unit found")
						local pPlot = pUnit:GetPlot()
						local pPlotOwner = Players[pPlot:GetOwner()]
						if (pPlotOwner ~= nil) then
							--print("Combat unit in owned plot")
							if (pPlotOwner:IsMinorCiv() and pPlotOwner:IsProtectedByMajor(pPlayer:GetID())) then
								if (Game:GetElapsedGameTurns() >= 30) then
									local nSpawnChance = math.random(100);
									--print("Spawn roll for Outer Ops: " ..nSpawnChance.. ". Must be 2 or lower to activate.")
									if (nSpawnChance <= 2) then
										local iBarbSize = 0;
										local nRandomSizeChance = math.random(100);
										--print("Random size modifier: " ..nRandomSizeChance);
										local iCurrentEra = Game:GetCurrentEra();
										local iBarbTypeMelee = 0;
										local iBarbTypeRanged = 0;
										local iBarbTypeMounted = 0;
										local sBarbSize = 0;
										if (nRandomSizeChance >= 1 and nRandomSizeChance <= 25) then
											iBarbSize = 1;
											sBarbSize = Locale.ConvertTextKey("TXT_KEY_OUTER_OPS_ENEMY_SIZE_SMALL")
										elseif (nRandomSizeChance >= 26 and nRandomSizeChance <= 80) then
											iBarbSize = 2;
											sBarbSize = Locale.ConvertTextKey("TXT_KEY_OUTER_OPS_ENEMY_SIZE_MEDIUM")
										elseif (nRandomSizeChance >= 81) then
											iBarbSize = 3;
											sBarbSize = Locale.ConvertTextKey("TXT_KEY_OUTER_OPS_ENEMY_SIZE_LARGE")
										else
											--print("Error: nRandomChance out of range")
											return;
										end
										if (iCurrentEra == GameInfoTypes.ERA_ANCIENT) then
											iBarbTypeMelee = GameInfoTypes.UNIT_BARBARIAN_WARRIOR
											iBarbTypeRanged = GameInfoTypes.UNIT_ARCHER
											iBarbTypeMounted = GameInfoTypes.UNIT_CHARIOT_ARCHER
										elseif (iCurrentEra == GameInfoTypes.ERA_CLASSICAL) then
											iBarbTypeMelee = GameInfoTypes.UNIT_SPEARMAN
											iBarbTypeRanged = GameInfoTypes.UNIT_COMPOSITE_BOWMAN
											iBarbTypeMounted = GameInfoTypes.UNIT_HORSEMAN
										elseif (iCurrentEra == GameInfoTypes.ERA_MEDIEVAL) then
											iBarbTypeMelee = GameInfoTypes.UNIT_PIKEMAN
											iBarbTypeRanged = GameInfoTypes.UNIT_CROSSBOWMAN
											iBarbTypeMounted = GameInfoTypes.UNIT_KNIGHT
										elseif (iCurrentEra == GameInfoTypes.ERA_RENAISSANCE) then
											iBarbTypeMelee = GameInfoTypes.UNIT_MUSKETMAN
											iBarbTypeRanged = GameInfoTypes.UNIT_CROSSBOWMAN
											iBarbTypeMounted = GameInfoTypes.UNIT_LANCER
											iBarbSize = iBarbSize + 1
										elseif (iCurrentEra == GameInfoTypes.ERA_INDUSTRIAL) then
											iBarbTypeMelee = GameInfoTypes.UNIT_RIFLEMAN
											iBarbTypeRanged = GameInfoTypes.UNIT_GATLING_GUN
											iBarbTypeMounted = GameInfoTypes.UNIT_CAVALRY
											iBarbSize = iBarbSize + 1
										elseif (iCurrentEra == GameInfoTypes.ERA_MODERN) then
											iBarbTypeMelee = GameInfoTypes.UNIT_GREAT_WAR_INFANTRY
											iBarbTypeRanged = GameInfoTypes.UNIT_MACHINE_GUN
											iBarbTypeMounted = GameInfoTypes.UNIT_WWI_TANK
											iBarbSize = iBarbSize + 2
										elseif (iCurrentEra == GameInfoTypes.ERA_POSTMODERN) then
											iBarbTypeMelee = GameInfoTypes.UNIT_INFANTRY
											iBarbTypeRanged = GameInfoTypes.UNIT_BAZOOKA
											iBarbTypeMounted = GameInfoTypes.UNIT_TANK
											iBarbSize = iBarbSize + 2
										elseif (iCurrentEra == GameInfoTypes.ERA_FUTURE) then
											iBarbTypeMelee = GameInfoTypes.UNIT_MARINE
											iBarbTypeRanged = GameInfoTypes.UNIT_BAZOOKA
											iBarbTypeMounted = GameInfoTypes.UNIT_TANK
											iBarbSize = iBarbSize + 3
										end
										--find a better plot to spawn on
										local spawnPlot = pPlot; --will default to the plot the unit is on, but only if all 6 adjacent tiles are invalid
										local direction_types = {
											DirectionTypes.DIRECTION_NORTHEAST,
											DirectionTypes.DIRECTION_EAST,
											DirectionTypes.DIRECTION_SOUTHEAST,
											DirectionTypes.DIRECTION_SOUTHWEST,
											DirectionTypes.DIRECTION_WEST,
											DirectionTypes.DIRECTION_NORTHWEST
										}
										for a, direction in ipairs(direction_types) do
											local nextPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
											if (nextPlot ~= nil) then
												if (nextPlot:IsUnit() == false and nextPlot:IsCity() == false) then
													spawnPlot = nextPlot;
													break
												end
											end
										end
										for i = 1, iBarbSize do
											local nRandomSpawn = math.random(100)
											if (nRandomSpawn >= 1 and nRandomSpawn <= 70) then
												eBarbSpawn = pBarbarian:InitUnit(iBarbTypeMelee, spawnPlot:GetX(), spawnPlot:GetY(), UNITAI_ATTACK)
											elseif (nRandomSpawn >= 71 and nRandomSpawn <= 85) then
												eBarbSpawn = pBarbarian:InitUnit(iBarbTypeRanged, spawnPlot:GetX(), spawnPlot:GetY(), UNITAI_RANGED)
											elseif (nRandomSpawn >= 86) then
												eBarbSpawn = pBarbarian:InitUnit(iBarbTypeMounted, spawnPlot:GetX(), spawnPlot:GetY(), UNITAI_FAST_ATTACK)
											end
											eBarbSpawn:JumpToNearestValidPlot();
											if (eBarbSpawn:GetPlot():IsWater() == true) then
												eBarbSpawn:Embark(eBarbSpawn:GetPlot());
											end
											eBarbSpawn:SetHasPromotion(GameInfoTypes.PROMOTION_OUTEROPSENEMY, true)
											eBarbSpawn:SetName("Outer Ops Target");
										end
										local sCSName = pPlotOwner:GetName();
										local sText = sCSName.." "..Locale.ConvertTextKey("TXT_KEY_OUTER_OPS_ACTIVE_NOTIFICATION").." "..sBarbSize;
										local sTitle = Locale.ConvertTextKey("TXT_KEY_OUTER_OPS_ACTIVE_NOTIFICATION_TITLE") .." "..sCSName
											pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, pPlot:GetX(), pPlot:GetY())
										return;
									end
								end
							end
						end
					end
				end
			end
		end
	end
end


function UnitCaptureInOwnTerritory(iPlayer, iUnitID, iX, iY)
	if tWhoIsMSF[iPlayer] then
	local pPlayer = Players[iPlayer];
		if (pPlayer:GetNumCities() > 0) then
			if (MSF.MotherBaseLevel[iPlayer] >= 8) then
				local pPlot = Map.GetPlot(iX, iY);
				local pUnit = pPlayer:GetUnitByID(iUnitID);
				if (pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MELEE or pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_GUN or pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MOUNTED or pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_ARMOR) then 
					if (pPlot:GetOwner() == iPlayer and MSF.MotherBaseLevel[iPlayer] < 15) then
						pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_CAPTURE_IN_OWN_TERRITORY, true)
					else
						pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_CAPTURE_IN_OWN_TERRITORY, false)
					end
				end
			end
		end
	end
end


--Function to upgrade mother base, called by anything which adds progress if the progress is higher than the requirement
function UpgradeMotherBase(bFromPolicy)
	--print("Function to upgrade Mother Base has been called.")
	for iPlayer, pMSFPlayer in pairs(Players) do
		if (pMSFPlayer:IsEverAlive()) then
			if (pMSFPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MSF) then
				local pCapital = pMSFPlayer:GetCapitalCity();
				local tMotherBaseTable = {}
				tMotherBaseTable[1] = GameInfoTypes.BUILDING_MOTHER_BASE_L1
				tMotherBaseTable[2] = GameInfoTypes.BUILDING_MOTHER_BASE_L2
				tMotherBaseTable[3] = GameInfoTypes.BUILDING_MOTHER_BASE_L3
				tMotherBaseTable[4] = GameInfoTypes.BUILDING_MOTHER_BASE_L4
				tMotherBaseTable[5] = GameInfoTypes.BUILDING_MOTHER_BASE_L5
				tMotherBaseTable[6] = GameInfoTypes.BUILDING_MOTHER_BASE_L6
				tMotherBaseTable[7] = GameInfoTypes.BUILDING_MOTHER_BASE_L7
				tMotherBaseTable[8] = GameInfoTypes.BUILDING_MOTHER_BASE_L8
				tMotherBaseTable[9] = GameInfoTypes.BUILDING_MOTHER_BASE_L9
				tMotherBaseTable[10] = GameInfoTypes.BUILDING_MOTHER_BASE_L10
				tMotherBaseTable[11] = GameInfoTypes.BUILDING_MOTHER_BASE_L11
				tMotherBaseTable[12] = GameInfoTypes.BUILDING_MOTHER_BASE_L12
				tMotherBaseTable[13] = GameInfoTypes.BUILDING_MOTHER_BASE_L13
				tMotherBaseTable[14] = GameInfoTypes.BUILDING_MOTHER_BASE_L14
				tMotherBaseTable[15] = GameInfoTypes.BUILDING_MOTHER_BASE_L15
				tMotherBaseTable[16] = GameInfoTypes.BUILDING_MOTHER_BASE_L16
				tMotherBaseTable[17] = GameInfoTypes.BUILDING_MOTHER_BASE_L17
				tMotherBaseTable[18] = GameInfoTypes.BUILDING_MOTHER_BASE_L18
				tMotherBaseTable[19] = GameInfoTypes.BUILDING_MOTHER_BASE_L19
				tMotherBaseTable[20] = GameInfoTypes.BUILDING_MOTHER_BASE_L20
				tMotherBaseTable[21] = GameInfoTypes.BUILDING_MOTHER_BASE_L21
				if (MSF.MotherBaseLevel[iPlayer] ~= nil) then
					if (MSF.MotherBaseLevel[iPlayer] > 0 and MSF.MotherBaseLevel[iPlayer] < 21) then
						pCapital:SetNumRealBuilding(tMotherBaseTable[GetMotherBaseLevel(iPlayer) + 1], 1)
						pCapital:SetNumRealBuilding(tMotherBaseTable[GetMotherBaseLevel(iPlayer)], 0)
						local iX = pCapital:GetX();
						local iY = pCapital:GetY();
						local sText = Locale.ConvertTextKey("TXT_KEY_MOTHER_BASE_LEVEL_UP_NOTIFICATION", MSF.MotherBaseLevel[iPlayer] + 1)
						local sTitle = Locale.ConvertTextKey("TXT_KEY_MOTHER_BASE_LEVEL_UP_NOTIFICATION_TITLE")
						pMSFPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, sText, sTitle, iX, iY, GameInfoTypes.BUILDING_MOTHER_BASE_L1, 0)
						if (bFromPolicy ~= true) then
							MSF.MSFSalvage[iPlayer] = MSF.MSFSalvage[iPlayer] - MSF.MSFLevelRequirements[GetMotherBaseLevel(iPlayer)];
						end
						MSF.MotherBaseLevel[iPlayer] = MSF.MotherBaseLevel[iPlayer] + 1;
						LuaEvents.MSFRefreshSalvageDisplay()
					elseif (MSF.MotherBaseLevel[iPlayer] == 21) then
						--print("Maximum level has been reached.")
						return;
					else
						--print ("Error: iMotherBaseLevel outside of range")
						return;
					end
				else
					--print ("Error: nil value for iMotherBaseLevel")
				end
			end
		end
	end
end

--Prevents purchasing in puppet states
function MSFNoPuppetBuy(iPlayer, iCityID)
	if not tWhoIsMSF[iPlayer] and not tWhoIsDiamondDogs[iPlayer] then
		return true
	end
	local pPlayer = Players[iPlayer]
	local pCity = UI.GetHeadSelectedCity()
	if pCity ~= nil then
		if pCity:IsPuppet() then
			return false
		end
	end
	return true
end

GameEvents.CityCanConstruct.Add(MSFNoPuppetBuy)
GameEvents.CityCanTrain.Add(MSFNoPuppetBuy)

GameEvents.PlayerDoTurn.Add(AddMotherBaseProgressFromUnits)
GameEvents.PlayerDoTurn.Add(OuterOpsSpawn)

GameEvents.CityCaptureComplete.Add(AddMotherBaseProgressFromConquest)

GameEvents.PlayerAdoptPolicy.Add(CollectiveRuleLevelUpMotherBase)

GameEvents.PlayerCityFounded.Add(InitMotherBase)

GameEvents.UnitSetXY.Add(UnitCaptureInOwnTerritory)
GameEvents.UnitSetXY.Add(OnBBMoveRefreshInfo)
Events.SequenceGameInitComplete.Add(MotherBaseLevelReqs)
Events.SequenceGameInitComplete.Add(MSFFreeStartUnits)



----------------------------------------------------------------------------------------------------------------------------------------------------
--DLL Various Mod Components-based Custom Mission Compatibility. When DVMC is loaded, the separate mission Lua files will not run.
----------------------------------------------------------------------------------------------------------------------------------------------------

local iOSPMission = GameInfoTypes.MISSION_MSF_OSP_UPGRADE
local iMGUpgradeMission = GameInfoTypes.MISSION_MSF_MG_UPGRADE
local iMetalGearType = GameInfoTypes.UNIT_METAL_GEAR


function MSFCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if tWhoIsMSF[iPlayer] then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if iMission == iOSPMission then
			if not pUnit:IsCombatUnit() then return false end
			local iUpgradeType = pUnit:GetUpgradeUnitType()
			if iUpgradeType < 0 then return false end
			local iUpgradeCost = pUnit:GetBaseCombatStrength() * 5
			if MSF.MSFSalvage[iPlayer] < iUpgradeCost then
				return bTestVisible
			end
			for pResource in GameInfo.Resources() do
				iResourceLoop = pResource.ID;
		
				if pUnit:GetNumResourceNeededToUpgrade(iResourceLoop) then
					iNumResourceNeededToUpgrade = pUnit:GetNumResourceNeededToUpgrade(iResourceLoop);
				end
				
				if (iNumResourceNeededToUpgrade > 0 and iNumResourceNeededToUpgrade > Players[Game:GetActivePlayer()]:GetNumResourceAvailable(iResourceLoop, true)) then
					return bTestVisible
				end
			end
			local sTechRequired = GameInfo.Units[iUpgradeType].PrereqTech
			if Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes[sTechRequired]) then
				return true
			else
				return bTestVisible
			end
		elseif iMission == iMGUpgradeMission then
			if pUnit:GetUnitType() == iMetalGearType then
				local pCity = pUnit:GetPlot():GetPlotCity()
				if pCity then
					if pCity:IsCapital() then
						local iUpgradeCost = math.floor((pUnit:GetBaseCombatStrength() ^ 2) / 8)
						if MSF.MSFSalvage[iPlayer] >= iUpgradeCost then
							return true
						else
							return bTestVisible
						end
					else
						return bTestVisible
					end
				else
					return bTestVisible
				end
			else
				return false
			end
		end
	end
	return false
end

function MSFCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if iMission == iOSPMission then
		local iUpgradeCost = pUnit:GetBaseCombatStrength() * 5
		local iUpgradeType = pUnit:GetUpgradeUnitType()
		local iX = pUnit:GetX()
		local iY = pUnit:GetY()
		local pNewUnit = pPlayer:InitUnit(iUpgradeType, iX, iY)
		pNewUnit:Convert(pUnit)
		if (pNewUnit:GetPlot():IsWater()) then
			pNewUnit:Embark(pNewUnit:GetPlot());
		end
		pNewUnit:SetMoves(0)
		MSF.MSFSalvage[iPlayer] = MSF.MSFSalvage[iPlayer] - iUpgradeCost
		LuaEvents.MSFRefreshSalvageDisplay()
	elseif iMission == iMGUpgradeMission then
		local iUpgradeCost = math.floor((pUnit:GetBaseCombatStrength() ^ 2) / 8)
		local iCurrentStrength = pUnit:GetBaseCombatStrength()
		pUnit:SetBaseCombatStrength(iCurrentStrength + 10)
		MSF.MSFSalvage[iPlayer] = MSF.MSFSalvage[iPlayer] - iUpgradeCost
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_METAL_GEAR_UPGRADED_TEXT", pUnit:GetBaseCombatStrength()), Locale.ConvertTextKey("TXT_KEY_METAL_GEAR_UPGRADED_TITLE"), pUnit:GetX(), pUnit:GetY())
		pUnit:SetMoves(0)
		LuaEvents.MSFRefreshSalvageDisplay()
		Events.SerialEventUnitInfoDirty()
	end
	return 0
end

function MSFCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iOSPMission or iMission == iMGUpgradeMission then
		return true
	end
end


if GameInfo.CustomModOptions then
	print("DLL Various Mod Components loaded, add GameEvent calls for the DLL-based Custom Mission Handlers.")
	GameEvents.CustomMissionPossible.Add(MSFCustomMissionPossible)
	GameEvents.CustomMissionStart.Add(MSFCustomMissionStart)
	GameEvents.CustomMissionCompleted.Add(MSFCustomMissionCompleted)
end



----------------------------------------------------------------------------------------------------------------------------------------------------
--Diamond Dogs functions
----------------------------------------------------------------------------------------------------------------------------------------------------

--Get a bonus to ALL yields on a kill
--Food/Prod go to the Capital (if they have one)
local iKillValueModFoodFaith = 0.25
local iKillValueModOthers = 0.50

function OnDiamondDogsKill(iKiller, iKilled, iUnitType)
	if tWhoIsDiamondDogs[iKiller] then
		local pPlayer = Players[iKiller]
		local iCombatValue = GameInfo.Units[iUnitType].Combat
		if iCombatValue and iCombatValue > 0 then
			pPlayer:ChangeGold(math.ceil(iCombatValue * iKillValueModOthers))
			pPlayer:ChangeJONSCulture(math.ceil(iCombatValue * iKillValueModOthers))
			pPlayer:ChangeFaith(math.ceil(iCombatValue * iKillValueModFoodFaith))
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				pCapital:ChangeProduction(math.ceil(iCombatValue * iKillValueModOthers))
				pCapital:ChangeFood(math.ceil(iCombatValue * iKillValueModFoodFaith))
			end
			if iKiller == Game:GetActivePlayer() then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_VENOM_SNAKE_ALERT_MESSAGE", iCombatValue * iKillValueModOthers, iCombatValue * iKillValueModFoodFaith))
			end
		end
	end
end

GameEvents.UnitKilledInCombat.Add(OnDiamondDogsKill)


--DDs always have a MG hangar

local iMetalGearHangar = GameInfoTypes.BUILDING_METAL_GEAR_HANGAR

function DiamondDogsHangar(iPlayer)
	if tWhoIsDiamondDogs[iPlayer] then
		local pPlayer = Players[iPlayer]
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			pCapital:SetNumRealBuilding(iMetalGearHangar, 1)
		end
	end
end

GameEvents.PlayerDoTurn.Add(DiamondDogsHangar)


local iDDPromotion = GameInfoTypes.PROMOTION_DIAMOND_DOGS_RECAPTURE

function CheckDiamondDogsPromotion(iPlayer, pPlayer, pUnit)
	if tWhoIsDiamondDogs[iPlayer] then
		if pPlayer:GetNumCities() <= 0 then
			pUnit:SetHasPromotion(iDDPromotion, true)
		else
			pUnit:SetHasPromotion(iDDPromotion, false)
		end
	else
		pUnit:SetHasPromotion(iDDPromotion, false)
	end
end

function OnTurnDiamondDogsPromotion(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				CheckDiamondDogsPromotion(iPlayer, pPlayer, pUnit)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(OnTurnDiamondDogsPromotion)

function OnCaptureDiamondDogsPromotion(iPlayer, bCapital, iX, iY, iCapturingPlayer, iPopulation, bConquest)
	if iCapturingPlayer < iMaxCivs then
		local pPlayer = Players[iCapturingPlayer]
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				CheckDiamondDogsPromotion(iPlayer, pPlayer, pUnit)
			end
		end
	end
	--check both Civs
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				CheckDiamondDogsPromotion(iPlayer, pPlayer, pUnit)
			end
		end
	end
end

GameEvents.CityCaptureComplete.Add(OnCaptureDiamondDogsPromotion)


local iVenomSnake = GameInfoTypes.LEADER_VENOM_SNAKE

--Turn MSF into DD if their Capital is Captured
--This function can be safely deleted if you don't want this functionality
function MSFToDiamondDogs(iPlayer, bCapital, iX, iY, iCapturingPlayer, iPopulation, bConquest)
	if tWhoIsMSF[iPlayer] and bCapital then
		PreGame.SetCivilization(iPlayer, iDiamondDogsType)
		PreGame.SetLeaderType(iPlayer, iVenomSnake)
		PreGame.SetLeaderName(iPlayer, GameInfo.Leaders[iVenomSnake].Description)
		PreGame.SetCivilizationDescription(iPlayer, GameInfo.Civilizations[iDiamondDogsType].Description)
		PreGame.SetCivilizationShortDescription(iPlayer, GameInfo.Civilizations[iDiamondDogsType].ShortDescription)
		PreGame.SetCivilizationAdjective(iPlayer, GameInfo.Civilizations[iDiamondDogsType].Adjective)
		PreGame.SetPlayerColor(iPlayer, GameInfoTypes.PLAYERCOLOR_DIAMOND_DOGS)
		Events.SerialEventUnitInfoDirty()
		Events.SerialEventCityInfoDirty()
		Events.SerialEventGameDataDirty()
		RefreshSnakePlayers(true)
		
		local pCapital = Players[iPlayer]:GetCapitalCity()
		if pCapital then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PALACE, 1)
		end

		LuaEvents.MSFRefreshTopPanelMSFStatus()
		LuaEvents.MSFRefreshSalvageDisplay()
	end
end

GameEvents.CityCaptureComplete.Add(MSFToDiamondDogs)