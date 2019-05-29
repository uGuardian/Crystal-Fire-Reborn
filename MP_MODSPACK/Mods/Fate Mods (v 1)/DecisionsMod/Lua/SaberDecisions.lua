-- SaberDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local iACType = GameInfoTypes.BUILDING_ARTHURIAN_COURT

local Decisions_SaberLily = {}
	Decisions_SaberLily.Name = "TXT_KEY_DECISIONS_SABER_LILY"
	Decisions_SaberLily.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SABER_LILY_DESC")
	HookDecisionCivilizationIcon(Decisions_SaberLily, "CIVILIZATION_BRITAIN_FSN")
	Decisions_SaberLily.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_BRITAIN_FSN) then
			return false, false
		end

		if load(pPlayer, "Decisions_SaberLily") then
			Decisions_SaberLily.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SABER_LILY_ENACTED_DESC")
			return false, false, true
		end
		
		local iCultureCost = math.ceil(550 * iMod)

		local iWLKTDTurns = math.ceil(pPlayer:GetGoldenAgeLength() * 2)

		Decisions_SaberLily.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SABER_LILY_DESC", iCultureCost, iWLKTDTurns)
		
		if pPlayer:GetJONSCulture() < iCultureCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		if pPlayer:GetCurrentEra() > GameInfoTypes.ERA_RENAISSANCE then return true, false end

		local iNumACs = 0
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iACType) then
				iNumACs = iNumACs + 1
				if iNumACs >= 4 then return true, true end
			end
		end
	
		return true, false

	end
	)
	
	Decisions_SaberLily.DoFunc = (
	function(pPlayer)
		local iCultureCost = math.ceil(550 * iMod)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		local iWLKTDTurns = math.ceil(pPlayer:GetGoldenAgeLength() * 2)
		pPlayer:GetCapitalCity():ChangeWeLoveTheKingDayCounter(iWLKTDTurns)

		local iSaberLily = GameInfoTypes.LEADER_SABER_LILY
		local iPlayer = pPlayer:GetID()

		PreGame.SetLeaderType(iPlayer, iSaberLily)
		PreGame.SetLeaderName(iPlayer, GameInfo.Leaders[iSaberLily].Description)

		Events.SerialEventUnitInfoDirty()
		Events.SerialEventCityInfoDirty()
		Events.SerialEventGameDataDirty()

		save(pPlayer, "Decisions_SaberLily", Game:GetGameTurn())
	end
	)

	Decisions_SaberLily.Monitors = {}
	Decisions_SaberLily.Monitors[GameEvents.UnitSetXY] = (
	function(iPlayer, iUnit, iX, iY)
		if iX > 0 and iY > 0 and iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_SaberLily") then
				local pUnit = pPlayer:GetUnitByID(iUnit)
				if pUnit:GetUnitType() == GameInfoTypes.UNIT_KOTR_FSN and not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_SABER_LILY_DECISION) then
					if pUnit:GetGameTurnCreated() > load(pPlayer, "Decisions_SaberLily") then
						pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SABER_LILY_DECISION, true)
						pPlayer:ChangeNumResourceTotal(iMagistrate, 1)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_BRITAIN_FSN, "Decisions_SaberLily", Decisions_SaberLily)

local Decisions_SaberArthurianCycle = {}
	Decisions_SaberArthurianCycle.Name = "TXT_KEY_DECISIONS_SABER_ARTHURIAN_CYCLE"
	Decisions_SaberArthurianCycle.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SABER_ARTHURIAN_CYCLE_DESC")
	HookDecisionCivilizationIcon(Decisions_SaberArthurianCycle, "CIVILIZATION_BRITAIN_FSN")
	Decisions_SaberArthurianCycle.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_BRITAIN_FSN) then
			return false, false
		end

		local iGoldCost = math.ceil((450 + 125 * pPlayer:GetCurrentEra()) * iMod)

		Decisions_SaberArthurianCycle.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SABER_ARTHURIAN_CYCLE_DESC", iGoldCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if not pTeamTechs:HasTech(GameInfoTypes.TECH_CHIVALRY) then return true, false end

		local iWriterClass = GameInfoTypes.UNITCLASS_WRITER

		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == iWriterClass then
				return true, true
			end
		end

		return true, false
	end
	)

	Decisions_SaberArthurianCycle.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil((450 + 125 * pPlayer:GetCurrentEra()) * iMod)
		pPlayer:ChangeGold(-iGoldCost)

		local iWriterClass = GameInfoTypes.UNITCLASS_WRITER

		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == iWriterClass then
				pUnit:Kill(true)
				break
			end
		end

		local iTourismCultureAmount = 0;
		local iKOTR = GameInfoTypes.UNIT_KOTR_FSN

		if load(pPlayer, "Decisions_SaberArthurianCycle") then
			iTourismCultureAmount = load(pPlayer, "Decisions_SaberArthurianCycle")
		end

		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iKOTR then
				iTourismCultureAmount = iTourismCultureAmount + 1
			end
		end

		local pCapital = pPlayer:GetCapitalCity()

		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_CULTURE, iTourismCultureAmount)

		local tTourismTable = {}

		tTourismTable = toBits(iTourismCultureAmount)

		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_TOURISM_1, tTourismTable[1])
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_TOURISM_2, tTourismTable[2])
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_TOURISM_4, tTourismTable[3])
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_TOURISM_8, tTourismTable[4])
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_TOURISM_16, tTourismTable[5])
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_TOURISM_32, tTourismTable[6])
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_TOURISM_64, tTourismTable[7])
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SABER_TOURISM_128, tTourismTable[8])

		save(pPlayer, "Decisions_SaberArthurianCycle", iTourismCultureAmount)
	end
	)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_BRITAIN_FSN, "Decisions_SaberArthurianCycle", Decisions_SaberArthurianCycle)



--Credit to UltimatePotato from Civfanatics for this trick!
function toBits(num)
    -- returns a table of bits, least significant first.
	t={} -- will contain the bits
    while num>0 do
        local rest=math.fmod(num,2)
        t[#t+1]=rest
        num=(num-rest)/2
    end
    return t
end