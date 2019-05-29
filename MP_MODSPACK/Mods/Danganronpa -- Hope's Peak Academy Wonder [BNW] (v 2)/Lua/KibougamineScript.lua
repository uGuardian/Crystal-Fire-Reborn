-- KibougamineScript
-- Author: Vicevirtuoso
-- DateCreated: 8/13/2014 11:54:13 AM
--------------------------------------------------------------

local iBuilding = GameInfoTypes.BUILDING_VV_KIBOUGAMINE

local tSHSLUnits = {}

for unit in GameInfo.Units() do
	if string.find(unit.Type, "_VV_SHSL_") then
		tSHSLUnits[unit.ID] = true
	end
end

function OnCityCanTrain(iPlayer, iCity, iUnitType)
	if tSHSLUnits[iUnitType] then
		local pPlayer = Players[iPlayer]
		local pCity = pPlayer:GetCityByID(iCity)
		if pCity:IsHasBuilding(iBuilding) then
			for pUnit in pPlayer:Units() do
				if tSHSLUnits[pUnit:GetUnitType()] then
					return false
				end
			end
			return true
		end
		return false
	end
	return true
end




GameEvents.CityCanTrain.Add(OnCityCanTrain)