----------------------------------------------------------------------------------------------------------------------------
-- Core Mood Functions
-- Author: Vicevirtuoso
-- DateCreated: 12/19/2014 2:48:01 AM
----------------------------------------------------------------------------------------------------------------------------


t_MoodMods = {}


local iGameSpeedMod = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ResearchPercent / 100
local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL
local iWitchClass = GameInfoTypes.UNITCLASS_PMMM_WITCH
local iSeaWitchClass = GameInfoTypes.UNITCLASS_PMMM_SEA_WITCH


--Function to refresh an MG's mood. Will be called on PlayerDoTurn and Events.UnitSelectionChanged.
function RefreshMGMood(iMGKey, pPlayer, pUnit, bGetText, bAccumulators)
	local iTotalMood = 0
	local tMoodInfos = {}
	for iMod, pMod in pairs(t_MoodMods) do
		local iNewEntry = #tMoodInfos + 1
		tMoodInfos[iNewEntry] = {}
		if bAccumulators and pMod.Accumulator then
			--Accumulators maintain the duration of Mood modifiers.
			pMod.Accumulator(iMGKey, pPlayer, pUnit)
		end
		tMoodInfos[iNewEntry].Value = pMod.Func(iMGKey, pPlayer, pUnit)
		--default to 0 if no value was returned
		if not tMoodInfos[iNewEntry].Value then tMoodInfos[iNewEntry].Value = 0 end
		local iMaxBoost = 1
		--Mood boosts from traits
		if MapModData.gPMMMTraitMoodBoosts[pPlayer:GetID()] then
			for k, v in pairs(MapModData.gPMMMTraitMoodBoosts[pPlayer:GetID()]) do
				if v.Type == iMod then
					if tMoodInfos[iNewEntry].Value then
						tMoodInfos[iNewEntry].Value = math.floor(tMoodInfos[iNewEntry].Value * (1 + (v.Value / 100)))
					else
						tMoodInfos[iNewEntry].Value = 0
					end
					iMaxBoost = math.floor(iMaxBoost * (1 + (v.Value / 100)))
				end
			end
		end
		--clamp to MaxValue if the pMod.Func didn't already do it
		if pMod.Max and tonumber(pMod.Max) and math.abs(tMoodInfos[iNewEntry].Value) > pMod.Max then
			if tMoodInfos[iNewEntry].Value > 0 then
				tMoodInfos[iNewEntry].Value = pMod.Max * iMaxBoost
			else
				tMoodInfos[iNewEntry].Value = -(pMod.Max * iMaxBoost)
			end
		end
		iTotalMood = iTotalMood + tMoodInfos[iNewEntry].Value
		if bGetText then
			if tMoodInfos[iNewEntry].Value > 0 then
				tMoodInfos[iNewEntry].Desc = "[COLOR_POSITIVE_TEXT]"..Locale.ConvertTextKey(pMod.Desc, "+"..tostring(tMoodInfos[iNewEntry].Value)).."[ENDCOLOR]"
				if pMod.PosTT then
					tMoodInfos[iNewEntry].Tooltip = "[COLOR_POSITIVE_TEXT]"..Locale.ConvertTextKey(pMod.PosTT).."[ENDCOLOR]"
				end
			elseif tMoodInfos[iNewEntry].Value == 0 then
				tMoodInfos[iNewEntry].Desc = nil
				tMoodInfos[iNewEntry].Tooltip = nil
			else
				tMoodInfos[iNewEntry].Desc = "[COLOR_WARNING_TEXT]"..Locale.ConvertTextKey(pMod.Desc, tostring(tMoodInfos[iNewEntry].Value)).."[ENDCOLOR]"
				if pMod.NegTT then
					tMoodInfos[iNewEntry].Tooltip = "[COLOR_WARNING_TEXT]"..Locale.ConvertTextKey(pMod.NegTT).."[ENDCOLOR]"
				end
			end
		end
	end
	--clamp to min or max mood value
	if iTotalMood < GameDefines.MG_MOOD_MINIMUM then
		iTotalMood = GameDefines.MG_MOOD_MINIMUM
	elseif iTotalMood > GameDefines.MG_MOOD_MAXIMUM then
		iTotalMood = GameDefines.MG_MOOD_MAXIMUM
	end

	MagicalGirls[iMGKey].Mood = iTotalMood
	MagicalGirls[iMGKey].MoodMods = tMoodInfos

	for row in GameInfo.MG_Moods() do
		if iTotalMood >= row.MinValue and iTotalMood <= row.MaxValue then
			MagicalGirls[iMGKey].MoodLevel = row.ID
			if row.Promotion then
				pUnit:SetHasPromotion(GameInfo.UnitPromotions[row.Promotion].ID, true)
			end
		else
			if row.Promotion then
				pUnit:SetHasPromotion(GameInfo.UnitPromotions[row.Promotion].ID, false)
			end
		end
	end
end

function OnUnitSelectionChangedUpdateMood()
	local pUnit = UI.GetHeadSelectedUnit()
	if pUnit and pUnit:GetUnitClassType() == iMagicalGirlClass then
		local iPlayer = Game:GetActivePlayer()
		local pPlayer = Players[iPlayer]
		local iUnit = pUnit:GetID()
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if iMGKey then
			RefreshMGMood(iMGKey, pPlayer, pUnit, true)
		end
	end
end

function OnUnitInfoDirtyUpdateMood()
	local pUnit = UI.GetHeadSelectedUnit()
	local iActivePlayer = Game:GetActivePlayer()
	local pPlayer = Players[iActivePlayer]
	if pUnit and pUnit:GetUnitClassType() == iMagicalGirlClass and Players[iActivePlayer]:IsTurnActive() then
		local iUnit = pUnit:GetID()
		local iMGKey = GetMagicalGirlKey(iActivePlayer, iUnit)
		if iMGKey then
			RefreshMGMood(iMGKey, pPlayer, pUnit, true)
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- EMPIRE HAPPINESS
----------------------------------------------------------------------------------------------------------------------------

