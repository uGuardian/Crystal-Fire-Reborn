-- PMMM Trait Bootstrapper
-- Author: Vicevirtuoso
-- DateCreated: 6/12/2014 12:35:21 PM
--------------------------------------------------------------

--This file loads trait scripts, but ONLY if a Civ with the trait in question is in the game.
--Why run trait scripts for Civs not in the game?


include('PMMMGeneralFunctions.lua');

bIsMadoka = false; --currently not used since Madoka's working trait uses only XML
bIsHomura = false; --no longer used as of v27; her trait is handled in the core workings of the MG system
bIsSayaka = false;
bIsMami = false;
bIsKyouko = false;
bIsNagisa = false;
bIsUMadoka = false; 
bIsDHomura = false;
bIsPleiades = false;
bIsShirome = false;
bIsGustavus = false;

bMulti = Game.IsNetworkMultiPlayer()

for iPlayer, pTrait in pairs(MapModData.gPMMMTraits) do
	if not bIsSayaka then
		if MapModData.gPMMMTraits[iPlayer].GreatPersonProgressFromKills or MapModData.gPMMMTraits[iPlayer].CombatBonusFromTourismInfluence == 1 then
			print("Loading Sayaka's trait script.")
			include('PMMMSayakaTrait.lua');
			bIsSayaka = true;
		end
	end
	if not bIsMami then
		if MapModData.gPMMMTraits[iPlayer].CityStateCombatStrengthModTimes100 > 0 or MapModData.gPMMMTraits[iPlayer].MagicalGirlRelationshipModifier ~= 0 then
			print("Loading Mami's trait script.")
			include('PMMMMamiTrait.lua');
			bIsMami = true;
		end
	end
	if not bIsKyouko then
		if MapModData.gPMMMTraits[iPlayer].MaxStolenFood > 0 then
			print("Loading Kyouko's trait script.")
			include('PMMMKyoukoTrait.lua');
			bIsKyouko = true;
		end
	end
	if not bIsNagisa then
		for row in GameInfo.Trait_PMMM_GoldenAgeResourceSpread() do
			if row.TraitType == MapModData.gPMMMTraits[iPlayer].Type then
				if row.ResourceType and row.ProbabilityPerTurn > 0 then
					print("Loading Nagisa's trait script.")
					include('PMMMNagisaTrait.lua');
					bIsNagisa = true;
					break
				end
			end
		end
	end
	if not bIsUMadoka then
		if MapModData.gPMMMTraits[iPlayer].NoWitches == true or MapModData.gPMMMTraits[iPlayer].NoWitches == 1 or MapModData.gPMMMTraits[iPlayer].NoWitches == 1 then
			print("Loading Ultimate Madoka's trait script.")
			include('PMMMUltimateMadokaTrait.lua');
			bIsUMadoka = true;
		end
	end
	if not bIsDHomura then
		if MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == true or MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == 1 or MapModData.gPMMMTraits[iPlayer].CapitalBonusPerKilledMagicalGirl > 0 or MapModData.gPMMMTraits[iPlayer].MagicalGirlAttrition > 0 then
			print("Loading Demon Homura's trait script.")
			include('PMMMDemonHomuraTrait.lua');
			bIsDHomura = true;
		end
	end
	if not bIsPleiades then
		if MapModData.gPMMMTraits[iPlayer].EnableFreezerSystem == 1 then
			print("Loading The Pleiades' trait script.")
			include('PMMMPleiadesTrait.lua');
			bIsPleiades = true;
		end
	end
	if not bIsShirome then
		if MapModData.gPMMMTraits[iPlayer].LeaderMGUniqueMission then
			print("Loading Shirome's trait script.")
			include('PMMMShiromeTrait.lua');
			bIsShirome = true;
		end
	end
	if not bIsGustavus then
		for row in GameInfo.Trait_PMMM_PromotionAdjacentUnitCombats() do
			if row.TraitType == MapModData.gPMMMTraits[iPlayer].Type then
				if row.PromotionType and row.AdjacentDifferentUnitCombatsRequired > 0 then
					print("Loading Gustavus Adolphus's trait script.")
					include('PMMMGustavusTrait.lua');
					bIsGustavus = true;
					break
				end
			end
		end
	end
end


function OnDoTurnRunTraitScripts(iPlayer)
	if iPlayer < iMaxCivs then
		if bIsKyouko then
			OnDoTurnStolenFoodPillageUpkeep(iPlayer)
			if not Players[iPlayer]:IsHuman() then
				AIStolenFoodCheck(iPlayer)
			end
		end
		if bIsMami then
			CityStateCombatStrengthUp(iPlayer)
		end
		if bIsSayaka then
			OnTurnTourismPromotionUpdate(iPlayer)
		end
		if bIsNagisa then
			NagisaGoldenAge(iPlayer)
		end
		if bIsUMadoka then
			CheckLOCMagicalGirls(iPlayer)
			WitchCooldownUpkeep(iPlayer)
		end
		if bIsDHomura then
			DemonHomuraOnTurnFunctions(iPlayer)
		end
		if bIsGustavus then
			OnTurnGustavusTrait(iPlayer)
		end
		if bIsShirome then
			OnPlayerDoTurnShiromeTrait(iPlayer)
		end
		if bIsPleiades then
			OnPleiadesDoTurn(iPlayer)
		end
	end
