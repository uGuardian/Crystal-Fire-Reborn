-- OcelotDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local iSiegeType = GameInfoTypes.UNITCOMBAT_SIEGE
local iPromotion = GameInfoTypes.PROMOTION_CITY_SIEGE

local Decisions_OcelotSAA = {}
	Decisions_OcelotSAA.Name = "TXT_KEY_DECISIONS_OCELOT_SAA"
	Decisions_OcelotSAA.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OCELOT_SAA_DESC")
	HookDecisionCivilizationIcon(Decisions_OcelotSAA, "CIVILIZATION_OUTER_HEAVEN")
	Decisions_OcelotSAA.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_OUTER_HEAVEN) then
			return false, false
		end

		if load(pPlayer, "Decisions_OcelotSAA") == true then
			Decisions_OcelotSAA.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OCELOT_SAA_ENACTED_DESC")
			return false, false, true
		end
		
		local iGoldCost = math.ceil(1000 * iMod)

		Decisions_OcelotSAA.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OCELOT_SAA_DESC", iGoldCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_INDUSTRIALIZATION) and pTeamTechs:HasTech(GameInfoTypes.TECH_RIFLING) then
			return true, true
		else
			return true, false	
		end
	
	end
	)
	
	Decisions_OcelotSAA.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(800 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		save(pPlayer, "Decisions_OcelotSAA", true)
	end
	)

	Decisions_OcelotSAA.Monitors = {}
	Decisions_OcelotSAA.Monitors[GameEvents.UnitKilledInCombat] =  (
	function(iKiller, iKilled, iUnitType)
		local pKiller = Players[iKiller]
		if load(pKiller, "Decisions_OcelotSAA") == true then
			local iCulture = GameInfo.Units[iUnitType].Combat
			if iCulture then
				pKiller:ChangeJONSCulture(iCulture)
			end
		end
	end)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_OUTER_HEAVEN, "Decisions_OcelotSAA", Decisions_OcelotSAA)

local Decisions_OcelotGesture = {}
	Decisions_OcelotGesture.Name = "TXT_KEY_DECISIONS_OCELOT_GESTURE"
	Decisions_OcelotGesture.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OCELOT_GESTURE_DESC")
	HookDecisionCivilizationIcon(Decisions_OcelotGesture, "CIVILIZATION_OUTER_HEAVEN")
	Decisions_OcelotGesture.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_OUTER_HEAVEN) then
			return false, false
		end

		if load(pPlayer, "Decisions_OcelotGesture") == true then
			Decisions_OcelotGesture.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OCELOT_GESTURE_ENACTED_DESC")
			return false, false, true
		end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		if pPlayer:HasPolicy(GameInfoTypes.POLICY_HONOR_FINISHER) then
			return true, true
		else
			return true, false
		end
	end
	)

	Decisions_OcelotGesture.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_OCELOT_GESTURE, true)
		save(pPlayer, "Decisions_OcelotGesture", true)
	end
	)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_OUTER_HEAVEN, "Decisions_OcelotGesture", Decisions_OcelotGesture)