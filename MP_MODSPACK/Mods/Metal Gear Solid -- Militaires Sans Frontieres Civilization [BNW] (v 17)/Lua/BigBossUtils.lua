-- BigBossUtils
-- Author: Vicevirtuoso
-- DateCreated: 2/26/2014 3:37:37 PM
--------------------------------------------------------------


--MSFFunctions = getmetatable(Players[0]).__index
--LuaEvents.Player = LuaEvents.Player or function(player) end

MapModData.MSF = {}
MapModData.MSF.MSFSalvage = {}
MapModData.MSF.MotherBaseLevel = {}
MapModData.MSF.MSFLevelRequirements = {}
MapModData.MSF.MSFPlayers = {}
MapModData.MSF.DiamondDogsPlayers = {}
MapModData.MSF.MSFInitedPlayers =  {}
MSF = MapModData.MSF

local ttable = {}


function GetProgressToMotherBaseLevel(iPlayer, ttable)
	if ttable then
		ttable[0] = MSF.MSFSalvage[iPlayer] or 0
	end
	return MSF.MSFSalvage[iPlayer] or 0;
end

function GetRequiredProgressToMotherBaseLevel(iLevel, ttable)
	if ttable then
		ttable[0] = MSF.MSFLevelRequirements[iLevel] or 0
	end
	return MSF.MSFLevelRequirements[iLevel] or 0;
end

function GetMotherBaseLevel(iPlayer, ttable)
	if ttable then
		ttable[0] = MSF.MotherBaseLevel[iPlayer] or 0;
	end
	return MSF.MotherBaseLevel[iPlayer] or 0;
end

LuaEvents.MSFGetProgressToMotherBaseLevel.Add(GetProgressToMotherBaseLevel)
LuaEvents.MSFGetRequiredProgressToMotherBaseLevel.Add(GetRequiredProgressToMotherBaseLevel)
LuaEvents.MSFGetMotherBaseLevel.Add(GetMotherBaseLevel)

--Called by both TopPanel and other functions in this file to get the MB progress amount by all units.
function GetMotherBaseProgressFromUnits(pPlayer, ttable)
	local iProgress = 0;
	if (pPlayer:IsEverAlive()) then
		if tWhoIsMSF[pPlayer:GetID()] then
			for pUnit in pPlayer:Units() do
				if (pUnit:IsCombatUnit()) then
					local pPlot = pUnit:GetPlot()
					if pPlot then
						local pPlotOwner = Players[pPlot:GetOwner()]
						if (pPlotOwner ~= nil) then
							if (pPlotOwner:IsMinorCiv() and pPlotOwner:IsProtectedByMajor(iPlayer)) then
								--print("An MSF unit is within the borders of a protected City-State.")
								iProgress = iProgress + pUnit:GetBaseCombatStrength()
							end
						end
					end
				end
			end
		elseif (iMotherBaseLevel == nil) then
			iProgress = -2;
		else
			iProgress = -1;
		end
	else
		return -2;
	end
	if ttable then
		ttable[0] = iProgress
	end
	return iProgress;
end

LuaEvents.MSFGetMotherBaseProgressFromUnits.Add(GetMotherBaseProgressFromUnits)


--Initialize requirements for Mother Base to level up. The base formula is: start at 65, then multiply the previous value by 1.2 and add 65. Then multiply this by the research speed
--of the currently selected game speed. (Specific game speeds are not specified to allow compatibility with custom game speeds.)
function MotherBaseLevelReqs()
	if not MSF.MSFLevelRequirements[1] then
		for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pPlayer = Players[iPlayer]
			if (pPlayer:IsEverAlive()) then
				if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MSF) then
					local iProgressRequirement = 0;
					local iResearchLevel = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ResearchPercent / 100
					--print("Research Level: " ..iResearchLevel)
					for i = 1, 20, 1 do
						MSF.MSFLevelRequirements[i] = math.floor(((iProgressRequirement * 1.25) + 80) * iResearchLevel)
						iProgressRequirement = math.floor((iProgressRequirement * 1.25) + 80)
					end
					MSF.MSFLevelRequirements[21] = 99999999999
					print ("Values of Mother Base XP requirements:" )
					for k, v in pairs(MSF.MSFLevelRequirements) do
						print(k, v)
					end
					break
				end
			end
		end
	end
end

--Grants MSF free starting units -- a siege unit per City-state puppeter, two melee/gunpowder units, and one ranged unit. All unit types are determined by start era.
function MSFFreeStartUnits()
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pPlayer = Players[i]
		if (pPlayer:IsEverAlive()) and tWhoIsMSF[i] and not MSF.MSFInitedPlayers[i] then
			for pLoopUnit in pPlayer:Units() do
				if (pLoopUnit:GetUnitType() == GameInfoTypes.UNIT_CITYSTATEPUPPETER_DUMMY) then
					ReplaceDummyWithSiegeUnit(pLoopUnit, pPlayer);
				end
			end
		end
	end
end

