-- StatesmanDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:02:02 PM
--------------------------------------------------------------

local iPromotion = GameInfoTypes.PROMOTION_DECISIONS_STATESMAN_MIGHT_FOR_RIGHT
local iDummy1 = GameInfoTypes.BUILDING_DECISION_STATESMAN_MIGHT_FOR_RIGHT
local iDummy2 = GameInfoTypes.BUILDING_DECISION_STATESMAN_PPD_AWAKENED

local tUnitTypes = {
	[GameInfoTypes.ERA_RENAISSANCE] = GameInfoTypes.UNIT_MUSKETMAN,
	[GameInfoTypes.ERA_INDUSTRIAL] = GameInfoTypes.UNIT_RIFLEMAN,
	[GameInfoTypes.ERA_MODERN] = GameInfoTypes.UNIT_GREAT_WAR_INFANTRY,
	[GameInfoTypes.ERA_POSTMODERN] = GameInfoTypes.UNIT_INFANTRY,
	[GameInfoTypes.ERA_FUTURE] = GameInfoTypes.UNIT_LONGBOW_RIFLEMAN
}

function UpdateMFRUnhappiness(i)
	local pPlayer = Players[i]
	if pPlayer:IsAlive() then
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iNumBuildings = 0
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(iPromotion) then
					iNumBuildings = iNumBuildings + 1
				end
			end
			pCapital:SetNumRealBuilding(iDummy1, iNumBuildings)
		end
	end
end


local Decisions_MightForRight = {}
	Decisions_MightForRight.Name = "TXT_KEY_DECISIONS_STATESMAN_MIGHT_FOR_RIGHT"
	Decisions_MightForRight.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_STATESMAN_MIGHT_FOR_RIGHT_DESC")
	HookDecisionCivilizationIcon(Decisions_MightForRight, "CIVILIZATION_PARAGON")
	Decisions_MightForRight.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_PARAGON) then
			return false, false
		end
		if not pPlayer:GetCapitalCity() then
			return false, false
		end
		if load(pPlayer, "Decisions_MightForRight") == true then
			Decisions_MightForRight.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_STATESMAN_MIGHT_FOR_RIGHT_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(700 * iMod)

		Decisions_MightForRight.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_STATESMAN_MIGHT_FOR_RIGHT_DESC", iCost)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		if pPlayer:GetJONSCulture() < iCost then return true, false end

		local iEra = pPlayer:GetCurrentEra()
		if iEra < GameInfoTypes.ERA_RENAISSANCE then
			return true, false
		end

		return true, true
	end
	)
	
	Decisions_MightForRight.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(700 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		save(pPlayer, "Decisions_MightForRight", true)
	end
	)

	Decisions_MightForRight.Monitors = {}
	Decisions_MightForRight.Monitors[Events.WarStateChanged] =  (
	function(iTeam1, iTeam2, bWar)
		if bWar then
			for i = 0, GameDefines.MAX_MAJOR_CIVS -1, 1 do
				local pLoop = Players[i]
				if pLoop:IsAlive() and load(pLoop, "Decisions_MightForRight") == true then
					if pLoop:GetTeam() == iTeam1 or pLoop:GetTeam() == iTeam2 then
						local iNumCities = pLoop:GetNumCities()
						local iNumDraftees = 1 + math.floor(iNumCities / 5)
						local tTable = InitUnitFromCity(pLoop:GetCapitalCity(), tUnitTypes[pLoop:GetCurrentEra()], iNumDraftees)
						for k, v in pairs(tTable) do
							v:SetHasPromotion(iPromotion, true)
						end
						UpdateMFRUnhappiness(i)
					end
				end
			end
		end
	end
	)

	Decisions_MightForRight.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			if load(Players[iPlayer], "Decisions_MightForRight") == true then
				UpdateMFRUnhappiness(iPlayer)
			end
		end
	end
	)

	Decisions_MightForRight.Monitors[GameEvents.UnitKilledInCombat] = (
	function(iKiller, iPlayer, iUnitType)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			if load(Players[iPlayer], "Decisions_MightForRight") == true then
				UpdateMFRUnhappiness(iPlayer)
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_PARAGON, "Decisions_MightForRight", Decisions_MightForRight)



local Decisions_PPDAwakened = {}
	Decisions_PPDAwakened.Name = "TXT_KEY_DECISIONS_STATESMAN_PPD_AWAKENED"
	Decisions_PPDAwakened.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_STATESMAN_PPD_AWAKENED_DESC")
	HookDecisionCivilizationIcon(Decisions_PPDAwakened, "CIVILIZATION_PARAGON")
	Decisions_PPDAwakened.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_PARAGON) then
			return false, false
		end

		if load(pPlayer, "Decisions_PPDAwakened") == true then
			Decisions_PPDAwakened.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_STATESMAN_PPD_AWAKENED_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(800 * iMod)

		Decisions_PPDAwakened.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_STATESMAN_PPD_AWAKENED_DESC", iGoldCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local iPoliceStations = 0

		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_POLICE_STATION) then
				iPoliceStations = iPoliceStations + 1
				if iPoliceStations >= 4 then
					return true, true
				end
			end
		end


		return true, false
	end
	)
	
	Decisions_PPDAwakened.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(800 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_POLICE_STATION) then
				pCity:SetNumRealBuilding(iDummy2, 1)
			else
				pCity:SetNumRealBuilding(iDummy2, 0)
			end
		end
		save(pPlayer, "Decisions_PPDAwakened", true)
	end
	)

	Decisions_PPDAwakened.Monitors = {}
	Decisions_MightForRight.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			if load(Players[iPlayer], "Decisions_PPDAwakened") == true then
				for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(GameInfoTypes.BUILDING_POLICE_STATION) then
						pCity:SetNumRealBuilding(iDummy2, 1)
					else
						pCity:SetNumRealBuilding(iDummy2, 0)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_PARAGON, "Decisions_PPDAwakened", Decisions_PPDAwakened)

