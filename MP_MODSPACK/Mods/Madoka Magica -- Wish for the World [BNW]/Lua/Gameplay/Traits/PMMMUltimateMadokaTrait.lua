-- PMMMUltimateMadokaTrait
-- Author: Vicevirtuoso
-- DateCreated: 7/2/2014 12:58:04 PM
--------------------------------------------------------------



local iMissionType = MissionTypes.MISSION_PMMM_SUMMON_WITCH
local iMissionType2 = MissionTypes.MISSION_PMMM_DISMISS_WITCH

local iMagicalGirl = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL
local iWitch = GameInfoTypes.UNIT_PMMM_WITCH

local iBrokenPsyche = GameInfoTypes.PROMOTION_PMMM_BROKEN_PSYCHE
local iNoXPPromo = GameInfoTypes.PROMOTION_PMMM_WITCH_NO_XP

function CheckLOCMagicalGirls(iPlayer)
	if iPlayer < iMaxCivs and MapModData.gPMMMTraits[iPlayer].NoWitches == true or MapModData.gPMMMTraits[iPlayer].NoWitches == 1 then
		for k, v in pairs(MagicalGirls) do
			if v.Owner == iPlayer and v.Status == GameInfoTypes.MGACTIONSTATE_CYCLING then
				local iCurTurn = Game:GetGameTurn()
				if	(iCurTurn - v.CycleStartTurn) >= MapModData.gPMMMLawOfCyclesTurns then
					ReturnFromLawOfCycles(k)
				end
			end
		end
	end
end




function SummonWitchCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if MapModData.gPMMMTraits[iPlayer].CanSummonWitches == 1 then
			if iMission == iMissionType and pUnit:GetUnitType() == iMagicalGirl then
				local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
				if not MagicalGirls[iMGKey].SummonedWitch and not MagicalGirls[iMGKey].SummonedWitchCooldown then
					return true
				else
					return bTestVisible
				end
			elseif iMission == iMissionType2 and pUnit:GetUnitType() == iWitch then
				return true
			end
		end
	end
	return false
end


function SummonWitchCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType and iPlayer == Game:GetActivePlayer() then
		DoSummonWitch(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), Map.GetPlot(-iData1, -iData2))
	elseif iMission == iMissionType2 then
		DoUnsummonWitch(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	end
	return 0
end


function SummonWitchCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iPlayer == Game:GetActivePlayer() then
		if iMission == iMissionType or iMission == iMissionType2 then
			return true
		end
	end
	return false
end


function DoSummonWitch(iPlayer, pUnit, pPlot)
	local pPlayer = Players[iPlayer]
	local iMGKey = GetMagicalGirlKey(iPlayer, pUnit:GetID())
	local eWitch = pPlayer:InitUnit(iWitch, pPlot:GetX(), pPlot:GetY(), UNITAI_ATTACK)
	MagicalGirls[iMGKey].SummonedWitch = GetUnitSpecialID(iPlayer, eWitch:GetID())
	eWitch:SetName(Locale.ConvertTextKey(pUnit:GetNameNoDesc())..Locale.ConvertTextKey("TXT_KEY_PMMM_WITCH_NAME_APPEND"))
	eWitch:SetBaseCombatStrength(MapModData.gPMMMWitchEraStrengths[pPlayer:GetCurrentEra()])
	eWitch:SetHasPromotion(iNoXPPromo, true)
	pUnit:SetMoves(0)
	eWitch:SetMoves(0)
end


function DoUnsummonWitch(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	print("DoUnsummonWitch called")
	local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
	local iMGKey;
	for k, v in pairs(MagicalGirls) do
		if v.SummonedWitch == iSpecialID then
			iMGKey = k
			break
		end
	end
	if iMGKey then
		MagicalGirls[iMGKey].SummonedWitch = nil
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		pUnit:Kill(true)
		MagicalGirls[iMGKey].SummonedWitchCooldown = 10
	end
end


--This function not only does the Witch Cooldown, but will handle AI logic to summon Witches (they will only do so during war)
function WitchCooldownUpkeep(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local bAIAtWar;
		local pTeam = Teams[pPlayer:GetTeam()]
		--only run the AI logic if it's at war with a major
		if not pPlayer:IsHuman() then
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pLoop = Players[i]
				if i ~= iPlayer and pLoop:IsAlive() and pTeam:IsAtWar(pLoop:GetTeam()) then
					bAIAtWar = true
					break
				end
			end
		end
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL then
				local iMGKey = GetMagicalGirlKey(iPlayer, pUnit:GetID())
				if MagicalGirls[iMGKey] and MagicalGirls[iMGKey].SummonedWitchCooldown then
					MagicalGirls[iMGKey].SummonedWitchCooldown = MagicalGirls[iMGKey].SummonedWitchCooldown - 1
					if MagicalGirls[iMGKey].SummonedWitchCooldown == 0 then
						MagicalGirls[iMGKey].SummonedWitchCooldown = nil
						pUnit:SetHasPromotion(iBrokenPsyche, false)
					end
				end
				if not pPlayer:IsHuman() then
					--AI Logic: If not already summoned, then check if at war with a major and has at least 75% Soul Gem. If so, summon the Witch in a nearby plot (if one is available)
					if MagicalGirls[iMGKey] and not MagicalGirls[iMGKey].SummonedWitch and not MagicalGirls[iMGKey].SummonedWitchCooldown and MapModData.gPMMMTraits[iPlayer].CanSummonWitches == 1 then
						if bAIAtWar and MagicalGirls[iMGKey].SoulGem >= 75 then
							for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), GameInfo.Missions[iMissionType].PMMMMissionRange, 1, false, false, false) do
								if not pAreaPlot:IsUnit() and not pAreaPlot:IsCity() and not pAreaPlot:IsImpassable() and not pAreaPlot:IsMountain() and not pAreaPlot:IsWater() then
									local iOwner = pAreaPlot:GetOwner()
									if iOwner == pUnit:GetOwner() or iOwner < 0 then
										DoSummonWitch(iPlayer, pUnit, pAreaPlot)
										break
									elseif pTeam:IsAtWar(Players[iOwner]:GetTeam()) or pPlayer:IsPlayerHasOpenBorders(iOwner) then
										DoSummonWitch(iPlayer, pUnit, pAreaPlot)
										break
									end
								end
							end
						end
					end
				end
			elseif pUnit:GetUnitType() == GameInfoTypes.UNIT_PMMM_WITCH and not pPlayer:IsHuman() then
				--Unsummon the Witch if:
				-- Not at war
				-- It has less than 25 HP without a promotion available to use Insta Heal
				-- AND/OR Its owner has 30% or less Soul Gem
				if (pUnit:GetCurrHitPoints() <= 25 and not pUnit:IsPromotionReady()) or not bAIAtWar then
					DoUnsummonWitch(iPlayer, pUnit:GetID())
				else
					local iSpecialID = GetUnitSpecialID(iPlayer, pUnit:GetID())
					local iMGKey;
					for k, v in pairs(MagicalGirls) do
						if v.SummonedWitch == iSpecialID then
							iMGKey = k
							break
						end
					end
					if iMGKey then
						if MagicalGirls[iMGKey].SoulGem <= 30 then
							DoUnsummonWitch(iPlayer, pUnit:GetID())
						end
					end
				end
			end
		end
	end
end

function UMadokaOnWitchOrMGDeath(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	if iPlayer < iMaxCivs and MapModData.gPMMMTraits[iPlayer].CanSummonWitches == 1 and bDelay == false then
		if iUnitType == iMagicalGirl then
			local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
			if MagicalGirls[iMGKey].SummonedWitch then
				local pWitch = ReturnUnitFromSpecialID(MagicalGirls[iMGKey].SummonedWitch)
				pWitch:Kill(true)
			end
		elseif iUnitType == iWitch then
			local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
			for k, v in pairs(MagicalGirls) do
				if v.SummonedWitch == iSpecialID then
					local iMGKey = k
					local pPlayer, pUnit = RetrieveMGPointers(iMGKey)
					if pUnit then
						--Does 25 Damage, but this can never kill the MG directly.
						pUnit:ChangeDamage(math.min(50, pUnit:GetCurrHitPoints() - 1))
						--Does half of the current Soul Gem rating worth of "damage" to the SG percentage
						local iCorruption = v.SoulGem - math.ceil(v.SoulGem / 2)
						DoChangeCorruption(iCorruption, k)
						pUnit:SetHasPromotion(iBrokenPsyche, true)
						MagicalGirls[iMGKey].SummonedWitch = nil
						MagicalGirls[iMGKey].SummonedWitchCooldown = 10
						SetSoulGemState(iMGKey)
						if iPlayer == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_UMADOKA_WITCH_DIED", pUnit:GetNameNoDesc()))
						end
					end
				end
			end
		end
	end
end