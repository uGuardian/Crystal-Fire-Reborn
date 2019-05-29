-- Gilgamesh's Newer Trait Script
-- Author: Vicevirtuoso
-- DateCreated: 12/17/2013 1:52:52 PM
--------------------------------------------------------------

local tBuildAllUUs = {}
local tConvertFaithGold = {}
local tUnlimitedBladeWorks = {}
local bAnyBuildAllUUs;
local bAnyConvertFaithGold;
local bVaultBuilt;
local iVault = GameInfoTypes.BUILDING_GILGAMESH_VAULT
local iVaultClass = GameInfoTypes.BUILDINGCLASS_NATIONAL_TREASURY
local iVaultPolicy = GameInfoTypes.POLICY_GILGAMESH_VAULT

for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
		local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
		local pTrait = GameInfo.Traits[traitType]
		if pTrait.BuildAllUniqueUnits == 1 or pTrait.BuildAllUniqueUnits == true then
			tBuildAllUUs[i] = true
			bAnyBuildAllUUs = true
		end
		if pTrait.ConvertFaithToGold == 1 or pTrait.ConvertFaithToGold == true then
			tConvertFaithGold[i] = true
			bAnyConvertFaithGold = true
		end
		if pTrait.CanUseUnlimitedBladeWorks == 1 or pTrait.CanUseUnlimitedBladeWorks == true then
			tUnlimitedBladeWorks[i] = true
		end
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iVault) then
				bVaultBuilt = true
				break
			end
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CANTRAIN
-- This should always run!
-- Note: Units are known as "UBW" units because they're the same copies that Archer uses, to save space
--------------------------------------------------------------------------------------------------------------------------------------------------------

local tUBWUnits = {}
for unit in GameInfo.Units() do 
	if string.find(unit.Type, '_FSN_UBW') then
		tUBWUnits[unit.ID] = true
	end
end


function OnPlayerCanTrainUBWUnits(iPlayer, iUnitType)
	if tUBWUnits[iUnitType] then
		if tBuildAllUUs[iPlayer] then
			return true
		elseif tUnlimitedBladeWorks[iPlayer] then
			if not MapModData.FSNArcher.UBWActiveTurns[iPlayer] then MapModData.FSNArcher.UBWActiveTurns[iPlayer] = 0 end
			if MapModData.FSNArcher.UBWActiveTurns[iPlayer] > 0 then
				return true
			else
				return false
			end
		end
		return false
	end
	return true
end


GameEvents.PlayerCanTrain.Add(OnPlayerCanTrainUBWUnits)


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- FAITH TO GOLD
-- Only run if Gil is in the game.
--------------------------------------------------------------------------------------------------------------------------------------------------------

function GilgameshConvertFaithToGold(iPlayer)
	if tConvertFaithGold[iPlayer] then
		local pPlayer = Players[iPlayer]
		local iFaith = pPlayer:GetFaith()
		if iFaith > 0 then
			pPlayer:SetFaith(0)
			pPlayer:ChangeGold(iFaith)
			if iPlayer == Game:GetActivePlayer() then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_GILGAMESH_FAITH_CONVERTED_TO_GOLD", iFaith))
			end
		end
	end
end


if bAnyConvertFaithGold then
	GameEvents.PlayerDoTurn.Add(GilgameshConvertFaithToGold)
end	



--------------------------------------------------------------------------------------------------------------------------------------------------------
-- VAULT OF THE GOLDEN KING
-- Only run if Gil is in the game, and once the Vault has been built.
--------------------------------------------------------------------------------------------------------------------------------------------------------




--Variable to detect if CultureOverview popup is up; this is the only time that the UpdateGilgameshVaultUI() function should run
local bPopup;

--Update theming bonus buildings at beginning of turn
function OnTurnVaultThemeUpdate(iPlayer)
	if iPlayer >= GameDefines.MAX_MAJOR_CIVS then return end
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_SUMER_FSN then
		for pCity in pPlayer:Cities() do
			if pCity:GetThemingBonus(iVaultClass) > 0 then
				if not pPlayer:HasPolicy(iVaultPolicy) then
					pPlayer:SetNumFreePolicies(1)
					pPlayer:SetHasPolicy(iVaultPolicy, true)
					pPlayer:SetNumFreePolicies(0)
				end
				return
			end
		end
		if pPlayer:HasPolicy(iVaultPolicy) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iVaultPolicy, false)
			pPlayer:SetNumFreePolicies(0)
		end
	end
end

--Update theming bonus buildings when Great Works are swapped around
function OnUIVaultThemeUpdate()
	--If bPopup is false then that will (should) mean that CultureOverview is not active, and that's the only screen this mod needs tracking for,
	--so quit this function if false
	if not bPopup then
		return
	end
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_SUMER_FSN then
		for pCity in pPlayer:Cities() do
			if pCity:GetThemingBonus(iVaultClass) > 0 then
				if not pPlayer:HasPolicy(iVaultPolicy) then
					pPlayer:SetNumFreePolicies(1)
					pPlayer:SetHasPolicy(iVaultPolicy, true)
					pPlayer:SetNumFreePolicies(0)
				end
				return
			end
		end
		if pPlayer:HasPolicy(iVaultPolicy) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iVaultPolicy, false)
			pPlayer:SetNumFreePolicies(0)
		end
	end
end

--When a popup screen appears, check if it is CultureOverview. If so, set bPopup to true, which lets OnUIVaultThemeUpdate() fire
function SetCurrentPopupVault(popupInfo)
	local popupType = popupInfo.Type
	if popupType == ButtonPopupTypes.BUTTONPOPUP_CULTURE_OVERVIEW then
		bPopup = true
	end
end


function OnConstructedVault(iPlayer, _, iBuildingType)
	if iBuildingType == iVault then
		GameEvents.PlayerDoTurn.Add(OnTurnVaultThemeUpdate)
		Events.SerialEventCityInfoDirty.Add(OnUIVaultThemeUpdate)
		Events.SerialEventGameMessagePopup.Add(SetCurrentPopupVault)
		bVaultBuilt = true
	end
end


if bVaultBuilt then
	GameEvents.PlayerDoTurn.Add(OnTurnVaultThemeUpdate)
	Events.SerialEventCityInfoDirty.Add(OnUIVaultThemeUpdate)
	Events.SerialEventGameMessagePopup.Add(SetCurrentPopupVault)
else
	GameEvents.CityConstructed.Add(OnConstructedVault)
end


