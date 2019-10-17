-- PMMMKaoruUmikaDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/27/2014 12:19:45 AM
--------------------------------------------------------------

--Precache all buildings that have Great Works of Art to make things go significantly faster
local tGreatArtBuildings = {};
for pBuilding in GameInfo.Buildings() do
	if pBuilding.GreatWorkSlotType == "GREAT_WORK_SLOT_LITERATURE" and pBuilding.GreatWorkCount > 0 then
		local pBuildingClass = GameInfo.BuildingClasses("Type = '" ..pBuilding.BuildingClass.. "'")()
		--Save BuildingClasses instead of BuildingTypes since GetBuildingGreatWork() calls for Classes
		tGreatArtBuildings[pBuildingClass.ID] = pBuildingClass.Type
	end
end



--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Fund Asunaro United F.C.
--Stadiums get +1C/+1G and +20% Tourism to the City.
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_AsunaroUFC = {}
	Decisions_AsunaroUFC.Name = "TXT_KEY_DECISIONS_KAORU_UMIKA_SOCCER"
	Decisions_AsunaroUFC.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KAORU_UMIKA_SOCCER_DESC")
	HookDecisionCivilizationIcon(Decisions_AsunaroUFC, "CIVILIZATION_KAORU_UMIKA")
	Decisions_AsunaroUFC.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_KAORU_UMIKA) then
			return false, false
		end
		if load(pPlayer, "Decisions_AsunaroUFC") == true then
			Decisions_AsunaroUFC.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KAORU_UMIKA_SOCCER_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(800 * iMod)
		Decisions_AsunaroUFC.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KAORU_UMIKA_SOCCER_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local iNumStadiums = 0
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_STADIUM) then
				iNumStadiums = iNumStadiums + 1
				if iNumStadiums >= 4 then
					break
				end
			end
		end

		if iNumStadiums < 4 then return true, false end

		local iNumCivsLeft = 0
		local iNumFamiliarCivs = 0
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoopPlayer = Players[i]
			if pLoopPlayer:IsAlive() then
				iNumCivsLeft = iNumCivsLeft + 1
			end
			if pPlayer:GetInfluenceLevel(i) >= InfluenceLevelTypes.INFLUENCE_LEVEL_FAMILIAR then
				iNumFamiliarCivs = iNumFamiliarCivs + 1
			end
		end

		if math.floor(iNumCivsLeft / 2) <= iNumFamiliarCivs then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_AsunaroUFC.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(800 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_KAORU_UMIKA_SOCCER, true)
		save(pPlayer, "Decisions_AsunaroUFC", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_KAORU_UMIKA, "Decisions_AsunaroUFC", Decisions_AsunaroUFC)



--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Publish a Novel
--+50 Tourism to all known Civs and lump of Gold scaling with number of Great Works of Writing
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_PublishAsunaroBook = {}
	Decisions_PublishAsunaroBook.Name = "TXT_KEY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS"
	Decisions_PublishAsunaroBook.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS_DESC")
	HookDecisionCivilizationIcon(Decisions_PublishAsunaroBook, "CIVILIZATION_KAORU_UMIKA")
	Decisions_PublishAsunaroBook.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_KAORU_UMIKA) then
			return false, false
		end

		local iReward = 0

		for pCity in pPlayer:Cities() do
			for k, v in pairs(tGreatArtBuildings) do
				iReward = iReward + pCity:GetNumGreatWorksInBuilding(k)
			end
		end

		iReward = iReward * 350

		local iEra = load(pPlayer, "Decisions_PublishAsunaroBook")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_PublishAsunaroBook", nil)
			else
				Decisions_PublishAsunaroBook.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS_ENACTED_DESC", iReward)
				return false, false, true
			end
		end

		local iGoldCost = math.ceil((100 * iCurrentEra + 200) * iMod)
		local iCulture = math.ceil((50 * iCurrentEra + 150) * iMod)
		Decisions_PublishAsunaroBook.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS_DESC", iGoldCost, iCulture, iReward)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if pPlayer:GetJONSCulture() < iCulture then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_PRINTING_PRESS) then 
			return true, true
		else
			return true, false
		end

	end
	)
	
	Decisions_PublishAsunaroBook.DoFunc = (
	function(pPlayer)
		local iCurrentEra = pPlayer:GetCurrentEra()
		local iReward = 0
		for pCity in pPlayer:Cities() do
			for k, v in pairs(tGreatArtBuildings) do
				iReward = iReward + pCity:GetNumGreatWorksInBuilding(k)
			end
		end
		iReward = iReward * 250
		local iGoldCost = math.ceil((100 * iCurrentEra + 200) * iMod)
		local iCulture = math.ceil((50 * iCurrentEra + 150) * iMod)
		pPlayer:ChangeGold(iReward - iGoldCost)
		pPlayer:ChangeJONSCulture(-iCulture)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS, true)
		local pDummy = pPlayer:InitUnit(GameInfoTypes.UNIT_PMMM_ARTIFICIAL_INCUBATOR, pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY())
		pDummy:Kill(true)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS, false)
		save(pPlayer, "Decisions_PublishAsunaroBook", iCurrentEra)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_KAORU_UMIKA, "Decisions_PublishAsunaroBook", Decisions_PublishAsunaroBook)

