-- Sayaka Trait Script
-- Author: Vicevirtuoso
-- DateCreated: 8/20/2013 12:04:47 AM
--------------------------------------------------------------


include('PMMMGeneralFunctions.lua');


function GreatPersonProgressFromKills(iKiller, iKilled, iKilledUnit)
	dprint("Sayaka OnKill function called")
	if iKiller == 63 then return end
	local pKiller = Players[iKiller]
	local pKilled = Players[iKilled]
	if not pKiller:IsEverAlive() or not pKilled:IsEverAlive() then return end
	if pKiller:IsMinorCiv() then return end
	dprint("Both civs are majors")
	if Teams[pKiller:GetTeam()]:IsHasTech(GameInfoTypes.TECH_ACOUSTICS) then
	dprint("Killer has discovered acoustics")
		if MapModData.gPMMMTraits[iPlayer] and MapModData.gPMMMTraits[iPlayer].GreatPersonProgressFromKills and GameInfo.Units[iKilledUnit].Combat > 0 then
			dprint("Trait is correct and killed unit has a Combat Str value")
			iSpecialistType = GameInfoTypes[MapModData.gPMMMTraits[iPlayer].GreatPersonProgressFromKills]
			iSpecialistAmount = (math.floor(GameInfo.Units[iKilledUnit].Combat / 10)) * 100
			if ContentManager.IsActive("6DA07636-4123-4018-B643-6575B4EC336B", ContentType.GAMEPLAY) then
				dprint("BNW is active")
				local iBuildingType;
				if iSpecialistType == GameInfoTypes.SPECIALIST_MUSICIAN then
					dprint("Musician")
					iBuildingType = GameInfoTypes.BUILDING_MUSICIANS_GUILD
				elseif iSpecialistType == GameInfoTypes.SPECIALIST_WRITER then
					dprint("Writer")
					iBuildingType = GameInfoTypes.BUILDING_WRITERS_GUILD
				elseif iSpecialistType == GameInfoTypes.SPECIALIST_ARTIST then
					dprint("Artist")
					iBuildingType = GameInfoTypes.BUILDING_ARTISTS_GUILD
				end
				if iBuildingType then
					dprint("Specialist which requires building needed")
					for pCity in pKiller:Cities() do
						dprint("Checking city " ..pCity:GetName())
						if pCity:IsHasBuilding(iBuildingType) then
							pCity:ChangeSpecialistGreatPersonProgressTimes100(iSpecialistType, iSpecialistAmount)
							if iKiller == Game:GetActivePlayer() then
								Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_SAYAKA_BOOST", iSpecialistAmount / 100, pCity:GetName()))
							end
							dprint("Added " ..iSpecialistAmount.. " to Musician's Guild city")
							return
						end
					end
				else
					pKiller:GetCapitalCity():ChangeSpecialistGreatPersonProgressTimes100(iSpecialistType, iSpecialistAmount)
					if iKiller == Game:GetActivePlayer() then
						Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_SAYAKA_BOOST", iSpecialistAmount / 100, pKiller:GetCapitalCity():GetName()))
					end
					return
				end
			else
				pKiller:GetCapitalCity():ChangeSpecialistGreatPersonProgressTimes100(iSpecialistType, iSpecialistAmount)
				if iKiller == Game:GetActivePlayer() then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_SAYAKA_BOOST", iSpecialistAmount / 100, pKiller:GetCapitalCity():GetName()))
				end
			end
		end
	end
end

function OnMoveTourismPromotionUpdate(iPlayer, iUnitID)
	local pPlayer = Players[iPlayer]
    if iPlayer < iMaxCivs and (pPlayer:IsEverAlive()) then
        if MapModData.gPMMMTraits[iPlayer].CombatBonusFromTourismInfluence == 1 or MapModData.gPMMMTraits[iPlayer].CombatBonusFromTourismInfluence == true then
            local pUnit = pPlayer:GetUnitByID(iUnitID);
            UpdateTourismBonusPromotions(pUnit);
        end
    end
end


function OnTurnTourismPromotionUpdate(iPlayer)
	local pPlayer = Players[iPlayer]
    if iPlayer < iMaxCivs and (pPlayer:IsEverAlive()) then
        if MapModData.gPMMMTraits[iPlayer].CombatBonusFromTourismInfluence == 1 or MapModData.gPMMMTraits[iPlayer].CombatBonusFromTourismInfluence == true then
            for pUnit in pPlayer:Units() do
				 UpdateTourismBonusPromotions(pUnit);
			end
        end
    end
end



function UpdateTourismBonusPromotions(pUnit)
    if pUnit and pUnit:GetPlot() and pUnit:IsCombatUnit() then
		local pPlayer = Players[pUnit:GetOwner()];
		local iPlotOwner = pUnit:GetPlot():GetOwner();
		local pPlotOwner = Players[iPlotOwner];
		if (pPlotOwner == nil) then
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_EXOTIC, false)
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_FAMILIAR, false)
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_POPULAR, false)
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_INFLUENTIAL, false)
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_DOMINANT, false)
		else
			if (pPlotOwner == pPlayer or pPlotOwner:IsMinorCiv()) then
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_EXOTIC, false)
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_FAMILIAR, false)
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_POPULAR, false)
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_INFLUENTIAL, false)
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_DOMINANT, false)
		    else
				iInfluenceLevel = pPlayer:GetInfluenceLevel(iPlotOwner);
				dprint("Influence level: " ..iInfluenceLevel)
				if (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_EXOTIC) then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_EXOTIC, true)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_FAMILIAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_POPULAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_INFLUENTIAL, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_DOMINANT, false)
				elseif (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_FAMILIAR) then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_EXOTIC, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_FAMILIAR, true)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_POPULAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_INFLUENTIAL, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_DOMINANT, false)    
				elseif (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_POPULAR) then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_EXOTIC, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_FAMILIAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_POPULAR, true)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_INFLUENTIAL, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_DOMINANT, false)    
				elseif (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_INFLUENTIAL) then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_EXOTIC, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_FAMILIAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_POPULAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_INFLUENTIAL, true)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_DOMINANT, false)    
				elseif (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_DOMINANT) then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_EXOTIC, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_FAMILIAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_POPULAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_INFLUENTIAL, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_DOMINANT, true)     
				else
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_EXOTIC, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_FAMILIAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_POPULAR, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_INFLUENTIAL, false)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_SAYAKA_DOMINANT, false)    
				end
			end
        end
    end    
end