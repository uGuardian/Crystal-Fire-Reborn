-- PMMMKyoukoDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 11:24:14 AM
--------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Empower your Missionaries with your Magic
--Removes penalizing promotions from Missionaries (like the old UA).
--Costs Faith and GP points.
--------------------------------------------------------------------------------------------------------------------------------------------
local iMissionary = GameInfoTypes.UNITCLASS_MISSIONARY
local iProphet = GameInfoTypes.UNITCLASS_PROPHET
local iUnwelcome = GameInfoTypes.PROMOTION_UNWELCOME_EVANGELIST
local iSight = GameInfoTypes.PROMOTION_SIGHT_PENALTY
local iBuilding = GameInfoTypes.BUILDING_DECISIONS_KYOUKO_DEVELOP_ROCKY

local Decisions_EmpowerMissionariesMagic = {}
	Decisions_EmpowerMissionariesMagic.Name = "TXT_KEY_DECISIONS_KYOUKO_EMPOWER_MISSIONARIES"
	Decisions_EmpowerMissionariesMagic.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KYOUKO_EMPOWER_MISSIONARIES_DESC")
	HookDecisionCivilizationIcon(Decisions_EmpowerMissionariesMagic, "CIVILIZATION_KYOUKO")
	Decisions_EmpowerMissionariesMagic.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_KYOUKO) then
			return false, false
		end
		if load(pPlayer, "Decisions_EmpowerMissionariesMagic") == true then
			Decisions_EmpowerMissionariesMagic.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KYOUKO_EMPOWER_MISSIONARIES_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(200 * iMod)
		Decisions_EmpowerMissionariesMagic.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KYOUKO_EMPOWER_MISSIONARIES_DESC", iCost)
		
		if pPlayer:GetFaith() < iCost then return true, false end
		
		if not pPlayer:HasCreatedReligion() then return true, false end
		
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iTotalGPProgress = 0
			for pSpecialistInfo in GameInfo.Specialists() do
				local iSpecialistIndex = pSpecialistInfo.ID;			
				local iProgress = pCapital:GetSpecialistGreatPersonProgress(iSpecialistIndex)
				iTotalGPProgress = iTotalGPProgress + iProgress
				if iTotalGPProgress >= 100 then
					return true, true
				end
			end
			return true, false
		else
			return true, false
		end
	end
	)
	


	Decisions_EmpowerMissionariesMagic.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeFaith(-iCost)
		local pCapital = pPlayer:GetCapitalCity()
		for pSpecialistInfo in GameInfo.Specialists() do
			local iSpecialistIndex = pSpecialistInfo.ID;	
			local iReduceValue = 2500
			local iCurrentValue = pCapital:GetSpecialistGreatPersonProgressTimes100(iSpecialistIndex)
			if iCurrentValue < iReduceValue then
				iReduceValue = iCurrentValue
			end
			pCapital:ChangeSpecialistGreatPersonProgressTimes100(iSpecialistIndex, -1 * iReduceValue)
		end
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == iMissionary or pUnit:GetUnitClassType() == iProphet then
				pUnit:SetHasPromotion(iUnwelcome, false)
				pUnit:SetHasPromotion(iSight, false)
			end
		end
		save(pPlayer, "Decisions_EmpowerMissionariesMagic", true)
	end
	)

	Decisions_EmpowerMissionariesMagic.Monitors = {}
	Decisions_EmpowerMissionariesMagic.Monitors[GameEvents.UnitSetXY] =  (
	function(iPlayer, iUnit, iX, iY)
		if iX > 0 and iY > 0 then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_EmpowerMissionariesMagic") == true then
				local pUnit = pPlayer:GetUnitByID(iUnit)
				if pUnit then
					local iMissionary = GameInfoTypes.UNITCLASS_MISSIONARY
					local iProphet = GameInfoTypes.UNITCLASS_PROPHET
					local iUnwelcome = GameInfoTypes.PROMOTION_UNWELCOME_EVANGELIST
					local iSight = GameInfoTypes.PROMOTION_SIGHT_PENALTY
					if pUnit:GetUnitClassType() == iMissionary or pUnit:GetUnitClassType() == iProphet then
						pUnit:SetHasPromotion(iUnwelcome, false)
						pUnit:SetHasPromotion(iSight, false)
					end
				end			
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_KYOUKO, "Decisions_EmpowerMissionariesMagic", Decisions_EmpowerMissionariesMagic)



--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Develop Rocky
--Building with the East India Company gets a building which provides 3 of a unique Luxury and +2 Food.
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_DevelopRocky = {}
	Decisions_DevelopRocky.Name = "TXT_KEY_DECISIONS_KYOUKO_DEVELOP_ROCKY"
	Decisions_DevelopRocky.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KYOUKO_DEVELOP_ROCKY_DESC")
	HookDecisionCivilizationIcon(Decisions_DevelopRocky, "CIVILIZATION_KYOUKO")
	Decisions_DevelopRocky.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_KYOUKO) then
			return false, false
		end

		if load(pPlayer, "Decisions_DevelopRocky") == true then
			Decisions_DevelopRocky.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KYOUKO_DEVELOP_ROCKY_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(400 * iMod)
		Decisions_DevelopRocky.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KYOUKO_DEVELOP_ROCKY_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_NATIONAL_TREASURY) then
				Decisions_DevelopRocky.Data1 = pCity
				return true, true
			end
		end
		
		return true, false
		
	end
	)
	
	Decisions_DevelopRocky.DoFunc = (
	function(pPlayer, pCity)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pCity:SetNumRealBuilding(iBuilding, 1)
		save(pPlayer, "Decisions_DevelopRocky", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_KYOUKO, "Decisions_DevelopRocky", Decisions_DevelopRocky)

