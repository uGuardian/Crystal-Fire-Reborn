-- PMMMPolicyMovementBonus
-- Author: Vicevirtuoso
-- DateCreated: 11/22/2014 2:06:13 PM
--------------------------------------------------------------

local iLightningWarfare = GameInfoTypes.POLICY_LIGHTNING_WARFARE
local iNavigationSchool = GameInfoTypes.POLICY_NAVIGATION_SCHOOL

local iGeneralClass = GameInfoTypes.UNITCLASS_GREAT_GENERAL
local iAdmiralClass = GameInfoTypes.UNITCLASS_GREAT_ADMIRAL

local iPromotion = GameInfoTypes.PROMOTION_MG_MOVE_BONUS_FROM_POLICY

function MagicalGirlPolicyMovementBonus(iPlayer, iPolicy)
	local iClass;
	if iPolicy == iLightningWarfare then 
		iClass = iGeneralClass
	elseif iPolicy == iNavigationSchool then
		iClass = iAdmiralClass
	else
		return
	end

	for k, v in pairs(MagicalGirls) do
		if v.Owner == iPlayer then
			if v.Class == iClass then
				local _, pUnit = RetrieveMGPointers(k)
				pUnit:SetHasPromotion(iPromotion, true)
			end
		end
	end
end