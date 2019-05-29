GameEvents.PlayerCanTrain.Add(
function(iPlayer, unitTypeID)
	local prereqEra = GameInfo.Units[unitTypeID].PrereqEra
	local obsoleteEra = GameInfo.Units[unitTypeID].ObsoleteEra
	if prereqEra then
		local player = Players[iPlayer]
		local currentEra = player:GetCurrentEra()
		if prereqEra > currentEra then
			return false
		end
	end
	if obsoleteEra then
		local player = Players[iPlayer]
		local currentEra = player:GetCurrentEra()
		if obsoleteEra <= currentEra then
			return false
		end
	end
	return true
end)