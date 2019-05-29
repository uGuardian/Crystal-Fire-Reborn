-- LancerDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local iPromotion = GameInfoTypes.PROMOTION_DECISIONS_LANCER
local iImprovement = GameInfoTypes.IMPROVEMENT_RUNE_HENGE_FSN
local iMissionaryClass = GameInfoTypes.UNITCLASS_MISSIONARY
local iFianna = GameInfoTypes.UNIT_FIANNA_FSN
local iRadius = 1  --radius of AOE of first decision
local iWriterClass = GameInfoTypes.UNITCLASS_WRITER
local iLongswordsman = GameInfoTypes.UNIT_LONGSWORDSMAN

local Decisions_LancerRuneSpell = {}
	Decisions_LancerRuneSpell.Name = "TXT_KEY_DECISIONS_LANCER_RUNE_SPELL"
	Decisions_LancerRuneSpell.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LANCER_RUNE_SPELL_DESC")
	HookDecisionCivilizationIcon(Decisions_LancerRuneSpell, "CIVILIZATION_IRELAND_FSN")
	Decisions_LancerRuneSpell.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_IRELAND_FSN) then
			return false, false
		end

		local iCurrentEra = pPlayer:GetCurrentEra()

		if load(pPlayer, "Decisions_LancerRuneSpell") and load(pPlayer, "Decisions_LancerRuneSpell") >= iCurrentEra then
			Decisions_LancerRuneSpell.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LANCER_RUNE_SPELL_ENACTED_DESC")
			return false, false, true
		end
		
		local iEraMod = math.min(0, iCurrentEra - 1)

		local iFaithCost = math.ceil((200 + (120 * iEraMod)) * iMod)
		
		Decisions_LancerRuneSpell.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LANCER_RUNE_SPELL_DESC", iFaithCost)

		if pPlayer:GetFaith() < iFaithCost then return true, false end

		local bHasRuneMissionary;
		local bHasEnemyUnit;
		local pTeam = Teams[pPlayer:GetTeam()]

		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot then
					if not bHasRuneMissionary then
						if pPlot:GetImprovementType() == iImprovement then
							for c = 0, pPlot:GetNumUnits() - 1 do
								local pPlotUnit = pPlot:GetUnit(c)
								if pPlotUnit and pPlotUnit:GetOwner() == pPlayer:GetID() and pPlotUnit:GetUnitClassType() == iMissionaryClass then
									bHasRuneMissionary = true
									if bHasRuneMissionary and bHasEnemyUnit then
										return true, true
									end
									break
								end
							end
						end
					end
					if not bHasEnemyUnit then
						for c = 0, pPlot:GetNumUnits() - 1 do
							local pPlotUnit = pPlot:GetUnit(c)
							if pPlotUnit and pPlotUnit:GetOwner() ~= pPlayer:GetID() then
								local iOwnerTeam = Players[pPlotUnit:GetOwner()]:GetTeam()
								if pTeam:IsAtWar(iOwnerTeam) then
									bHasEnemyUnit = true
									if bHasRuneMissionary and bHasEnemyUnit then
										return true, true
									end
									break
								end
							end
						end
					end
				end
			end
		end

		return true, false
	end
	)
	
	Decisions_LancerRuneSpell.DoFunc = (
	function(pPlayer)
		local iEraMod = math.min(0, pPlayer:GetCurrentEra() - 1)
		local iFaithCost = math.ceil((200 + (120 * iEraMod)) * iMod)
		pPlayer:ChangeFaith(-iFaithCost)

		local pTeam = Teams[pPlayer:GetTeam()]

		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot then
					if pPlot:GetImprovementType() == iImprovement then
						for c = 0, pPlot:GetNumUnits() - 1 do
							local pPlotUnit = pPlot:GetUnit(c)
							if pPlotUnit and pPlotUnit:GetOwner() == pPlayer:GetID() and pPlotUnit:GetUnitClassType() == iMissionaryClass then
								for pAreaPlot in PlotAreaSpiralIterator(pPlot, iRadius, 1, true, true, false) do
									if pAreaPlot:IsUnit() then
										for c = 0, pAreaPlot:GetNumUnits() - 1 do
											local pPlotUnit = pAreaPlot:GetUnit(c)
											if pPlotUnit then
												if pPlotUnit:GetOwner() ~= pPlayer:GetID() then
													local iOwnerTeam = Players[pPlotUnit:GetOwner()]:GetTeam()
													if pTeam:IsAtWar(iOwnerTeam) then
														pPlotUnit:SetHasPromotion(iPromotion, true)
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
			end
		end

		save(pPlayer, "Decisions_LancerRuneSpell", pPlayer:GetCurrentEra())
	end
	)

	Decisions_LancerRuneSpell.Monitors = {}
	Decisions_LancerRuneSpell.Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(iPromotion) then
				pUnit:SetMoves(0)
			end
			pUnit:SetHasPromotion(iPromotion, false)
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_IRELAND_FSN, "Decisions_LancerRuneSpell", Decisions_LancerRuneSpell)

local Decisions_LancerFianna = {}
	Decisions_LancerFianna.Name = "TXT_KEY_DECISIONS_LANCER_MODERNIZE_FIANNA"
	Decisions_LancerFianna.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LANCER_MODERNIZE_FIANNA_DESC")
	HookDecisionCivilizationIcon(Decisions_LancerFianna, "CIVILIZATION_IRELAND_FSN")
	Decisions_LancerFianna.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_IRELAND_FSN) then
			return false, false
		end

		if load(pPlayer, "Decisions_LancerFianna") then
			Decisions_LancerFianna.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LANCER_MODERNIZE_FIANNA_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = 0
		local iCultureReward = 0
		local bHasWriter;

		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iFianna then
				iGoldCost = iGoldCost + math.ceil(50 * iMod)
				iCultureReward = iCultureReward + math.ceil(4 * pUnit:GetExperience() * iMod)
			elseif pUnit:GetUnitClassType() == iWriterClass then
				bHasWriter = true
			end
		end

		Decisions_LancerFianna.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LANCER_MODERNIZE_FIANNA_DESC", iGoldCost, iCultureReward)

		if not bHasWriter then return true, false end
		
		if pPlayer:GetGold() < iGoldCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		if (pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_IRON, true) < 0) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_CHIVALRY) then
			return true, true
		else
			return true, false	
		end
	end
	)

	Decisions_LancerFianna.DoFunc = (
	function(pPlayer)
		local iGoldCost = 0
		local iCultureReward = 0
		local bKilledWriter;

		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iFianna then
				iGoldCost = iGoldCost + math.ceil(50 * iMod)
				iCultureReward = iCultureReward + math.ceil(4 * pUnit:GetExperience() * iMod)
				local pNewUnit = pPlayer:InitUnit(iLongswordsman, pUnit:GetX(), pUnit:GetY(), UNITAI_ATTACK)
				pNewUnit:Convert(pUnit)
				if pNewUnit:GetPlot():IsWater() then
					pNewUnit:Embark(pNewUnit:GetPlot())
				end
				pNewUnit:SetMoves(0)
			elseif pUnit:GetUnitClassType() == iWriterClass and not bKilledWriter then
				pUnit:Kill(true)
				bKilledWriter = true
			end
		end

		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeJONSCulture(iCultureReward)

		save(pPlayer, "Decisions_LancerFianna", true)
	end
	)


	Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_IRELAND_FSN, "Decisions_LancerFianna", Decisions_LancerFianna)