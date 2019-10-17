-- PMMMCityConnectionBuildings
-- Author: Vice
-- DateCreated: 3/3/2015 4:33:10 PM
--------------------------------------------------------------

local iPostOfficeClass = GameInfoTypes.BUILDINGCLASS_PMMM_POST_OFFICE
local iPhoneNetworkClass = GameInfoTypes.BUILDINGCLASS_PMMM_PHONE_NETWORK
local iPostOfficeDummy = GameInfoTypes.BUILDING_PMMM_POST_OFFICE_DUMMY
local iPhoneNetworkDummy = GameInfoTypes.BUILDING_PMMM_PHONE_NETWORK_DUMMY

function OnDoTurnCityConnectionBuildings(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local iSetMail = pPlayer:HasBuildingClass(iPostOfficeClass) and 1 or 0
		local iSetPhone = pPlayer:HasBuildingClass(iPhoneNetworkClass) and 1 or 0
		for pCity in pPlayer:Cities() do
			if pCity:IsCapital() or pPlayer:IsCapitalConnectedToCity(pCity) == false then
				pCity:SetNumRealBuilding(iPostOfficeDummy, 0)
				pCity:SetNumRealBuilding(iPhoneNetworkDummy, 0)
			else
				pCity:SetNumRealBuilding(iPostOfficeDummy, iSetMail)
				pCity:SetNumRealBuilding(iPhoneNetworkDummy, iSetPhone)
			end
		end
	end
end