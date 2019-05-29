-- Tiro Musketeer
-- Author: Vicevirtuoso
-- DateCreated: 6/19/2014 7:06:29 PM
--------------------------------------------------------------

local iPromotion = GameInfoTypes.PROMOTION_PMMM_TIRO_MUSKETEER
local iRangePromotion = GameInfoTypes.PROMOTION_PMMM_TIRO_MUSKETEER_READY
local iDefenseReduction = GameInfoTypes.PROMOTION_PMMM_TIRO_MUSKETEER_DEBUFF
local iMissionType = MissionTypes.MISSION_PMMM_TIRO_FINALE

function TiroFinaleCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		--lazy and specifying one promotion for now
		if pUnit:IsHasPromotion(iPromotion) and iMission == iMissionType then
			return true
		end
	end
	return false
end


function TiroFinaleCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType then
		DoTiroFinale(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), Map.GetPlot(-iData1, -iData2))
	end
	return 0
end

function TiroFinaleCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType then
		return true
	end
	return false
end

function DoTiroFinale(iPlayer, pHeadUnit, pPlot)
	print("Tiro Finale called")
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]
	local iNumUnits = pPlot:GetNumUnits();
	local pThisPlot = pHeadUnit:GetPlot()
	
	--We currently (and likely will only have) one Tiro Finale promotion since I'm lazy.
	local iMultiplier = GameInfo.UnitPromotions[iPromotion].TiroFinaleStrength / 100
	print("Tiro Finale strength: " ..iMultiplier)
	local iStrength;

	local bThisPlotDamaged = false
	-- Loop through Units to find the first Combat unit. If no Combat unit is found, loop again and do the damage to the first non-combat unit.
	for i = 0, iNumUnits do
		pUnit = pPlot:GetUnit(i);
		if (pUnit ~= nil and not pUnit:IsInvisible(iTeam, false)) then
			 if (pUnit:GetBaseCombatStrength() > 0 or pHeadUnit:IsRanged()) then
				if (pTeam:IsAtWar(pUnit:GetTeam()) or (UIManager:GetAlt() and pUnit:GetOwner() ~= iTeam)) then
					print("Found valid target")
					iStrength = math.floor(pHeadUnit:GetMaxAttackStrength(pThisPlot, pPlot, pUnit) * iMultiplier)
					print("iStrength: " ..iStrength)
					InflictTiroFinaleDamage(pHeadUnit, pUnit, pPlot, iStrength)
					bThisPlotDamaged = true
					break
				end
			end
		end
	end
	if not bThisPlotDamaged then
		for i = 0, iNumUnits do
			pUnit = pPlot:GetUnit(i);
			if (pUnit ~= nil and not pUnit:IsInvisible(iTeam, false)) then
				if (pTeam:IsAtWar(pUnit:GetTeam()) or (UIManager:GetAlt() and pUnit:GetOwner() ~= iTeam)) then
				print("Found valid target")
					iStrength = math.floor(pHeadUnit:GetMaxAttackStrength(pThisPlot, pPlot, pUnit) * iMultiplier)
					print("iStrength: " ..iStrength)
					InflictTiroFinaleDamage(pHeadUnit, pUnit, pPlot, iStrength)
					break
				end
			end
		end
	end
	
	--Now do the same for all adjacent plots. Adjacent plots are attacked with only half of the strength which hit the focal plot.
	for pAreaPlot in PlotAreaSpiralIterator(pPlot, 1, 1, true, true, false) do
		bThisPlotDamaged = false
		iNumUnits = pAreaPlot:GetNumUnits()
		for i = 0, iNumUnits do
			pUnit = pAreaPlot:GetUnit(i);
			if (pUnit ~= nil and not pUnit:IsInvisible(iTeam, false)) then
				 if (pUnit:GetBaseCombatStrength() > 0 or pHeadUnit:IsRanged()) then
					if (pTeam:IsAtWar(pUnit:GetTeam()) or (UIManager:GetAlt() and pUnit:GetOwner() ~= iTeam)) then
					print("Found valid target")
						iStrength = math.floor((pHeadUnit:GetMaxAttackStrength(pThisPlot, pPlot, pUnit) * iMultiplier) / 2)
						print("iStrength: " ..iStrength)
						InflictTiroFinaleDamage(pHeadUnit, pUnit, pAreaPlot, iStrength)
						bThisPlotDamaged = true
						break
					end
				end
			end
		end
		if not bThisPlotDamaged then
			for i = 0, iNumUnits do
				pUnit = pAreaPlot:GetUnit(i);
				if (pUnit ~= nil and not pUnit:IsInvisible(iTeam, false)) then
					if (pTeam:IsAtWar(pUnit:GetTeam()) or (UIManager:GetAlt() and pUnit:GetOwner() ~= iTeam)) then
					print("Found valid target")
						iStrength = math.floor((pHeadUnit:GetMaxAttackStrength(pThisPlot, pPlot, pUnit) * iMultiplier) / 2)
						print("iStrength: " ..iStrength)
						InflictTiroFinaleDamage(pHeadUnit, pUnit, pAreaPlot, iStrength)
						break
					end
				end
			end
		end
	end
	
	pHeadUnit:ChangeExperience(5)
	pHeadUnit:SetMoves(0)
	pHeadUnit:SetHasPromotion(iDefenseReduction, true)
	CleanMissionInfo()
	ClearAllHighlights()
