--Variable to detect if CultureOverview popup is up. If it is true, this is the only time that the new Events.SerialEventCityInfoDirty function should run.
local bPopup = false;

--Checks to see if the popup opened is CultureOverview. If it is, sets bPopup to true.
Events.SerialEventGameMessagePopup.Add(function(popupInfo)
	if popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CULTURE_OVERVIEW then
		bPopup = true
	end
end)

--When the popup menu is closed, change bPopup back to false, so we don't repeatedly run our function for no reason.
Events.SerialEventGameMessagePopupProcessed.Add(function()
	bPopup = false;
end)

--At the beginning of each turn, check for the theming bonus.
GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if Players[iPlayer]:GetCivilizationType() == GameInfoTypes.CIVILIZATION_PENSEE then
		for dCity in Players[iPlayer]:Cities() do
			if dCity:IsHasBuilding(GameInfoTypes.BUILDING_PENSEE_STOREFRONT) and dCity:GetThemingBonus(GameInfoTypes.BUILDINGCLASS_MARKET) > 0 then
				dCity:SetNumRealBuilding(GameInfoTypes.BUILDING_PENSEE_STOREFRONT_BONUS, 1);
			else
				dCity:SetNumRealBuilding(GameInfoTypes.BUILDING_PENSEE_STOREFRONT_BONUS, 0);
			end
		end
	end
end)

--When the CultureOverview menu is open, check for the theming bonus.
Events.SerialEventCityInfoDirty.Add(function()
	if bPopup then
		local iPlayer = Game:GetActivePlayer()
		if Players[iPlayer]:GetCivilizationType() == GameInfoTypes.CIVILIZATION_PENSEE then
			for dCity in Players[iPlayer]:Cities() do
				if dCity:IsHasBuilding(GameInfoTypes.BUILDING_PENSEE_STOREFRONT) and dCity:GetThemingBonus(GameInfoTypes.BUILDINGCLASS_MARKET) > 0 then
					dCity:SetNumRealBuilding(GameInfoTypes.BUILDING_PENSEE_STOREFRONT_BONUS, 1);
				else
					dCity:SetNumRealBuilding(GameInfoTypes.BUILDING_PENSEE_STOREFRONT_BONUS, 0);
				end
			end
		end
	end
end)