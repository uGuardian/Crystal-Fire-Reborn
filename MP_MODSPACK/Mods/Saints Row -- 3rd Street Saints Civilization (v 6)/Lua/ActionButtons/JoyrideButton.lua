-- JoyrideButton
-- Author: Vicevirtuoso
-- DateCreated: 7/17/2014 10:43:55 PM
--------------------------------------------------------------

if GameInfo.CustomModOptions then
	print("DLL Various Mod Components loaded, do not load the Lua-based mission button.")
	return
end

local JoyrideButton = {
  Name = "JoyrideButton",
  Title = "TXT_KEY_SRTT_JOYRIDE_BUTTON_TITLE", -- or a TXT_KEY
  OrderPriority = 200, -- default is 200
  IconAtlas = "UNIT_ACTION_ATLAS", -- 45 and 64 variations required
  PortraitIndex = 36,
  ToolTip = function(action, unit)
	local sTooltip = Locale.ConvertTextKey("TXT_KEY_SRTT_JOYRIDE_BUTTON_TEXT")
	local pCity = unit:GetPlot():GetPlotCity()
	if not pCity then
		sTooltip = sTooltip ..Locale.ConvertTextKey("TXT_KEY_SRTT_JOYRIDE_BUTTON_MUST_BE_IN_CITY_TEXT")
	elseif pCity:GetPopulation() <= 1 then
		sTooltip = sTooltip ..Locale.ConvertTextKey("TXT_KEY_SRTT_JOYRIDE_BUTTON_MUST_HAVE_2_OR_MORE_POP_TEXT")
	else
		local ttable = {}
		LuaEvents.SRTTGetJoyrideCooldown(pCity, ttable)
		if ttable[0] then
			sTooltip = sTooltip ..Locale.ConvertTextKey("TXT_KEY_SRTT_JOYRIDE_BUTTON_DISABLED_COOLDOWN_TEXT", ttable[0])
		end
	end
	return sTooltip
  end,
  Condition = function(action, unit)
  local ttable = {}
  LuaEvents.SRTTIsActivePlayerSaints(unit:GetOwner(), ttable)
  if ttable[0] == true then
		if Players[Game:GetActivePlayer()]:IsTurnActive() then
			if unit:GetMoves() > 0 and unit:IsCombatUnit() then
				return true
			end
		end
	end
  return false
  end,
  Disabled = function(action, unit)
	local pCity = unit:GetPlot():GetPlotCity()
	if pCity then
		if pCity:GetPopulation() > 1 then
			local ttable = {}
			LuaEvents.SRTTGetJoyrideCooldown(pCity, ttable)
			if not ttable[0] then
				return false
			end
		end
	end
	return true
  end,
  Action = function(action, unit, eClick)
	LuaEvents.SRTTDoJoyride(unit)
  end,
}
LuaEvents.UnitPanelActionAddin(JoyrideButton)