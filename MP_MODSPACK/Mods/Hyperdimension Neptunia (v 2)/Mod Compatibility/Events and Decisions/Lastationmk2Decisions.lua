-- Lastationmk2Decisions
-- Author: Vice
-- DateCreated: 8/6/2015 1:31:59 PM
--------------------------------------------------------------


local iMapXWidth, iMapYWidth = Map.GetGridSize()
local iRequiredDistance = math.ceil(iMapXWidth * 0.3)

--The numbers indicate the multiplier used for the Gold/Share costs. (More expensive to automatically transform Warriors to Musketmen, for example)
local tMeleeUnits = {
	[GameInfoTypes.UNITCLASS_WARRIOR] = 3,
	[GameInfoTypes.UNITCLASS_SPEARMAN] = 2,
	[GameInfoTypes.UNITCLASS_PIKEMAN] = 1,
	[GameInfoTypes.UNITCLASS_SWORDSMAN] = 2,
	[GameInfoTypes.UNITCLASS_LONGSWORDSMAN] = 1
}

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Develop Remote Play
--+10% from City Connections and +50% from Internal Trade Routes.
--Requires a City at least 30% of the total X width of the map away from your Capital.
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_Lastationmk2RemotePlay = {}
	Decisions_Lastationmk2RemotePlay.Name = "TXT_KEY_DECISIONS_VV_LASTATION_UN_REMOTE_PLAY"
	Decisions_Lastationmk2RemotePlay.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_UN_REMOTE_PLAY_DESC")
	HookDecisionCivilizationIcon(Decisions_Lastationmk2RemotePlay, "CIVILIZATION_VV_LASTATION_UN")
	Decisions_Lastationmk2RemotePlay.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_UN) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_BS) then
			return false, false
		end

		if load(pPlayer, "Decisions_Lastationmk2RemotePlay") then
			Decisions_Lastationmk2RemotePlay.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_UN_REMOTE_PLAY_ENACTED_DESC")
			return false, false, true
		end

		local pCapital = pPlayer:GetCapitalCity()
		if not pCapital then return false, false end

		local iGold = math.ceil(600 * iMod)
		local iScience = math.ceil(200 * iMod)

		Decisions_Lastationmk2RemotePlay.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_UN_REMOTE_PLAY_DESC", iRequiredDistance, iGold, iScience)

		local bDistRequirement = false
		for pCity in pPlayer:Cities() do
			if pCity ~= pCapital and Map.PlotDistance(pCity:GetX(), pCity:GetY(), pCapital:GetX(), pCapital:GetY()) >= iRequiredDistance then
				bDistRequirement = true
				break
			end
		end

		if bDistRequirement == false then return true, false end
		if pPlayer:GetGold() < iGold then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		local iProgressThisTech = pTeamTechs:GetResearchProgress(pPlayer:GetCurrentResearch())
		if iProgressThisTech < iScience then return true, false end
		
		return true, true

	end
	)

	Decisions_Lastationmk2RemotePlay.DoFunc = (
	function(pPlayer)
		local iGold = math.ceil(600 * iMod)
		local iScience = math.ceil(200 * iMod)
		pPlayer:ChangeGold(-iGold)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		LuaEvents.Sukritact_ChangeResearchProgress(pPlayer:GetID(), -iScience)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_VV_LASTATION_UN, true)
		save(pPlayer, "Decisions_Lastationmk2RemotePlay", true)
	end
	)
	

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_UN, "Decisions_Lastationmk2RemotePlay", Decisions_Lastationmk2RemotePlay)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_BS, "Decisions_Lastationmk2RemotePlay", Decisions_Lastationmk2RemotePlay)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Start the Gunpowder Revolution
--Upgrades every standard Melee Unit to a Musketman.
--Costs are affected by how many standard Melee Units you own.
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_Lastationmk2Gunpowder = {}
	Decisions_Lastationmk2Gunpowder.Name = "TXT_KEY_DECISIONS_VV_LASTATION_UN_EQUIP_GUNS"
	Decisions_Lastationmk2Gunpowder.Desc = "TXT_KEY_DECISIONS_VV_LASTATION_UN_EQUIP_GUNS_DESC"
	HookDecisionCivilizationIcon(Decisions_Lastationmk2Gunpowder, "CIVILIZATION_VV_LASTATION_UN")
	Decisions_Lastationmk2Gunpowder.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_UN) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_BS) then
			return false, false
		end

		if load(pPlayer, "Decisions_Lastationmk2Gunpowder") == true then
			Decisions_Lastationmk2Gunpowder.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_UN_EQUIP_GUNS_ENACTED_DESC")
			return false, false, true
		end

		local iNumMeleeUnits = 0
		for pUnit in pPlayer:Units() do
			local iUnitType = pUnit:GetUnitClassType()
			if tMeleeUnits[iUnitType] then
				iNumMeleeUnits = iNumMeleeUnits + tMeleeUnits[iUnitType]
			end
		end

		local iGoldCost = math.ceil((150 * iNumMeleeUnits)  * iMod)
		local iSharesCost = math.ceil((50 * iNumMeleeUnits) * iMod)
		local iResistanceTurns = math.floor((iNumMeleeUnits / 2) * iMod)

		local sSharesCost = string.format("%.2f%%", iSharesCost / (iMod * 100))

		Decisions_Lastationmk2Gunpowder.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_UN_EQUIP_GUNS_DESC", iGoldCost, sSharesCost, iResistanceTurns)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if MapModData.HDNMod.Shares[pPlayer:GetID()] < iSharesCost then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_GUNPOWDER) then
			return true, true
		else
			return true, false
		end
	end
	)

	Decisions_Lastationmk2Gunpowder.DoFunc = (
	function(pPlayer)
		local iNumMeleeUnits = 0
		local tUnitsToUpgrade = {}
		for pUnit in pPlayer:Units() do
			local iUnitType = pUnit:GetUnitClassType()
			if tMeleeUnits[iUnitType] then
				iNumMeleeUnits = iNumMeleeUnits + tMeleeUnits[iUnitType]
				tUnitsToUpgrade[#tUnitsToUpgrade + 1] = pUnit
			end
		end

		local iGoldCost = math.ceil((150 * iNumMeleeUnits)  * iMod)
		local iSharesCost = math.ceil((50 * iNumMeleeUnits) * iMod)
		local iResistanceTurns = math.floor((iNumMeleeUnits / 2) * iMod)

		pPlayer:ChangeGold(-iGoldCost)
		LuaEvents.HDNChangeShares(pPlayer:GetID(), -iSharesCost)
		pPlayer:GetCapitalCity():ChangeResistanceTurns(iResistanceTurns)

		local iNewUnitType = GameInfoTypes.UNIT_MUSKETMAN
		for _, pUnit in pairs(tUnitsToUpgrade) do
			local pNewUnit = pPlayer:InitUnit(iNewUnitType, pUnit:GetX(), pUnit:GetY())
			pNewUnit:Convert(pUnit)
			pNewUnit:SetMoves(0)
		end

		save(pPlayer, "Decisions_Lastationmk2Gunpowder", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_UN, "Decisions_Lastationmk2Gunpowder", Decisions_Lastationmk2Gunpowder)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_BS, "Decisions_Lastationmk2Gunpowder", Decisions_Lastationmk2Gunpowder)