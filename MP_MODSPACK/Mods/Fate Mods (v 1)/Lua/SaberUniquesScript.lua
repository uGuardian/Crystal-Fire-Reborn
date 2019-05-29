-- SaberUniquesScript
-- Author: Vicevirtuoso
-- DateCreated: 3/22/2014 5:22:32 PM
--------------------------------------------------------------

--Cache the type of the UU, UB, dummy UB, and the tech requirements/strength upgrades for KOTRs. Makes things faster.
local iCourtType = GameInfoTypes.BUILDING_ARTHURIAN_COURT
local iSpecialistType = GameInfoTypes.SPECIALIST_GREAT_GENERAL_SABERMOD
local iKOTRType = GameInfoTypes.UNIT_KOTR_FSN

local iLWarfare = GameInfoTypes.POLICY_LIGHTNING_WARFARE
local iLWarfarePromo = GameInfoTypes.PROMOTION_FAST_GENERAL

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS

local tKOTRTable = {
	[GameInfoTypes.TECH_CHIVALRY] = 22,
	[GameInfoTypes.TECH_METALLURGY] = 28,
	[GameInfoTypes.TECH_MILITARY_SCIENCE] = 37,
	[GameInfoTypes.TECH_COMBUSTION] = 66,
	[GameInfoTypes.TECH_COMBINED_ARMS] = 77,
	[GameInfoTypes.TECH_LASERS] = 110
	}

--When a Knight of the Round Table is killed, put its owner in anarchy for a number of turns based on game speed (2 at Standard).
function OnKOTRKillAnarchy(iKiller, iKilled, iUnitType)
	if iUnitType == iKOTRType and iKilled ~= 63 then
		local pKilled = Players[iKilled]
		if not pKilled:IsMinorCiv() then
			local iResearchLevel = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ResearchPercent / 100
			local iAnarchyTurns = math.floor(iResearchLevel * 3)
			pKilled:ChangeAnarchyNumTurns(iAnarchyTurns)
			if iKilled == Game:GetActivePlayer() then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_SABER_KOTR_DIED", iAnarchyTurns))
			end
		end
	end
end

GameEvents.UnitKilledInCombat.Add(OnKOTRKillAnarchy)

--Increase KOTR strength function. Since doing the Madoka-style function will burn through GP names and the KOTR won't be as ubiquitous
--as Magical Girls, we will just be using SetBaseCombatStrength() for now.
function OnMoveKOTRStrengthUpkeep(iPlayer, iUnitID, iX, iY)
	if iPlayer < iMaxCivs and iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit then
			if pUnit:GetUnitType() == iKOTRType and pUnit:GetPlot():GetOwner() == iPlayer then
				local pTeam = Teams[pPlayer:GetTeam()]
				for iTech, iStrength in pairs(tKOTRTable) do
					if pTeam:IsHasTech(iTech) and iStrength > pUnit:GetBaseCombatStrength() then
						pUnit:SetBaseCombatStrength(iStrength)
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(OnMoveKOTRStrengthUpkeep)

function OnTurnKOTRStrengthUpkeep(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iKOTRType then
				local pTeam = Teams[pPlayer:GetTeam()]
				for iTech, iStrength in pairs(tKOTRTable) do
					if pTeam:IsHasTech(iTech) and iStrength > pUnit:GetBaseCombatStrength() then
						pUnit:SetBaseCombatStrength(iStrength)
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(OnTurnKOTRStrengthUpkeep)

--For every two Arthurian Courts in an Empire, put a copy of the dummy building which grants Great General progress in the Capital.
function GeneralProgressInCapitalFromCourts(iPlayer)
	if iPlayer < iMaxCivs then 
		local pPlayer = Players[iPlayer]
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iTotalBuildings = 0;
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(iCourtType) then
					iTotalBuildings = iTotalBuildings + 1
				end
			end
			iTotalBuildings = math.floor(iTotalBuildings / 2) * 100
		
			pCapital:ChangeSpecialistGreatPersonProgressTimes100(iSpecialistType, iTotalBuildings)
		end
	end
end

GameEvents.PlayerDoTurn.Add(GeneralProgressInCapitalFromCourts)


function OnAdoptLightningWarfare(iPlayer, iPolicyID)
	if iPolicyID == iLWarfare then
		local pPlayer = Players[iPlayer]
		for unit in pPlayer:Units() do
			if unit:GetUnitType() == iKOTRType then
				unit:SetHasPromotion(iLWarfarePromo, true)
			end
		end
	end
end

GameEvents.PlayerAdoptPolicy.Add(OnAdoptLightningWarfare)

function OnMoveLightningWarfare(iPlayer, iUnitID, iX, iY)
	if iPlayer < iMaxCivs and iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		if pPlayer:HasPolicy(iLWarfare) then
			local pUnit = pPlayer:GetUnitByID(iUnitID)
			if pUnit then
				if pUnit:GetUnitType() == iKOTRType and not pUnit:IsHasPromotion(iLWarfarePromo) then
					pUnit:SetHasPromotion(iLWarfarePromo, true)
					pUnit:SetMoves(pUnit:MaxMoves())
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(OnMoveLightningWarfare)