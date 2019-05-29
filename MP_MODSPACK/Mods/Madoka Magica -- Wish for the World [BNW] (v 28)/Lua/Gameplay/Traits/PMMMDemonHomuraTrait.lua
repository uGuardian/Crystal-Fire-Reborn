-- PMMMDemonHomuraTrait
-- Author: Vicevirtuoso
-- DateCreated: 7/2/2014 12:57:46 PM
--------------------------------------------------------------




local iImmunePromo = GameInfoTypes.PROMOTION_IMMUNE_TO_DEMON_HOMURA_TRAIT --earned by a MG getting to level 5 or higher

local iDummy = GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY

local iMagicalGirlType = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL
local iMagicalGirlClassType = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL

local iMoodPolicyID = GameInfo.MG_MoodModifiers["MGMOODMOD_POLICIES"].ID
local iMoodBeliefsID = GameInfo.MG_MoodModifiers["MGMOODMOD_BELIEFS"].ID
local iMoodBuildingsID = GameInfo.MG_MoodModifiers["MGMOODMOD_BUILDINGS"].ID

local iMoodModMultiplierBase = 0.1   --will be pushed out to Defines or Traits later

function SetNumDemonHomuraBuildings(iPlayer)
	local pPlayer = Players[iPlayer]
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then
		if not PMMM.Subjugations[iPlayer] then PMMM.Subjugations[iPlayer] = 0 end
		local iSubjugations = math.floor(PMMM.Subjugations[iPlayer])
		local tBuildingTable = toBits(iSubjugations)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_1, tBuildingTable[1] or 0)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_2, tBuildingTable[2] or 0)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_4, tBuildingTable[3] or 0)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_8, tBuildingTable[4] or 0)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_16, tBuildingTable[5] or 0)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_32, tBuildingTable[6] or 0)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_64, tBuildingTable[7] or 0)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_128, tBuildingTable[8] or 0)
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_DEMON_HOMURA_DUMMY_256, tBuildingTable[9] or 0)
	end
end


--Called by other functions, do not use directly with GameEvents
function OnDemonHomuraKillMG(iPlayer, iX, iY, iMGKey)
	if not PMMM.Subjugations[iPlayer] then
		PMMM.Subjugations[iPlayer] = 1
	else
		PMMM.Subjugations[iPlayer] = PMMM.Subjugations[iPlayer] + 1
	end
	SetNumDemonHomuraBuildings(iPlayer)
	if iX > 0 and iY > 0 then
		Players[iPlayer]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_DHOMURA_MGKILL_TEXT"), Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_DHOMURA_MGKILL_TITLE"), iX, iY)
	end
end


function DemonHomuraDirectKill(iAttackingPlayer, iAttackingUnit, attackerDamage, attackerFinalDamage, attackerMaxHP, iDefendingPlayer, iDefendingUnit, defenderDamage, defenderFinalDamage, defenderMaxHP, iInterceptingPlayer, iInterceptingUnit, interceptorDamage, plotX, plotY)
	local pEnemyUnit;
	local pPlayer;
	local pEnemyPlayer;

	--Determines which player's unit died, if any, and bases the rest of the code off of that. In case that two DHomura players are attacking each other.
	if MapModData.gPMMMTraits[iAttackingPlayer] and MapModData.gPMMMTraits[iAttackingPlayer].CapitalBonusPerKilledMagicalGirl > 0 then
		pEnemyPlayer = Players[iDefendingPlayer]
		if pEnemyPlayer then
			pEnemyUnit = pEnemyPlayer:GetUnitByID(iDefendingUnit)
			if pEnemyUnit and pEnemyUnit:GetCurrHitPoints() == 0 then
				pPlayer = Players[iAttackingPlayer]
			else
				pEnemyUnit = nil
				pEnemyPlayer = nil
			end
		end
	end
	if not pEnemyUnit then
		if MapModData.gPMMMTraits[iDefendingPlayer] and MapModData.gPMMMTraits[iDefendingPlayer].CapitalBonusPerKilledMagicalGirl > 0 then
			pEnemyPlayer = Players[iAttackingPlayer]
			if pEnemyPlayer then
				pEnemyUnit = pEnemyPlayer:GetUnitByID(iAttackingUnit)
				if pEnemyUnit:GetCurrHitPoints() == 0 then
					pPlayer = Players[iDefendingPlayer]
				else
					pEnemyUnit = nil
					pEnemyPlayer = nil
				end
			end
		end
	end
	if pEnemyUnit then
		--If we've gotten this far, we can ascertain that there's a dead unit detected and the killer was a DHomura player.
		if pEnemyUnit:GetUnitType() == iMagicalGirlType then
			local iMGKey = GetMagicalGirlKey(pEnemyUnit:GetOwner(), pEnemyUnit:GetID())
			if not MagicalGirls[iMGKey].IsLeader then
				OnDemonHomuraKillMG(pPlayer:GetID(), plotX, plotY)
			end
		end
	end
