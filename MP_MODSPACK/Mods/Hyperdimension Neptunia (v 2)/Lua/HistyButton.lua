-- HistyButton
-- Author: Vice
-- DateCreated: 10/9/2015 7:41:55 PM
--------------------------------------------------------------

function SetOffsetForEUI()
	if ContentManager.IsActive("570f793e-fc33-417f-ae19-7cecccdd5f85", ContentType.UISKIN) then
		Controls.Grid:SetOffsetY(-40)
	end
end
SetOffsetForEUI()

function Refresh()
	if MapModData.HDNMod and MapModData.HDNMod.HistoireCity then
		LuaEvents.VV_RefreshHistyPanel(Controls.EnergyLabel, Controls.StatusLabel, Controls.CityList, ContextPtr)
	else
		ContextPtr:SetHide(true)
	end
end

function SetMinimized(bSet)
	if bSet == 0 then bSet = not Controls.HistyImage:IsHidden() end
	print(bSet)
	Controls.HistyImage:SetHide(bSet)
	Controls.EnergyLabel:SetHide(bSet)
	Controls.StatusLabel:SetHide(bSet)
	if bSet == true then
		Controls.Grid:SetSizeY(120)
		Controls.MinMaxButton:SetText("[ICON_PLUS]")
	else
		Controls.Grid:SetSizeY(230)
		Controls.MinMaxButton:SetText("[ICON_MINUS]")
	end
	
	Refresh()
end

Events.SerialEventCityInfoDirty.Add(Refresh)
Events.SerialEventGameDataDirty.Add(Refresh)
Events.LoadScreenClose.Add(Refresh)
LuaEvents.VV_ConvertHDNLeader.Add(Refresh)
Controls.MinMaxButton:RegisterCallback(Mouse.eLClick, SetMinimized)