-- NitrousButton
-- Author: Vicevirtuoso
-- DateCreated: 7/17/2014 10:44:24 PM
--------------------------------------------------------------

if GameInfo.CustomModOptions then
	print("DLL Various Mod Components loaded, do not load the Lua-based mission button.")
	return
end


local iNitrous = GameInfoTypes.PROMOTION_SRTT_RJ_NITROUS
local iNitrousActive = GameInfoTypes.PROMOTION_SRTT_RJ_NITROUS_ACTIVE

local NitrousButton = {
  Name = "NitrousButton",
  Title = "TXT_KEY_SRTT_NITROUS_BUTTON_TITLE", -- or a TXT_KEY
  OrderPriority = 200, -- default is 200
  IconAtlas = "UNIT_ACTION_ATLAS", -- 45 and 64 variations required
  PortraitIndex = 23,
  ToolTip = function(action, unit)
	local sTooltip = Locale.ConvertTextKey("TXT_KEY_SRTT_NITROUS_BUTTON_TEXT")
	if unit:IsHasPromotion(iNitrousActive) then
		sTooltip = sTooltip ..Locale.ConvertTextKey("TXT_KEY_SRTT_NITROUS_BUTTON_DISABLED_ALREADY_ACTIVE_TEXT")
	else	
		local ttable = {}
		LuaEvents.SRTTGetNitrousCooldown(unit, ttable)
		if ttable[0] then
			sTooltip = sTooltip ..Locale.ConvertTextKey("TXT_KEY_SRTT_NITROUS_BUTTON_DISABLED_COOLDOWN_TEXT", ttable[0])
		end
	end
	return sTooltip
  end,
  Condition = function(action, unit)
	if Players[Game:GetActivePlayer()]:IsTurnActive() then
		if unit:GetMoves() > 0 and unit:IsHasPromotion(iNitrous) then
			return true
		end
	end
  return false
  end,
  Disabled = function(action, unit)
	if not unit:IsHasPromotion(iNitrousActive) then
		local ttable = {}
		LuaEvents.SRTTGetNitrousCooldown(unit, ttable)
		if not ttable[0] then
			return false
		end
	end
	return true
  end,
  Action = function(action, unit, eClick)
	LuaEvents.SRTTDoNitrous(unit)
  end,
}
LuaEvents.UnitPanelActionAddin(NitrousButton)