--Called by both TopPanel and other functions in this file to get the mercenary gold amount by all units.
function GetGoldFromMercenaryUnits(pPlayer)
	if not pPlayer then
		pPlayer = Players[Game:GetActivePlayer()]
	end
	local iGoldGain = 0;
	local iPlayer = pPlayer:GetID()
	if tWhoIsMSF[iPlayer] then
		for pUnit in pPlayer:Units() do
			if (pUnit:IsCombatUnit()) then
				local pPlot = pUnit:GetPlot()
				if pPlot then
					local pPlotOwner = Players[pPlot:GetOwner()]
					if (pPlotOwner ~= nil) then
						if (pPlotOwner:IsMinorCiv() and pPlotOwner:IsProtectedByMajor(iPlayer)) then
							local iEraBasePerUnit;
							local iFriendshipModifier;
							local iEra = Game.GetCurrentEra();
							if (iEra == GameInfoTypes.ERA_ANCIENT) then
								iEraBasePerUnit = 1;
							elseif (iEra == GameInfoTypes.ERA_CLASSICAL) then
								iEraBasePerUnit = 1;
							elseif (iEra == GameInfoTypes.ERA_MEDIEVAL) then
								iEraBasePerUnit = 2;
							elseif (iEra == GameInfoTypes.ERA_RENAISSANCE) then
								iEraBasePerUnit = 2;
							elseif (iEra == GameInfoTypes.ERA_INDUSTRIAL) then
								iEraBasePerUnit = 3;
							elseif (iEra == GameInfoTypes.ERA_MODERN) then
								iEraBasePerUnit = 3;
							elseif (iEra == GameInfoTypes.ERA_FUTURE) then
								iEraBasePerUnit = 4;
							elseif (iEra == GameInfoTypes.ERA_POSTMODERN) then
								iEraBasePerUnit = 4;
							end
							if (pPlotOwner:GetMinorCivFriendshipLevelWithMajor(iPlayer) == 0) then
								iFriendshipModifier = 1;
							elseif (pPlotOwner:GetMinorCivFriendshipLevelWithMajor(iPlayer) == 1) then
								iFriendshipModifier = 2;
							elseif (pPlotOwner:GetMinorCivFriendshipLevelWithMajor(iPlayer) == 2) then
								iFriendshipModifier = 4;
							end
							iGoldGain = iGoldGain + (iEraBasePerUnit * iFriendshipModifier);
						end
					end
				end
			end
		end
		--v12: Gold is now set to be a flat amount by finding the capital's Gold Modifier and setting the number of buildings accordingly.
		--Example: if 100 GPT from mercs and capital has +100% Gold, it will only put 50 buildings so that the 100 GPT will only ever be 100 GPT.
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			iGoldGain = math.ceil(iGoldGain / (1 + pCapital:GetYieldRateModifier(YieldTypes.YIELD_GOLD) / 100))
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_BIGBOSS_MERC_GOLD_BUILDING, iGoldGain);
		end
		Events.SerialEventCityInfoDirty()
		Events.SerialEventGameDataDirty()
		return iGoldGain;
	end
end

-- Events.SerialEventGameDataDirty.Add(GetGoldFromMercenaryUnits)
-- Events.SerialEventCityInfoDirty.Add(GetGoldFromMercenaryUnits)


function OnBBMoveRefreshInfo(iPlayer, iUnit, iX, iY)
	if tWhoIsMSF[iPlayer] then
		LuaEvents.MSFRefreshSalvageDisplay()
		GetGoldFromMercenaryUnits(Players[iPlayer])
		Events.SerialEventCityInfoDirty()
	end
end

--Return the amount of Mother Base progress per population in captured city for Snake
function GetMotherBaseProgressPerCapturePop(ttable)
	local iPerPop;
	if (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_DUEL) then
		iPerPop = 200;
	elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_TINY) then
		iPerPop = 175;
	elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_SMALL) then
		iPerPop = 150;
	elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_STANDARD) then
		iPerPop = 125;
	elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_LARGE) then
		iPerPop = 100;
	elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_HUGE) then
		iPerPop = 75;
	else
		iPerPop = 125;
	end
	if ttable then
		ttable[0] = iPerPop
	end
	return iPerPop;
end

LuaEvents.MSFGetMotherBaseProgressPerCapturePop.Add(GetMotherBaseProgressPerCapturePop)

--Called to kill a City-State puppeter dummy and replace it with the highest available siege unit, and give it promotions
function ReplaceDummyWithSiegeUnit(pUnit, pPlayer)
	local pPlotX = pUnit:GetPlot():GetX();
	local pPlotY = pUnit:GetPlot():GetY();
	pUnit:Kill();
	local iUnitType;
	local pTeam = Teams[pPlayer:GetTeam()];
	if (pTeam:GetTeamTechs():HasTech(GameInfoTypes[ "TECH_DYNAMITE" ])) then
		iUnitType = GameInfoTypes.UNIT_ARTILLERY;
	elseif (pTeam:GetTeamTechs():HasTech(GameInfoTypes[ "TECH_CHEMISTRY" ])) then
		iUnitType = GameInfoTypes.UNIT_CANNON;
	elseif (pTeam:GetTeamTechs():HasTech(GameInfoTypes[ "TECH_PHYSICS" ])) then
		iUnitType = GameInfoTypes.UNIT_TREBUCHET;
	else
		iUnitType = GameInfoTypes.UNIT_CATAPULT;
	end
	local eNewUnit = pPlayer:InitUnit(iUnitType, pPlotX, pPlotY, UNITAI_CITY_BOMBARD)
	eNewUnit:SetHasPromotion(GameInfoTypes.PROMOTION_COVER_1, true)
	eNewUnit:SetHasPromotion(GameInfoTypes.PROMOTION_INDIRECT_FIRE, true)
end