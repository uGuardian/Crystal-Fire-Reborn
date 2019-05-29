-- FreliaFunctions
-- Author: LeonAzarola
-- DateCreated: 2/2/2015 12:30:19 PM
--------------------------------------------------------------
print("[Debug] Loading Lua for Frelia's functions..")

--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- FreliaCivilisationActive
--------------------------------------------------------------
local civilisationFreliaID = GameInfoTypes["CIVILIZATION_FRELIA"]

function FreliaCivilisationActive(civilisationID)
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

if FreliaCivilisationActive(civilisationFreliaID) then
	print("Frelia is in this game")
end

--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--Extra Bonus during Golden Age Trait
----------------------------------------------------------------------------------------------------------------------------	

local iDummy = GameInfoTypes.BUILDING_FRELIA_EXTRA_GOLDENAGE_BONUS_DUMMY
local iPlayer = GameInfoTypes.CIVILIZATION_FRELIA

function FreliaGoldenAge(iPlayer)
       local pPlayer = Players[iPlayer]
	          if pPlayer:IsGoldenAge() then
			       for pCity in pPlayer:Cities() do
			          pCity:SetNumRealBuilding(iDummy, 1)
			        end
            else
			  if not pPlayer:IsGoldenAge() then
			     for pCity in pPlayer:Cities() do
					pCity:SetNumRealBuilding(iDummy, 0)
				end
			end
		end
	end	

if FreliaCivilisationActive(civilisationFreliaID) then
	GameEvents.PlayerDoTurn.Add(FreliaGoldenAge)
end	

function BanMaiddroid2(iPlayer, iUnitType)
   if (iUnitType == GameInfoTypes["UNIT_FRELIA_MAIDDROID_2"]) then
 return false
 end
 return true
 end
 GameEvents.PlayerCanTrain.Add(BanMaiddroid2)

 function BanMaiddroid3(iPlayer, iUnitType)
   if (iUnitType == GameInfoTypes["UNIT_FRELIA_MAIDDROID_3"]) then
 return false
 end
 return true
 end
 GameEvents.PlayerCanTrain.Add(BanMaiddroid3)

 function BanMaiddroid4(iPlayer, iUnitType)
   if (iUnitType == GameInfoTypes["UNIT_FRELIA_MAIDDROID_4"]) then
 return false
 end
 return true
 end
 GameEvents.PlayerCanTrain.Add(BanMaiddroid4)