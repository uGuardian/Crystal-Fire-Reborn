-- Rosebow Infantry
-- Author: Vicevirtuoso
-- DateCreated: 6/13/2014 1:45:41 AM
--------------------------------------------------------------



include('PMMMGeneralFunctions.lua');

function GrantNewPromotionOnImprovement(iPlayer, iUnit)
	if iPlayer < iMaxCivs then
		dprint("GrantNewPromotionOnImprovement called")
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit then
			dprint(pUnit:GetID())
			for k, v in pairs(MapModData.gPMMMOnImprovementPromotions) do
				dprint("Test promotionID " ..k)
				if pUnit:IsHasPromotion(k) then
					dprint("Has promotion")
					local pPlot = pUnit:GetPlot()
					dprint(pPlot:GetX()..", "..pPlot:GetY())
					if pPlot:GetImprovementType() == v.ImprovementType then
						dprint("Is on improvement, grant promotion")
						pUnit:SetHasPromotion(v.NewPromotionType, true)
					else
						dprint("Not on improvement, remove promotion")
						pUnit:SetHasPromotion(v.NewPromotionType, false)
					end
				else
					dprint("Does not have promotion")
					pUnit:SetHasPromotion(v.NewPromotionType, false)
				end
			end
		end
	end
end


function GrantNewPromotionInCity(iPlayer, iUnit)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit then
			for k, v in pairs(MapModData.gPMMMInCityPromotions) do
				if pUnit:IsHasPromotion(k) then
					if pUnit:GetPlot():IsCity() then
						pUnit:SetHasPromotion(v, true)
					else
						pUnit:SetHasPromotion(v, false)
					end
				else
					pUnit:SetHasPromotion(v, false)
				end
			end
		end
	end
end
