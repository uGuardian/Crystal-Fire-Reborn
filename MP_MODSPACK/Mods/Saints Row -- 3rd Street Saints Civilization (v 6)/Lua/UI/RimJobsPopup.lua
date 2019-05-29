
-------------------------------------------------
-- Rim Jobs Popup, copied from Choose Pantheon Popup
-------------------------------------------------

include( "IconSupport" );
include( "InstanceManager" );

ContextPtr:SetHide(true)

-- Used for Piano Keys
local ltBlue = {19/255,32/255,46/255,120/255};
local dkBlue = {12/255,22/255,30/255,120/255};

local g_ItemManager = InstanceManager:new( "ItemInstance", "Button", Controls.ItemStack );
local bHidden = true;

local screenSizeX, screenSizeY = UIManager:GetScreenSizeVal()
local spWidth, spHeight = Controls.ItemScrollPanel:GetSizeVal();

--local iMusicVolumeCache = 0;

local iPlayer = Game:GetActivePlayer()
local pPlayer = Players[iPlayer]

-- Original UI designed at 1050px 
local heightOffset = screenSizeY - 1020;

spHeight = spHeight + heightOffset;
Controls.ItemScrollPanel:SetSizeVal(spWidth, spHeight); 
Controls.ItemScrollPanel:CalculateInternalSize();
Controls.ItemScrollPanel:ReprocessAnchoring();

local bpWidth, bpHeight = Controls.BottomPanel:GetSizeVal();
--bpHeight = bpHeight * heightRatio;
-- print(heightOffset);
-- print(bpHeight);
bpHeight = bpHeight + heightOffset 
-- print(bpHeight);

Controls.BottomPanel:SetSizeVal(bpWidth, bpHeight);
Controls.BottomPanel:ReprocessAnchoring();
-------------------------------------------------
-------------------------------------------------
-- function OnPopupMessage(popupInfo)
	
	-- local popupType = popupInfo.Type;
	-- if popupType ~= ButtonPopupTypes.BUTTONPOPUP_FOUND_PANTHEON then
		-- return;
	-- end
	
	-- g_PopupInfo = popupInfo;
	-- g_bPantheons = popupInfo.Data2;

   	-- UIManager:QueuePopup( ContextPtr, PopupPriority.SocialPolicy );
-- end
-- Events.SerialEventGameMessagePopup.Add( OnPopupMessage );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnClose()
	ContextPtr:SetHide(true)
--	Events.AudioDebugChangeMusic(true,false,true)
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function InputHandler( uiMsg, wParam, lParam )
    ----------------------------------------------------------------        
    -- Key Down Processing
    ----------------------------------------------------------------        
    if uiMsg == KeyEvents.KeyDown then
        if (wParam == Keys.VK_RETURN or wParam == Keys.VK_ESCAPE) then
			if(Controls.ChooseConfirm:IsHidden())then
	            OnClose();
	        else
				Controls.ChooseConfirm:SetHide(true);
           	end
			return true;
        end
    end
end
ContextPtr:SetInputHandler( InputHandler );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function RefreshList()
	g_ItemManager:ResetInstances();
		
	CivIconHookup( pPlayer:GetID(), 64, Controls.CivIcon, Controls.CivIconBG, Controls.CivIconShadow, false, true );
	
	local availablePromotions = {}
	
	Controls.PanelTitle:LocalizeAndSetText("TXT_KEY_SRTT_RIM_JOBS_TITLE");
		for i,v in ipairs(MapModData.gSRTTRimJobsPromotions) do
			local promotion = GameInfo.UnitPromotions[v];
			if(promotion ~= nil) then
				table.insert(availablePromotions, {
					ID = promotion.ID,
					Name = Locale.Lookup(promotion.Description),
					Description = Locale.Lookup(promotion.Help),
					LevelReq = promotion.RespectLevelRequired,
					GoldReq = math.floor(promotion.RJGoldCost * (1 + (pPlayer:GetHurryModifier(GameInfoTypes.HURRY_GOLD) / 100)) * (GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent / 100))
				});
			end
		end	

	-- Sort promotions by their Respect Level Requirement.
	table.sort(availablePromotions, function(a,b) return a.LevelReq<b.LevelReq end);
	
	local bTickTock = false;

	for i, promotion in ipairs(availablePromotions) do
		local itemInstance = g_ItemManager:GetInstance();
		itemInstance.Name:SetText(promotion.Name);
		itemInstance.Gold:SetText("[ICON_GOLD] [COLOR:150:255:150:255]" ..promotion.GoldReq.."[ENDCOLOR]");
		itemInstance.Respect:SetText("[ICON_SRTT_RESPECT] [COLOR:140:48:255:255]" ..promotion.LevelReq.."[ENDCOLOR]");
		itemInstance.Description:SetText(promotion.Description);
		
		local sTooltip = "";
		local bDisable;
		
		if UI.GetHeadSelectedUnit():IsHasPromotion(promotion.ID) then
			bDisable = true
			sTooltip = Locale.ConvertTextKey("TXT_KEY_SRTT_RIMJOBS_ALREADY_HAVE_PROMOTION")
		end
		
		if pPlayer:GetGold() < promotion.GoldReq then
			bDisable = true
			if sTooltip ~= "" then
				sTooltip = sTooltip.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_SRTT_RIMJOBS_NOT_ENOUGH_GOLD")
			else
				sTooltip = Locale.ConvertTextKey("TXT_KEY_SRTT_RIMJOBS_NOT_ENOUGH_GOLD")
			end
		end
		
		local ttable = {}
		LuaEvents.SRTTGetRespectLevel(iPlayer, ttable)
		if ttable[0] < promotion.LevelReq then
			bDisable = true
			if sTooltip ~= "" then
				sTooltip = sTooltip.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_SRTT_RIMJOBS_NOT_ENOUGH_RESPECT")
			else
				sTooltip = Locale.ConvertTextKey("TXT_KEY_SRTT_RIMJOBS_NOT_ENOUGH_RESPECT")
			end
		end
		
		if bDisable then
			itemInstance.Button:SetDisabled(true)
			itemInstance.Button:EnableToolTip(true)
			itemInstance.Button:SetToolTipString(sTooltip)
		else
			itemInstance.Button:SetDisabled(false)
			itemInstance.Button:EnableToolTip(false)
		end
		
		itemInstance.Button:RegisterCallback(Mouse.eLClick, function() SelectPromotion(promotion.ID, promotion.GoldReq); end);
	
		if(bTickTock == false) then
			itemInstance.Box:SetColorVal(unpack(ltBlue));
		else
			itemInstance.Box:SetColorVal(unpack(dkBlue));
		end
		
		local buttonWidth, buttonHeight = itemInstance.Button:GetSizeVal();
		local descWidth, descHeight = itemInstance.Description:GetSizeVal();
		
		local newHeight = descHeight + 40;	
	
		
		itemInstance.Button:SetSizeVal(buttonWidth, newHeight);
		itemInstance.Box:SetSizeVal(buttonWidth + 20, newHeight);
		itemInstance.BounceAnim:SetSizeVal(buttonWidth + 20, newHeight + 5);
		itemInstance.BounceGrid:SetSizeVal(buttonWidth + 20, newHeight + 5);
		
				
		bTickTock = not bTickTock;
	end
	
	Controls.ItemStack:CalculateSize();
	Controls.ItemStack:ReprocessAnchoring();
	Controls.ItemScrollPanel:CalculateInternalSize();
