-- BigBossDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local Decisions_BigBossDiamondDogs = {}
	Decisions_BigBossDiamondDogs.Name = "TXT_KEY_DECISIONS_BIGBOSS_DIAMOND_DOGS"
	Decisions_BigBossDiamondDogs.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BIGBOSS_DIAMOND_DOGS_DESC")
	HookDecisionCivilizationIcon(Decisions_BigBossDiamondDogs, "CIVILIZATION_MSF")
	Decisions_BigBossDiamondDogs.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_DIAMOND_DOGS) then
			Decisions_BigBossDiamondDogs.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BIGBOSS_DIAMOND_DOGS_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(800 * iMod)

		local iMBLevel = MapModData.MSF.MotherBaseLevel[pPlayer:GetID()] or 0

		local iScienceBonus = pPlayer:GetScience() * iMBLevel

		Decisions_BigBossDiamondDogs.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BIGBOSS_DIAMOND_DOGS_DESC", iGoldCost, iScienceBonus)
		
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_BB_OUTER_HEAVEN) then
			return true, false
		end

		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MSF) then
			return false, false
		end

		if load(pPlayer, "Decisions_BigBossDiamondDogs") == true then
			Decisions_BigBossDiamondDogs.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BIGBOSS_DIAMOND_DOGS_ENACTED_DESC", iGoldCost, iScienceBonus)
			return false, false, true
		end
		
		if pPlayer:GetGold() < iGoldCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		if IsDenunciationThresholdMSF(pPlayer) then
			return true, true
		end
		
		local pLeague = Game.GetLeague()
		
		if pLeague then
			for k, v in pairs(pLeague:GetActiveResolutions()) do
				if v.Type == GameInfoTypes.RESOLUTION_PLAYER_EMBARGO and v.ProposerDecision == pPlayer:GetID() then
					return true, true
				else
					return true, false
				end
			end
		else
			return true, false
		end
	end
	)
	
	Decisions_BigBossDiamondDogs.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iGoldCost = math.ceil(800 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		local iMBLevel = MapModData.MSF.MotherBaseLevel[iPlayer] or 0

		local iScienceBonus = pPlayer:GetScience() * iMBLevel

		LuaEvents.Sukritact_ChangeResearchProgress(iPlayer, iScienceBonus)

		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			for i = 1, 21, 1 do
				local sBuildingString = "BUILDING_MOTHER_BASE_L" ..tostring(i)
				pCapital:SetNumRealBuilding(GameInfoTypes[sBuildingString], 0)
			end
		end

	
		MapModData.MSF.MotherBaseLevel[iPlayer] = nil
		MapModData.MSF.MSFSalvage[iPlayer] = nil

		local iVenomSnake = GameInfoTypes.LEADER_VENOM_SNAKE
		local iDiamondDogsType = GameInfoTypes.CIVILIZATION_DIAMOND_DOGS

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
		LuaEvents.MSFRefreshSnakePlayers(true)

		LuaEvents.MSFRefreshTopPanelMSFStatus()
		LuaEvents.MSFRefreshSalvageDisplay()

		if pCapital then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_METAL_GEAR_HANGAR, 1)
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PALACE, 1)
		end

		save(pPlayer, "Decisions_BigBossDiamondDogs", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MSF, "Decisions_BigBossDiamondDogs", Decisions_BigBossDiamondDogs)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_DIAMOND_DOGS, "Decisions_BigBossDiamondDogs", Decisions_BigBossDiamondDogs)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_BB_OUTER_HEAVEN, "Decisions_BigBossDiamondDogs", Decisions_BigBossDiamondDogs)

