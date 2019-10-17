-- PMMMSayakaDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/24/2014 10:55:50 PM
--------------------------------------------------------------

local iPromotion = GameInfoTypes.PROMOTION_DECISIONS_SAYAKA
local iDummy = GameInfoTypes.BUILDING_DECISION_SAYAKA_DUMMY

local iOverOneThirdCivs = 0

local tTeams = {}

for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		iOverOneThirdCivs = iOverOneThirdCivs + 1
		table.insert(tTeams, i)
	end
end

iOverOneThirdCivs = math.ceil(iOverOneThirdCivs / 3)

function IsDenunciationThreshold(pPlayer)
	local iDenouncements = 0
	for iLoopPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pLoopPlayer = Players[iLoopPlayer]
		if iLoopPlayer ~= iPlayer then
			if pLoopPlayer:IsDenouncedPlayer(pPlayer:GetID()) then
				iDenouncements = iDenouncements + 1
				if iDenouncements >= iOverOneThirdCivs then
					return true
				end
			end
		end
	end
	return false
end

function CheckAllyOfJustice(pPlayer)
	if load(pPlayer, "Decisions_AllyOfJustice") == true then
		if IsDenunciationThreshold(pPlayer) then
			save(pPlayer, "Decisions_AllyOfJustice", false)
			pPlayer:SetNumAnarchyTurns(math.ceil(iGAMod * 3))
			return
		end
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoopPlayer = Players[i]
			if Teams[pPlayer:GetTeam()]:IsAtWar(pLoopPlayer:GetTeam()) then
				if IsDenunciationThreshold(pLoopPlayer) then
					for pUnit in pPlayer:Units() do
						if pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MELEE or pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_GUN then
							pUnit:SetHasPromotion(iPromotion, true)
						end
					end
					return
				end
			end
		end
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MELEE or pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_GUN then
				pUnit:SetHasPromotion(iPromotion, false)
			end
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Hold the Oktavian Dance Queen Competition
--Effect of Hotel + Airport for 6 turns, plus 6 turns of WLTKD.
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_OktaviaDanceQueen = {}
	Decisions_OktaviaDanceQueen.Name = "TXT_KEY_DECISIONS_SAYAKA_DANCE_QUEEN"
	Decisions_OktaviaDanceQueen.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SAYAKA_DANCE_QUEEN_DESC")
	HookDecisionCivilizationIcon(Decisions_OktaviaDanceQueen, "CIVILIZATION_SAYAKA")
	Decisions_OktaviaDanceQueen.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_SAYAKA) then
			return false, false
		end
		local iTurns = math.ceil(iGAMod * 6)
		local iEra = load(pPlayer, "Decisions_OktaviaDanceQueen")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_OktaviaDanceQueen", nil)
			else
				Decisions_OktaviaDanceQueen.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SAYAKA_DANCE_QUEEN_ENACTED_DESC", iTurns)
				return false, false, true
			end
		end
		
		local iCost = math.ceil(400 * iMod)

		Decisions_OktaviaDanceQueen.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SAYAKA_DANCE_QUEEN_DESC", iCost, iTurns)
		
		if pPlayer:GetGold() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_ACOUSTICS) then
			return true, true
		else
			return true, false
		end

	end
	)
	
	Decisions_OktaviaDanceQueen.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(400 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		local iTurns = math.ceil(iGAMod * 6)
		pPlayer:GetCapitalCity():ChangeWeLoveTheKingDayCounter(iTurns)

		pPlayer:GetCapitalCity():SetNumRealBuilding(iDummy, 1)
		
		save(pPlayer, "Decisions_OktaviaDanceQueen", Game:GetGameTurn())
	end
	)

	Decisions_OktaviaDanceQueen.Monitors = {}
	Decisions_OktaviaDanceQueen.Monitors[GameEvents.PlayerDoTurn] =  (
	function (iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_OktaviaDanceQueen") then
				local iCurTurn = Game:GetGameTurn()
				local iTurnDifference = iCurTurn - load(pPlayer, "Decisions_OktaviaDanceQueen")
				local iTurns = math.ceil(iGAMod * 6)
				if iTurnDifference % iTurns == 0 then
					pPlayer:GetCapitalCity():SetNumRealBuilding(iDummy, 0)
				end
			end
			if load(pPlayer, "Decisions_AllyOfJustice") == true then
				for pCity in pPlayer:Cities() do
					if pCity:IsCapital() or pPlayer:IsCapitalConnectedToCity(pCity) then
						pCity:SetNumRealBuilding(iDummy, 1)
					else
						pCity:SetNumRealBuilding(iDummy, 0)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_SAYAKA, "Decisions_OktaviaDanceQueen", Decisions_OktaviaDanceQueen)



--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Declare Yourself the True Ally of Justice
--Special promotion when at war with a Civ that's denounced by over 1/3 of the world's Civs
--Cannot be enacted and gets repealed if YOU get denounced by over 1/3 of the world's Civs
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_AllyOfJustice = {}
	Decisions_AllyOfJustice.Name = "TXT_KEY_DECISIONS_SAYAKA_ALLY_OF_JUSTICE"
	Decisions_AllyOfJustice.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SAYAKA_ALLY_OF_JUSTICE_DESC")
	HookDecisionCivilizationIcon(Decisions_AllyOfJustice, "CIVILIZATION_SAYAKA")
	Decisions_AllyOfJustice.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_SAYAKA) then
			return false, false
		end
		if load(pPlayer, "Decisions_AllyOfJustice") == true then
			Decisions_AllyOfJustice.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SAYAKA_ALLY_OF_JUSTICE_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(600 * iMod)
		Decisions_AllyOfJustice.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SAYAKA_ALLY_OF_JUSTICE_DESC", iCost)
		
		if pPlayer:GetJONSCulture() < iCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if not pTeamTechs:HasTech(GameInfoTypes.TECH_CIVIL_SERVICE) then return true, false end
		
		if IsDenunciationThreshold(pPlayer) then
			return true, false
		else
			return true, true
		end
	end
	)
	
	Decisions_AllyOfJustice.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(600 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		save(pPlayer, "Decisions_AllyOfJustice", true)
		CheckAllyOfJustice(pPlayer)
	end
	)

	Decisions_AllyOfJustice.Monitors = {}
	Decisions_AllyOfJustice.Monitors[GameEvents.PlayerDoTurn] =  (
	function (iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			CheckAllyOfJustice(Players[iPlayer])
		end
	end
	)

	Decisions_AllyOfJustice.Monitors[Events.WarStateChanged] =  (
	function(iTeam1, iTeam2, bWar)
		for i = 0, GameDefines.MAX_MAJOR_CIVS -1 , 1 do
			CheckAllyOfJustice(Players[iPlayer])
		end
	end
	)


Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_SAYAKA, "Decisions_AllyOfJustice", Decisions_AllyOfJustice)