end

function SelectPromotion(promotionID, goldCost) 
	iPromotionID = promotionID;
	iGoldCost = goldCost;
	local promotion = GameInfo.UnitPromotions[promotionID];
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_SRTT_CONFIRM_RIMJOB_PURCHASE", promotion.Description);
	Controls.ChooseConfirm:SetHide(false);
end

function OnYes( )
	Controls.ChooseConfirm:SetHide(true);
	
	local pUnit = UI.GetHeadSelectedUnit()
	
	pUnit:SetHasPromotion(iPromotionID, true)
	pUnit:ChangeMoves(-1 * GameDefines.MOVE_DENOMINATOR)
	
	pPlayer:ChangeGold(-1 * iGoldCost)
	LuaEvents.SRTTDoAddRespect(Game:GetActivePlayer(), math.floor(iGoldCost / 10), pUnit:GetPlot())
	
	Events.AudioPlay2DSound("AS2D_SRTT_RIM_JOBS_SELECT_SOUND");	
	
	OnClose();	
end
Controls.Yes:RegisterCallback( Mouse.eLClick, OnYes );

function OnNo( )
	Controls.ChooseConfirm:SetHide(true);
end
Controls.No:RegisterCallback( Mouse.eLClick, OnNo );


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function ShowHideHandler( bIsHide, bInitState )

	bHidden = bIsHide;
    if( not bInitState ) then
        if( not bIsHide ) then
        	UI.incTurnTimerSemaphore();
     --   	Events.SerialEventGameMessagePopupShown(g_PopupInfo);
        	
        	RefreshList();
	--		Events.AudioPlay2DSound("AS2D_SRTT_RIM_JOBS_MUSIC")  --don't think there's a way to override music, unfortunately. this would play over the existing music which is bad
        
			local unitPanel = ContextPtr:LookUpControl( "/InGame/WorldView/UnitPanel/Base" );
			if( unitPanel ~= nil ) then
				unitPanel:SetHide( true );
			end
			
			local infoCorner = ContextPtr:LookUpControl( "/InGame/WorldView/InfoCorner" );
			if( infoCorner ~= nil ) then
				infoCorner:SetHide( true );
			end
               	
        else
      
			local unitPanel = ContextPtr:LookUpControl( "/InGame/WorldView/UnitPanel/Base" );
			if( unitPanel ~= nil ) then
				unitPanel:SetHide(false);
			end
			
			local infoCorner = ContextPtr:LookUpControl( "/InGame/WorldView/InfoCorner" );
			if( infoCorner ~= nil ) then
				infoCorner:SetHide(false);
			end
			
			-- if(g_PopupInfo ~= nil) then
				-- Events.SerialEventGameMessagePopupProcessed.CallImmediate(g_PopupInfo.Type, 0);
			-- end
            UI.decTurnTimerSemaphore();
        end
    end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );

function OpenRimJobsPopup()
	ContextPtr:SetHide(false)
	RefreshList()
end

LuaEvents.SRTTOpenRimJobsPopup.Add(OpenRimJobsPopup)
----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnActivePlayerChanged()
	if (not Controls.ChooseConfirm:IsHidden()) then
		Controls.ChooseConfirm:SetHide(true);
    end
end
Events.GameplaySetActivePlayer.Add(OnActivePlayerChanged);

function OnDirty()
	-- If the user performed any action that changes selection states, just close this UI.
	if not bHidden then
		OnClose();
	end
end
Events.UnitSelectionChanged.Add( OnDirty );
