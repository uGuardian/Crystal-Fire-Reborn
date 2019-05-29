-- RecluseDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/22/2014 1:02:29 PM
--------------------------------------------------------------

local iPromotion = GameInfoTypes.PROMOTION_DECISIONS_RECLUSE_APPOINT_ARBITER

local Decisions_ArachnosArbiter = {}
	Decisions_ArachnosArbiter.Name = "TXT_KEY_DECISIONS_RECLUSE_APPOINT_ARBITER"
	Decisions_ArachnosArbiter.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RECLUSE_APPOINT_ARBITER_DESC")
	HookDecisionCivilizationIcon(Decisions_ArachnosArbiter, "CIVILIZATION_ARACHNOS")
	Decisions_ArachnosArbiter.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_ARACHNOS) then
			return false, false
		end

		local tTable = {}

		tTable.GoldCost = math.ceil((250 + (150 * pPlayer:GetCurrentEra())) * iMod)
		tTable.LevelReq = 3

		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(iPromotion) then
				tTable.LevelReq = 2
				break
			end
		end

		for pUnit in pPlayer:Units() do

			if pUnit:IsCombatUnit() then
			
				local sKey = "Decisions_ArachnosArbiter" ..pPlayer:GetID()..":"..pUnit:GetID()
				local sName = Locale.ConvertTextKey(pUnit:GetName())
				
				tTempDecisions[sKey] = {}
				tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RECLUSE_APPOINT_ARBITER", sName)
				tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RECLUSE_APPOINT_ARBITER_DESC", sName)
				tTempDecisions[sKey].Data1 = pUnit
				tTempDecisions[sKey].Data2 = tTable
				tTempDecisions[sKey].Weight = 0
				tTempDecisions[sKey].Type = "Civilization"
				HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_ARACHNOS")
				tTempDecisions[sKey].CanFunc = (
				function(pPlayer, pUnit, tTable)
					local sKey = "Decisions_ArachnosArbiter" ..pPlayer:GetID()..":"..pUnit:GetID()
					local sName = Locale.ConvertTextKey(pUnit:GetName())

					if load(pPlayer, sKey) == true and load(pPlayer, "Decisions_ArachnosArbiter") == true then
						tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RECLUSE_APPOINT_ARBITER_ENACTED_DESC", sName)
						return false, false, true
					end

					tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RECLUSE_APPOINT_ARBITER_DESC", tTable.GoldCost)

					if pUnit:GetLevel() < tTable.LevelReq then return false, false end

					if not pUnit:IsPromotionReady() then return true, false end
					
					if pPlayer:GetGold() < tTable.GoldCost then return true, false end
				
					return true, true
				end
				)
				
				tTempDecisions[sKey].DoFunc = (
				function(pPlayer, pUnit, tTable)
					local sKey = "Decisions_ArachnosArbiter" ..pPlayer:GetID()..":"..pUnit:GetID()
					pPlayer:ChangeGold(-tTable.GoldCost)
					pUnit:SetHasPromotion(iPromotion, true)
					pUnit:SetLevel(pUnit:GetLevel() + 1)
					local sName;
					if pUnit:HasName() then
						sName = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ARACHNOS_ARBITER_NAME_APPEND", pUnit:GetNameNoDesc())
					else
						local iRand = Game.Rand(19, "Arachnos Arbiter Name Random") + 1
						sName = "TXT_KEY_DECISIONS_ARACHNOS_ARBITER_NAME_" ..tostring(iRand)
					end
					pUnit:SetName(sName)
					DoArbiterPolicies(pPlayer)
					for eEvent, fFunc in pairs(Decisions_ArachnosArbiter.Monitors) do
						eEvent.Remove(fFunc)
						eEvent.Add(fFunc)
					end
					save("GAME", "Decisions_ArachnosArbiter_Monitors", true)		
					save(pPlayer, "Decisions_ArachnosArbiter", true)
					save(pPlayer, sKey, true)
				end
				)
			end
		end

		return false, false
	end
	)

	Decisions_ArachnosArbiter.Monitors = {}
	Decisions_ArachnosArbiter.Monitors[GameEvents.UnitKilledInCombat] =  (
	function (iKiller, iKilled, iUnit)
		local pPlayer = Players[iKilled]
		if load(pPlayer, "Decisions_ArachnosArbiter") == true then
			DoArbiterPolicies(pPlayer)
		end
	end
	)

	Decisions_ArachnosArbiter.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_ArachnosArbiter") == true then
			DoArbiterPolicies(pPlayer)
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_ARACHNOS, "Decisions_ArachnosArbiter", Decisions_ArachnosArbiter)

local tArbiterPolicies = {}

for policy in GameInfo.Policies() do
	if string.find(policy.Type, "PROMOTION_DECISIONS_RECLUSE_APPOINT_ARBITER_") then
		tArbiterPolicies[policy.Type] = policy.ID
	end
end


function DoArbiterPolicies(pPlayer)
	local iNumArbiters = 0

	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(iPromotion) then
			iNumArbiters = iNumArbiters + 1
			if iNumArbiters >= 10 then iNumArbiters = 10 break end
		end
	end

	local sType = "PROMOTION_DECISIONS_RECLUSE_APPOINT_ARBITER_" ..tostring(iNumArbiters)
	for type, ID in pairs(tArbiterPolicies) do
		if type == sType and not pPlayer:HasPolicy(ID) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(ID, true)
			pPlayer:SetNumFreePolicies(0)
		elseif pPlayer:HasPolicy(ID) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(ID, false)
			pPlayer:SetNumFreePolicies(0)
		end
	end