local row = GameInfo.MG_MoodModifiers["MGMOODMOD_EMPIRE_HAPPINESS"]
local iEmpireHappinessID = row.ID
t_MoodMods[iEmpireHappinessID] = {}
t_MoodMods[iEmpireHappinessID].Value = row.Value
t_MoodMods[iEmpireHappinessID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iHappiness = pPlayer:GetExcessHappiness()
		return t_MoodMods[iEmpireHappinessID].Value * iHappiness
	end
)
t_MoodMods[iEmpireHappinessID].Desc = row.Description
t_MoodMods[iEmpireHappinessID].PosTT = row.PositiveTooltip
t_MoodMods[iEmpireHappinessID].NegTT = row.NegativeTooltip
t_MoodMods[iEmpireHappinessID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- GOLDEN AGE
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_GOLDEN_AGE"]
local iGoldenAgeID = row.ID
t_MoodMods[iGoldenAgeID] = {}
t_MoodMods[iGoldenAgeID].Value = row.Value
t_MoodMods[iGoldenAgeID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local bGoldenAge = pPlayer:IsGoldenAge()
		local iVal;
		if bGoldenAge then iVal = t_MoodMods[iGoldenAgeID].Value else iVal = 0 end
		return iVal;
	end
)
t_MoodMods[iGoldenAgeID].Desc = row.Description
t_MoodMods[iGoldenAgeID].PosTT = row.PositiveTooltip
t_MoodMods[iGoldenAgeID].NegTT = row.NegativeTooltip
t_MoodMods[iGoldenAgeID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- VACATION
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_VACATION"]
local iVacationID = row.ID
t_MoodMods[iVacationID] = {}
t_MoodMods[iVacationID].Value = row.Value
t_MoodMods[iVacationID].Func = (
	function(iMGKey, pPlayer, pUnit)
		if not MagicalGirls[iMGKey].VacationBonus then MagicalGirls[iMGKey].VacationBonus = 0 end
		return MagicalGirls[iMGKey].VacationBonus * t_MoodMods[iVacationID].Value
	end
)
t_MoodMods[iVacationID].Accumulator = (
	function(iMGKey, pPlayer, pUnit)
		if MagicalGirls[iMGKey].LastVacationTurn then
			local iTurn = Game:GetGameTurn()
			if iTurn - MagicalGirls[iMGKey].LastVacationTurn >= t_MoodMods[iVacationID].Turns then
				MagicalGirls[iMGKey].VacationBonus = 0
			end
		end
	end
)
t_MoodMods[iVacationID].Desc = row.Description
t_MoodMods[iVacationID].PosTT = row.PositiveTooltip
t_MoodMods[iVacationID].NegTT = row.NegativeTooltip
t_MoodMods[iVacationID].Max = row.MaxValue
t_MoodMods[iVacationID].Turns = math.floor(iGameSpeedMod * row.Turns)

local iVacationMission = GameInfoTypes.MISSION_PMMM_VACATION

function VacationCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass and iMission == iVacationMission then
		if not pUnit:IsEmbarked() then
			local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
			if not MagicalGirls[iMGKey].IsLeader then
				if not MagicalGirls[iMGKey].VacationBonus then MagicalGirls[iMGKey].VacationBonus = 0 end
				if pUnit:GetPlot():GetOwner() == iPlayer and MagicalGirls[iMGKey].VacationBonus <= 0 then
					return true
				else
					return bTestVisible
				end
			end
		end
	end
	return false
end

function VacationCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iVacationMission then	
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		DoMagicalGirlDisappearFromMapAction(iMGKey, iPlayer, iUnit, GameInfoTypes.MGACTIONSTATE_VACATIONING)
	end
	return 0
end

function VacationCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iVacationMission then
		return true
	end
	return false
end


--Done every turn for any MG in Vacation
function DoVacationTurn(iMGKey)
	if not MagicalGirls[iMGKey].VacationTurnTable then MagicalGirls[iMGKey].VacationTurnTable = {} end
	local pVacationCiv = Players[MagicalGirls[iMGKey].CurrentVacationLocation]
	MagicalGirls[iMGKey].VacationTurnTable[#MagicalGirls[iMGKey].VacationTurnTable + 1] = GetEmpireEntertainment(pVacationCiv)

	--Later, she will build Relationships with other MGs vacationing, but that will actually require the Relationships system to be implemented.
end

function OnPlayerDoTurnVacationTurn(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		for k, v in pairs(MagicalGirls) do
			if v.Owner == iPlayer and v.Status == GameInfoTypes.MGACTIONSTATE_VACATIONING then
				DoVacationTurn(k)
			end
		end
		--AI Logic will be here
		--Pop it ASAP if getting a penalty (unless we're at war with a major)
		if not pPlayer:IsHuman() then
			local pTeam = Teams[pPlayer:GetTeam()]
			for i = 0, iMaxCivs - 1, 1 do
				if i ~= iPlayer then
					local pLoop = Players[i]
					if pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
						return
					end
				end
			end
			local iNoVacationID = GameInfo.MG_MoodModifiers["MGMOODMOD_NO_VACATION"].ID
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitClassType() == iMagicalGirlClass and pUnit:GetPlot():GetOwner() == iPlayer then
					local iMGKey = GetMagicalGirlKey(iPlayer, pUnit:GetID())
					if iMGKey then
						local iMod = t_MoodMods[iNoVacationID].Func(iMGKey, pPlayer, pUnit)
						if iMod < 0 then
							pUnit:PopMission()
							pUnit:PushMission(iVacationMission, pUnit:GetX(), pUnit:GetY())
						end
					end
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------------------------------------------
-- LIKES & DISLIKES
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_LIKES_DISLIKES"]
local iLikesDislikesID = row.ID
t_MoodMods[iLikesDislikesID] = {}
t_MoodMods[iLikesDislikesID].Value = row.Value
t_MoodMods[iLikesDislikesID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		local iPlayer = pPlayer:GetID()
		if not MagicalGirls[iMGKey].LikesDislikes then MagicalGirls[iMGKey].LikesDislikes = {} end
		if not pPlayer:IsMinorCiv() then
			for k, v in pairs(MagicalGirls[iMGKey].LikesDislikes) do
				local iThisVal;
				iThisVal, v.Text, v.Tooltip = t_LikesDislikes[v.Category].FulfilledFunc(iPlayer, iMGKey, v.Type, v.Value)
				iVal = iVal + iThisVal
			end
			if MagicalGirls[iMGKey].IdeologicalBelief then
				local iThisVal;
				iThisVal, MagicalGirls[iMGKey].IdeologicalBeliefString	= tIdeologyLDTable.FulfilledFunc(iPlayer, iMGKey, MagicalGirls[iMGKey].IdeologicalBelief)
				iVal = iVal + iThisVal
			end
		end
		return iVal
	end
)
t_MoodMods[iLikesDislikesID].Desc = row.Description
t_MoodMods[iLikesDislikesID].PosTT = row.PositiveTooltip
t_MoodMods[iLikesDislikesID].NegTT = row.NegativeTooltip
t_MoodMods[iLikesDislikesID].Max = row.MaxValue

--The (large amount of) logic for this Moodlet is in the following file.
include("PMMMCoreLikesDislikes.lua")


----------------------------------------------------------------------------------------------------------------------------
-- KILLED WITCH
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_KILLED_WITCH"]
local iKilledWitchID = row.ID
t_MoodMods[iKilledWitchID] = {}
t_MoodMods[iKilledWitchID].Value = row.Value
t_MoodMods[iKilledWitchID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal;
		if MagicalGirls[iMGKey].RecentKilledWitches then
			iVal = math.min(#MagicalGirls[iMGKey].RecentKilledWitches * t_MoodMods[iKilledWitchID].Value, t_MoodMods[iKilledWitchID].Max)
		else
			iVal = 0
		end

		return iVal
	end
)
t_MoodMods[iKilledWitchID].Accumulator = (
	function(iMGKey, pPlayer, pUnit)
		if MagicalGirls[iMGKey].RecentKilledWitches then
			for i = #MagicalGirls[iMGKey].RecentKilledWitches, 1, -1 do
				if MagicalGirls[iMGKey].RecentKilledWitches[i] + t_MoodMods[iKilledWitchID].Decay <= Game:GetGameTurn() then
					table.remove(MagicalGirls[iMGKey].RecentKilledWitches, i)
				end
			end
		end
	end
)
t_MoodMods[iKilledWitchID].Desc = row.Description
t_MoodMods[iKilledWitchID].PosTT = row.PositiveTooltip
t_MoodMods[iKilledWitchID].NegTT = row.NegativeTooltip
t_MoodMods[iKilledWitchID].Max = row.MaxValue
t_MoodMods[iKilledWitchID].Decay = math.floor(row.Turns * iGameSpeedMod)

--Determine when a MG killed a Witch
--NOTE: This also gives the XP bonus from killing one, to save on processing.
local tXPPolicies = {}
for row in GameInfo.Policies() do
	if row.ExpModifier ~= 0 then
		tXPPolicies[row.ID] = row.ExpModifier / 100
	end
end


function OnCombatEndedDidMGKillWitch(iAttackingPlayer, iAttackingUnit, attackerDamage, attackerFinalDamage, attackerMaxHP, iDefendingPlayer, iDefendingUnit, defenderDamage, defenderFinalDamage, defenderMaxHP, iInterceptingPlayer, iInterceptingUnit, interceptorDamage, plotX, plotY)
	local pAttackingPlayer = Players[iAttackingPlayer]
	local pDefendingPlayer = Players[iDefendingPlayer]
	if pAttackingPlayer and pDefendingPlayer then
		local pAttackingUnit = pAttackingPlayer:GetUnitByID(iAttackingUnit)
		local pDefendingUnit = pDefendingPlayer:GetUnitByID(iDefendingUnit)
		if pAttackingUnit and pDefendingUnit then
			local pMagicalGirl;
			local pXPBonusUnit;
			if ((pAttackingUnit:GetUnitClassType() == iWitchClass or pAttackingUnit:GetUnitClassType() == iSeaWitchClass) and pAttackingUnit:GetCurrHitPoints() == 0 and pDefendingUnit:GetCurrHitPoints() > 0) then
				pXPBonusUnit = pDefendingUnit
				if pDefendingUnit:GetUnitClassType() == iMagicalGirlClass then
					pMagicalGirl = pDefendingUnit
				end
			elseif ((pDefendingUnit:GetCurrHitPoints() == 0 and (pDefendingUnit:GetUnitClassType() == iWitchClass or pDefendingUnit:GetUnitClassType() == iSeaWitchClass)) and pAttackingUnit:GetCurrHitPoints() > 0) then
				pXPBonusUnit = pAttackingUnit
				if pAttackingUnit:GetUnitClassType() == iMagicalGirlClass then
					pMagicalGirl = pAttackingUnit
				end
			end
			if pMagicalGirl then
				local iMGKey = GetMagicalGirlKey(pMagicalGirl:GetOwner(), pMagicalGirl:GetID())
				if iMGKey then
					if not MagicalGirls[iMGKey].RecentKilledWitches then
						MagicalGirls[iMGKey].RecentKilledWitches = {}
					end
					MagicalGirls[iMGKey].RecentKilledWitches[#MagicalGirls[iMGKey].RecentKilledWitches + 1] = Game:GetGameTurn() -- stores the game turn, to later determine when the bonus falls off
				end
			end
			--XP bonus
			if pXPBonusUnit then
				local iXPPercent = 1 + (pXPBonusUnit:GetExperiencePercent() / 100)
				for k, v in pairs(tXPPolicies) do
					if Players[pXPBonusUnit:GetOwner()]:HasPolicy(k) then
						iXPPercent = iXPPercent + v
					end
				end
				local iXPChange = math.floor(GameDefines.WITCH_KILLED_XP_BONUS * iXPPercent)
				pXPBonusUnit:ChangeExperience(iXPChange)
			end
			--v25: Handle "last combat" here
			if pAttackingUnit:GetUnitClassType() == iMagicalGirlClass then
				local iMGKey = GetMagicalGirlKey(pAttackingUnit:GetOwner(), pAttackingUnit:GetID())
				if iMGKey then
					MagicalGirls[iMGKey].LastCombatTurn = Game:GetGameTurn()
				end
			end
			if pDefendingUnit:GetUnitClassType() == iMagicalGirlClass then
				local iMGKey = GetMagicalGirlKey(pDefendingUnit:GetOwner(), pDefendingUnit:GetID())
				if iMGKey then
					MagicalGirls[iMGKey].LastCombatTurn = Game:GetGameTurn()
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------------------------------------------
-- SOCIALIZING
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_SOCIALIZING"]
local iSocializingID = row.ID
t_MoodMods[iSocializingID] = {}
t_MoodMods[iSocializingID].Value = row.Value
t_MoodMods[iSocializingID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal;
		if MagicalGirls[iMGKey].RecentSocializations then
			iVal = math.min(#MagicalGirls[iMGKey].RecentSocializations * t_MoodMods[iSocializingID].Value, t_MoodMods[iSocializingID].Max)
		else
			iVal = 0
		end

		return iVal
	end
)
t_MoodMods[iSocializingID].Accumulator = (
	function(iMGKey, pPlayer, pUnit)
		if MagicalGirls[iMGKey].RecentSocializations then
			for i = #MagicalGirls[iMGKey].RecentSocializations, 1, -1 do
				if MagicalGirls[iMGKey].RecentSocializations[i] + t_MoodMods[iSocializingID].Decay <= Game:GetGameTurn() then
					table.remove(MagicalGirls[iMGKey].RecentSocializations, i)
				end
			end
		end
	end
)
t_MoodMods[iSocializingID].Desc = row.Description
t_MoodMods[iSocializingID].PosTT = row.PositiveTooltip
t_MoodMods[iSocializingID].NegTT = row.NegativeTooltip
t_MoodMods[iSocializingID].Max = row.MaxValue
t_MoodMods[iSocializingID].Decay = math.floor(row.Turns * iGameSpeedMod)


local iSocializationMission = MissionTypes.MISSION_PMMM_SOCIALIZE
local iAutoSocializationMission = MissionTypes.MISSION_PMMM_SOCIALIZE_AUTO

local tSocializationPromotions = {}

for row in GameInfo.UnitPromotions() do
	if row.MGLikeDislikeSpreadBonus > 0 or row.MGSocializeBonus > 0 or row.MGSocializingXPGrantedToPartner > 0 or row.MGSocializingLoyaltyGrantedToPartner > 0 then
		tSocializationPromotions[row.ID] = {
			["LDBonus"] = row.MGLikeDislikeSpreadBonus,
			["SocializeBonus"] = row.MGSocializeBonus,
			["XPBonus"] = row.MGSocializingXPGrantedToPartner,
			["LoyaltyBonus"] = row.MGSocializingLoyaltyGrantedToPartner
		}
	end
end

function SocializationCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass and iMission == iSocializationMission then
		if not pUnit:IsEmbarked() then
			return true
		end
	end
	return false
end

function SocializationCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iSocializationMission then	
		DoSocialize(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), Map.GetPlot(-iData1, -iData2))
	end
	return 0
end

function SocializationCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iSocializationMission then
		return true
	end
	return false
end

function AutoSocializationCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass and iMission == iAutoSocializationMission then
		if not pUnit:IsEmbarked() then
			return true
		end
	end
	return false
end

function AutoSocializationCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iAutoSocializationMission then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		return 1
	end
	return 0
end

function AutoSocializationCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iAutoSocializationMission then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetMoves() > 0 then
			local tCandidatePlots = {}
			for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1, false, false, false, true) do
				if pAreaPlot:IsUnit() then
					for i = 0, pAreaPlot:GetNumUnits() - 1 do
						local pAllyUnit = pAreaPlot:GetUnit(i)
						if pAllyUnit ~= pUnit then
							local iOwner = pAllyUnit:GetOwner()
							if iOwner == pPlayer:GetID() or pPlayer:IsAtWarWith(iOwner) == false then
								local iMGKey = GetMagicalGirlKey(iOwner, pAllyUnit:GetID())
								if iMGKey then
									tCandidatePlots[#tCandidatePlots + 1] = pAreaPlot
								end
							end
						end
					end
				end
			end
			if #tCandidatePlots > 0 then
				local pChosenPlot = tCandidatePlots[Game.Rand(#tCandidatePlots, "PMMM Random Auto Socialize Plot") + 1]
				if pChosenPlot then
					DoSocialize(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), pChosenPlot)
				end
			else
				pUnit:SetMoves(0)
			end
		end
	end
	return false
end

function DoSocialize(iPlayer, pHeadUnit, pPlot)
	local iTurn = Game:GetGameTurn()
	local pPlayer = Players[iPlayer]
	for i = 0, pPlot:GetNumUnits() - 1 do
		local pUnit = pPlot:GetUnit(i)
		if pUnit ~= pHeadUnit and pUnit:GetUnitClassType() == iMagicalGirlClass then
			local iOwner = pUnit:GetOwner()

			local iOurMGKey = GetMagicalGirlKey(iPlayer, pHeadUnit:GetID())
			local iTheirMGKey = GetMagicalGirlKey(iOwner, pUnit:GetID())
			
			if not MagicalGirls[iOurMGKey].RecentSocializations then MagicalGirls[iOurMGKey].RecentSocializations = {} end
			if not MagicalGirls[iTheirMGKey].RecentSocializations then MagicalGirls[iTheirMGKey].RecentSocializations = {} end

			local iOurSocializationTimes = 1
			local iTheirSocializationTimes = 1
			local iOurLDBonus = 0
			local iTheirLDBonus = 0
			local iOurXPBonusToThem = 0
			local iTheirXPBonusToUs = 0
			local iOurLoyaltyBonusToThem = 0
			local iTheirLoyaltyBonusToUs = 0

			for k, v in pairs(tSocializationPromotions) do
				if pHeadUnit:IsHasPromotion(k) then
					iOurSocializationTimes = iOurSocializationTimes + v.SocializeBonus
					iOurLDBonus = iOurLDBonus + v.LDBonus
					if pHeadUnit:GetOwner() == pUnit:GetOwner() then
						iOurLoyaltyBonusToThem = iOurLoyaltyBonusToThem + v.LoyaltyBonus
						iOurXPBonusToThem = iOurXPBonusToThem + v.XPBonus
					end
				end
				if pUnit:IsHasPromotion(k) then
					iTheirSocializationTimes = iTheirSocializationTimes + v.SocializeBonus
					iTheirLDBonus = iTheirLDBonus + v.LDBonus
					if pHeadUnit:GetOwner() == pUnit:GetOwner() then
						iTheirLoyaltyBonusToUs = iTheirLoyaltyBonusToUs + v.LoyaltyBonus
						iTheirXPBonusToUs = iTheirXPBonusToUs + v.XPBonus
					end
				end
			end

			for i = 1, iTheirSocializationTimes, 1 do
				MagicalGirls[iOurMGKey].RecentSocializations[#MagicalGirls[iOurMGKey].RecentSocializations + 1] = iTurn
			end
			for i = 1, iOurSocializationTimes, 1 do
				MagicalGirls[iTheirMGKey].RecentSocializations[#MagicalGirls[iTheirMGKey].RecentSocializations + 1] = iTurn
			end

			--They influence each other's next Likes/Dislikes. Each conversation adds a percent chance that the next gained L/D is one of the other MG's
			--(if they don't already have one of the same Category and Value).
			if not MagicalGirls[iOurMGKey].InfluencedLikeDislikes then MagicalGirls[iOurMGKey].InfluencedLikeDislikes = {} end
			if not MagicalGirls[iTheirMGKey].InfluencedLikeDislikes then MagicalGirls[iTheirMGKey].InfluencedLikeDislikes = {} end
			
			local tInsertTable = {}
			
			for k, v in pairs(MagicalGirls[iTheirMGKey].LikesDislikes) do
				local bExistingEntry = false
				for k2, v2 in pairs(MagicalGirls[iOurMGKey].InfluencedLikeDislikes) do
					if v.Category == v2.Category and v.Type == v2.Type and v.Value == v2.Value then
						v2.Influence = v2.Influence + GameDefines.MG_NEXT_LIKE_DISLIKE_SOCIAL_INFLUENCE_PERCENT + iTheirLDBonus
						bExistingEntry = true
						break
					end
				end
				if not bExistingEntry then
					MagicalGirls[iOurMGKey].InfluencedLikeDislikes[#MagicalGirls[iOurMGKey].InfluencedLikeDislikes + 1] = {
						["Category"] = v.Category,
						["Type"] = v.Type,
						["Value"] = v.Value,
						["Influence"] = GameDefines.MG_NEXT_LIKE_DISLIKE_SOCIAL_INFLUENCE_PERCENT + iTheirLDBonus
					}
				end
			end
			
			for k, v in pairs(MagicalGirls[iOurMGKey].LikesDislikes) do
				local bExistingEntry = false
				for k2, v2 in pairs(MagicalGirls[iTheirMGKey].InfluencedLikeDislikes) do
					if v.Category == v2.Category and v.Type == v2.Type and v.Value == v2.Value then
						v2.Influence = v2.Influence + GameDefines.MG_NEXT_LIKE_DISLIKE_SOCIAL_INFLUENCE_PERCENT + iOurLDBonus
						bExistingEntry = true
						break
					end
				end
				if not bExistingEntry then
					MagicalGirls[iTheirMGKey].InfluencedLikeDislikes[#MagicalGirls[iTheirMGKey].InfluencedLikeDislikes + 1] = {
						["Category"] = v.Category,
						["Type"] = v.Type,
						["Value"] = v.Value,
						["Influence"] = GameDefines.MG_NEXT_LIKE_DISLIKE_SOCIAL_INFLUENCE_PERCENT + iOurLDBonus
					}
				end
			end
			
			--They also affect each other's Ideology.
			
			if PMMM.AnyoneHasIdeology and MagicalGirls[iOurMGKey].IdeologicalBelief and MagicalGirls[iTheirMGKey].IdeologicalBelief then
				local iOurHighestIdeology = -1
				local iTheirHighestIdeology = -1
				local iOurHighestIdeologyAmount = 0
				local iTheirHighestIdeologyAmount = 0
				for k, v in pairs(MagicalGirls[iOurMGKey].IdeologicalBelief) do
					if v > iOurHighestIdeologyAmount then
						iOurHighestIdeology = k
						iOurHighestIdeologyAmount = v
					end
				end
				for k, v in pairs(MagicalGirls[iTheirMGKey].IdeologicalBelief) do
					if v > iTheirHighestIdeologyAmount then
						iTheirHighestIdeology = k
						iTheirHighestIdeologyAmount = v
					end
				end
				MagicalGirls[iOurMGKey].IdeologicalBelief[iTheirHighestIdeology] = MagicalGirls[iOurMGKey].IdeologicalBelief[iTheirHighestIdeology] + 5 + iTheirLDBonus
				MagicalGirls[iTheirMGKey].IdeologicalBelief[iOurHighestIdeology] = MagicalGirls[iTheirMGKey].IdeologicalBelief[iOurHighestIdeology] + 5 + iOurLDBonus
			end
			
			MagicalGirls[iOurMGKey].LastSocializedTurn = iTurn
			MagicalGirls[iTheirMGKey].LastSocializedTurn = iTurn

			--v25: If there is an XP or Loyalty bonus, apply it
			if iOurXPBonusToThem > 0 then
				pUnit:ChangeExperience(iOurXPBonusToThem)
			end
			if iTheirXPBonusToUs > 0 then
				pHeadUnit:ChangeExperience(iTheirXPBonusToUs)
			end
			if iOurLoyaltyBonusToThem > 0 and MagicalGirls[iOurMGKey].Loyalty > MagicalGirls[iTheirMGKey].Loyalty then
				MagicalGirls[iTheirMGKey].Loyalty = math.floor(MagicalGirls[iTheirMGKey].Loyalty + iOurLoyaltyBonusToThem, GameDefines.MAXIMUM_MG_LOYALTY)
			end
			if iTheirLoyaltyBonusToUs > 0 and MagicalGirls[iTheirMGKey].Loyalty > MagicalGirls[iOurMGKey].Loyalty then
				MagicalGirls[iOurMGKey].Loyalty = math.floor(MagicalGirls[iOurMGKey].Loyalty + iTheirLoyaltyBonusToUs, GameDefines.MAXIMUM_MG_LOYALTY)
			end
			
			if iPlayer == Game:GetActivePlayer() then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_SOCIALIZATION_COMPLETED", Locale.ConvertTextKey(MagicalGirls[iOurMGKey].Name), Locale.ConvertTextKey(MagicalGirls[iTheirMGKey].Name)))
			elseif iOwner == Game:GetActivePlayer()  then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_SOCIALIZATION_COMPLETED_FROM_OTHER_PLAYER", pPlayer:GetCivilizationAdjective(), Locale.ConvertTextKey(MagicalGirls[iTheirMGKey].Name), Locale.ConvertTextKey(MagicalGirls[iOurMGKey].Name)))
			end
			
			pHeadUnit:SetMoves(0)
			return
		end
	end
end

local iSocializeRange = GameInfo.Missions["MISSION_PMMM_SOCIALIZE"].PMMMMissionRange

----------------------------------------------------------------------------------------------------------------------------
-- POLICIES
----------------------------------------------------------------------------------------------------------------------------

local tMoodPerCapitalPop = {}
local tMoodPerCity = {}
local tMoodPerMilitary = {}
local tMoodPerFollower = {}
local tMoodPerCSAlly = {}
local tMoodPerGreatWork = {}
local tMoodPerLuxury = {}
local tMoodPerMapPercent = {}
local tMoodPerTech = {}
local tMoodPerSpecialist = {}
local tMoodPerProd = {}
local tMoodPerScore = {}

for policy in GameInfo.Policies() do 
	if policy.PMMMMoodBonusPerCapitalPop ~= 0 then
		tMoodPerCapitalPop[policy.ID] = policy.PMMMMoodBonusPerCapitalPop
	end
	if policy.PMMMMoodBonusPerCity ~= 0 then
		tMoodPerCity[policy.ID] = policy.PMMMMoodBonusPerCity
	end
	if policy.PMMMMoodBonusPerNonMGMilitaryUnit ~= 0 then
		tMoodPerMilitary[policy.ID] = policy.PMMMMoodBonusPerNonMGMilitaryUnit
	end
	if policy.PMMMMoodBonusPerReligiousFollower ~= 0 then
		tMoodPerFollower[policy.ID] = policy.PMMMMoodBonusPerReligiousFollower
	end
	if policy.PMMMMoodBonusPerMinorCivAlly ~= 0 then
		tMoodPerCSAlly[policy.ID] = policy.PMMMMoodBonusPerMinorCivAlly
	end
	if policy.PMMMMoodBonusPerGreatWork ~= 0 then
		tMoodPerGreatWork[policy.ID] = policy.PMMMMoodBonusPerGreatWork
	end
	if policy.PMMMMoodBonusPerLuxury ~= 0 then
		tMoodPerLuxury[policy.ID] = policy.PMMMMoodBonusPerLuxury
	end
	if policy.PMMMMoodBonusPerMapPercent ~= 0 then
		tMoodPerMapPercent[policy.ID] = policy.PMMMMoodBonusPerMapPercent
	end
	if policy.PMMMMoodBonusPerTech ~= 0 then
		tMoodPerTech[policy.ID] = policy.PMMMMoodBonusPerTech
	end
	if policy.PMMMMoodBonusPerSpecialist ~= 0 then
		tMoodPerSpecialist[policy.ID] = policy.PMMMMoodBonusPerSpecialist
	end
	if policy.PMMMMoodBonusPerProductionTimes100 ~= 0 then
		tMoodPerProd[policy.ID] = policy.PMMMMoodBonusPerProductionTimes100
	end	
	if policy.PMMMMoodBonusPerScoreTimes100 ~= 0 then
		tMoodPerScore[policy.ID] = policy.PMMMMoodBonusPerScoreTimes100
	end
end

local tSpecialistBuildings = {}
for building in GameInfo.Buildings() do
	if building.SpecialistType and building.SpecialistCount > 0 then
		tSpecialistBuildings[building.ID] = true
	end
end

row = GameInfo.MG_MoodModifiers["MGMOODMOD_POLICIES"]
local iPolicyMoodID = row.ID
t_MoodMods[iPolicyMoodID] = {}
t_MoodMods[iPolicyMoodID].Value = row.Value
t_MoodMods[iPolicyMoodID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		for k, v in pairs(tMoodPerCapitalPop) do
			if pPlayer:HasPolicy(k) then
				local pCapital = pPlayer:GetCapitalCity()
				if pCapital then
					iVal = iVal + (pCapital:GetPopulation() * v)
				end
			end
		end
		for k, v in pairs(tMoodPerCity) do
			if pPlayer:HasPolicy(k) then
				iVal = iVal + (pPlayer:GetNumCities() * v)
			end
		end
		for k, v in pairs(tMoodPerMilitary) do
			if pPlayer:HasPolicy(k) then
				local iNumUnits = 0
				for pLoopUnit in pPlayer:Units() do
					if pLoopUnit:IsCombatUnit() and pLoopUnit:GetUnitClassType() ~= iMagicalGirlClass and pLoopUnit:GetUnitClassType() ~= GameInfoTypes.UNITCLASS_PMMM_WITCH then
						iNumUnits = iNumUnits + 1
					end
				end
				iVal = iVal + (iNumUnits * v)
			end
		end
		for k, v in pairs(tMoodPerFollower) do
			if pPlayer:HasPolicy(k) then
				local iReligion = pPlayer:GetReligionCreatedByPlayer()
				if iReligion and iReligion > -1 then
					iVal = iVal + (Game.GetNumFollowers(iReligion) * v)
				end
			end
		end
		for k, v in pairs(tMoodPerCSAlly) do
			if pPlayer:HasPolicy(k) then
				local iNumAllies = 0
				for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
					if Players[i]:IsAllies(pPlayer:GetID()) then
						iNumAllies = iNumAllies + 1
					end
				end
				iVal = iVal + (iNumAllies * v)
			end
		end
		for k, v in pairs(tMoodPerGreatWork) do
			if pPlayer:HasPolicy(k) then
				iVal = iVal + (pPlayer:GetNumGreatWorks() * v)
			end
		end
		for k, v in pairs(tMoodPerLuxury) do
			if pPlayer:HasPolicy(k) then
				local iNumLuxuries = 0
				for resource in GameInfo.Resources() do
					local resourceID = resource.ID;
					local iHappiness = pPlayer:GetHappinessFromLuxury(resourceID);
					if (iHappiness > 0) then
						iNumLuxuries = iNumLuxuries + 1
					end
				end
				iVal = iVal + (iNumLuxuries * v)
			end
		end
		for k, v in pairs(tMoodPerMapPercent) do
			if pPlayer:HasPolicy(k) then
				local iDiscoveredPlots = 0
				local iTotalPlots = Map.GetNumPlots()
				local iTeam = pPlayer:GetTeam()
				for i = 0, iTotalPlots - 1, 1 do
					local pPlot = Map.GetPlotByIndex(i)
					if pPlot:IsRevealed(iTeam) then
						iDiscoveredPlots = iDiscoveredPlots + 1
					end
				end
				local iPercent = math.floor(iDiscoveredPlots / iTotalPlots * 100)
				iVal = iVal + (iPercent * v)
			end
		end
		for k, v in pairs(tMoodPerTech) do
			if pPlayer:HasPolicy(k) then
				local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
				local iTechsKnown = pTeamTechs:GetNumTechsKnown()
				local iFutureScore = pPlayer:GetScoreFromFutureTech() / GameDefines.SCORE_FUTURE_TECH_MULTIPLIER
				iVal = iVal + ((iTechsKnown + iFutureScore) * v)
			end
		end
		for k, v in pairs(tMoodPerSpecialist) do
			if pPlayer:HasPolicy(k) then
				local iNumSpecialists = 0
				for pCity in pPlayer:Cities() do
					for k2, v2 in pairs(tSpecialistBuildings) do
						if pCity:IsHasBuilding(k2) then
							iNumSpecialists = iNumSpecialists + pCity:GetNumSpecialistsInBuilding(k2)
						end
					end
				end
				iVal = iVal + ((iNumSpecialists) * v)
			end
		end
		for k, v in pairs(tMoodPerProd) do
			if pPlayer:HasPolicy(k) then
				local iProduction = 0
				for pCity in pPlayer:Cities() do
					iProduction = iProduction + pCity:GetYieldRate(YieldTypes.YIELD_PRODUCTION)
				end
				iVal = iVal + math.floor((iProduction * (v / 100)))
			end
		end
		for k, v in pairs(tMoodPerScore) do
			if pPlayer:HasPolicy(k) then
				local iScore = pPlayer:GetScore()
				iVal = iVal + math.floor((iScore * (v / 100)))
			end
		end

		return iVal;
	end
)
t_MoodMods[iPolicyMoodID].Desc = row.Description
t_MoodMods[iPolicyMoodID].PosTT = row.PositiveTooltip
t_MoodMods[iPolicyMoodID].NegTT = row.NegativeTooltip
t_MoodMods[iPolicyMoodID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- BELIEFS
----------------------------------------------------------------------------------------------------------------------------

local tMoodFromFollowersBelief = {}
local tMoodFromFollowingCitiesBelief = {}

for belief in GameInfo.Beliefs() do 
	if belief.PMMMMoodBonusPerFollowingCity ~= 0 then
		tMoodFromFollowingCitiesBelief[belief.ID] = {
			["Value"] = belief.PMMMMoodBonusPerFollowingCity,
			["Founder"] = belief.Founder
		}
	end
	if belief.PMMMMoodBonusPerFollower ~= 0 then
		tMoodFromFollowersBelief[policy.ID] = {
			["Value"] = belief.PMMMMoodBonusPerFollower,
			["Founder"] = belief.Founder
		}
	end
end

row = GameInfo.MG_MoodModifiers["MGMOODMOD_BELIEFS"]
local iBeliefMoodID = row.ID
t_MoodMods[iBeliefMoodID] = {}
t_MoodMods[iBeliefMoodID].Value = row.Value
t_MoodMods[iBeliefMoodID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		if Game.AnyoneHasAnyReligion() then
			local bShouldTestBeliefs = false
			local bIsFounder = false
			local iReligion = -1
			local iFoundedReligion = pPlayer:GetReligionCreatedByPlayer()
			if iFoundedReligion and iFoundedReligion > -1 then
				bShouldTestBeliefs = true
				bIsFounder = true
				iReligion = iFoundedReligion
			end
			if not bShouldTestBeliefs then
				local iMajorityReligion = nil
				for row in GameInfo.Religions() do
					if pPlayer:HasReligionInMostCities(row.ID) then
						local tThisReligionBeliefs = Game.GetBeliefsInReligion(row.ID)
						for k2, v2 in pairs(tThisReligionBeliefs) do
							if k2 == k then
								bShouldTestBeliefs = true
								iReligion = row.ID
								break
							end
						end
					end
					if bShouldTestBeliefs then break end
				end
			end
			if bShouldTestBeliefs then
				local tThisReligionBeliefs = Game.GetBeliefsInReligion(iReligion)
				for k, v in pairs(tMoodFromFollowersBelief) do
					for k2, v2 in pairs(tThisReligionBeliefs) do
						if k2 == k and ((v.Founder == true or v.Founder == 1 and bIsFounder == true) or v.Founder == false) then
							iVal = iVal + (Game.GetNumFollowers(iReligion) * v.Value)
						end
					end
				end
				for k, v in pairs(tMoodFromFollowingCitiesBelief) do
					for k2, v2 in pairs(tThisReligionBeliefs) do
						if v2 == k and ((v.Founder == true or v.Founder == 1 and bIsFounder == true) or v.Founder == false) then
							iVal = iVal + (Game.GetNumCitiesFollowing(iReligion) * v.Value)
						end
					end
				end
			end
		end
		return iVal
	end
)
t_MoodMods[iBeliefMoodID].Desc = row.Description
t_MoodMods[iBeliefMoodID].PosTT = row.PositiveTooltip
t_MoodMods[iBeliefMoodID].NegTT = row.NegativeTooltip
t_MoodMods[iBeliefMoodID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- BUILDINGS
----------------------------------------------------------------------------------------------------------------------------

local tMoodBuildings = {}
for building in GameInfo.Buildings() do
	if building.PMMMMoodBonus > 0 then
		tMoodBuildings[building.ID] = building.PMMMMoodBonus
	end
end

row = GameInfo.MG_MoodModifiers["MGMOODMOD_BUILDINGS"]
local iBuildingMoodID = row.ID
t_MoodMods[iBuildingMoodID] = {}
t_MoodMods[iBuildingMoodID].Value = row.Value
t_MoodMods[iBuildingMoodID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		for pCity in pPlayer:Cities() do
			for iBuilding, iMood in pairs(tMoodBuildings) do
				if pCity:IsHasBuilding(iBuilding) then
					iVal = iVal + iMood
				end
			end
		end

		return iVal
	end
)
t_MoodMods[iBuildingMoodID].Desc = row.Description
t_MoodMods[iBuildingMoodID].PosTT = row.PositiveTooltip
t_MoodMods[iBuildingMoodID].NegTT = row.NegativeTooltip
t_MoodMods[iBuildingMoodID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- TRAITS
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_TRAITS"]
local iTraitMoodID = row.ID
t_MoodMods[iTraitMoodID] = {}
t_MoodMods[iTraitMoodID].Value = row.Value
t_MoodMods[iTraitMoodID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		if MapModData.gPMMMTraits[pPlayer:GetID()] then
			iVal = iVal + MapModData.gPMMMTraits[pPlayer:GetID()].MGMoodBonus
		end
		return iVal
	end
)
t_MoodMods[iTraitMoodID].Desc = row.Description
t_MoodMods[iTraitMoodID].PosTT = row.PositiveTooltip
t_MoodMods[iTraitMoodID].NegTT = row.NegativeTooltip
t_MoodMods[iTraitMoodID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- INJURED
----------------------------------------------------------------------------------------------------------------------------

local tWoundedUnitDamageModPolicies = {}

for policy in GameInfo.Policies() do
	if policy.WoundedUnitDamageMod ~= 0 then
		tWoundedUnitDamageModPolicies[policy.ID] = policy.WoundedUnitDamageMod
	end
end

row = GameInfo.MG_MoodModifiers["MGMOODMOD_INJURED"]
local iInjuredID = row.ID
t_MoodMods[iInjuredID] = {}
t_MoodMods[iInjuredID].Value = row.Value
t_MoodMods[iInjuredID].Func = (
	function(iMGKey, pPlayer, pUnit)
		if MagicalGirls[iMGKey].DullPainTurns and MagicalGirls[iMGKey].DullPainTurns > 0 then
			return 0
		else
			local iPlayer = pPlayer:GetID()
			if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].FightWellDamaged == true or MapModData.gPMMMTraits[iPlayer].FightWellDamaged == 1) then
				return 0
			end
			local iMultiplier = 100
			for k, v in pairs(tWoundedUnitDamageModPolicies) do
				if pPlayer:HasPolicy(k) then
					iMultiplier = iMultiplier + v
				end
			end
			iMultiplier = iMultiplier / 100
			return math.floor(pUnit:GetDamage() * t_MoodMods[iInjuredID].Value * iMultiplier) * -1
		end
	end
)

t_MoodMods[iInjuredID].Accumulator = (
	function(iMGKey, pPlayer, pUnit)
		if MagicalGirls[iMGKey].DullPainTurns and MagicalGirls[iMGKey].DullPainTurns > 0 then
			MagicalGirls[iMGKey].DullPainTurns = MagicalGirls[iMGKey].DullPainTurns - 1
			if MagicalGirls[iMGKey].DullPainTurns == 0 then
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_PMMM_DULL_PAIN, false)
				pUnit:SetMoves(pUnit:MaxMoves())
			end
		else
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_PMMM_DULL_PAIN, false)
			pUnit:SetMoves(pUnit:MaxMoves())
		end
	end
)
t_MoodMods[iInjuredID].Desc = row.Description
t_MoodMods[iInjuredID].PosTT = row.PositiveTooltip
t_MoodMods[iInjuredID].NegTT = row.NegativeTooltip
t_MoodMods[iInjuredID].Max = row.MaxValue


--Dull Pain ability: Heals the user and increases their max HP...wait, wrong game. ;_;

--Makes a MG ignore the Mood effects of being injured for 5 turns (at ALL speeds),
--at the cost of -1 Movement and -20% when attacking for that 5 turn duration.

local iDullPainMission = MissionTypes.MISSION_PMMM_DULL_PAIN

function DullPainCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].FightWellDamaged == true or MapModData.gPMMMTraits[iPlayer].FightWellDamaged == 1) then return false end
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass and iMission == iDullPainMission and pUnit:GetDamage() > 0 then
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if iMGKey then
			if not MagicalGirls[iMGKey].DullPainTurns then
				return true
			elseif MagicalGirls[iMGKey].DullPainTurns <= 0 then
				return true
			else
				return bTestVisible
			end
		end
	end
	return false
end

function DullPainCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iDullPainMission then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_PMMM_DULL_PAIN, true)
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if iMGKey then
			MagicalGirls[iMGKey].DullPainTurns = GameDefines.MG_DULL_PAIN_TURNS
		end
	end
	return 0
end

function DullPainCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iDullPainMission then
		return true
	end
	return false
end

function DullPainAILogic(iPlayer, iUnit, iX, iY)
	--Pop it if they're at 67+ damage (i.e. more than a -200 mood change)
	if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].FightWellDamaged == true or MapModData.gPMMMTraits[iPlayer].FightWellDamaged == 1) then return false end
	if iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		if not pPlayer:IsHuman() then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit:GetUnitClassType() == iMagicalGirlClass and pUnit:GetDamage() >= 67 then
				local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
				if iMGKey then
					pUnit:PopMission()
					pUnit:PushMission(iDullPainMission, iX, iY)
				end
			end
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- HOSTILE TERRAIN
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_HOSTILE_TERRAIN"]
local iHostileTerrainID = row.ID
t_MoodMods[iHostileTerrainID] = {}

local tHostileTerrains = {
	[TerrainTypes.TERRAIN_DESERT] = true,
	[TerrainTypes.TERRAIN_TUNDRA] = true,
	[TerrainTypes.TERRAIN_SNOW] = true
}

local tHostileFeatures = {
	[FeatureTypes.FEATURE_JUNGLE] = true
}

local tFeatureMakesNonHostile = {
	[FeatureTypes.FEATURE_OASIS] = true
}
t_MoodMods[iHostileTerrainID].Value = row.Value
t_MoodMods[iHostileTerrainID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local pPlot = pUnit:GetPlot()
		local iVal = 0
		if pPlot then
			if pPlot:GetImprovementType() < 0 and not pPlot:IsCity() then
				local iTerrain = pPlot:GetTerrainType()
				if iTerrain == TerrainTypes.TERRAIN_SNOW then iTerrain = TerrainTypes.TERRAIN_TUNDRA end  				--Snow counts as Tundra for this
				local iFeature = pPlot:GetFeatureType()
				if (tHostileTerrains[iTerrain] and not tFeatureMakesNonHostile[iFeature]) then
					if MagicalGirls[iMGKey].AdaptedHostileTerrain and MagicalGirls[iMGKey].AdaptedHostileTerrain ~= iTerrain then
						iVal = t_MoodMods[iHostileTerrainID].Value * 2
					elseif not MagicalGirls[iMGKey].AdaptedHostileTerrain then
						iVal = t_MoodMods[iHostileTerrainID].Value
					end
				elseif (tHostileFeatures[iFeature]) then
					if MagicalGirls[iMGKey].AdaptedHostileFeature and MagicalGirls[iMGKey].AdaptedHostileFeature ~= iFeature then
						iVal = t_MoodMods[iHostileTerrainID].Value * 2
					elseif not MagicalGirls[iMGKey].AdaptedHostileFeature then
						iVal = t_MoodMods[iHostileTerrainID].Value
					end
				end
			end
		end
		return -iVal
	end
)
t_MoodMods[iHostileTerrainID].Desc = row.Description
t_MoodMods[iHostileTerrainID].PosTT = row.PositiveTooltip
t_MoodMods[iHostileTerrainID].NegTT = row.NegativeTooltip
t_MoodMods[iHostileTerrainID].Max = row.MaxValue



----------------------------------------------------------------------------------------------------------------------------
-- HOMESICK
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_HOMESICK"]
local iHomesickID = row.ID
t_MoodMods[iHomesickID] = {}
t_MoodMods[iHomesickID].Value = row.Value
t_MoodMods[iHomesickID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		if pPlayer:IsHuman() then
			if MagicalGirls[iMGKey].HomeCity then
				local pCity = Vice_DecompileCityID(MagicalGirls[iMGKey].HomeCity)
				if pCity then
					local iThreshold = t_MoodMods[iHomesickID].StartTurn
					local iTurnsSinceGoneHome = Game:GetGameTurn() - MagicalGirls[iMGKey].HomeCityLastVisited
					if iTurnsSinceGoneHome >= iThreshold then
						iTurnsSinceGoneHome = iTurnsSinceGoneHome - iThreshold
						iVal = math.min(iTurnsSinceGoneHome * t_MoodMods[iHomesickID].Value, t_MoodMods[iHomesickID].Max)
						if MagicalGirls[iMGKey].HomeCityLastContacted then
							local iTurnsSinceContacted = Game:GetGameTurn() - MagicalGirls[iMGKey].HomeCityLastContacted
							if iTurnsSinceContacted <= iThreshold then
								iVal = math.floor(iVal / 2)
							end
						end
						t_MoodMods[iHomesickID].NegTT = Locale.ConvertTextKey(GameInfo.MG_MoodModifiers[iHomesickID].NegativeTooltip, pCity:GetName())
					end
				else --the City has been destroyed and she can never return ;_;
					iVal = t_MoodMods[iHomesickID].Max
					t_MoodMods[iHomesickID].NegTT = Locale.ConvertTextKey("TXT_KEY_MGMOODMOD_HOMESICK_DESTROYED_TT") --unique tooltip
				end
			else
				iVal = 0
			end
		end
		return -iVal
	end
)
t_MoodMods[iHomesickID].Desc = row.Description
t_MoodMods[iHomesickID].Max = row.MaxValue
t_MoodMods[iHomesickID].StartTurn = math.floor(iGameSpeedMod * row.Turns)

function OnSetXYIsMGNearHomeCity(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetUnitClassType() == iMagicalGirlClass then
			local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
			if iMGKey and MagicalGirls[iMGKey].HomeCity then
				local pCity = Vice_DecompileCityID(MagicalGirls[iMGKey].HomeCity)
				if pCity then
					if Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY()) <= 1 then
						MagicalGirls[iMGKey].HomeCityLastVisited = Game:GetGameTurn()
					end
				end
			end
		end
	end
end


local iWriteHome = GameInfoTypes.MISSION_PMMM_WRITE_HOME
local iPhoneHome = GameInfoTypes.MISSION_PMMM_PHONE_HOME
local iPostOfficeClass = GameInfoTypes.BUILDINGCLASS_PMMM_POST_OFFICE
local iPhoneNetworkClass = GameInfoTypes.BUILDINGCLASS_PMMM_PHONE_NETWORK

function HomesickAILogic(iPlayer, iUnit, iX, iY)
--Commented out for now. AIs do not receive Homesick until I can figure out a way to code it which doesn't crash
--[[	if iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		if not pPlayer:IsHuman() and not pPlayer:IsMinorCiv() then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit:GetUnitClassType() == iMagicalGirlClass then
				local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
				if iMGKey then
					local iPenalty = t_MoodMods[iHomesickID].Func(iMGKey, pPlayer, pUnit)
					if iPenalty < -200 then
						local pTeam = Teams[pPlayer:GetTeam()]
						for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
							if i ~= iPlayer then
								local pLoop = Players[i]
								if pLoop:IsAlive() and pTeam:IsAtWar(pLoop:GetTeam()) then
									return
								end
							end
						end
						local pCity = Vice_DecompileCityID(MagicalGirls[iMGKey].HomeCity)
						if pCity and pUnit:CanMoveOrAttackInto(pCity:Plot(), 0, 1) then
							print("Attempt to move MG unit home")
							print("Data:")
							print("Name: "..pUnit:GetName())
							print("Location: "..pUnit:GetX()..", "..pUnit:GetY())
							print("Destination: "..pCity:GetX()..", "..pCity:GetY())
							pUnit:PopMission()
							pUnit:PushMission(MissionTypes.MISSION_MOVE_TO, pCity:GetX()+1, pCity:GetY()+1, 0, 0, 1)
						end
					--v24: Only return home if penalty is severe. If not severe, just try to call or write home
					elseif iPenalty < 0 then
						local pCity = Vice_DecompileCityID(MagicalGirls[iMGKey].HomeCity)
						if pCity then
							if ContactHomeCustomMissionPossible(iPlayer, iUnit, iWriteHome) == true  then
								DoMagicalGirlDisappearFromMapAction(iMGKey, iPlayer, iUnit, GameInfoTypes.MGACTIONSTATE_WRITING_HOME)
								--Doing missions the "right" way causes CTDs here, so don't do it
								-- pUnit:PopMission()
								-- pUnit:PushMission(iWriteHome, pUnit:GetX(), pUnit:GetY(), 0, 0, 1, iWriteHome, pUnit:GetPlot(), pUnit)
							elseif ContactHomeCustomMissionPossible(iPlayer, iUnit, iPhoneHome) == true then
								pUnit:PopMission()
								pUnit:PushMission(iPhoneHome, pUnit:GetX(), pUnit:GetY(), 0, 0, 1, iPhoneHome, pUnit:GetPlot(), pUnit)
							end
						end
					end
				end
			end
		end
	end]]
end



function ContactHomeCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	if not pPlayer:IsMinorCiv() then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetUnitClassType() == iMagicalGirlClass then
			local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
			if iMGKey then
				if iMission == iWriteHome or iMission == iPhoneHome then
					if (iMission == iWriteHome and (pPlayer:HasBuildingClass(iPostOfficeClass) == false or pPlayer:HasBuildingClass(iPhoneNetworkClass) == true)) then return false end
					if (iMission == iPhoneHome and not pPlayer:HasBuildingClass(iPhoneNetworkClass)) then return false end
					local pCity = Vice_DecompileCityID(MagicalGirls[iMGKey].HomeCity)
					if pCity then
						local iTurn = Game:GetGameTurn()
						if MagicalGirls[iMGKey].HomeCityLastVisited then
							local iTurnsSinceVisited = iTurn - MagicalGirls[iMGKey].HomeCityLastVisited
							if iTurnsSinceVisited < t_MoodMods[iHomesickID].StartTurn then
								return bTestVisible
							end
						end
						if MagicalGirls[iMGKey].HomeCityLastContacted then
							local iTurnsSinceContacted = iTurn - MagicalGirls[iMGKey].HomeCityLastContacted
							if iTurnsSinceContacted < t_MoodMods[iHomesickID].StartTurn then
								return bTestVisible
							end
						end
						if (iMission == iPhoneHome and pPlayer:HasTech(GameInfoTypes.TECH_INTERNET)) then
							return true
						else
							local pPlot = pUnit:GetPlot()
							if pPlot then
								local iOwner = pPlot:GetOwner()
								if iOwner > -1 then
									local pOwner = Players[iOwner]
									local pOwnerTeam = Teams[pOwner:GetTeam()]
									if iOwner == iPlayer or pOwnerTeam:IsAllowsOpenBordersToTeam(pPlayer:GetTeam()) or pOwner:IsMinorCiv() and pOwner:GetMinorCivFriendshipLevelWithMajor(iPlayer) >= 1 then
										return true
									else
										return bTestVisible
									end
								else
									return bTestVisible
								end
							else
								return bTestVisible
							end
						end
					end
				end
			end
		end
	end
	return false
end

function ContactHomeCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iWriteHome then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if iMGKey then
			DoMagicalGirlDisappearFromMapAction(iMGKey, iPlayer, iUnit, GameInfoTypes.MGACTIONSTATE_WRITING_HOME)
		end
	elseif iMission == iPhoneHome then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if iMGKey then
			pUnit:SetMoves(0)
			MagicalGirls[iMGKey].HomeCityLastContacted = Game:GetGameTurn()
		end
	end
	return 0
end

function ContactHomeCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iWriteHome or iMission == iPhoneHome then
		return true
	end
	return false
end

----------------------------------------------------------------------------------------------------------------------------
-- HASN'T VACATIONED IN A WHILE
----------------------------------------------------------------------------------------------------------------------------
row = GameInfo.MG_MoodModifiers["MGMOODMOD_NO_VACATION"]
local iNoVacationID = row.ID
t_MoodMods[iNoVacationID] = {}
t_MoodMods[iNoVacationID].Value = row.Value
t_MoodMods[iNoVacationID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		--Leaders don't ever need Vacations
		if not MagicalGirls[iMGKey].IsLeader then
			if not MagicalGirls[iMGKey].LastVacationTurn then MagicalGirls[iMGKey].LastVacationTurn = Game:GetGameTurn() end
			local iTurnsSinceLastVacation = Game:GetGameTurn() - MagicalGirls[iMGKey].LastVacationTurn
			local iThreshold = t_MoodMods[iNoVacationID].StartTurn
			if iTurnsSinceLastVacation >= iThreshold then
				iTurnsSinceLastVacation = iTurnsSinceLastVacation - iThreshold
				iVal = math.min(iTurnsSinceLastVacation * t_MoodMods[iNoVacationID].Value, t_MoodMods[iNoVacationID].Max)
			end
		end
		return -iVal
	end
	)
t_MoodMods[iNoVacationID].Desc = row.Description
t_MoodMods[iNoVacationID].PosTT = row.PositiveTooltip
t_MoodMods[iNoVacationID].NegTT = row.NegativeTooltip
t_MoodMods[iNoVacationID].Max = row.MaxValue
t_MoodMods[iNoVacationID].StartTurn = math.floor(iGameSpeedMod * row.Turns)

----------------------------------------------------------------------------------------------------------------------------
-- HASN'T SOCIALIZED IN A WHILE
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_NO_SOCIALIZING"]
local iNoSocializingID = row.ID
t_MoodMods[iNoSocializingID] = {}
t_MoodMods[iNoSocializingID].Value = row.Value
t_MoodMods[iNoSocializingID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		if not MagicalGirls[iMGKey].LastSocializedTurn then MagicalGirls[iMGKey].LastSocializedTurn = Game:GetGameTurn() end
		local iTurnsSinceLastSocialize = Game:GetGameTurn() - MagicalGirls[iMGKey].LastSocializedTurn
		local iThreshold = t_MoodMods[iNoSocializingID].StartTurn
		if iTurnsSinceLastSocialize >= iThreshold then
			iTurnsSinceLastSocialize = iTurnsSinceLastSocialize - iThreshold
			iVal = math.min(iTurnsSinceLastSocialize * t_MoodMods[iNoSocializingID].Value, t_MoodMods[iNoSocializingID].Max)
		end
		return -iVal
	end
)
t_MoodMods[iNoSocializingID].Desc = row.Description
t_MoodMods[iNoSocializingID].PosTT = row.PositiveTooltip
t_MoodMods[iNoSocializingID].NegTT = row.NegativeTooltip
t_MoodMods[iNoSocializingID].Max = row.MaxValue
t_MoodMods[iNoSocializingID].StartTurn = math.floor(iGameSpeedMod * row.Turns)

local iSparringMission = GameInfoTypes.MISSION_PMMM_SPAR

function SocializingAILogic(iPlayer, iUnit, iX, iY)
	--The current, simple AI logic is to make them do the mission whenever they move near another Magical Girl
	--and they are getting a negative Moodlet from not socializing.
	if iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		if not pPlayer:IsHuman() then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit:GetUnitClassType() == iMagicalGirlClass then
				local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
				if iMGKey then
					if t_MoodMods[iNoSocializingID].Func(iMGKey, pPlayer, pUnit) < 0 then
						for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), iSocializeRange) do
							if pAreaPlot:IsUnit() then
								for i = 0, pAreaPlot:GetNumUnits() - 1 do
									local pAllyUnit = pAreaPlot:GetUnit(i)
									local iOwner = pAllyUnit:GetOwner()
									if iOwner == pPlayer:GetID() or Teams[pPlayer:GetTeam()]:IsAtWar(Players[iOwner]:GetTeam()) == false then
										local iOtherMGKey = GetMagicalGirlKey(iOwner, pAllyUnit:GetID())
										if iOtherMGKey then
											pUnit:PopMission()
											DoSocialize(iPlayer, pUnit, pAreaPlot)
											return
										end
									end
								end
							end
						end
					--v24: This will also handle Sparring. When the Skill Tree comes in, AI Logic will all be consolidated into one function anyway.
					elseif not pPlayer:IsMinorCiv() and SparringCustomMissionPossible(iPlayer, iUnit, iSparringMission) == true then
						local pTeam = Teams[pPlayer:GetTeam()]
						for i = 0, iMaxCivs - 1, 1 do
							if i ~= iPlayer then
								local pLoop = Players[i]
								if pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
									return
								end
							end
						end
						for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1) do
							for i = 0, pAreaPlot:GetNumUnits() - 1 do
								local pAllyUnit = pAreaPlot:GetUnit(i)
								local iOwner = pAllyUnit:GetOwner()
								if iOwner == pPlayer:GetID() and pAllyUnit:GetUnitClassType() == iMagicalGirlClass and pAllyUnit:GetDamage() == 0 then
									local iMGKey = GetMagicalGirlKey(iOwner, pAllyUnit:GetID())
									if iMGKey then
										if not MagicalGirls[iMGKey].SparringCooldown then MagicalGirls[iMGKey].SparringCooldown = 0 end
										if Game:GetGameTurn() - MagicalGirls[iMGKey].SparringCooldown >= GameDefines.MG_SPARRING_COOLDOWN then
											pUnit:PopMission()
											DoSparring(iPlayer, pUnit, pAreaPlot)
											return
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

----------------------------------------------------------------------------------------------------------------------------
-- FRIENDLY UNITS KILLED NEARBY
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_FRIENDLY_UNIT_KILLED"]
local iFriendlyUnitsID = row.ID
t_MoodMods[iFriendlyUnitsID] = {}
t_MoodMods[iFriendlyUnitsID].Value = row.Value
t_MoodMods[iFriendlyUnitsID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal;
		if MagicalGirls[iMGKey].RecentFriendlyKilledUnits then
			iVal = math.min(#MagicalGirls[iMGKey].RecentFriendlyKilledUnits * t_MoodMods[iFriendlyUnitsID].Value, t_MoodMods[iFriendlyUnitsID].Max)
		else
			iVal = 0
		end

		return -iVal
	end
)
t_MoodMods[iFriendlyUnitsID].Accumulator = (
	function(iMGKey, pPlayer, pUnit)
		if MagicalGirls[iMGKey].RecentFriendlyKilledUnits then
			for i = #MagicalGirls[iMGKey].RecentFriendlyKilledUnits, 1, -1 do
				if MagicalGirls[iMGKey].RecentFriendlyKilledUnits[i] + t_MoodMods[iFriendlyUnitsID].Decay <= Game:GetGameTurn() then
					table.remove(MagicalGirls[iMGKey].RecentFriendlyKilledUnits, i)
				end
			end
		end
	end
)
t_MoodMods[iFriendlyUnitsID].Desc = row.Description
t_MoodMods[iFriendlyUnitsID].PosTT = row.PositiveTooltip
t_MoodMods[iFriendlyUnitsID].NegTT = row.NegativeTooltip
t_MoodMods[iFriendlyUnitsID].Max = row.MaxValue
t_MoodMods[iFriendlyUnitsID].Decay = math.floor(row.Turns * iGameSpeedMod)

function OnUnitPreKillNearbyMGMood(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	if bDelay == true and iByPlayer > -1 and iByPlayer ~= iPlayer then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:IsCombatUnit() then
			for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 2, false, false, false, true) do
				if pAreaPlot:IsUnit() then
					for c = 0, pAreaPlot:GetNumUnits() - 1 do
						local pPlotUnit = pAreaPlot:GetUnit(c)
						if pPlotUnit and pPlotUnit ~= pUnit and pPlotUnit:GetUnitClassType() == iMagicalGirlClass and pPlotUnit:GetOwner() == iPlayer then
							local iMGKey = GetMagicalGirlKey(pPlotUnit:GetOwner(), pPlotUnit:GetID())
							if iMGKey then
								if not MagicalGirls[iMGKey].RecentFriendlyKilledUnits then MagicalGirls[iMGKey].RecentFriendlyKilledUnits = {} end
								MagicalGirls[iMGKey].RecentFriendlyKilledUnits[#MagicalGirls[iMGKey].RecentFriendlyKilledUnits + 1] = Game:GetGameTurn()
							end
						end
					end
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------------------------------------------
-- KNOWS THE TRUTH
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_KNOWS_THE_TRUTH"]
local iKnowsTruthID = row.ID
t_MoodMods[iKnowsTruthID] = {}
t_MoodMods[iKnowsTruthID].Value = row.Value
t_MoodMods[iKnowsTruthID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0;
		if not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_PMMM_IMMUNE_TO_TRUTH) then
			if MagicalGirls[iMGKey].TruthDiscoveredTurn then
				iVal = math.min(MagicalGirls[iMGKey].TruthDiscoveredTurn * t_MoodMods[iKnowsTruthID].Value, t_MoodMods[iKnowsTruthID].Max)
				local iTurnsSinceDiscovered = Game:GetGameTurn() - MagicalGirls[iMGKey].TruthDiscoveredTurn
				local iThreshold = t_MoodMods[iKnowsTruthID].HalfTurn
				if iTurnsSinceDiscovered >= iThreshold then
					iVal = t_MoodMods[iKnowsTruthID].Value
				else
					iVal = t_MoodMods[iKnowsTruthID].Value * 2
				end
			else
				iVal = 0
			end
		end
		return -iVal
	end
)
t_MoodMods[iKnowsTruthID].Desc = row.Description
t_MoodMods[iKnowsTruthID].PosTT = row.PositiveTooltip
t_MoodMods[iKnowsTruthID].NegTT = row.NegativeTooltip
t_MoodMods[iKnowsTruthID].Max = row.MaxValue
t_MoodMods[iKnowsTruthID].HalfTurn = math.floor(row.Turns * iGameSpeedMod)


----------------------------------------------------------------------------------------------------------------------------
-- WAR SCORE
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_WAR_SCORE"]
local iWarScoreID = row.ID
t_MoodMods[iWarScoreID] = {}
t_MoodMods[iWarScoreID].Value = row.Value
t_MoodMods[iWarScoreID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0;
		local iTeam = pPlayer:GetTeam()
		if PMMM.WarScore[iTeam] then
			iVal = PMMM.WarScore[iTeam]
		end
		return iVal
	end
)
t_MoodMods[iWarScoreID].Desc = row.Description
t_MoodMods[iWarScoreID].PosTT = row.PositiveTooltip
t_MoodMods[iWarScoreID].NegTT = row.NegativeTooltip
t_MoodMods[iWarScoreID].Max = row.MaxValue

function OnUnitKilledInCombatWarScore(iVictor, iLoser, iUnit)
	if iVictor == 63 or iLoser == 63 then return end
	
	local pVictor = Players[iVictor]
	local pLoser = Players[iLoser]
	local bVictorAtWarWithMajor;
	local bLoserAtWarWithMajor;
	
	if pVictor:IsAlive() and not pVictor:IsMinorCiv() then
		local pTeam = Teams[pVictor:GetTeam()]
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
				bVictorAtWarWithMajor = true
				break
			end
		end
	end
	
	if pLoser:IsAlive() and not pLoser:IsMinorCiv() then
		local pTeam = Teams[pLoser:GetTeam()]
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
				bLoserAtWarWithMajor = true
				break
			end
		end
	end
	
	if bVictorAtWarWithMajor then
		local iTeam = pVictor:GetTeam()
		if not PMMM.WarScore[iTeam] then
			PMMM.WarScore[iTeam] = 10
		else
			PMMM.WarScore[iTeam] = PMMM.WarScore[iTeam] + 10
		end
	end
	
	if bLoserAtWarWithMajor then
		local iTeam = pLoser:GetTeam()
		if not PMMM.WarScore[iTeam] then
			PMMM.WarScore[iTeam] = -10
		else
			PMMM.WarScore[iTeam] = PMMM.WarScore[iTeam] - 10
		end
	end
end

function OnCityCaptureCompleteWarScore(iLoser, bCapital, iX, iY, iVictor, iPop, bConquest)
	if iLoser == 63 or iVictor == 63 or bConquest == false then return end

	local pVictor = Players[iVictor]
	local pLoser = Players[iLoser]
	local bVictorAtWarWithMajor;
	local bLoserAtWarWithMajor;
	
	if pVictor:IsAlive() and not pVictor:IsMinorCiv() then
		local pTeam = Teams[pVictor:GetTeam()]
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
				bVictorAtWarWithMajor = true
				break
			end
		end
	end
	
	if pLoser:IsAlive() and not pLoser:IsMinorCiv() then
		local pTeam = Teams[pLoser:GetTeam()]
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
				bLoserAtWarWithMajor = true
				break
			end
		end
	end
	
	if bVictorAtWarWithMajor then
		local iTeam = pVictor:GetTeam()
		if not PMMM.WarScore[iTeam] then
			PMMM.WarScore[iTeam] = 10
		else
			PMMM.WarScore[iTeam] = PMMM.WarScore[iTeam] + 10
		end
	end
	
	if bLoserAtWarWithMajor then
		local iTeam = pLoser:GetTeam()
		if not PMMM.WarScore[iTeam] then
			PMMM.WarScore[iTeam] = -10
		else
			PMMM.WarScore[iTeam] = PMMM.WarScore[iTeam] - 10
		end
	end
end

--The war score persists until all of your wars are completed. If you start one war, get dragged into another, and finish the first, you still maintain the score.
--To prevent easy CS exploiting, only wars with majors are counted, but any CS casualties WHILE at war with a major will contribute to the score.
function OnPeaceResetWarScore(iTeam1, iTeam2)
	local pTeam1 = Teams[iTeam1]
	local pTeam2 = Teams[iTeam2]
	
	local bTeam1AtWar = false
	local bTeam2AtWar = false
	
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pLoop = Players[i]
		if pTeam1:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
			bTeam1AtWar = true
		end
		if pTeam2:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
			bTeam2AtWar = true
		end
	end
	
	if not bTeam1AtWar then
		PMMM.WarScore[iTeam1] = 0
	end
	
	if not bTeam2AtWar then
		PMMM.WarScore[iTeam2] = 0
	end
end

function OnTurnResetWarScore(iPlayer)
	local pTeam = Teams[Players[iPlayer]:GetTeam()]
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local iLoopTeam = Players[i]:GetTeam()
		if pTeam:IsAtWar(iLoopTeam) then
			return
		end
	end
	--If not at war with any majors, reset the score
	PMMM.WarScore[pTeam:GetID()] = 0
end


----------------------------------------------------------------------------------------------------------------------------
-- FOUGHT NEAR LEADER (suggested by emeralis)
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_FOUGHT_NEAR_LEADER"]
local iNearLeaderID = row.ID
t_MoodMods[iNearLeaderID] = {}
t_MoodMods[iNearLeaderID].Value = row.Value
t_MoodMods[iNearLeaderID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		if MagicalGirls[iMGKey].FoughtNearLeaderTurn then
			local iTurnsSinceLastNearLeader = Game:GetGameTurn() - MagicalGirls[iMGKey].FoughtNearLeaderTurn
			local iThreshold = t_MoodMods[iNearLeaderID].Decay
			if iTurnsSinceLastNearLeader < iThreshold then
				iVal = t_MoodMods[iNearLeaderID].Value
			end
		end
		return iVal
	end
)
t_MoodMods[iNearLeaderID].Desc = row.Description
t_MoodMods[iNearLeaderID].PosTT = row.PositiveTooltip
t_MoodMods[iNearLeaderID].NegTT = row.NegativeTooltip
t_MoodMods[iNearLeaderID].Max = row.MaxValue
t_MoodMods[iNearLeaderID].Decay = math.floor(row.Turns * iGameSpeedMod)


function OnCombatEndedDidMGFightNearLeader(iAttackingPlayer, iAttackingUnit, attackerDamage, attackerFinalDamage, attackerMaxHP, iDefendingPlayer, iDefendingUnit, defenderDamage, defenderFinalDamage, defenderMaxHP, iInterceptingPlayer, iInterceptingUnit, interceptorDamage, plotX, plotY)
	local pAttackingPlayer = Players[iAttackingPlayer]
	if pAttackingPlayer then
		local pAttackingUnit = pAttackingPlayer:GetUnitByID(iAttackingUnit)
		if pAttackingUnit and pAttackingUnit:GetCurrHitPoints() > 0 and pAttackingUnit:GetUnitClassType() == iMagicalGirlClass then
			local iMGKey = GetMagicalGirlKey(iAttackingPlayer, iAttackingUnit)
			if iMGKey then
				--Iterating over the MG table may be faster than doing a PlotAreaSpiralIterator.
				for iLoopKey, tMGData in pairs(MagicalGirls) do
					if tMGData.IsLeader and tMGData.Owner == iAttackingPlayer then
						local _, pLeader = RetrieveMGPointers(iLoopKey)
						if pLeader and pLeader ~= pAttackingUnit and Map.PlotDistance(pLeader:GetX(), pLeader:GetY(), pAttackingUnit:GetX(), pAttackingUnit:GetY()) <= 2 then
							MagicalGirls[iMGKey].FoughtNearLeaderTurn = Game:GetGameTurn()
						end
					end
				end
			end
		end
	end
	
	local pDefendingPlayer = Players[iDefendingPlayer]
	if pDefendingPlayer then
		local pDefendingUnit = pDefendingPlayer:GetUnitByID(iDefendingUnit)
		if pDefendingUnit and pDefendingUnit:GetCurrHitPoints() > 0 and pDefendingUnit:GetUnitClassType() == iMagicalGirlClass then
			local iMGKey = GetMagicalGirlKey(iDefendingPlayer, iDefendingUnit)
			if iMGKey then
				--Iterating over the MG table may be faster than doing a PlotAreaSpiralIterator.
				for iLoopKey, tMGData in pairs(MagicalGirls) do
					if tMGData.IsLeader and tMGData.Owner == iDefendingPlayer then
						local _, pLeader = RetrieveMGPointers(iLoopKey)
						if pLeader and pLeader ~= pDefendingUnit and Map.PlotDistance(pLeader:GetX(), pLeader:GetY(), pDefendingUnit:GetX(), pDefendingUnit:GetY()) <= 2 then
							MagicalGirls[iMGKey].FoughtNearLeaderTurn = Game:GetGameTurn()
						end
					end
				end
			end
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- EMOTIONAL ABUSE (Incubators)
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_QB_EMOTIONAL_ABUSE"]
local iEmoAbuseID = row.ID
t_MoodMods[iEmoAbuseID] = {}
t_MoodMods[iEmoAbuseID].Value = row.Value
t_MoodMods[iEmoAbuseID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal;
		if MagicalGirls[iMGKey].EmotionalAbuses then
			iVal = math.min(#MagicalGirls[iMGKey].EmotionalAbuses * t_MoodMods[iEmoAbuseID].Value, t_MoodMods[iEmoAbuseID].Max)
		else
			iVal = 0
		end

		return -iVal
	end
)
t_MoodMods[iEmoAbuseID].Accumulator = (
	function(iMGKey, pPlayer, pUnit)
		if MagicalGirls[iMGKey].EmotionalAbuses then
			for i = #MagicalGirls[iMGKey].EmotionalAbuses, 1, -1 do
				if MagicalGirls[iMGKey].EmotionalAbuses[i] + t_MoodMods[iEmoAbuseID].Decay <= Game:GetGameTurn() then
					table.remove(MagicalGirls[iMGKey].EmotionalAbuses, i)
				end
			end
		end
	end
)
t_MoodMods[iEmoAbuseID].Desc = row.Description
t_MoodMods[iEmoAbuseID].PosTT = row.PositiveTooltip
t_MoodMods[iEmoAbuseID].NegTT = row.NegativeTooltip
t_MoodMods[iEmoAbuseID].Max = row.MaxValue
t_MoodMods[iEmoAbuseID].Decay = math.floor(row.Turns * iGameSpeedMod)



----------------------------------------------------------------------------------------------------------------------------
-- POPULATION (Kyouko trait)
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_TRAIT_POPULATION"]
local iPopTraitID = row.ID
t_MoodMods[iPopTraitID] = {}
t_MoodMods[iPopTraitID].Value = row.Value
t_MoodMods[iPopTraitID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iPlayer = pPlayer:GetID()
		if MapModData.gPMMMTraits[iPlayer] and MapModData.gPMMMTraits[iPlayer].PopulationMoodBonus ~= 0 then
			return pPlayer:GetTotalPopulation() * MapModData.gPMMMTraits[iPlayer].PopulationMoodBonus * t_MoodMods[iPopTraitID].Value
		else
			return 0
		end
	end
)
t_MoodMods[iPopTraitID].Desc = row.Description
t_MoodMods[iPopTraitID].PosTT = row.PositiveTooltip
t_MoodMods[iPopTraitID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- BROKEN PSYCHE (Ultimate Madoka penalty if MG's Witch is killed)
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_TRAIT_BROKEN_PSYCHE"]
local iBrokenPsycheID = row.ID
t_MoodMods[iBrokenPsycheID] = {}
t_MoodMods[iBrokenPsycheID].Value = row.Value
t_MoodMods[iBrokenPsycheID].Func = (
	function(iMGKey, pPlayer, pUnit)
		if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_PMMM_BROKEN_PSYCHE) then
			return -t_MoodMods[iBrokenPsycheID].Value
		else
			return 0
		end
	end
)
t_MoodMods[iBrokenPsycheID].Desc = row.Description
t_MoodMods[iBrokenPsycheID].NegTT = row.NegativeTooltip
t_MoodMods[iBrokenPsycheID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- AI HANDICAP
----------------------------------------------------------------------------------------------------------------------------
local iHandicap = Game:GetHandicapType()

row = GameInfo.MG_MoodModifiers["MGMOODMOD_AI_HANDICAP"]
local iHandicapID = row.ID
t_MoodMods[iHandicapID] = {}
t_MoodMods[iHandicapID].Value = row.Value
t_MoodMods[iHandicapID].Func = (
	function(iMGKey, pPlayer, pUnit)
		if pPlayer:IsHuman() then
			return 0
		else
			return t_MoodMods[iHandicapID].Value * iHandicap
		end
	end
)
t_MoodMods[iHandicapID].Desc = row.Description
t_MoodMods[iHandicapID].NegTT = row.NegativeTooltip
t_MoodMods[iHandicapID].Max = row.MaxValue


----------------------------------------------------------------------------------------------------------------------------
-- INADEQUACY
----------------------------------------------------------------------------------------------------------------------------
row = GameInfo.MG_MoodModifiers["MGMOODMOD_INADEQUACY"]
local iInadequacyID = row.ID
t_MoodMods[iInadequacyID] = {}
t_MoodMods[iInadequacyID].Value = row.Value
t_MoodMods[iInadequacyID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		if not MagicalGirls[iMGKey].IsLeader then
			if Game:GetGameTurn() - MagicalGirls[iMGKey].TurnCreated >= t_MoodMods[iInadequacyID].Turns then
				local iHighestLevel = 1
				for k, v in pairs(MagicalGirls) do
					if k ~= iMGKey and v.Owner == pPlayer:GetID() and v.Status == GameInfoTypes.MGACTIONSTATE_ACTIVE then
						if not v.IsLeader and v.Level and v.Level > iHighestLevel then
							iHighestLevel = v.Level
						end
					end
				end
				if iHighestLevel - 1 > pUnit:GetLevel() then
					iVal = -75
				end
			end
		end
		return iVal;
	end
)
t_MoodMods[iInadequacyID].Desc = row.Description
t_MoodMods[iInadequacyID].NegTT = row.NegativeTooltip
t_MoodMods[iInadequacyID].Max = row.MaxValue
t_MoodMods[iInadequacyID].Turns =  math.floor(iGameSpeedMod * row.Turns)


----------------------------------------------------------------------------------------------------------------------------
-- RESTLESSNESS
----------------------------------------------------------------------------------------------------------------------------

row = GameInfo.MG_MoodModifiers["MGMOODMOD_RESTLESSNESS"]
local iRestlessnessID = row.ID
t_MoodMods[iRestlessnessID] = {}
t_MoodMods[iRestlessnessID].Value = row.Value
t_MoodMods[iRestlessnessID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0
		if not MagicalGirls[iMGKey].LastCombatTurn then MagicalGirls[iMGKey].LastCombatTurn = Game:GetGameTurn() end
		local iTurnsSinceLastCombat = Game:GetGameTurn() - MagicalGirls[iMGKey].LastCombatTurn
		local iThreshold = t_MoodMods[iRestlessnessID].Turns
		if iTurnsSinceLastCombat >= iThreshold then
			iTurnsSinceLastCombat = iTurnsSinceLastCombat - iThreshold
			iVal = math.min(iTurnsSinceLastCombat * t_MoodMods[iRestlessnessID].Value, t_MoodMods[iRestlessnessID].Max)
		end
		return -iVal
	end
)
t_MoodMods[iRestlessnessID].Desc = row.Description
t_MoodMods[iRestlessnessID].PosTT = row.PositiveTooltip
t_MoodMods[iRestlessnessID].NegTT = row.NegativeTooltip
t_MoodMods[iRestlessnessID].Max = row.MaxValue
t_MoodMods[iRestlessnessID].Turns = math.floor(iGameSpeedMod * row.Turns)



----------------------------------------------------------------------------------------------------------------------------
-- ADD MOODMODS FROM OTHER MODS
-- Uses include statements for the ExternalScript value of the MGMoodModifier in the database.
----------------------------------------------------------------------------------------------------------------------------

row = nil
for row in GameInfo.MG_MoodModifiers() do
	if not t_MoodMods[row.ID] then
		if row.ExternalScript then
			include(row.ExternalScript)
		end
	end
end