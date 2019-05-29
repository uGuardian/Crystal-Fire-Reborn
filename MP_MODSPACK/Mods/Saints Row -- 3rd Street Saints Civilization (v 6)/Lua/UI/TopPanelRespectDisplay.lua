-- TopPanelRespectDisplay
-- Author: Vicevirtuoso
-- DateCreated: 7/17/2014 1:47:19 PM
--------------------------------------------------------------


ContextPtr:SetHide(true)

local ttable = {}

LuaEvents.SRTTIsActivePlayerSaints(Game:GetActivePlayer(), ttable)

local bIsActivePlayerSaints;

if ttable[0] == true then
	bIsActivePlayerSaints = true
end


function UpdateGriefSeedDisplay()
	if bIsActivePlayerSaints then
		Controls.SRTTRespectString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
		ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"):ReprocessAnchoring()
		DoInitRespectTooltips()
		RefreshRespectDisplay()
	end
end

Events.LoadScreenClose.Add(UpdateGriefSeedDisplay)

function DoInitRespectTooltips()
	Controls.SRTTRespectString:SetToolTipCallback( RespectTipHandler );
end

local tipControlTable = {}
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable )

function RespectTipHandler(control)
	if bIsActivePlayerSaints then
		local iPlayer = Game:GetActivePlayer()
		LuaEvents.SRTTGetRespect(iPlayer, ttable)
		local iCurRespect = ttable[0]
		LuaEvents.SRTTGetNextRespectLevelReqs(iPlayer, ttable)
		local iNextLevelReqs = ttable[0]
		LuaEvents.SRTTGetNextRespectLevel(iPlayer, ttable)
		local iNextLevel = ttable[0]
		LuaEvents.SRTTGetRespectLevel(iPlayer, ttable)
		local iThisLevel = ttable[0]
		
		local sText;
		if iNextLevel == -1 then
			sText = Locale.ConvertTextKey("TXT_KEY_SRTT_TT_RESPECT_MAX", iThisLevel)
		else
			sText = Locale.ConvertTextKey("TXT_KEY_SRTT_TT_RESPECT", iCurRespect, iNextLevelReqs, iNextLevel, iThisLevel)
		end

		if(sText ~= "") then
			tipControlTable.TopPanelMouseover:SetHide(false)
			tipControlTable.TooltipLabel:SetText( sText )
		else
			tipControlTable.TopPanelMouseover:SetHide(true)
		end

		tipControlTable.TopPanelMouseover:DoAutoSize()
	end
end

function RefreshRespectDisplay()
	if bIsActivePlayerSaints then
		local iPlayer = Game:GetActivePlayer()
		local sText = "[ICON_SRTT_RESPECT] "
		LuaEvents.SRTTGetRespect(iPlayer, ttable)
		local iCurRespect = ttable[0]
		LuaEvents.SRTTGetNextRespectLevelReqs(iPlayer, ttable)
		local iNextLevelReqs = ttable[0]
		LuaEvents.SRTTGetRespectPerTurn(iPlayer, ttable)
		local iRespectPerTurn = ttable[0]

		local sValueText = string.format("%i/%i (+%i)", iCurRespect, iNextLevelReqs, iRespectPerTurn)
		if iNextLevelReqs > 0 then
			sText = sText .."[COLOR:140:48:255:255]"..sValueText.."[ENDCOLOR]"
		else
			sText = sText.."[COLOR:140:48:255:255]"..Locale.ConvertTextKey("TXT_KEY_SRTT_TOPPANEL_MAXIMUM").."[ENDCOLOR]"
		end
		Controls.SRTTRespectString:SetText(sText);
	end
end

LuaEvents.SRTTRefreshRespectDisplay.Add(RefreshRespectDisplay)

Events.SerialEventScoreDirty.Add(RefreshRespectDisplay)