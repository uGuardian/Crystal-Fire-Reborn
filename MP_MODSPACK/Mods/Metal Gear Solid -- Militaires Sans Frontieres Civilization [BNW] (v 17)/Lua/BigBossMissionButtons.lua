-- Big Boss Upgrade Buttons Lua
-- Author: Vicevirtuoso
-- DateCreated: 12/20/2013 11:30:04 AM
--------------------------------------------------------------

if GameInfo.CustomModOptions then
	print("DLL Various Mod Components loaded, do not load the Lua-based mission button.")
	return
end


include("BigBossUtils.lua")

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local iMSFType = GameInfoTypes.CIVILIZATION_MSF
local iDiamondDogsType = GameInfoTypes.CIVILIZATION_DIAMOND_DOGS

--Find out if there are any MSF players in the game, and get their player IDs.-------------------------
tWhoIsMSF = MSF.MSFPlayers or {}
tWhoIsDiamondDogs = MSF.DiamondDogsPlayers or {}

bAnyMSFs = false;

function RefreshSnakePlayers(bRefresh)
	print("Refreshing Snake Players")
	if #MSF.MSFPlayers <= 0 or bRefresh then
		for i = 0, iMaxCivs - 1, 1 do
			local pPlayer = Players[i]
			if pPlayer:IsEverAlive() then
				if pPlayer:GetCivilizationType() == iMSFType then
					tWhoIsMSF[i] = true
					tWhoIsDiamondDogs[i] = false
					bAnyMSFs = true
					if not MSF.MSFSalvage[i] then MSF.MSFSalvage[i] = 0 end
					if not MSF.MotherBaseLevel[i] then MSF.MotherBaseLevel[i] = 1 end
				elseif pPlayer:GetCivilizationType() == iDiamondDogsType then
					tWhoIsDiamondDogs[i] = true
					tWhoIsMSF[i] = false
					bAnyMSFs = true
				else
					tWhoIsMSF[i] = false
					tWhoIsDiamondDogs[i] = false
				end
			end
		end
	else
		bAnyMSFs = true
	end
	MSF.MSFPlayers = tWhoIsMSF
	MSF.DiamondDogsPlayers = tWhoIsDiamondDogs
end

LuaEvents.MSFRefreshSnakePlayers.Add(RefreshSnakePlayers)

RefreshSnakePlayers()

if not bAnyMSFs then
	print("MSF or Diamond Dogs are not present in the game. No further functions will run.")
	return
else
	local string = ""
	for k, v in pairs(tWhoIsMSF) do
		if string == "" then
			string = k
		else
			string = string..", "..k
		end
	end
	string = "MSF/Diamond Dogs player IDs: "..string
	print(string)
end

LuaEvents.MSFRefreshSnakePlayers.Add(RefreshMotherBaseIDs)

print("Loaded BigBossMissionButtons")

local EnemyTerritoryUpgradeButton = {
  Name = "EnemyTerritoryUpgradeButton",
  Title = "TXT_KEY_ENEMY_TERRITORY_UPGRADE_BUTTON_TITLE", -- or a TXT_KEY
  OrderPriority = 200, -- default is 200
  IconAtlas = "UNIT_ACTION_ATLAS", -- 45 and 64 variations required
  PortraitIndex = 38,
  ToolTip = function(action, unit)
	local iUpgradeCost = unit:GetBaseCombatStrength() * 5
	local iUpgradeType = unit:GetUpgradeUnitType()
	local sUpgradeUnitDesc = Locale.ConvertTextKey(GameInfo.Units[iUpgradeType].Description)
	local sTooltip = Locale.ConvertTextKey("TXT_KEY_ENEMY_TERRITORY_UPGRADE_BUTTON_TEXT", sUpgradeUnitDesc, iUpgradeCost);
	if MapModData.MSF.MSFSalvage[Game:GetActivePlayer()] < iUpgradeCost then
		sTooltip = sTooltip .. "[NEWLINE][NEWLINE]" ..Locale.ConvertTextKey("TXT_KEY_ENEMY_TERRITORY_UPGRADE_BUTTON_NOT_ENOUGH_SALVAGE_TEXT")
	end
	-- Loop through all resources to see how many we need. If it's > 0 then add to the string
	local strResourcesNeeded = "";
	local iResourceLoop
	local iNumResourceNeededToUpgrade = 0;
	for pResource in GameInfo.Resources() do
		iResourceLoop = pResource.ID;
	
		iNumResourceNeededToUpgrade = unit:GetNumResourceNeededToUpgrade(iResourceLoop);
				
		if (iNumResourceNeededToUpgrade > 0 and iNumResourceNeededToUpgrade > Players[Game:GetActivePlayer()]:GetNumResourceAvailable(iResourceLoop, true)) then
			-- Add separator for non-initial entries
			if (strResourcesNeeded ~= "") then
				strResourcesNeeded = strResourcesNeeded .. ", ";
			end
			
			strResourcesNeeded = strResourcesNeeded .. iNumResourceNeededToUpgrade .. " " .. pResource.IconString .. " " .. Locale.ConvertTextKey(pResource.Description);
		end
	end
			
	-- Build resources required string
	if (strResourcesNeeded ~= "") then
		sTooltip = sTooltip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_UPGRADE_HELP_DISABLED_RESOURCES", strResourcesNeeded) .. "[ENDCOLOR]";
	end
	return sTooltip;
  end,
  Condition = function(action, unit)
  	if Players[Game:GetActivePlayer()]:IsTurnActive() then
		if tWhoIsMSF[Game:GetActivePlayer()] == true then
			if not unit:IsCombatUnit() then return false end
			local iUpgradeType = unit:GetUpgradeUnitType()
			if iUpgradeType < 0 then return false end
			local sTechRequired = GameInfo.Units[iUpgradeType].PrereqTech
			if Teams[Players[Game:GetActivePlayer()]:GetTeam()]:IsHasTech(GameInfoTypes[sTechRequired]) then
				if unit:GetMoves() > 0 then
					return true
				end
			end
		end
	end
  return false
  end,
  Disabled = function(action, unit)
	if not unit:IsCombatUnit() then return true end
	local iUpgradeCost = unit:GetBaseCombatStrength() * 5
	if MapModData.MSF.MSFSalvage[Game:GetActivePlayer()] < iUpgradeCost then
		return true
	end
	local iResourceLoop;
	local iNumResourceNeededToUpgrade = 0;
	for pResource in GameInfo.Resources() do
		iResourceLoop = pResource.ID;
		
		if unit:GetNumResourceNeededToUpgrade(iResourceLoop) then
			iNumResourceNeededToUpgrade = unit:GetNumResourceNeededToUpgrade(iResourceLoop);
		end
				
		if (iNumResourceNeededToUpgrade > 0 and iNumResourceNeededToUpgrade > Players[Game:GetActivePlayer()]:GetNumResourceAvailable(iResourceLoop, true)) then
			return true
		end
	end
	return false
  end,
  Action = function(action, unit, eClick)
  	local iUpgradeCost = unit:GetBaseCombatStrength() * 5
	local iUpgradeType = unit:GetUpgradeUnitType()
	local pPlayer = Players[Game:GetActivePlayer()]
	local pNewUnit = pPlayer:InitUnit(iUpgradeType, unit:GetX(), unit:GetY())
	pNewUnit:Convert(unit)
	--embark if on water
	if (pNewUnit:GetPlot():IsWater()) and pNewUnit:GetDomainType() ~= GameInfoTypes.DOMAIN_SEA then
		pNewUnit:Embark(pNewUnit:GetPlot());
	end
	pNewUnit:SetMoves(0)
	MapModData.MSF.MSFSalvage[Game:GetActivePlayer()] = MapModData.MSF.MSFSalvage[Game:GetActivePlayer()] - iUpgradeCost
	LuaEvents.MSFRefreshSalvageDisplay()
  end,
}
LuaEvents.UnitPanelActionAddin(EnemyTerritoryUpgradeButton)