end


function InflictTiroFinaleDamage(pHeadUnit, pUnit, pPlot, iMyStrength)
	print("Tiro Finale damage called")
	local iTheirStrength = 0;
	if (pUnit:IsEmbarked()) then
		iTheirStrength = pUnit:GetEmbarkedUnitDefense();
		print("iTheirStrength: " ..iTheirStrength)
	else
		iTheirStrength = pUnit:GetMaxDefenseStrength(pPlot, pHeadUnit);
		print("iTheirStrength: " ..iTheirStrength)
	end
	
	local iDamage = pHeadUnit:GetCombatDamage(iMyStrength, iTheirStrength, pHeadUnit:GetDamage(), true, false, false)
	print("iDamage: " ..iDamage)
	if iDamage > 100 then
		iDamage = 100
	end
	pUnit:ChangeDamage(iDamage, pHeadUnit:GetOwner())
end


-- Also handles AI logic for using Tiro Finale
function RemoveDefenseDebuff(iPlayer)
	if iPlayer < iMaxCivsAndCS then
		local pPlayer = Players[iPlayer]
		local bAIAtWar;
		--only run the AI logic if it's at war with a major
		if not pPlayer:IsHuman() then
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				if i ~= iPlayer and pPlayer:IsAtWarWith(i) then
					bAIAtWar = true
					break
				end
			end
		end
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(iDefenseReduction) then
				pUnit:SetHasPromotion(iDefenseReduction, false)
			end
			if bAIAtWar and pUnit:IsHasPromotion(iPromotion) then
				-- Do not use if at less than 40 HP due to the defense debuff
				if pUnit:GetCurrHitPoints() >= 40 then
					-- Look through plots in range.
					-- If there is no enemy City in range, always use Tiro Finale if there is a target.
					-- If there IS an enemy City in range, only use Tiro Finale if there are 3 or more nearby enemy Units to take care of first. Otherwise it should act normally and go after the City.
					local bIsCity;
					local iNumEnemyUnits = 0
					local tRange = FindMissionRange(iMissionType, iPlayer, pUnit:GetPlot(), pUnit)
					local iLowestHP = 100
					local pLowestHPUnit;
					for k, v in pairs(tRange) do
						if v.ValidAttackTarget == true then
							local pAreaPlot = Map.GetPlot(v.X, v.Y)
							if pAreaPlot then
								if pAreaPlot:IsCity() then
									if pAreaPlot:GetPlotCity():GetOwner() ~= iPlayer then
										bIsCity = true
									end
								elseif pAreaPlot:IsUnit() then
									for c = 0, pAreaPlot:GetNumUnits() - 1 do
										local pTestUnit = pAreaPlot:GetUnit(c)
										if pTestUnit then
											if pTestUnit:GetOwner() ~= iPlayer and pTestUnit:IsCombatUnit() then
												local iTestUnitHP = pTestUnit:GetCurrHitPoints()
												iNumEnemyUnits = iNumEnemyUnits + 1
												if iTestUnitHP < iLowestHP then
													iLowestHP = iTestUnitHP
													pLowestHPUnit = pTestUnit
													break
												end
											end
										end
									end
								end
							end
						end
					end
					if pLowestHPUnit then
						if not bIsCity then
							DoTiroFinale(iPlayer, pUnit, pLowestHPUnit:GetPlot())
						elseif iNumEnemyUnits >= 3 then
							DoTiroFinale(iPlayer, pUnit, pLowestHPUnit:GetPlot())
						end
					end
				end
			end
		end
	end
end