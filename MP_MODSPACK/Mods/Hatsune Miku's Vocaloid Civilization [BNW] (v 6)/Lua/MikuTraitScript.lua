-- MikuTraitScript
-- Author: Vicevirtuoso
-- DateCreated: 3/11/2014 11:26:00 PM
--------------------------------------------------------------

--set to true to enable print statements
local bDebug = false

function dprint(...)
  if (bDebug) then
    print(string.format(...))
  end
end

--Variable to detect if CultureOverview popup is up; this is the only time that the UpdateLostLogiaBuildingsUI() function should run
local bPopup;

--Populate each building which needs a direct replacement when Miku builds it to save time during turns
local tMikuThemeBuildings = {
	GameInfoTypes.BUILDINGCLASS_NATIONAL_TREASURY,
	GameInfoTypes.BUILDINGCLASS_IRONWORKS,
	GameInfoTypes.BUILDINGCLASS_GRAND_TEMPLE,
	GameInfoTypes.BUILDINGCLASS_CIRCUS_MAXIMUS,
		}

--Update theming bonus buildings at beginning of turn
function OnTurnMikuThemeUpdate(iPlayer)
	if iPlayer >= GameDefines.MAX_MAJOR_CIVS then return end
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_VOCALOID then
		for pCity in pPlayer:Cities() do
			dprint("MikuThemeUpdate: Testing city " ..pCity:GetName())
			local iNumBuildingsToSetThisCity = 0;
			for k, v in pairs(tMikuThemeBuildings) do
				if pCity:GetThemingBonus(v) > 0 then
					dprint("Theming bonus present, adding to dummy building total")
					iNumBuildingsToSetThisCity = iNumBuildingsToSetThisCity + 1
				end
			end
			dprint("Total number of dummy buildings to set in this city: " ..iNumBuildingsToSetThisCity)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_MIKU_MUSICIAN_BONUS, iNumBuildingsToSetThisCity)
		end
	end
end


--Update theming bonus buildings when Great Works are swapped around
function OnUIMikuThemeUpdate()
	--If bPopup is false then that will (should) mean that CultureOverview is not active, and that's the only screen this mod needs tracking for,
	--so quit this function if false
	if not bPopup then
		return
	end
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_VOCALOID then
		for pCity in pPlayer:Cities() do
			dprint("MikuThemeUpdate: Testing city " ..pCity:GetName())
			local iNumBuildingsToSetThisCity = 0;
			for k, v in pairs(tMikuThemeBuildings) do
				if pCity:GetThemingBonus(v) > 0 then
					dprint("Theming bonus present, adding to dummy building total")
					iNumBuildingsToSetThisCity = iNumBuildingsToSetThisCity + 1
				end
			end
			dprint("Total number of dummy buildings to set in this city: " ..iNumBuildingsToSetThisCity)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_MIKU_MUSICIAN_BONUS, iNumBuildingsToSetThisCity)
		end
	end
end

GameEvents.PlayerDoTurn.Add(OnTurnMikuThemeUpdate)
Events.SerialEventCityInfoDirty.Add(OnUIMikuThemeUpdate)

--When a popup screen appears, check if it is CultureOverview. If so, set bPopup to true, which lets OnUIMikuThemeUpdate() fire
function SetCurrentPopupMiku(popupInfo)
	local popupType = popupInfo.Type
	if popupType == ButtonPopupTypes.BUTTONPOPUP_CULTURE_OVERVIEW then
		bPopup = true
	end
end
Events.SerialEventGameMessagePopup.Add(SetCurrentPopupMiku)


--When a popup is closed, delete bPopup so it doesn't keep refreshing Vocaloid buildings when CultureOverview isn't open
function ClearCurrentPopupMiku()
	bPopup = nil;
end
Events.SerialEventGameMessagePopupProcessed.Add(ClearCurrentPopupMiku)