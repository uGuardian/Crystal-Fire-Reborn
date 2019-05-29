-- TopPanelEntertainmentDisplay
-- Author: Vice
-- DateCreated: 1/26/2015 8:51:30 PM
--------------------------------------------------------------

include("PMMMEntertainmentSystem.lua")

function UpdateEntertainmentDisplay()
	Controls.EntertainmentString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
	ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"):ReprocessAnchoring()
	DoInitEntertainmentTooltips()
	RefreshEntertainmentDisplay()
end

Events.LoadScreenClose.Add(UpdateEntertainmentDisplay)

function DoInitEntertainmentTooltips()
	Controls.EntertainmentString:SetToolTipCallback( EntertainmentTipHandler );
end

local tipControlTable = {}
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable )

function EntertainmentTipHandler(control)
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	local iEntertainment = GetEmpireEntertainment(pPlayer)
	local iTotalMoodPerEnt = GameInfo.MG_MoodModifiers["MGMOODMOD_VACATION"].Value
	local iVacationers = GetNumVacationingMagicalGirls(pPlayer)

	local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_TOPPANEL_ENTERTAINMENT_TOOLTIP", iEntertainment, iTotalMoodPerEnt, iVacationers)
	if(sText ~= "") then
		tipControlTable.TopPanelMouseover:SetHide(false)
		tipControlTable.TooltipLabel:SetText( sText )
	else
		tipControlTable.TopPanelMouseover:SetHide(true)
	end

	tipControlTable.TopPanelMouseover:DoAutoSize()
end

function RefreshEntertainmentDisplay()
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	local iEntertainment = GetEmpireEntertainment(pPlayer)
	local sText = "[ICON_PMMM_ENTERTAINMENT] [COLOR_PLAYER_MADOKA_BACKGROUND]+"..iEntertainment.."[ENDCOLOR]"
	Controls.EntertainmentString:SetText(sText);
end

GameEvents.PlayerDoTurn.Add(RefreshEntertainmentDisplay)
Events.SerialEventCityInfoDirty.Add(RefreshEntertainmentDisplay)
LuaEvents.PMMMRefreshEntertainmentDisplay.Add(RefreshEntertainmentDisplay)