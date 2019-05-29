-- PMMMOrikoKirikaDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/27/2014 12:19:55 AM
--------------------------------------------------------------

local iDummy = GameInfoTypes.BUILDING_DECISION_ORIKO_KIRIKA_DUMMY

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Divine your Country's Future
--50% chance of a Golden Age, 50% chance of Anarchy
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_DivineCountrysFuture = {}
	Decisions_DivineCountrysFuture.Name = "TXT_KEY_DECISIONS_ORIKO_KIRIKA_DIVINATION"
	Decisions_DivineCountrysFuture.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIKO_KIRIKA_DIVINATION_DESC")
	HookDecisionCivilizationIcon(Decisions_DivineCountrysFuture, "CIVILIZATION_ORIKO_KIRIKA")
	Decisions_DivineCountrysFuture.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_ORIKO_KIRIKA) then
			return false, false
		end
		local iTurnsBetween = math.ceil(25 * iMod)
		local iGoldenAge = pPlayer:GetGoldenAgeLength()
		local iAnarchy = math.ceil(iGoldenAge / 3)
		if load(pPlayer, "Decisions_DivineCountrysFuture") then
			if Game:GetGameTurn() - load(pPlayer, "Decisions_DivineCountrysFuture") <= iTurnsBetween then
				Decisions_DivineCountrysFuture.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIKO_KIRIKA_DIVINATION_ENACTED_DESC", iGoldenAge, iAnarchy)
				return false, false, true
			end
		end
		
		local iCost = math.ceil((60 * pPlayer:GetCurrentEra()) * iMod)
		if iCost == 0 then iCost = 60 end
		Decisions_DivineCountrysFuture.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIKO_KIRIKA_DIVINATION_DESC", iTurnsBetween, iCost, iGoldenAge, iAnarchy)
		
		if pPlayer:GetFaith() < iCost then return true, false else return true, true end
	end
	)
	
	Decisions_DivineCountrysFuture.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil((60 * pPlayer:GetCurrentEra()) * iMod)
		if iCost == 0 then iCost = 60 end
		pPlayer:ChangeFaith(-iCost)
		local iChance = Game.Rand(99, "Shirome Decision Roll")
		if iChance < 50 then
			local iGoldenAge = pPlayer:GetGoldenAgeLength()
			pPlayer:ChangeGoldenAgeTurns(iGoldenAge)
		else
			local iAnarchy = math.ceil(pPlayer:GetGoldenAgeLength() / 3)
			pPlayer:ChangeAnarchyNumTurns(iAnarchy)
		end
		save(pPlayer, "Decisions_DivineCountrysFuture", Game:GetGameTurn())
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_ORIKO_KIRIKA, "Decisions_DivineCountrysFuture", Decisions_DivineCountrysFuture)



--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Sharpen up the New Recruits in {1_CityName}
--Kill a brand new Unit so that the next Units built get +15 XP
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_SharpenUpRecruits = {}
	Decisions_SharpenUpRecruits.Name = "TXT_KEY_DECISIONS_ORIKO_KIRIKA_SHARPEN_RECRUITS"
	Decisions_SharpenUpRecruits.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIKO_KIRIKA_SHARPEN_RECRUITS_DESC")
	HookDecisionCivilizationIcon(Decisions_SharpenUpRecruits, "CIVILIZATION_ORIKO_KIRIKA")
	Decisions_SharpenUpRecruits.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_ORIKO_KIRIKA) then
			return false, false
		end

			for pCity in pPlayer:Cities() do

			local sKey = "Decisions_SharpenUpRecruits" .. CompileCityID(pCity)
			local sName = pCity:GetName()

			local tTable = {}
		
		
			local pTargetUnit = nil
			local iLand = DomainTypes.DOMAIN_LAND
		
			local pPlot = pCity:Plot()
			local iNumUnits = pPlot:GetNumUnits()
			for iVal = 0,(iNumUnits - 1) do
				local pUnit = pPlot:GetUnit(iVal)
				if pUnit:GetDomainType() == iLand and pUnit:IsCombatUnit() and pUnit:GetGameTurnCreated() == Game:GetGameTurn() and pUnit:GetUnitType() ~= GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL then
					pTargetUnit = pUnit
					break
				end
			end
			
			tTable.Unit = pTargetUnit
			if pTargetUnit then
				tTable.Strength = pTargetUnit:GetBaseCombatStrength()
				tTable.Gold = tTable.Strength * 13
				tTable.Turns = (10 + math.ceil(tTable.Strength / 10)) * iMod
			end

			if not tTable.Turns then tTable.Turns = 10 * iMod end
		
		
			tTempDecisions[sKey] = {}
			tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIKO_KIRIKA_SHARPEN_RECRUITS", sName)
			tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIKO_KIRIKA_SHARPEN_RECRUITS_DESC")
			tTempDecisions[sKey].Data1 = pCity
			tTempDecisions[sKey].Data2 = tTable
			tTempDecisions[sKey].Weight = 0
			tTempDecisions[sKey].Type = "Civilization"
			HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_ORIKO_KIRIKA")
			tTempDecisions[sKey].CanFunc = (
			function(pPlayer, pCity)
				local sKey = "Decisions_SharpenUpRecruits" .. CompileCityID(pCity)
				local sName = pCity:GetName()

				if load(pPlayer, "Decisions_SharpenUpRecruits") then
					if load(pPlayer, "Decisions_SharpenUpRecruits") > 0 and load(pPlayer, sKey) == true then
						tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIKO_KIRIKA_SHARPEN_RECRUITS_ENACTED_DESC", sName, tTable.Turns)
						return false, false, true
					elseif load(pPlayer, "Decisions_SharpenUpRecruits") > 0 and not load(pPlayer, sKey) then
						return false, false
					end
				end

				if not tTable.Unit then
					return false, false
				end
					
				tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIKO_KIRIKA_SHARPEN_RECRUITS_DESC", sName, tTable.Gold, tTable.Turns)

				if pPlayer:GetGold() < tTable.Gold then return true, false end
							
				return true, true
			end
			)
			
			tTempDecisions[sKey].DoFunc = (
			function(pPlayer, pCity)
				local sKey = "Decisions_SharpenUpRecruits" .. CompileCityID(pCity)
				pPlayer:ChangeGold(-tTable.Gold)
				pCity:SetNumRealBuilding(iDummy, 1)
				tTable.Unit:Kill(true)
				for eEvent, fFunc in pairs(Decisions_SharpenUpRecruits.Monitors) do
					eEvent.Remove(fFunc)
					eEvent.Add(fFunc)
				end
				save("GAME", "Decisions_SharpenUpRecruits_Monitors", true)		
				save(pPlayer, "Decisions_SharpenUpRecruits", tTable.Turns)
				save(pPlayer, sKey, true)
			end
			)
		end

	end
	)

	Decisions_SharpenUpRecruits.Monitors = {}
	Decisions_SharpenUpRecruits.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_SharpenUpRecruits") then
			local iValue = load(pPlayer, "Decisions_SharpenUpRecruits")
			if iValue > 0 then
				iValue = iValue - 1
				save(pPlayer, "Decisions_SharpenUpRecruits", iValue)
				if iValue <= 0 then
					for pCity in pPlayer:Cities() do
						if pCity:IsHasBuilding(iDummy) then
							pCity:SetNumRealBuilding(iDummy, 0)
							local sKey = "Decisions_SharpenUpRecruits" .. CompileCityID(pCity)
							save(pPlayer, sKey, false)
							return
						end
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_ORIKO_KIRIKA, "Decisions_SharpenUpRecruits", Decisions_SharpenUpRecruits)