local MetalGearUpgradeButton = {
  Name = "MetalGearUpgradeButton",
  Title = "TXT_KEY_METAL_GEAR_UPGRADE_BUTTON_TITLE", -- or a TXT_KEY
  OrderPriority = 200, -- default is 200
  IconAtlas = "UNIT_ACTION_ATLAS", -- 45 and 64 variations required
  PortraitIndex = 36,
  ToolTip = function(action, unit)
	local iUpgradeCost = math.floor((unit:GetBaseCombatStrength() ^ 2) / 8)
	local sTooltip = Locale.ConvertTextKey("TXT_KEY_METAL_GEAR_UPGRADE_BUTTON_TEXT", iUpgradeCost);
	if MapModData.MSF.MSFSalvage[Game:GetActivePlayer()] < iUpgradeCost then
		sTooltip = sTooltip .. "[NEWLINE][NEWLINE]" ..Locale.ConvertTextKey("TXT_KEY_ENEMY_TERRITORY_UPGRADE_BUTTON_NOT_ENOUGH_SALVAGE_TEXT")
	end
	if unit:GetPlot() ~= Players[Game:GetActivePlayer()]:GetCapitalCity():Plot() then
		sTooltip = sTooltip .. "[NEWLINE][NEWLINE]" ..Locale.ConvertTextKey("TXT_KEY_METAL_GEAR_UPGRADE_BUTTON_NOT_IN_CAPITAL_TEXT")
	end
	return sTooltip;
  end,
  Condition = function(action, unit)
	if Players[Game:GetActivePlayer()]:IsTurnActive() then
		if tWhoIsMSF[Game:GetActivePlayer()] == true then
			if unit:GetMoves() > 0 and unit:GetUnitType() == GameInfoTypes.UNIT_METAL_GEAR then
				return true
			end
		end
	end
  return false
  end,
  Disabled = function(action, unit)
  	--Current upgrade cost formula for Metal Gear: Strength squared divided by 10
	if Players[Game:GetActivePlayer()]:GetNumCities() > 0 then
		if unit:GetPlot() == Players[Game:GetActivePlayer()]:GetCapitalCity():Plot() then
			local iUpgradeCost = math.floor((unit:GetBaseCombatStrength() ^ 2) / 10)
			if MapModData.MSF.MSFSalvage[Game:GetActivePlayer()] >= iUpgradeCost then
				return false
			end
		end
	end
	return true
  end,
  Action = function(action, unit, eClick)
	local pPlayer = Players[Game:GetActivePlayer()]
	local iUpgradeCost = math.floor((unit:GetBaseCombatStrength() ^ 2) / 10)
	local iCurrenStrength = unit:GetBaseCombatStrength()
	unit:SetBaseCombatStrength(unit:GetBaseCombatStrength() + 10)
	MapModData.MSF.MSFSalvage[Game:GetActivePlayer()] = MapModData.MSF.MSFSalvage[Game:GetActivePlayer()] - iUpgradeCost
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_METAL_GEAR_UPGRADED_TEXT", unit:GetBaseCombatStrength()), Locale.ConvertTextKey("TXT_KEY_METAL_GEAR_UPGRADED_TITLE"), unit:GetX(), unit:GetY())
	unit:SetMoves(0)
	LuaEvents.MSFRefreshSalvageDisplay()
	Events.SerialEventUnitInfoDirty()
  end,
}
LuaEvents.UnitPanelActionAddin(MetalGearUpgradeButton)