end

function OnSetXYRunTraitScripts(iPlayer, iUnit)
	if iPlayer < iMaxCivs then
		if bIsGustavus then
			OnMoveGustavusTrait(iPlayer, iUnit)
		end
		if bIsSayaka then
			OnMoveTourismPromotionUpdate(iPlayer, iUnit)
		end
	end
end

function OnUnitKilledInCombatRunTraitScripts(iKiller, iKilled, iKilledUnit)
	if iKiller < iMaxCivs then
		if bIsSayaka then
			GreatPersonProgressFromKills(iKiller, iKilled, iKilledUnit)
		end
	end
end

function OnTileImprovementChangedRunTraitScripts(iPlotX, iPlotY, iOwner, iOldImprovement, iNewImprovement, bPillaged)
	if bIsKyouko then
		AddStolenFoodFromImprovement(iPlotX, iPlotY, iOwner, iOldImprovement, iNewImprovement, bPillaged)
	end
end

function OnCustomMissionPossibleRunTraitScripts(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local bReturn
	if bIsKyouko then
		bReturn = OnKyoukoCustomMission1Possible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	end
	if bIsUMadoka and not bReturn then
		bReturn = SummonWitchCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	end
	return bReturn
end

function OnCustomMissionStartRunTraitScripts(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	local bReturn
	if bIsKyouko then
		bReturn = OnKyoukoCustomMission1Start(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	end
	if bIsUMadoka then
		bReturn = SummonWitchCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	end
	if bIsPleiades and bMulti then
		bReturn = FreezerCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
		bReturn = FreezerGriefSeedCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	end
	return bReturn
end

function OnCustomMissionCompletedRunTraitScripts(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	local bReturn
	if bIsKyouko then
		bReturn = OnKyoukoCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	end
	if bIsUMadoka then
		bReturn = SummonWitchCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	end
	return bReturn
end

function OnPlayerPlunderedTradeRouteRunTraitScripts(iPlayer, iUnit, iPlunderedGold, iFromPlayer, iFromCity, iToPlayer, iToCity, iRouteType, iRouteDomain)
	if bIsKyouko then
		AddStolenFoodFromSacking(iPlayer, iUnit)
	end
end

function OnPrekillRunTraitScripts(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	if bIsUMadoka then
		UMadokaOnWitchOrMGDeath(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	end
	if bIsDHomura then
		DemonHomuraDirectKill(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	end
end

function OnPromotedRunTraitScripts(iPlayer, iUnit)
	if bIsDHomura then
		OnPromotedToLevel5(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	end
end

function OnCombatEndedRunTraitScripts(iAttackingPlayer, iAttackingUnit, attackerDamage, attackerFinalDamage, attackerMaxHP, iDefendingPlayer, iDefendingUnit, defenderDamage, defenderFinalDamage, defenderMaxHP, iInterceptingPlayer, iInterceptingUnit, interceptorDamage, plotX, plotY)
	if bIsDHomura then
		DemonHomuraDirectKill(iAttackingPlayer, iAttackingUnit, attackerDamage, attackerFinalDamage, attackerMaxHP, iDefendingPlayer, iDefendingUnit, defenderDamage, defenderFinalDamage, defenderMaxHP, iInterceptingPlayer, iInterceptingUnit, interceptorDamage, plotX, plotY)
	end
	if bIsPleiades then
		PleiadesOnCombatEnded(iAttackingPlayer, iAttackingUnit, attackerDamage, attackerFinalDamage, attackerMaxHP, iDefendingPlayer, iDefendingUnit, defenderDamage, defenderFinalDamage, defenderMaxHP, iInterceptingPlayer, iInterceptingUnit, interceptorDamage, plotX, plotY)
	end	
end

function OnCityCaptureRunTraitScripts(iCapturedPlayer, bCapital, iX, iY, iCapturingPlayer, bConquest)
	if bIsPleiades then
		OnPleiadesCityCapture(iCapturedPlayer, bCapital, iX, iY, iCapturingPlayer, bConquest)
	end
end

function OnLoadScreenCloseRunTraitScripts()
	if bIsShirome then
		OnLoadScreenCloseShiromeTrait()
	end
end

if bIsDHomura then
	LuaEvents.PMMMSetNumDemonHomuraBuildings.Add(SetNumDemonHomuraBuildings)
	LuaEvents.CityInfoStackDataRefresh.Add(DHCityInfoStackDataRefresh)
	LuaEvents.CityInfoStackDirty.Add(DHCityInfoStackDirty)
end