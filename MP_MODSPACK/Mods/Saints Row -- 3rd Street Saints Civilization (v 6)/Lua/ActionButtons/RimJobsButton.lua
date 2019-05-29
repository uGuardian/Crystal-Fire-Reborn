-- RimJobsButton
-- Author: Vicevirtuoso
-- DateCreated: 7/17/2014 10:44:13 PM
--------------------------------------------------------------

if GameInfo.CustomModOptions then
	print("DLL Various Mod Components loaded, do not load the Lua-based mission button.")
	return
end


local iBuilding = GameInfoTypes.BUILDING_SRTT_RIM_JOBS
local iArmor = GameInfoTypes.UNITCOMBAT_ARMOR

local RimJobsButton = {
  Name = "RimJobsButton",
  Title = "TXT_KEY_SRTT_RJ_BUTTON_TITLE", -- or a TXT_KEY
  OrderPriority = 200, -- default is 200
  IconAtlas = "UNIT_ACTION_ATLAS", -- 45 and 64 variations required
  PortraitIndex = 20,
  ToolTip = function(action, unit)
	local sTooltip = Locale.ConvertTextKey("TXT_KEY_SRTT_RJ_BUTTON_TEXT")
	local pCity = unit:GetPlot():GetPlotCity()
	if not pCity then
		sTooltip = sTooltip ..Locale.ConvertTextKey("TXT_KEY_SRTT_RJ_BUTTON_DISABLED_TEXT")
	elseif not pCity:IsHasBuilding(iBuilding) then
		sTooltip = sTooltip ..Locale.ConvertTextKey("TXT_KEY_SRTT_RJ_BUTTON_DISABLED_TEXT")
	end
	return sTooltip
  end,
  Condition = function(action, unit)
  local ttable = {}
  LuaEvents.SRTTIsActivePlayerSaints(unit:GetOwner(), ttable)
  if ttable[0] == true then
		if Players[Game:GetActivePlayer()]:IsTurnActive() then
			if unit:GetMoves() > 0 and unit:GetUnitCombatType() == iArmor then
				return true
			end
		end
	end
  return false
  end,
  Disabled = function(action, unit)
	local pCity = unit:GetPlot():GetPlotCity()
	if pCity then
		if pCity:IsHasBuilding(iBuilding) then
			return false
		end
	end
	return true
  end,
  Action = function(action, unit, eClick)
	LuaEvents.SRTTOpenRimJobsPopup()
  end,
}
LuaEvents.UnitPanelActionAddin(RimJobsButton)