end

function DemonHomuraOnTurnFunctions(iPlayer)
	if iPlayer < GameDefines.MAX_CIV_PLAYERS then
		local pPlayer = Players[iPlayer]
		--v21: DH gets a multiplier to the subjugation palace bonuses based on certain global mood mods.
		--Included mood mods are: Beliefs, Policies, Buildings.
		if MapModData.gPMMMTraits[iPlayer] and MapModData.gPMMMTraits[iPlayer].CapitalBonusPerKilledMagicalGirl > 0 then
			SetNumDemonHomuraBuildings(iPlayer)
			--v23: Golden Age Points from Global Mood
			if not pPlayer:IsGoldenAge() then
				pPlayer:ChangeGoldenAgeProgressMeter(GetGoldenAgePointsFromMood(iPlayer))
			end
		end
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iMagicalGirlType and not pUnit:IsHasPromotion(iImmunePromo) then
				local pPlot = pUnit:GetPlot()
				local iOwner = pPlot:GetOwner()
				if iOwner > -1 and iOwner < iMaxCivs then
					if MapModData.gPMMMTraits[iOwner].MagicalGirlAttrition > 0 then
						local pOwner = Players[iOwner]
						local pTeam = Teams[pPlayer:GetTeam()]
						local iOwnerTeam = pOwner:GetTeam()
						if pTeam:IsAtWar(iOwnerTeam) then
							local iCurHP = pUnit:GetCurrHitPoints()
							if iCurHP <= MapModData.gPMMMTraits[iOwner].MagicalGirlAttrition then
								OnDemonHomuraKillMG(iOwner, pUnit:GetX(), pUnit:GetY())
							end
							pUnit:ChangeDamage(MapModData.gPMMMTraits[iOwner].MagicalGirlAttrition, iOwner)
						end
					end
				end
			end
		end
	end
end

function GetGoldenAgePointsFromMood(iPlayer)
	local iPoints = 0 
	local pPlayer = Players[iPlayer]
	iPoints = iPoints + t_MoodMods[iMoodBuildingsID].Func(_, pPlayer, _)
	iPoints = iPoints + t_MoodMods[iMoodBeliefsID].Func(_, pPlayer, _)
	iPoints = iPoints + t_MoodMods[iMoodPolicyID].Func(_, pPlayer, _)
	return math.floor(iPoints * iMoodModMultiplierBase)
end

function OnPromotedToLevel5(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitType() == iMagicalGirlType and pUnit:GetLevel() >= 5 then
		pUnit:SetHasPromotion(iImmunePromo, true)
	else
		pUnit:SetHasPromotion(iImmunePromo, false)
	end
end



function DHCityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "PMMM_DemonHomura", ["SortOrder"] = 1})
end

function DHCityInfoStackDirty(sKey, pInstance)
	if sKey ~= "PMMM_DemonHomura" then return end
	local iPlayer = Game:GetActivePlayer()
	if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == true or MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == 1) then
		local pPlayer = Players[iPlayer]
		local pCity = UI.GetHeadSelectedCity()
		if pCity and pCity:IsCapital() and pCity:GetOwner() == iPlayer then
			if not PMMM.Subjugations[iPlayer] then PMMM.Subjugations[iPlayer] = 0 end
			local iSubj = PMMM.Subjugations[iPlayer]
			local iSubjRound = math.floor(PMMM.Subjugations[iPlayer])
			local iGAPoints = GetGoldenAgePointsFromMood(iPlayer)
			IconHookup(0, 64, "CIV_COLOR_ATLAS_DEMON_HOMURA", pInstance.IconImage)
			pInstance.IconImage:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_CITYVIEW_DEMON_HOMURA_TOOLTIP", iSubj, iGAPoints))
		else
			pInstance.IconFrame:SetHide(true)
			return
		end
	else
		pInstance.IconFrame:SetHide(true)
		return
	end
end