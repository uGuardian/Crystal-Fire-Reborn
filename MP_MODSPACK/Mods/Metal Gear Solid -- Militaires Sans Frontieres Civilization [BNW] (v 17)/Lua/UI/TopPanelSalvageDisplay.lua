-- TopPanelRespectDisplay
-- Author: Vicevirtuoso
-- DateCreated: 7/17/2014 1:47:19 PM
--------------------------------------------------------------


ContextPtr:SetHide(true)

local gT = MapModData.gT
local ttable = {}


local bIsActivePlayerMSF;

function RefreshTopPanelMSFStatus()
	if Players[Game:GetActivePlayer()]:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MSF then
		bIsActivePlayerMSF = true
	else
		bIsActivePlayerMSF = false
	end
end

RefreshTopPanelMSFStatus()

LuaEvents.MSFRefreshTopPanelMSFStatus.Add(RefreshTopPanelMSFStatus)


function UpdateSalvageDisplay()
	if bIsActivePlayerMSF then
		Controls.MSFSalvageString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
		ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"):ReprocessAnchoring()
		DoInitSalvageTooltips()
		RefreshSalvageDisplay()
	end
end

Events.LoadScreenClose.Add(UpdateSalvageDisplay)

function DoInitSalvageTooltips()
	Controls.MSFSalvageString:SetToolTipCallback( SalvageTipHandler );
end

local tipControlTable = {}
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable )

function SalvageTipHandler(control)
	if bIsActivePlayerMSF then
		local iPlayer = Game:GetActivePlayer()
		LuaEvents.MSFGetProgressToMotherBaseLevel(iPlayer, ttable)
		local iMBLevelProgress = ttable[0]
		LuaEvents.MSFGetMotherBaseLevel(iPlayer, ttable)
		local iThisLevel = ttable[0]
		LuaEvents.MSFGetRequiredProgressToMotherBaseLevel(iThisLevel, ttable)
		local iMBNextLevelReqs = ttable[0]
		LuaEvents.MSFGetMotherBaseProgressFromUnits(Players[iPlayer], ttable)
		local iSalvagePerTurn = ttable[0]
		LuaEvents.MSFGetMotherBaseProgressPerCapturePop(Players[iPlayer], ttable)
		local iSalvagePerCapture = ttable[0]
		
		local sText;
		if iNextLevel == -1 or iNextLevel == 99999999999 then
			sText = Locale.ConvertTextKey("TXT_KEY_TP_MOTHER_BASE_MAXIMUM_INFO", iMBLevelProgress)
		else
			sText = Locale.ConvertTextKey("TXT_KEY_TP_MOTHER_BASE_INFO", iThisLevel, iMBLevelProgress, iMBNextLevelReqs, iSalvagePerTurn, iSalvagePerCapture)
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

function RefreshSalvageDisplay()
	if bIsActivePlayerMSF then
		local iPlayer = Game:GetActivePlayer()
		local sText = "[ICON_MSF_SALVAGE] "
		LuaEvents.MSFGetProgressToMotherBaseLevel(iPlayer, ttable)
		local iCurSalvage = ttable[0]
		LuaEvents.MSFGetMotherBaseLevel(iPlayer, ttable)
		local iThisLevel = ttable[0]
		LuaEvents.MSFGetRequiredProgressToMotherBaseLevel(iThisLevel, ttable)
		local iNextLevelReqs = ttable[0]
		LuaEvents.MSFGetMotherBaseProgressFromUnits(Players[iPlayer], ttable)
		local iSalvagePerTurn = ttable[0]

		local sValueText; 
		if iNextLevelReqs < 10000000 then
			sValueText = "[COLOR_PLAYER_MSF_ICON]"..string.format("%i/%i (+%i)", iCurSalvage, iNextLevelReqs, iSalvagePerTurn).."[ENDCOLOR]"
		else
			sValueText = "[COLOR_PLAYER_MSF_ICON]"..tostring(iCurSalvage).."[ENDCOLOR]"
		end
		sText = sText .."[COLOR_PLAYER_MSF_ICON]"..sValueText.."[ENDCOLOR]"
		Controls.MSFSalvageString:SetText(sText);
	else
		Controls.MSFSalvageString:SetText("");
	end
end

LuaEvents.MSFRefreshSalvageDisplay.Add(RefreshSalvageDisplay)