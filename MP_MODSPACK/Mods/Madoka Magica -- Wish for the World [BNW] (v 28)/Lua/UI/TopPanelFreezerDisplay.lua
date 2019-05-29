-- TopPanelFreezerDisplay
-- Author: Vicevirtuoso
-- DateCreated: 7/17/2014 1:47:19 PM
--------------------------------------------------------------

local ttable = {}

ContextPtr:SetHide(true)

--Don't use the cached trait table since it has issues when first loading -- find it directly from the DB
local leaderType = GameInfo.Leaders[Players[Game:GetActivePlayer()]:GetLeaderType()].Type
local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
local trait = GameInfo.Traits[traitType]

local bIsActivePlayerPleiades;

if trait.EnableFreezerSystem == 1 then
	bIsActivePlayerPleiades = true
end

trait = nil --keep pointers to traits in the DB out of memory since it can cause issues


function UpdateFreezerDisplay()
	if bIsActivePlayerPleiades then
		Controls.FreezerString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
		ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"):ReprocessAnchoring()
		DoInitFreezerTooltips()
		RefreshFreezerDisplay()
	end
end

Events.LoadScreenClose.Add(UpdateFreezerDisplay)

function DoInitFreezerTooltips()
	Controls.FreezerString:SetToolTipCallback( FreezerTipHandler );
end

local tipControlTable = {}
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable )

function FreezerTipHandler(control)
	if bIsActivePlayerPleiades then
		local iPlayer = Game:GetActivePlayer()
		LuaEvents.PMMMGetFreezerCurrentStorage(iPlayer, ttable)
		local iCurFreezer = ttable[0]
		LuaEvents.PMMMGetFreezerStorageMax(iPlayer, ttable)
		local iMaxFreezer = ttable[0]
		
		local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_UI_TOPPANEL_FREEZER_TT", iCurFreezer, iMaxFreezer)

		tipControlTable.TopPanelMouseover:SetHide(false)
		tipControlTable.TooltipLabel:SetText( sText )
		tipControlTable.TopPanelMouseover:DoAutoSize()
	end
end

function RefreshFreezerDisplay()
	if bIsActivePlayerPleiades then
		local iPlayer = Game:GetActivePlayer()
		LuaEvents.PMMMGetFreezerCurrentStorage(iPlayer, ttable)
		local iCurFreezer = ttable[0]
		LuaEvents.PMMMGetFreezerStorageMax(iPlayer, ttable)
		local iMaxFreezer = ttable[0]
		
		local sText;
		if iMaxFreezer > -1 and iCurFreezer > -1 then
			sText = "[ICON_PMMM_SOUL_GEM] "..string.format("%i/%i", iCurFreezer, iMaxFreezer)
		else
			sText = "FREEZER!"
		end
		Controls.FreezerString:SetText(sText);
	end
end

LuaEvents.SRTTRefreshFreezerDisplay.Add(RefreshFreezerDisplay)

Events.SerialEventUnitInfoDirty.Add(RefreshFreezerDisplay)



function OnClicked()
	LuaEvents.PMMMShowFreezerPopup()
end

Controls.FreezerString:RegisterCallback(Mouse.eLClick, OnClicked)