end



local Decisions_ArachnosInfighting = {}
	Decisions_ArachnosInfighting.Name = "TXT_KEY_DECISIONS_RECLUSE_PROMOTE_INFIGHTING"
	Decisions_ArachnosInfighting.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RECLUSE_PROMOTE_INFIGHTING_DESC")
	HookDecisionCivilizationIcon(Decisions_ArachnosInfighting, "CIVILIZATION_ARACHNOS")
	Decisions_ArachnosInfighting.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_ARACHNOS) then
			return false, false
		end
		
		local iTurns = math.ceil(15 * iMod)

		if load(pPlayer, "Decisions_ArachnosInfighting") then
			Decisions_ArachnosInfighting.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RECLUSE_PROMOTE_INFIGHTING_ENACTED_DESC", iTurns)
			return false, false, true
		end

		local iGoldCost = math.ceil(700 * iMod)
		local iCultureCost = math.ceil(300 * iMod)

		Decisions_ArachnosInfighting.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RECLUSE_PROMOTE_INFIGHTING_DESC", iGoldCost, iCultureCost, iTurns)

		if pPlayer:GetGold() < iGoldCost then return true, false end
		if pPlayer:GetJONSCulture() < iCultureCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if not pTeamTechs:HasTech(GameInfoTypes.TECH_CHIVALRY) then return true, false end

		return true, true

	end
	)
	
	Decisions_ArachnosInfighting.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(700 * iMod)
		local iCultureCost = math.ceil(300 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		local iTurns = math.ceil(15 * iMod)
		--Has a +/- 20% modifier to how many turns it will take
		local iRand = Game.Rand(99, "Arachnos Infighting Turn Modifier") + 1
		local iMultiplier = 1
		if iRand > 50 then
			iMultiplier = 1 - ((iRand - 50) / 100)
		else
			iMultiplier = 1 + (iRand / 100)
		end
		iNextTurn = Game:GetGameTurn() + math.floor(iTurns * iMultiplier)
		save(pPlayer, "Decisions_ArachnosInfighting", iNextTurn)
	end
	)

	Decisions_ArachnosInfighting.Monitors = {}
	Decisions_ArachnosInfighting.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_ArachnosInfighting") then
			if load(pPlayer, "Decisions_ArachnosInfighting") == Game:GetGameTurn() then
				local bIsAtWar
				for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
					local pLoop = Players[i]
					if pLoop ~= pPlayer and Teams[pPlayer:GetTeam()]:IsAtWar(pLoop:GetTeam()) then
						bIsAtWar = true
						break
					end
				end
				if not bIsAtWar then
					for pUnit in pPlayer:Units() do
						if pUnit:IsCombatUnit() and (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND or pUnit:GetDomainType() == DomainTypes.DOMAIN_SEA) then
							--Each Unit has a 20% chance to damage one next to it.
							local iRand = Game.Rand(99, "Arachnos Infighting Unit Chance") + 1
							if iRand <= 20 then
								local tAvailableUnits = {}
								for pPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1) do
									if pPlot:IsUnit() then
										for c = 0, pPlot:GetNumUnits() -1 do
											local pPlotUnit = pPlot:GetUnit(c)
											if pPlotUnit then
												if pPlotUnit:GetOwner() == iPlayer and pPlotUnit:IsCombatUnit() and pPlotUnit:GetDomainType() == pUnit:GetDomainType() then
													tAvailableUnits[#tAvailableUnits + 1] = pPlotUnit
												end
											end
										end
									end
								end
								if #tAvailableUnits > 0 then
									local iUnitChoiceRand = Game.Rand(#tAvailableUnits - 1, "Arachnos Infighting Unit Selection") + 1
									--Does between 20 and 50 damage
									local iDamageRand = Game.Rand(30, "Arachnos Infighting Damage Amount") + 20
									if iPlayer == Game:GetActivePlayer() then
										Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_DECISIONS_RECLUSE_PROMOTE_INFIGHTING", pUnit:GetName(), tAvailableUnits[iUnitChoiceRand]:GetName(), iDamageRand))
									end
									pUnit:ChangeExperience(5)
									tAvailableUnits[iUnitChoiceRand]:ChangeExperience(5)
									pUnit:ChangeDamage(-iDamageRand)
									tAvailableUnits[iUnitChoiceRand]:ChangeDamage(-iDamageRand)
								end
							end
						end
					end
				end
				local iTurns = math.ceil(15 * iMod)
				--Has a +/- 20% modifier to how many turns it will take
				local iRand = Game.Rand(99, "Arachnos Infighting Turn Modifier") + 1
				local iMultiplier = 1
				if iRand > 50 then
					iMultiplier = 1 - ((iRand - 50) / 100)
				else
					iMultiplier = 1 + (iRand / 100)
				end
				iNextTurn = Game:GetGameTurn() + math.floor(iTurns * iMultiplier)
				save(pPlayer, "Decisions_ArachnosInfighting", iNextTurn)
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_ARACHNOS, "Decisions_ArachnosInfighting", Decisions_ArachnosInfighting)

