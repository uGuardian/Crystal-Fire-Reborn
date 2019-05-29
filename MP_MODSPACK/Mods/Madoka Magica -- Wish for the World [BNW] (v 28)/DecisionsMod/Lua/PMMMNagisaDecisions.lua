-- PMMMNagisaDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:36 PM
--------------------------------------------------------------

local iCharlotte = GameInfoTypes.BUILDING_DECISIONS_NAGISA_CHARLOTTE_GATE
local iCastle = GameInfoTypes.BUILDING_CASTLE
local iPromotion = GameInfoTypes.PROMOTION_DECISIONS_NAGISA

function GrantCharlottePromotion(pUnit)
	if pUnit then
		local pPlot = pUnit:GetPlot()
		local pCity = pPlot:GetPlotCity()
		if pCity then
			if pCity:IsHasBuilding(iCharlotte) then
				pUnit:SetHasPromotion(iPromotion, true)
			else
				pUnit:SetHasPromotion(iPromotion, false)
			end
		else
			pUnit:SetHasPromotion(iPromotion, false)
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Enforce Mandatory Extended Recess
--+2 Happiness from Public Schools
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_MandatoryRecess = {}
	Decisions_MandatoryRecess.Name = "TXT_KEY_DECISIONS_NAGISA_RECESS"
	Decisions_MandatoryRecess.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NAGISA_RECESS_DESC")
	HookDecisionCivilizationIcon(Decisions_MandatoryRecess, "CIVILIZATION_NAGISA")
	Decisions_MandatoryRecess.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_NAGISA) then
			return false, false
		end
		if load(pPlayer, "Decisions_MandatoryRecess") == true then
			Decisions_MandatoryRecess.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NAGISA_RECESS_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(500 * iMod)
		Decisions_MandatoryRecess.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NAGISA_RECESS_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_SCIENTIFIC_THEORY) then 
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_MandatoryRecess.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(500 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_NAGISA_RECESS, true)
		save(pPlayer, "Decisions_MandatoryRecess", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_NAGISA, "Decisions_MandatoryRecess", Decisions_MandatoryRecess)


--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Paint Charlotte's Mouth on the Gate of Castle {City Name}
--Builds a Charlotte's Gate in the City which grants half defense effect of Walls and garrisoned units get -10% to enemy units within 1 tile
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_CharlotteGatePaint = {}
	Decisions_CharlotteGatePaint.Name = "TXT_KEY_DECISIONS_NAGISA_CHARLOTTE_GATE"
	Decisions_CharlotteGatePaint.Desc = "TXT_KEY_DECISIONS_NAGISA_CHARLOTTE_GATE_DESC"
	Decisions_CharlotteGatePaint.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_NAGISA then return false, false end
		
		for pCity in pPlayer:Cities() do

			local sKey = "Decisions_CharlotteGatePaint" .. CompileCityID(pCity)
			local sName = pCity:GetName()
			
			tTempDecisions[sKey] = {}
			tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NAGISA_CHARLOTTE_GATE", sName)
			tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NAGISA_CHARLOTTE_GATE_DESC")
			tTempDecisions[sKey].Data1 = pCity
			tTempDecisions[sKey].Weight = 0
			tTempDecisions[sKey].Type = "Civilization"
			HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_NAGISA")
			tTempDecisions[sKey].CanFunc = (
			function(pPlayer, pCity)
				local sKey = "Decisions_CharlotteGatePaint" .. CompileCityID(pCity)
				local sName = pCity:GetName()

				if load(pPlayer, sKey) == true then
					tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NAGISA_CHARLOTTE_GATE_ENACTED_DESC", sName)
					return false, false, true
				end
				
				if not pCity:IsHasBuilding(iCastle) then return false, false end
				
				local iCultureCost = math.ceil(100 * iMod)
				local iGoldCost = math.ceil(150 * iMod)

				tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NAGISA_CHARLOTTE_GATE_DESC", iCultureCost, iGoldCost)

				if pPlayer:GetGold() < iGoldCost then return true, false end
				if pPlayer:GetJONSCulture() < iCultureCost then return true, false end
			
				return true, true
			end
			)
			
			tTempDecisions[sKey].DoFunc = (
			function(pPlayer, pCity)
				local sKey = "Decisions_CharlotteGatePaint" .. CompileCityID(pCity)
				local iCultureCost = math.ceil(100 * iMod)
				local iGoldCost = math.ceil(150 * iMod)
				pPlayer:ChangeGold(-iGoldCost)
				pPlayer:ChangeJONSCulture(-iCultureCost)
				pCity:SetNumRealBuilding(iCharlotte, 1)
				for eEvent, fFunc in pairs(Decisions_CharlotteGatePaint.Monitors) do
					eEvent.Remove(fFunc)
					eEvent.Add(fFunc)
				end
				save("GAME", "Decisions_CharlotteGatePaint_Monitors", true)		
				save(pPlayer, sKey, true)
				save(pPlayer, "Decisions_CharlotteGatePaint", true)
			end
			)
		end
	end
	)
	
	Decisions_CharlotteGatePaint.Monitors = {}
	Decisions_CharlotteGatePaint.Monitors[GameEvents.UnitSetXY] =  (
	function(iPlayer, iUnit, iX, iY)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_CharlotteGatePaint") then
				local pUnit = pPlayer:GetUnitByID(iUnit)
				if pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then
					GrantCharlottePromotion(pUnit)
				end
			end
		end
	end
	)

	Decisions_CharlotteGatePaint.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_CharlotteGatePaint") then
				for pUnit in pPlayer:Units() do
					if pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then
						GrantCharlottePromotion(pUnit)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_NAGISA, "Decisions_CharlotteGatePaint", Decisions_CharlotteGatePaint)


