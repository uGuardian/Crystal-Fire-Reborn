-- Lua Script1
-- Author: Paul Durant
-- DateCreated: 7/13/2013 4:25:00 AM
--------------------------------------------------------------
function InitYuuka()
	 for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local player = Players[iPlayer];
		if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MUGENKAN"] then
			print("Gensokyo's Sleeping Terror has awakened!")
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(GameInfoTypes["POLICY_LOTUS_LAND_SOVEREIGN"], true)
		end
    end
end	

InitYuuka()