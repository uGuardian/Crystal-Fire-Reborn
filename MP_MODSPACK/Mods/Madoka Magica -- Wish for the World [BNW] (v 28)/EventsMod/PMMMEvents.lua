--===========================================================================================================================================================================
-- EVENT 1: LEWD DOUJINSHI
-- Only happens to PMMM Civs. Happens once per game once Printing Press is discovered.
--===========================================================================================================================================================================


local Event_PMMMLewd = {}
    Event_PMMMLewd.Name = "TXT_KEY_EVENT_PMMM_LEWD"
	Event_PMMMLewd.Desc = "TXT_KEY_EVENT_PMMM_LEWD_DESC"
	Event_PMMMLewd.tValidCivs = 
		{
		["CIVILIZATION_MADOKA"]			= true,
		["CIVILIZATION_HOMURA"]			= true,
		["CIVILIZATION_MAMI"]			= true,
		["CIVILIZATION_SAYAKA"]			= true,
		["CIVILIZATION_KYOUKO"]			= true,
		["CIVILIZATION_NAGISA"]			= true,
		["CIVILIZATION_DEMON_HOMURA"]	= true,
		["CIVILIZATION_ORIGINAL_MADOKA"]= true,
		["CIVILIZATION_ORIKO_KIRIKA"]	= true,
		["CIVILIZATION_KAORU_UMIKA"]	= true
		}
	Event_PMMMLewd.Weight = 30
	Event_PMMMLewd.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_PMMMLewd") == true then return false end

			local pTeam = Teams[pPlayer:GetTeam()]
			local pTeamTechs = pTeam:GetTeamTechs()
		
			if not pTeamTechs:HasTech(GameInfoTypes.TECH_PRINTING_PRESS) then return false end

			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_PMMMLewd.tValidCivs[sCivType]
		end
		)
	Event_PMMMLewd.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_PMMMLewd.Outcomes[1] = {}
	Event_PMMMLewd.Outcomes[1].Name = "TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_1"
	Event_PMMMLewd.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_1_DESC")
	Event_PMMMLewd.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iValue = math.ceil(250 * iMod)

			Event_PMMMLewd.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_1_DESC", iValue)

			return true
		end
		)
	Event_PMMMLewd.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iValue = math.ceil(250 * iMod)
			pPlayer:ChangeGoldenAgeProgressMeter(-iValue)
			
			save(pPlayer, "Event_PMMMLewd", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_PMMMLewd.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_PMMMLewd.Outcomes[2] = {}
	Event_PMMMLewd.Outcomes[2].Name = "TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_2"
	Event_PMMMLewd.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_2_DESC")
	Event_PMMMLewd.Outcomes[2].CanFunc = (
		function(pPlayer)

			local iGoldValue = math.ceil(300 * iMod)
			if iGoldValue > pPlayer:GetGold() then return false end

			local iGAValue = math.ceil(250 * iMod)

			Event_PMMMLewd.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_2_DESC", iGoldValue, iGAValue)

			return true
		end
		)
	Event_PMMMLewd.Outcomes[2].DoFunc = (
		function(pPlayer)

			local iGoldValue = math.ceil(300 * iMod)
			local iGAValue = math.ceil(250 * iMod)
			pPlayer:ChangeGold(-iGoldValue)
			pPlayer:ChangeGoldenAgeProgressMeter(iGAValue)
			
			save(pPlayer, "Event_PMMMLewd", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_PMMMLewd.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_PMMMLewd.Outcomes[3] = {}
	Event_PMMMLewd.Outcomes[3].Name = "TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_3"
	Event_PMMMLewd.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_3_DESC")
	Event_PMMMLewd.Outcomes[3].CanFunc = (
		function(pPlayer)

			if not pPlayer:GetCapitalCity() then return false end

			local iGoldValue = math.ceil(650 * iMod)
			if iGoldValue > pPlayer:GetGold() then return false end

			local iResistance = math.ceil(1 * iMod)

			Event_PMMMLewd.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_3_DESC", iGoldValue, iResistance)

			return true
		end
		)
	Event_PMMMLewd.Outcomes[3].DoFunc = (
		function(pPlayer)

			local iGoldValue = math.ceil(650 * iMod)
			local iResistance = math.ceil(1 * iMod)
			pPlayer:ChangeGold(-iGoldValue)
			pPlayer:GetCapitalCity():ChangeResistanceTurns(iResistance)
			pPlayer:SetNumFreePolicies(1)
			
			save(pPlayer, "Event_PMMMLewd", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_3_NOTIFICATION"), Locale.ConvertTextKey(Event_PMMMLewd.Name))
		end
		)

	--=========================================================
	-- Outcome 4
	--=========================================================
	Event_PMMMLewd.Outcomes[4] = {}
	Event_PMMMLewd.Outcomes[4].Name = "TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_4"
	Event_PMMMLewd.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_4_DESC")
	Event_PMMMLewd.Outcomes[4].CanFunc = (
		function(pPlayer)

			local iGoldValue = math.ceil(800 * iMod)
			if iGoldValue > pPlayer:GetGold() then return false end

			local iGAValue = math.ceil(250 * iMod)
			if iGAValue > pPlayer:GetGoldenAgeProgressMeter() then return false end

			Event_PMMMLewd.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_4_DESC", iGoldValue, iGAValue)
		

			return true
		end
		)
	Event_PMMMLewd.Outcomes[4].DoFunc = (
		function(pPlayer)

			local iGoldValue = math.ceil(800 * iMod)
			local iGAValue = math.ceil(250 * iMod)
			pPlayer:ChangeGold(-iGoldValue)
			pPlayer:ChangeGoldenAgeProgressMeter(-iGAValue)

			pPlayer:AddFreeUnit(GameInfoTypes[JFD_GetUniqueUnit(pPlayer, "UNITCLASS_ARTIST")], GameInfoTypes["UNITAI_ARTIST"]) 
			pPlayer:AddFreeUnit(GameInfoTypes[JFD_GetUniqueUnit(pPlayer, "UNITCLASS_WRITER")], GameInfoTypes["UNITAI_WRITER"])
			
			save(pPlayer, "Event_PMMMLewd", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_LEWD_OUTCOME_4_NOTIFICATION"), Locale.ConvertTextKey(Event_PMMMLewd.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_PMMMLewd.tValidCivs[sCiv] then
			tEvents.Event_PMMMLewd = Event_PMMMLewd
			break
		end
	end
end



--===========================================================================================================================================================================
-- EVENT 2: FAMILIAR LURKS
-- Common event which can happen to any Civ. Happens throughout the game, but only happens to the Capital before Renaissance.
--===========================================================================================================================================================================

local Event_PMMMFamiliarLurks = {}
    Event_PMMMFamiliarLurks.Name = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY"
	Event_PMMMFamiliarLurks.Desc = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_DESC"
	Event_PMMMFamiliarLurks.Data1 = nil
	Event_PMMMFamiliarLurks.Data2 = nil
	Event_PMMMFamiliarLurks.Data3 = nil
	Event_PMMMFamiliarLurks.Weight = 5
	Event_PMMMFamiliarLurks.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() <= 0 then return false end

			if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_RENAISSANCE then
				Event_PMMMFamiliarLurks.Data1 = pPlayer:GetCapitalCity()
			else
				local iRand = Game.Rand(pPlayer:GetNumCities(), "PMMM Familiar Lurks Event City Roll")
				for pCity in pPlayer:Cities() do
					if iRand <= 0 then
						Event_PMMMFamiliarLurks.Data1 = pCity
						break
					else
						iRand = iRand + 1
					end
				end
			end

			if not Event_PMMMFamiliarLurks.Data1 then Event_PMMMFamiliarLurks.Data1 = pPlayer:GetCapitalCity() end

			Event_PMMMFamiliarLurks.Name = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY", Event_PMMMFamiliarLurks.Data1:GetName())
			Event_PMMMFamiliarLurks.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_DESC", Event_PMMMFamiliarLurks.Data1:GetName())	
				
			return true
		end
		)
	Event_PMMMFamiliarLurks.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_PMMMFamiliarLurks.Outcomes[1] = {}
	Event_PMMMFamiliarLurks.Outcomes[1].Name = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_1"
	Event_PMMMFamiliarLurks.Outcomes[1].Desc = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_DESC_1"
	Event_PMMMFamiliarLurks.Outcomes[1].CanFunc = (
		function(pPlayer, pCity)
			local iFood = math.floor(10 * (math.min(pPlayer:GetCurrentEra() * 2, 1)))
			Event_PMMMFamiliarLurks.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_1_DESC", iFood, pCity:GetName())
			return true
		end
		)
	Event_PMMMFamiliarLurks.Outcomes[1].DoFunc = (
		function(pPlayer, pCity)	
			local iFood = 10 * math.max(pPlayer:GetCurrentEra() * 2, 1)
			--Will loop as long as iFood is greater than 0, to allow for multiple Citizens to be killed off at once
			local bFirstLoop = true;
			while iFood > 0 do
				pCity:ChangeFood(-iFood)
				iFood = 0
				--If the growth is now negative, adjust it to kill off a Citizen
				if pCity:GetFood() < 0 then
					--If the city only has 1 Pop, just set it to 0 and stop the loop
					if pCity:GetPopulation() <= 1 then
						pCity:SetFood(0)
						break
					else
						iFood = -1 * pCity:GetFood()
						pCity:ChangePopulation(-1, true)
						pCity:SetFood(pCity:GrowthThreshold())
					end
				end
				bFirstLoop = false
			end

			local pWitch = Players[63]:InitUnit(GameInfoTypes.UNIT_PMMM_WITCH, pCity:GetX() + 1, pCity:GetY() + 1, UNITAI_ATTACK)
			pWitch:SetBaseCombatStrength(MapModData.gPMMMWitchEraStrengths[Game:GetCurrentEra()])
			pWitch:JumpToNearestValidPlot()

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_PMMMFamiliarLurks.Name))
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_PMMMFamiliarLurks.Outcomes[2] = {}
	Event_PMMMFamiliarLurks.Outcomes[2].Name = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_2"
	Event_PMMMFamiliarLurks.Outcomes[2].Desc = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_DESC_2"
	Event_PMMMFamiliarLurks.Outcomes[2].Weight = 2
	Event_PMMMFamiliarLurks.Outcomes[2].CanFunc = (
		function(pPlayer, pCity)
	
			for c = 0, pCity:Plot():GetNumUnits() - 1, 1 do
				local pUnit = pCity:Plot():GetUnit(c)
				if pUnit and pUnit:IsCombatUnit() and pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then
					for k, v in pairs(MapModData.PMMM.MagicalGirls) do
						if v.UnitID == pUnit:GetID() and v.IsLeader == true then
							return false
						end
					end
					Event_PMMMFamiliarLurks.Data2 = pUnit
					Event_PMMMFamiliarLurks.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_2_DESC", pCity:GetName())
					return true
				end
			end
						
			return false
		end
		)
	Event_PMMMFamiliarLurks.Outcomes[2].DoFunc = (
		function(pPlayer, pCity, pUnit)
			pUnit:ChangeDamage(10)

			local pFamiliar = Players[63]:InitUnit(GameInfoTypes.UNIT_PMMM_FAMILIAR, pCity:GetX() + 1, pCity:GetY() + 1, UNITAI_ATTACK)
			pFamiliar:SetBaseCombatStrength(MapModData.gPMMMFamiliarEraStrengths[Game:GetCurrentEra()])
			pFamiliar:JumpToNearestValidPlot()

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_PMMMFamiliarLurks.Name))
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_PMMMFamiliarLurks.Outcomes[3] = {}
	Event_PMMMFamiliarLurks.Outcomes[3].Name = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_3"
	Event_PMMMFamiliarLurks.Outcomes[3].Desc = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_DESC_3"
	Event_PMMMFamiliarLurks.Outcomes[3].Weight = 3
	Event_PMMMFamiliarLurks.Outcomes[3].CanFunc = (
		function(pPlayer, pCity)

			for c = 0, pCity:Plot():GetNumUnits() - 1, 1 do
				local pUnit = pCity:Plot():GetUnit(c)
				if pUnit and pUnit:IsCombatUnit() and pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then
					for k, v in pairs(MapModData.gT.PMMM.MagicalGirls) do
						if v.UnitID == pUnit:GetID() and v.IsLeader == true then
							local iGAPoints = math.ceil(50 * math.max(pPlayer:GetCurrentEra(), 1) * iMod)
							Event_PMMMFamiliarLurks.Data2 = pUnit
							Event_PMMMFamiliarLurks.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_3_DESC", v.Name, pCity:GetName(), iGAPoints)
							return true
						end
					end

				end
			end

			return false
		end
		)
	Event_PMMMFamiliarLurks.Outcomes[3].DoFunc = (
		function(pPlayer, pCity, pUnit)
			pUnit:ChangeDamage(10)

			local iGAPoints = math.ceil(50 * math.max(pPlayer:GetCurrentEra(), 1) * iMod)
			pPlayer:ChangeGoldenAgeProgressMeter(iGAPoints)

			local pFamiliar = Players[63]:InitUnit(GameInfoTypes.UNIT_PMMM_FAMILIAR, pCity:GetX() + 1, pCity:GetY() + 1, UNITAI_ATTACK)
			pFamiliar:SetBaseCombatStrength(MapModData.gPMMMFamiliarEraStrengths[Game:GetCurrentEra()])
			pFamiliar:JumpToNearestValidPlot()

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_3_NOTIFICATION", pCity:GetName()), Locale.ConvertTextKey(Event_PMMMFamiliarLurks.Name))
		end
		)
	--=========================================================
	-- Outcome 4
	--=========================================================
	Event_PMMMFamiliarLurks.Outcomes[4] = {}
	Event_PMMMFamiliarLurks.Outcomes[4].Name = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_4"
	Event_PMMMFamiliarLurks.Outcomes[4].Desc = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_DESC_4"
	Event_PMMMFamiliarLurks.Outcomes[4].Weight = 4
	Event_PMMMFamiliarLurks.Outcomes[4].CanFunc = (
		function(pPlayer, pCity)
			if pCity:IsCapital() then
				if Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", pPlayer:GetNameKey()) ~= "yes" then
					local iResistance = math.ceil(2 * iMod)
					Event_PMMMFamiliarLurks.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_4_DESC", iResistance, pCity:GetName())
					return true
				end
			end

			return false
		end
		)
	Event_PMMMFamiliarLurks.Outcomes[4].DoFunc = (
		function(pPlayer, pCity)
			local iResistance = math.ceil(2 * iMod)
			pCity:ChangeResistanceTurns(iResistance)
			
			local pFamiliar = Players[63]:InitUnit(GameInfoTypes.UNIT_PMMM_FAMILIAR, pCity:GetX() + 1, pCity:GetY() + 1, UNITAI_ATTACK)
			pFamiliar:SetBaseCombatStrength(MapModData.gPMMMFamiliarEraStrengths[Game:GetCurrentEra()])
			pFamiliar:JumpToNearestValidPlot()
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_4_NOTIFICATION"), Locale.ConvertTextKey(Event_PMMMFamiliarLurks.Name))
		end
		)
	--=========================================================
	-- Outcome 5
	--=========================================================
	Event_PMMMFamiliarLurks.Outcomes[5] = {}
	Event_PMMMFamiliarLurks.Outcomes[5].Name = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_5"
	Event_PMMMFamiliarLurks.Outcomes[5].Desc = "TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_DESC_5"
	Event_PMMMFamiliarLurks.Outcomes[5].Weight = 4
	Event_PMMMFamiliarLurks.Outcomes[5].CanFunc = (
		function(pPlayer, pCity)
			if pCity:IsHasBuildingClass(GameInfoTypes.BUILDINGCLASS_CONSTABLE) or pCity:IsHasBuildingClass(GameInfoTypes.BUILDINGCLASS_POLICE_STATION) then
				Event_PMMMFamiliarLurks.Outcomes[5].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_5_DESC", pCity:GetName())
				return true
			end
			
			return false
		end
		)
	Event_PMMMFamiliarLurks.Outcomes[5].DoFunc = (
		function(pPlayer, pCity)
		
			local pFamiliar = Players[63]:InitUnit(GameInfoTypes.UNIT_PMMM_FAMILIAR, pCity:GetX() + 1, pCity:GetY() + 1, UNITAI_ATTACK)
			pFamiliar:SetBaseCombatStrength(MapModData.gPMMMFamiliarEraStrengths[Game:GetCurrentEra()])
			pFamiliar:JumpToNearestValidPlot()
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_PMMM_FAMILIAR_IN_CITY_OUTCOME_5_NOTIFICATION"), Locale.ConvertTextKey(Event_PMMMFamiliarLurks.Name))
		end
		)
		
tEvents.Event_PMMMFamiliarLurks = Event_PMMMFamiliarLurks