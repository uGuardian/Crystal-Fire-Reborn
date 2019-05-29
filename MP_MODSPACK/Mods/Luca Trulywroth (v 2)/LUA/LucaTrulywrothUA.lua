-- LucaTrulywrothUA
-- Author:LeonAzarola
-- DateCreated: 12/23/2014 6:25:24 PM
--------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- LucaFreliaActive
------------------------------------------------------------------------------------------------------------------------
function LucaFreliaActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end


local civilisationID = GameInfoTypes["CIVILIZATION_FRELIAN"]
local isFreliaCivActive = LucaFreliaActive(civilisationID)
if isFreliaCivActive then
	print("Luca Trulywroth is in this game")
end


----------------------------------------------------------------------------------------------------------------------------
-- FreliaKingdom
--------------------------------------------------------------------------------------------------------------------------
function FreliaKingdom(playerID)
	local player = Players[playerID]
    if (player:IsEverAlive() and player:GetCivilizationType() == civilisationID) then 
		local goldenAgePoints = GetLucaGAPFromHappiness(playerID)
		player:ChangeGoldenAgeProgressMeter(goldenAgePoints)
	end
end

if isFreliaCivActive then
	GameEvents.PlayerDoTurn.Add(FreliaKingdom)
end
--------------------------------------------------------------------------------------------------------------------------
-- GetLucaGAPFromHappiness
--------------------------------------------------------------------------------------------------------------------------

function GetLucaGAPFromHappiness(playerID)
	local player = Players[playerID]
	local numGAPointsFromExcessHappiness = 0
	if player:GetExcessHappiness() > 0 then
		numGAPointsFromExcessHappiness = math.ceil(player:GetExcessHappiness() * 50 / 100)
	end

	return numGAPointsFromExcessHappiness
end