local Decisions_BigBossOuterHeaven = {}
	Decisions_BigBossOuterHeaven.Name = "TXT_KEY_DECISIONS_BIGBOSS_OUTER_HEAVEN"
	Decisions_BigBossOuterHeaven.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BIGBOSS_OUTER_HEAVEN_DESC")
	HookDecisionCivilizationIcon(Decisions_BigBossOuterHeaven, "CIVILIZATION_MSF")
	Decisions_BigBossOuterHeaven.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_BB_OUTER_HEAVEN) then
			Decisions_BigBossOuterHeaven.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BIGBOSS_OUTER_HEAVEN_ENACTED_DESC")
			return false, false, true
		end

		local iSalvageCost = math.ceil(MapModData.MSF.MSFLevelRequirements[20] * 2.5)

		Decisions_BigBossOuterHeaven.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BIGBOSS_OUTER_HEAVEN_DESC", iSalvageCost)
		
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_DIAMOND_DOGS) then
			return true, false
		end

		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MSF) then
			return false, false
		end

		if load(pPlayer, "Decisions_BigBossOuterHeaven") == true then
			Decisions_BigBossOuterHeaven.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BIGBOSS_OUTER_HEAVEN_ENACTED_DESC")
			return false, false, true
		end

		if not MapModData.MSF.MSFSalvage[pPlayer:GetID()] then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		if MapModData.MSF.MSFSalvage[pPlayer:GetID()] >= iSalvageCost then
			return true, true
		else
			return true, false
		end
	end
	)

	Decisions_BigBossOuterHeaven.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		local iPlayer = pPlayer:GetID()

		MapModData.MSF.MotherBaseLevel[iPlayer] = nil
		MapModData.MSF.MSFSalvage[iPlayer] = nil

		local iBigBoss = GameInfoTypes.LEADER_BIGBOSS_OH
		local iOuterHeavenType = GameInfoTypes.CIVILIZATION_BB_OUTER_HEAVEN

		PreGame.SetCivilization(iPlayer, iOuterHeavenType)
		PreGame.SetLeaderType(iPlayer, iBigBoss)
		PreGame.SetLeaderName(iPlayer, GameInfo.Leaders[iBigBoss].Description)
		PreGame.SetCivilizationDescription(iPlayer, GameInfo.Civilizations[iOuterHeavenType].Description)
		PreGame.SetCivilizationShortDescription(iPlayer, GameInfo.Civilizations[iOuterHeavenType].ShortDescription)
		PreGame.SetCivilizationAdjective(iPlayer, GameInfo.Civilizations[iOuterHeavenType].Adjective)
		PreGame.SetPlayerColor(iPlayer, GameInfoTypes.PLAYERCOLOR_BB_OUTER_HEAVEN)
		
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			pCapital:SetName("TXT_KEY_CITY_NAME_OUTER_HEAVEN")
		end

		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_BB_OUTER_HEAVEN, true)
			end
		end
		
		Events.SerialEventUnitInfoDirty()
		Events.SerialEventCityInfoDirty()
		Events.SerialEventGameDataDirty()
		LuaEvents.MSFRefreshSnakePlayers(true)

		LuaEvents.MSFRefreshTopPanelMSFStatus()
		LuaEvents.MSFRefreshSalvageDisplay()

		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoop = Players[i]
			if pLoop:IsEverAlive() and pLoop:GetCivilizationType() == GameInfoTypes.CIVILIZATION_OUTER_HEAVEN then
				PreGame.SetCivilizationDescription(iPlayer, Locale.ConvertTextKey("TXT_KEY_CIV_BB_OUTER_HEAVEN_APPEND") .." "..Locale.ConvertTextKey(GameInfo.Civilizations[iOuterHeavenType].Description))
				PreGame.SetCivilizationShortDescription(iPlayer, Locale.ConvertTextKey("TXT_KEY_CIV_BB_OUTER_HEAVEN_APPEND") .." "..Locale.ConvertTextKey(GameInfo.Civilizations[iOuterHeavenType].ShortDescription))
				PreGame.SetCivilizationAdjective(iPlayer, Locale.ConvertTextKey("TXT_KEY_CIV_BB_OUTER_HEAVEN_APPEND") .." "..Locale.ConvertTextKey(GameInfo.Civilizations[iOuterHeavenType].Adjective))
			end
		end

		save(pPlayer, "Decisions_BigBossOuterHeaven", true)
	end
	)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MSF, "Decisions_BigBossOuterHeaven", Decisions_BigBossOuterHeaven)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_DIAMOND_DOGS, "Decisions_BigBossOuterHeaven", Decisions_BigBossOuterHeaven)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_BB_OUTER_HEAVEN, "Decisions_BigBossOuterHeaven", Decisions_BigBossOuterHeaven)



local iOverThreeFourthCivs = 0

for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		iOverThreeFourthCivs = iOverThreeFourthCivs + 1
	end
end

iOverThreeFourthCivs = math.ceil(iOverThreeFourthCivs * 0.75)

function IsDenunciationThresholdMSF(pPlayer)
	local iDenouncements = 0
	for iLoopPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pLoopPlayer = Players[iLoopPlayer]
		if iLoopPlayer ~= iPlayer then
			if pLoopPlayer:IsDenouncedPlayer(pPlayer:GetID()) then
				iDenouncements = iDenouncements + 1
				if iDenouncements >= iOverThreeFourthCivs then
					return true
				end
			end
		end
	end
	return false
end