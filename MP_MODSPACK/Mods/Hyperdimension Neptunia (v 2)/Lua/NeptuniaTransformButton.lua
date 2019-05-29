-- NeptuniaTransformButton
-- Author: Vice
-- DateCreated: 9/14/2015 11:16:06 PM
--------------------------------------------------------------

-- Copied from JFD_IsUsingEUI from Mercenaries
function JFD_IsUsingEUI()
	if ContextPtr:LookUpControl("/InGame/CityView/CityInfoBG") then
		Controls.Grid:SetOffsetY(-30)
	end
end

Controls.TransformButton:RegisterCallback(Mouse.eLClick, function() LuaEvents.VV_HDDButton() end)
Events.SerialEventGameDataDirty.Add(function() LuaEvents.VV_RefreshTransformButton(Controls.TransformButton, Controls.TransformLabel, ContextPtr) end)
Events.LoadScreenClose.Add(function() LuaEvents.VV_RefreshTransformButton(Controls.TransformButton, Controls.TransformLabel, ContextPtr) end)