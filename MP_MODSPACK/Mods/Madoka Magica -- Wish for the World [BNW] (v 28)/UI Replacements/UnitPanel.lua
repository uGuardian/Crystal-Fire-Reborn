------------------------------------------------
-- Unit Panel Screen 
-------------------------------------------------
include( "IconSupport" );
include( "InstanceManager" );
--PMMM Mod Start
include("MagicalGirlInfoPanel.lua");
include( "PMMMGeneralFunctions.lua" );
--PMMM Mod End

local g_PrimaryIM    = InstanceManager:new( "UnitAction",  "UnitActionButton", Controls.PrimaryStack );
local g_SecondaryIM  = InstanceManager:new( "UnitAction",  "UnitActionButton", Controls.SecondaryStack );
local g_BuildIM      = InstanceManager:new( "UnitAction",  "UnitActionButton", Controls.WorkerActionPanel );
local g_PromotionIM  = InstanceManager:new( "UnitAction",  "UnitActionButton", Controls.WorkerActionPanel );
local g_EarnedPromotionIM   = InstanceManager:new( "EarnedPromotionInstance", "UnitPromotionImage", Controls.EarnedPromotionStack );

    
local g_CurrentActions = {};    --CurrentActions associated with each button
local g_lastUnitID = -1;        -- Used to determine if a different unit has been selected.
local g_ActionButtons = {};
local g_PromotionsOpen = false;
local g_SecondaryOpen = false;
local g_WorkerActionPanelOpen = false;

local MaxDamage = GameDefines.MAX_HIT_POINTS;

local promotionsTexture = "Promotions512.dds";

local unitPortraitSize = Controls.UnitPortrait:GetSize().x;
local actionIconSize = 64;
if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
	actionIconSize = 45;
end

--PMMM Mod
--Store MG Key
local g_MGKey = nil;
--Is the game multiplayer? If so, use custom mission calls for appearance changes.
local bMulti = Game:IsNetworkMultiPlayer();
--PMMM Mod End


local isBNW = true --ContentManager.IsActive("6DA07636-4123-4018-B643-6575B4EC336B", ContentType.GAMEPLAY)
					--WFTW requires BNW, so why bother testing for it?

if (OptionsManager.GetSmallUIAssets()) then
	Controls.RecommendedActionButton:SetOffsetVal(25,58)
end

local addinActions = {}
local addinBuilds = {}

function OnUnitPanelActionAddin(action)
  print(string.format("Adding UnitPanel action %s (%s)", Locale.ConvertTextKey(action.Title), action.Name))
  table.insert(addinActions, action)
end
LuaEvents.UnitPanelActionAddin.Add(OnUnitPanelActionAddin)

function OnUnitPanelBuildAddin(build)
  print(string.format("Adding UnitPanel build %s (%s)", Locale.ConvertTextKey(build.Title), build.Name))
  table.insert(addinBuilds, build)
end
LuaEvents.UnitPanelBuildAddin.Add(OnUnitPanelBuildAddin)

addins = {}
-- handle UnitPanelAddins
for addin in Modding.GetActivatedModEntryPoints("UnitPanelAddin") do
	local addinFile = addin.File;
	local extension = Path.GetExtension(addinFile);
	local path = string.sub(addinFile, 1, #addinFile - #extension);
	ptr = ContextPtr:LoadNewContext(path)
	table.insert(addins, ptr)
end
--
-- MODS END
--

--------------------------------------------------------------------------------
-- this maps from the normal instance names to the build city control names
-- so we can use the same code to set it up
--------------------------------------------------------------------------------
local g_BuildCityControlMap = { 
    UnitActionButton    = Controls.BuildCityButton,
    --UnitActionMouseover = Controls.BuildCityMouseover,
    --UnitActionText      = Controls.BuildCityText,
    --UnitActionHotKey    = Controls.BuildCityHotKey,
    --UnitActionHelp      = Controls.BuildCityHelp,
};

local direction_types = {
	DirectionTypes.DIRECTION_NORTHEAST,
	DirectionTypes.DIRECTION_EAST,
	DirectionTypes.DIRECTION_SOUTHEAST,
	DirectionTypes.DIRECTION_SOUTHWEST,
	DirectionTypes.DIRECTION_WEST,
	DirectionTypes.DIRECTION_NORTHWEST
};
	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function OnPromotionButton()
    g_PromotionsOpen = not g_PromotionsOpen;
    
    if g_PromotionsOpen then
        Controls.PromotionStack:SetHide( false );
    else
        Controls.PromotionStack:SetHide( true );
    end
end
Controls.PromotionButton:RegisterCallback( Mouse.eLClick, OnPromotionButton );


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function OnSecondaryButton()
    g_SecondaryOpen = not g_SecondaryOpen;
    
    if g_SecondaryOpen then
        Controls.SecondaryStack:SetHide( false );
        Controls.SecondaryStretchy:SetHide( false );
        Controls.SecondaryImageOpen:SetHide( true );
        Controls.SecondaryImageClosed:SetHide( false );
        Controls.SecondaryButton:SetToolTipString( Locale.ConvertTextKey( "TXT_KEY_SECONDARY_O_TEXT" ));

    else
        Controls.SecondaryStack:SetHide( true );
        Controls.SecondaryStretchy:SetHide( true );
        Controls.SecondaryImageOpen:SetHide( false );
        Controls.SecondaryImageClosed:SetHide( true );
        Controls.SecondaryButton:SetToolTipString( Locale.ConvertTextKey( "TXT_KEY_SECONDARY_C_TEXT" ));
    end
end
Controls.SecondaryButton:RegisterCallback( Mouse.eLClick, OnSecondaryButton );


local GetActionIconIndexAndAtlas = {
	[ActionSubTypes.ACTIONSUBTYPE_PROMOTION] = function(action)
		local thisPromotion = GameInfo.UnitPromotions[action.CommandData];
		return thisPromotion.PortraitIndex, thisPromotion.IconAtlas;
	end,
	
	[ActionSubTypes.ACTIONSUBTYPE_INTERFACEMODE] = function(action)
		local info = GameInfo.InterfaceModes[action.Type];
		return info.IconIndex, info.IconAtlas;
	end,
	
	[ActionSubTypes.ACTIONSUBTYPE_MISSION] = function(action)
		local info = GameInfo.Missions[action.Type];
		return info.IconIndex, info.IconAtlas;
	end,
	
	[ActionSubTypes.ACTIONSUBTYPE_COMMAND] = function(action)
		local info = GameInfo.Commands[action.Type];
		return info.IconIndex, info.IconAtlas;
	end,
	
	[ActionSubTypes.ACTIONSUBTYPE_AUTOMATE] = function(action)
		local info = GameInfo.Automates[action.Type];
		return info.IconIndex, info.IconAtlas;
	end,
	
	[ActionSubTypes.ACTIONSUBTYPE_BUILD] = function(action)
		local info = GameInfo.Builds[action.Type];
		return info.IconIndex, info.IconAtlas;
	end,
	
	[ActionSubTypes.ACTIONSUBTYPE_CONTROL] = function(action)
		local info = GameInfo.Controls[action.Type];
		return info.IconIndex, info.IconAtlas;
	end,
};

function HookupActionIcon(action, actionIconSize, icon)

	local f = GetActionIconIndexAndAtlas[action.SubType];
	if(f ~= nil) then
		local iconIndex, iconAtlas = f(action);
		IconHookup(iconIndex, actionIconSize, iconAtlas, icon);
	else
		print(action.Type);
		print(action.SubType);
		error("Could not find method to obtain action icon.");
	end
end
--------------------------------------------------------------------------------
-- Refresh unit actions
--------------------------------------------------------------------------------
function UpdateUnitActions( unit )

    g_PrimaryIM:ResetInstances();
    g_SecondaryIM:ResetInstances();
    g_BuildIM:ResetInstances();
    g_PromotionIM:ResetInstances();
    Controls.BuildCityButton:SetHide( true );
    Controls.WorkerActionPanel:SetHide(true);
    local pActivePlayer = Players[Game.GetActivePlayer()];
    
    local bShowActionButton;
    local bUnitHasMovesLeft = unit:MovesLeft() > 0;
    
    -- Text that tells the player this Unit's out of moves this turn
    if (isBNW and unit:IsTrade()) then
		Controls.UnitStatusInfo:SetHide(true);
		Controls.SecondaryButton:SetHide(true);
		Controls.UnitStatMovement:SetHide(true);
		Controls.UnitStatNameMovement:SetHide(true);

		-- If we have the DLL LUA API extensions available, tell the player where this trade route goes
		if (Game.GetTradeRoute) then
		  local iRoute = unit:GetTradeRouteIndex()
		  if (iRoute ~= -1) then
		    local route = Game.GetTradeRoute(iRoute)
  		    if (route) then
		      local sFromCity = route.FromCityName

              Controls.UnitStatMovement:SetHide(false)
              Controls.UnitStatNameMovement:SetHide(true)
			  Controls.UnitStatusInfo:SetHide(true)

              Controls.UnitStrengthBox:SetHide(true)
              Controls.UnitStatStrength:SetHide(true)
              Controls.UnitStatNameStrength:SetHide(true)
			  Controls.UnitRangedAttackBox:SetHide(true)

			  if (unit:IsRecalledTrader()) then
			    if (route.MovingForward) then
                  Controls.UnitStatMovement:LocalizeAndSetText("TXT_KEY_TRADE_ROUTE_RECALLING", sFromCity)
				else
                  Controls.UnitStatMovement:LocalizeAndSetText("TXT_KEY_TRADE_ROUTE_RECALLED", sFromCity)
				end
			  else
			    local sToCity = route.ToCityName

			    if (route.MovingForward == false) then
			      sFromCity = route.ToCityName
		          sToCity = route.FromCityName
			    end

                Controls.UnitStatMovement:LocalizeAndSetText("TXT_KEY_TRADE_ROUTE_FROM_CITY", sFromCity)
				Controls.UnitStatMovement:SetToolTipString(nil);

                Controls.UnitStrengthBox:SetHide(false)
                Controls.UnitStatStrength:SetHide(false)
                Controls.UnitStatStrength:LocalizeAndSetText("TXT_KEY_TRADE_ROUTE_TO_CITY", sToCity)
				Controls.UnitStatStrength:SetToolTipString(nil);
			  end
			end
		  end
		end
    elseif (not bUnitHasMovesLeft) then
		Controls.UnitStatusInfo:SetHide(false);
		Controls.SecondaryButton:SetHide(true);
if (isBNW) then
		Controls.UnitStatMovement:SetHide(false);
		Controls.UnitStatNameMovement:SetHide(false);
end
	else
		Controls.UnitStatusInfo:SetHide(true);
		Controls.SecondaryButton:SetHide(false);
if (isBNW) then
		Controls.UnitStatMovement:SetHide(false);
		Controls.UnitStatNameMovement:SetHide(false);
end
    end
    
    local hasPromotion = false;
	local bBuild = false;
	local bPromotion = false;
	local iBuildID;

    Controls.BackgroundCivFrame:SetHide( false );
   
	local numBuildActions = 0;
	local numPromotions = 0;
	local numPrimaryActions = 0;
	local numSecondaryActions = 0;
	
	local numberOfButtonsPerRow = 4;
	local buttonSize = 60;
	local buttonPadding = 8;
	local buttonOffsetX = 16;
	local buttonOffsetY = 40;
	local workerPanelSizeOffsetY = 104;
	if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
		numberOfButtonsPerRow = 6;
		buttonSize = 40;
		buttonPadding = 6;
		workerPanelSizeOffsetY = 86;
	end

    local recommendedBuild = nil;
    
    local buildCityButtonActive = false;
   
       -- loop over all the game actions
    for iAction = 0, #GameInfoActions, 1 do
        local action = GameInfoActions[iAction];
        
		-- test CanHandleAction w/ visible flag (ie COULD train if ... )
        if(action.Visible and Game.CanHandleAction( iAction, 0, 1 ) ) then
           	if( action.SubType == ActionSubTypes.ACTIONSUBTYPE_PROMOTION ) then
                hasPromotion = true;                
			end
        end
    end


    -- loop over all the game actions
    for iAction = 0, #GameInfoActions, 1 
    do
        local action = GameInfoActions[iAction];
        
        local bBuild = false;
        local bPromotion = false;
        local bDisabled = false;
        
        -- We hide the Action buttons when Units are out of moves so new players aren't confused
        if (bUnitHasMovesLeft or action.Type == "COMMAND_CANCEL" or action.Type == "COMMAND_STOP_AUTOMATION" or action.SubType == ActionSubTypes.ACTIONSUBTYPE_PROMOTION) then
			bShowActionButton = true;
		else
			bShowActionButton = false;
        end
        
		-- test CanHandleAction w/ visible flag (ie COULD train if ... )
        if( bShowActionButton and action.Visible and Game.CanHandleAction( iAction, 0, 1 ) ) 
        then
            local instance;
            local extraXOffset = 0;
			if (UI.IsTouchScreenEnabled()) then
				extraXOffset = 44;
			end
            if( action.Type == "MISSION_FOUND" ) then
                instance = g_BuildCityControlMap;
                Controls.BuildCityButton:SetHide( false );
                buildCityButtonActive = true;
                
            elseif( action.SubType == ActionSubTypes.ACTIONSUBTYPE_PROMOTION ) then
				bPromotion = true;
                instance = g_PromotionIM:GetInstance();
                instance.UnitActionButton:SetAnchor( "L,B" );
				instance.UnitActionButton:SetOffsetVal( (numBuildActions % numberOfButtonsPerRow) * buttonSize + buttonPadding + buttonOffsetX + extraXOffset, math.floor(numBuildActions / numberOfButtonsPerRow) * buttonSize + buttonPadding + buttonOffsetY );				
                numBuildActions = numBuildActions + 1;
                
            elseif( (action.SubType == ActionSubTypes.ACTIONSUBTYPE_BUILD or action.Type == "INTERFACEMODE_ROUTE_TO") and hasPromotion == false) then
            
				bBuild = true;
				iBuildID = action.MissionData;
				instance = g_BuildIM:GetInstance();
				instance.UnitActionButton:SetAnchor( "L,B" );
				instance.UnitActionButton:SetOffsetVal( (numBuildActions % numberOfButtonsPerRow) * buttonSize + buttonPadding + buttonOffsetX + extraXOffset, math.floor(numBuildActions / numberOfButtonsPerRow) * buttonSize + buttonPadding + buttonOffsetY );				
				numBuildActions = numBuildActions + 1;
				if recommendedBuild == nil and unit:IsActionRecommended( iAction ) then
				
					recommendedBuild = iAction;
					
					local buildInfo = GameInfo.Builds[action.Type];				
					IconHookup( buildInfo.IconIndex, actionIconSize, buildInfo.IconAtlas, Controls.RecommendedActionImage );
					Controls.RecommendedActionButton:RegisterCallback( Mouse.eLClick, OnUnitActionClicked );
					Controls.RecommendedActionButton:SetVoid1( iAction );
					Controls.RecommendedActionButton:SetToolTipCallback( TipHandler );
					local text = action.TextKey or action.Type or "Action"..(buttonIndex - 1);
					local convertedKey = Locale.ConvertTextKey( text );
					Controls.RecommendedActionLabel:SetText( convertedKey );
				end
               
            elseif( action.OrderPriority > 100 ) then
                instance = g_PrimaryIM:GetInstance();
                numPrimaryActions = numPrimaryActions + 1;
                
            else
                instance = g_SecondaryIM:GetInstance();
                numSecondaryActions = numSecondaryActions + 1;
            end
            
			-- test w/o visible flag (ie can train right now)
			if not Game.CanHandleAction( iAction ) then
				bDisabled = true;
				instance.UnitActionButton:SetAlpha( 0.4 );                
				instance.UnitActionButton:SetDisabled( true );                
			else
				instance.UnitActionButton:SetAlpha( 1.0 );
				instance.UnitActionButton:SetDisabled( false );                
			end
			
            if(instance.UnitActionIcon ~= nil) then
				HookupActionIcon(action, actionIconSize, instance.UnitActionIcon);	
            end
            instance.UnitActionButton:RegisterCallback( Mouse.eLClick, OnUnitActionClicked );
            instance.UnitActionButton:SetVoid1( iAction );
			instance.UnitActionButton:SetToolTipCallback( TipHandler )
           
		    if (action.Type == "COMMAND_UPGRADE") then
                instance.UnitActionButton:RegisterCallback( Mouse.eRClick, OnUpgradeTreeButton );
			end
        end
    end

--
-- MODS START
--
local function SetToolTip(sTitle, sToolTip)
  local ttTable = {}
  TTManager:GetTypeControlTable( "TypeUnitAction", ttTable )
  
  ttTable.UnitActionHelp:SetText(string.format("[NEWLINE]%s", sToolTip))
  ttTable.UnitActionText:SetText(string.format("[COLOR_POSITIVE_TEXT]%s[ENDCOLOR]", Locale.ConvertTextKey(sTitle)))
  ttTable.UnitActionHotKey:SetText("")
  
  ttTable.UnitActionMouseover:DoAutoSize()
  local mouseoverSize = ttTable.UnitActionMouseover:GetSize();
  if (mouseoverSize.x < 350) then
    ttTable.UnitActionMouseover:SetSizeVal(350, mouseoverSize.y)
  end
end
  
for _, action in pairs(addinActions) do
  if (action.Condition == nil or
      (type(action.Condition) == "function" and action.Condition(action, unit)) or
	  (type(action.Condition) ~= "function" and action.Condition)) then
    local instance	
    if ((tonumber(action.OrderPriority) or 200) > 100) then
      instance = g_PrimaryIM:GetInstance()
      numPrimaryActions = numPrimaryActions + 1
    else
      instance = g_SecondaryIM:GetInstance()
      numSecondaryActions = numSecondaryActions + 1
    end
	
	if ((type(action.Disabled) == "function" and action.Disabled(action, unit)) or
    	(type(action.Disabled) ~= "function" and action.Disabled)) then
      instance.UnitActionButton:SetAlpha(0.4)
      instance.UnitActionButton:SetDisabled(true)
    else
      instance.UnitActionButton:SetAlpha(1.0)
      instance.UnitActionButton:SetDisabled(false)
    end
	
    IconHookup(action.PortraitIndex, actionIconSize, action.IconAtlas, instance.UnitActionIcon)
	local sTitle
	if (type(action.Title) == "function") then
	  sTitle = action.Title(action, unit)
	else
	  sTitle = action.Title
	end

	local sToolTip
    if (type(action.ToolTip) == "function") then
	  sToolTip = action.ToolTip(action, unit)
	else
	  sToolTip = action.ToolTip
	end
    instance.UnitActionButton:SetToolTipCallback(function() SetToolTip(action.Title, sToolTip) end)

	if (type(action.Action) == "function") then
      instance.UnitActionButton:RegisterCallback(Mouse.eLClick, function() action.Action(action, unit, Mouse.eLClick) end)
      instance.UnitActionButton:RegisterCallback(Mouse.eRClick, function() action.Action(action, unit, Mouse.eRClick) end)
	else
      instance.UnitActionButton:RegisterCallback(Mouse.eLClick, function() end)
      instance.UnitActionButton:RegisterCallback(Mouse.eRClick, function() end)
	end
  end
end

for _, build in pairs(addinBuilds) do
  if (build.Condition == nil or
      (type(build.Condition) == "function" and build.Condition(build, unit)) or
	  (type(build.Condition) ~= "function" and build.Condition)) then
    local instance = g_BuildIM:GetInstance()
	instance.UnitActionButton:SetAnchor( "L,B" )
	instance.UnitActionButton:SetOffsetVal((numBuildActions % numberOfButtonsPerRow) * buttonSize + buttonPadding + buttonOffsetX, math.floor(numBuildActions / numberOfButtonsPerRow) * buttonSize + buttonPadding + buttonOffsetY)
	numBuildActions = numBuildActions + 1

	if ((type(build.Disabled) == "function" and build.Disabled(build, unit)) or
    	(type(build.Disabled) ~= "function" and build.Disabled)) then
      instance.UnitActionButton:SetAlpha(0.4)
      instance.UnitActionButton:SetDisabled(true)
    else
      instance.UnitActionButton:SetAlpha(1.0)
      instance.UnitActionButton:SetDisabled(false)
    end
	
    IconHookup(build.PortraitIndex, actionIconSize, build.IconAtlas, instance.UnitActionIcon)
	local sToolTip
    if (type(build.ToolTip) == "function") then
	  sToolTip = build.ToolTip(build, unit)
	else
	  sToolTip = build.ToolTip
	end
    instance.UnitActionButton:SetToolTipCallback(function() SetToolTip(build.Title, sToolTip) end)

	if (type(build.Build) == "function") then
      instance.UnitActionButton:RegisterCallback(Mouse.eLClick, function() build.Build(build, unit, Mouse.eLClick) end)
      instance.UnitActionButton:RegisterCallback(Mouse.eRClick, function() build.Build(build, unit, Mouse.eRClick) end)
	else
      instance.UnitActionButton:RegisterCallback(Mouse.eLClick, function() end)
      instance.UnitActionButton:RegisterCallback(Mouse.eRClick, function() end)
	end

	if (recommendedBuild == nil and 
	   ((type(build.Recommended) == "function" and build.Recommended(build, unit)) or
    	(type(build.Recommended) ~= "function" and build.Recommended))) then
		recommendedBuild = build;
		IconHookup(build.PortraitIndex, actionIconSize, build.IconAtlas, Controls.RecommendedActionImage)

		if (type(build.Build) == "function") then
			Controls.RecommendedActionButton:RegisterCallback(Mouse.eLClick, function() build.Build(build, unit, Mouse.eLClick) end)
			Controls.RecommendedActionButton:RegisterCallback(Mouse.eRClick, function() build.Build(build, unit, Mouse.eRClick) end)
		else
			Controls.RecommendedActionButton:RegisterCallback(Mouse.eLClick, function() end)
			Controls.RecommendedActionButton:RegisterCallback(Mouse.eRClick, function() end)
		end

		Controls.RecommendedActionButton:SetToolTipCallback(function() SetToolTip(build.Title, sToolTip) end)
		Controls.RecommendedActionLabel:SetText(Locale.ConvertTextKey(build.Title))
	end
  end
end
--
-- MODS END
--

    --if hasPromotion == true then
        --Controls.PromotionButton:SetHide( false );
    --else
        --Controls.PromotionButton:SetHide( true );
    --end
    Controls.PromotionStack:SetHide( true );
    
    g_PromotionsOpen = false;
    
    Controls.PrimaryStack:CalculateSize();
    Controls.PrimaryStack:ReprocessAnchoring();
    
    local stackSize = Controls.PrimaryStack:GetSize();
    local stretchySize = Controls.PrimaryStretchy:GetSize();
    local buildCityButtonSize = 0;
    if buildCityButtonActive then
		if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
			buildCityButtonSize = 36;
		else
			buildCityButtonSize = 60;
		end
    end
    Controls.PrimaryStretchy:SetSizeVal( stretchySize.x, stackSize.y + buildCityButtonSize + 348 );
    
    if (numPrimaryActions > 0) then
        Controls.PrimaryStack:SetHide( false );
        Controls.PrimaryStretchy:SetHide( false );
        Controls.SecondaryButton:SetHide( false );
      	Controls.SecondaryButton:SetDisabled(numSecondaryActions == 0);
    else
        Controls.PrimaryStack:SetHide( true );
        Controls.PrimaryStretchy:SetHide( true );
        Controls.SecondaryButton:SetHide( true );
    end
    
    if(numSecondaryActions == 0) then
		Controls.SecondaryStack:SetHide(true);
		Controls.SecondaryStretchy:SetHide(true);
    end
    
    Controls.SecondaryStack:CalculateSize();
    Controls.SecondaryStack:ReprocessAnchoring();
    
    stackSize = Controls.SecondaryStack:GetSize();
    stretchySize = Controls.SecondaryStretchy:GetSize();
    Controls.SecondaryStretchy:SetSizeVal( stretchySize.x, stackSize.y + 290 );

    --Controls.BuildStack:CalculateSize();
    --Controls.BuildStack:ReprocessAnchoring();
    if numBuildActions > 0 or hasPromotion then
		Controls.WorkerActionPanel:SetHide( false );
		g_bWorkerActionPanelOpen = true;
		stackSize = Controls.WorkerActionPanel:GetSize();
		local rbOffset = 0;
		if recommendedBuild then
			rbOffset = 60;
			if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
				rbOffset = 60;
			end
			Controls.RecommendedActionDivider:SetHide( false );
			Controls.RecommendedActionButton:SetHide( false );
		else
			rbOffset = 0;
			Controls.RecommendedActionDivider:SetHide( true );
			Controls.RecommendedActionButton:SetHide( true );
		end
		if hasPromotion then
			Controls.WorkerText:SetHide(true);
			Controls.PromotionText:SetHide(false);
			Controls.PromotionAnimation:SetHide(false);
			Controls.EditButton:SetHide(false);
		else
			Controls.WorkerText:SetHide(false);
			Controls.PromotionText:SetHide(true);
			Controls.PromotionAnimation:SetHide(true);
			Controls.EditButton:SetHide(true);
		end
		Controls.WorkerActionPanel:SetSizeVal( stackSize.x, math.floor((numBuildActions-1) / numberOfButtonsPerRow) * buttonSize + buttonPadding + buttonOffsetY + rbOffset + workerPanelSizeOffsetY );
    else
		Controls.WorkerActionPanel:SetHide( true );
		g_bWorkerActionPanelOpen = false;
    end
    
    local buildType = unit:GetBuildType();
    if (buildType ~= -1) then -- this is a worker who is actively building something
		local thisBuild = GameInfo.Builds[buildType];
		--print("thisBuild.Type:"..tostring(thisBuild.Type));
		local civilianUnitStr = Locale.ConvertTextKey(thisBuild.Description);
		local iTurnsLeft = unit:GetPlot():GetBuildTurnsLeft(buildType, Game.GetActivePlayer(),  0, 0) + 1;	
		local iTurnsTotal = unit:GetPlot():GetBuildTurnsTotal(buildType);	
		if (iTurnsLeft < 4000 and iTurnsLeft > 0) then
			civilianUnitStr = civilianUnitStr.." ("..tostring(iTurnsLeft)..")";
		end
		IconHookup( thisBuild.IconIndex, 45, thisBuild.IconAtlas, Controls.WorkerProgressIcon ); 		
		Controls.WorkerProgressLabel:SetText( civilianUnitStr );
		Controls.WorkerProgressLabel:SetToolTipString(civilianUnitStr );
		local percent = (iTurnsTotal - (iTurnsLeft - 1)) / iTurnsTotal;
		Controls.WorkerProgressBar:SetPercent( percent );
		Controls.WorkerProgressIconFrame:SetHide( false );
		Controls.WorkerProgressFrame:SetHide( false );
	else
		Controls.WorkerProgressIconFrame:SetHide( true );
		Controls.WorkerProgressFrame:SetHide( true );
	end
    
    Controls.PromotionStack:CalculateSize();
    Controls.PromotionStack:ReprocessAnchoring();
end

local defaultErrorTextureSheet = "TechAtlasSmall.dds";
local nullOffset = Vector2( 0, 0 );

--------------------------------------------------------------------------------
-- Refresh unit portrait and name
--------------------------------------------------------------------------------
function UpdateUnitPortrait( unit )
  
	local name;
	if(isBNW and unit:IsGreatPerson()) or unit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL or (unit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_WITCH and unit:HasName()) then
		name = unit:GetNameNoDesc();
		if(name == nil or #name == 0) then
			name = unit:GetName();			
		end
	else
		name = unit:GetName();
	end
	
	name = Locale.ToUpper(name);
  
    --local name = unit:GetNameKey();
    local convertedKey = Locale.ConvertTextKey(name);
    convertedKey = Locale.ToUpper(convertedKey);

    Controls.UnitName:SetText(convertedKey);    
    Controls.UnitName:SetFontByName("TwCenMT24");   
    
    local name_length = Controls.UnitName:GetSizeVal();
    local box_length = Controls.UnitNameButton:GetSizeVal();
    
    if (name_length > (box_length - 50)) then
	    Controls.UnitName:SetFontByName("TwCenMT20");   
	end
	
	name_length = Controls.UnitName:GetSizeVal();
	
	if(name_length > (box_length - 50)) then
		Controls.UnitName:SetFontByName("TwCenMT14");
	end
    
    -- Tool tip
    local strToolTip = Locale.ConvertTextKey("TXT_KEY_CURRENTLY_SELECTED_UNIT");
    
    if unit:IsCombatUnit() or unit:GetDomainType() == DomainTypes.DOMAIN_AIR then
		local iExperience = unit:GetExperience();
	    
		local iLevel = unit:GetLevel();
		local iExperienceNeeded = unit:ExperienceNeeded();
		local xpString = Locale.ConvertTextKey("TXT_KEY_UNIT_EXPERIENCE_INFO", iLevel, iExperience, iExperienceNeeded);
		Controls.XPMeter:SetToolTipString( xpString );
		Controls.XPMeter:SetPercent( iExperience / iExperienceNeeded );
			
		if (iExperience > 0) then
			strToolTip = strToolTip .. "[NEWLINE][NEWLINE]" .. xpString;
		end
		Controls.XPFrame:SetHide( false );
	else
 		Controls.XPFrame:SetHide( true );
   end
	
	Controls.UnitPortrait:SetToolTipString(strToolTip);
    
    local thisUnitInfo = GameInfo.Units[unit:GetUnitType()];

	local flagOffset, flagAtlas = UI.GetUnitFlagIcon(unit);	    
    local textureOffset, textureAtlas = IconLookup( flagOffset, 32, flagAtlas );
    Controls.UnitIcon:SetTexture(textureAtlas);
    Controls.UnitIconShadow:SetTexture(textureAtlas);
    Controls.UnitIcon:SetTextureOffset(textureOffset);
    Controls.UnitIconShadow:SetTextureOffset(textureOffset);
    
    local pPlayer = Players[ unit:GetOwner() ];
    if (pPlayer ~= nil) then
		local iconColor, flagColor = pPlayer:GetPlayerColors();
	        
		if( pPlayer:IsMinorCiv() ) then
			flagColor, iconColor = flagColor, iconColor;
		end

		Controls.UnitIcon:SetColor( iconColor );
		Controls.UnitIconBackground:SetColor( flagColor );
	end    
    
	if unit:GetUnitClassType() ~= GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL then
		local portraitOffset, portraitAtlas = UI.GetUnitPortraitIcon(unit);
		textureOffset, textureAtlas = IconLookup( portraitOffset, unitPortraitSize, portraitAtlas );
		if textureOffset == nil then
			textureOffset = nullOffset;
			textureAtlas = defaultErrorTextureSheet;
		end
		Controls.UnitPortrait:SetTexture(textureAtlas);
		Controls.UnitPortrait:SetTextureOffset(textureOffset);
	end
    
    --These controls are potentially hidden if the previous selection was a city.
	Controls.UnitTypeFrame:SetHide(false);
	Controls.CycleLeft:SetHide(false);
	Controls.CycleRight:SetHide(false);
    Controls.UnitMovementBox:SetHide(false);
  
end

function UpdateCityPortrait(city)
    local name = city:GetName();
    name = Locale.ToUpper(name);
    --local name = unit:GetNameKey();
    local convertedKey = Locale.ConvertTextKey(name);
    convertedKey = Locale.ToUpper(convertedKey);

    Controls.UnitName:SetText(convertedKey);    
    Controls.UnitName:SetFontByName("TwCenMT24");   
    
    local name_length = Controls.UnitName:GetSizeVal();
    local box_length = Controls.UnitNameButton:GetSizeVal();
    
    if (name_length > (box_length - 50)) then
	    Controls.UnitName:SetFontByName("TwCenMT20");   
	end
	
	name_length = Controls.UnitName:GetSizeVal();
	
	if(name_length > (box_length - 50)) then
		Controls.UnitName:SetFontByName("TwCenMT14");
	end
    
	Controls.UnitPortrait:SetToolTipString(nil);
    
    local textureOffset, textureAtlas = IconLookup( 0, unitPortraitSize, "CITY_ATLAS" );
    if textureOffset == nil then
		textureOffset = nullOffset;
		textureAtlas = defaultErrorTextureSheet;
    end
    Controls.UnitPortrait:SetTexture(textureAtlas);
    Controls.UnitPortrait:SetTextureOffset(textureOffset);
    
        
    --Hide various aspects of Unit Panel since they don't apply to the city.
    --Clear promotions
    g_EarnedPromotionIM:ResetInstances();
    
    Controls.UnitTypeFrame:SetHide(true);
    Controls.CycleLeft:SetHide(true);
    Controls.CycleRight:SetHide(true);
    Controls.XPFrame:SetHide( true );
    Controls.SecondaryButton:SetHide(true);
    Controls.UnitMovementBox:SetHide(true);
    Controls.UnitStrengthBox:SetHide(true);
    Controls.UnitRangedAttackBox:SetHide(true);
    Controls.WorkerActionPanel:SetHide(true);
	Controls.PrimaryStack:SetHide( true );
	Controls.PrimaryStretchy:SetHide( true );
	Controls.SecondaryStack:SetHide( true );
	Controls.SecondaryStretchy:SetHide( true );
	Controls.SecondaryImageOpen:SetHide( false );
	Controls.SecondaryImageClosed:SetHide( true );
	Controls.WorkerProgressIconFrame:SetHide( true );
	Controls.WorkerProgressFrame:SetHide( true );
	g_bWorkerActionPanelOpen = false;
	g_PromotionsOpen = false;
	g_SecondaryOpen = false;
end


--------------------------------------------------------------------------------
-- Refresh unit promotions
--------------------------------------------------------------------------------
function UpdateUnitPromotions(unit)
    
    g_EarnedPromotionIM:ResetInstances();
    local controlTable;
    
    --For each avail promotion, display the icon
    for unitPromotion in GameInfo.UnitPromotions() do
        local unitPromotionID = unitPromotion.ID;
        
        if (unit:IsHasPromotion(unitPromotionID) and not (isBNW and unit:IsTrade())) then
            
            controlTable = g_EarnedPromotionIM:GetInstance();
			IconHookup( unitPromotion.PortraitIndex, 32, unitPromotion.IconAtlas, controlTable.UnitPromotionImage );

            -- Tooltip
            local strToolTip = Locale.ConvertTextKey(unitPromotion.Description);
            strToolTip = strToolTip .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey(unitPromotion.Help)
            controlTable.UnitPromotionImage:SetToolTipString(strToolTip);
            
        end
    end
end

function UpdateUnitPromotionsEx(unit)
  g_EarnedPromotionIM:ResetInstances()
    
  local rankedPromotions = {}
  local groupedPromotions = {}

  for unitPromotion in GameInfo.UnitPromotions() do
    if (unit:IsHasPromotion(unitPromotion.ID)) then
      local type = unitPromotion.Type
	  
	  -- Sort some oddities out with the Morindim promotion system
	  if (type == "PROMOTION_COVER_2" and unit:IsHasPromotion("PROMOTION_MORINDIM_EARTH_SPIRIT_WARRIOR_1")) then
	    type = "PROMOTION_MORINDIM_EARTH_SPIRIT_WARRIOR_2"
	  elseif (type == "PROMOTION_MORINDIM_GREAT_EARTH_SPIRIT_1" or type == "PROMOTION_MORINDIM_GREAT_SKY_SPIRIT_1" or type == "PROMOTION_MORINDIM_GREAT_WATER_SPIRIT_1") then
	    type = "PROMOTION_MORINDIM_GREAT_SPIRIT_1"
	  end
	  
      local rank = type:match("_%d+$")

      if (rank ~= nil) then
        local base = type:sub(1, type:len()-rank:len())
        local promotions = rankedPromotions[base]

        if (promotions == nil) then
          promotions = {}
          rankedPromotions[base] = promotions
        end

        promotions[tonumber(rank:sub(2))] = unitPromotion
      else
        local order = unitPromotion.OrderPriority
        if (order == 0) then order = 10 end

        -- Assumes promotion icons are in an 8x8 grid
        local group = order * 100 + unitPromotion.PortraitIndex
		--PMMM Mod Start
		if unitPromotion.IconAtlas == 'PROMOTION_ATLAS_PMMM_SOUL_GEMS' then
			group = 321321321321321 --arbitrary number
		end
		--PMMM Mod End
        local promotions = groupedPromotions[group]

        if (promotions == nil) then
          promotions = {}
          groupedPromotions[group] = promotions
        end

        promotions[type] = unitPromotion
      end
    end
  end

  addRankedPromotions(rankedPromotions)
  addGroupedPromotions(groupedPromotions)
end

function addRankedPromotions(rankedPromotions)
  for _,promotions in pairs(rankedPromotions) do
    local sToolTip = ""
    local sPrefix = ""
    local unitPromotion = nil

    for _,promotion in ipairs(promotions) do
      unitPromotion = promotion

      local sDesc = Locale.ConvertTextKey(unitPromotion.Description)
      local sHelp = Locale.ConvertTextKey(unitPromotion.Help)

      sToolTip = sToolTip .. sPrefix .. "[COLOR_YELLOW]" .. sDesc .. "[ENDCOLOR]"

      if (sHelp ~= sDesc) then
        sToolTip = sToolTip .. ": " .. sHelp
      end

      sPrefix = "[NEWLINE]"
    end

    if (unitPromotion ~= nil) then
      local controlTable = g_EarnedPromotionIM:GetInstance()
      IconHookup(unitPromotion.PortraitIndex, 32, unitPromotion.IconAtlas, controlTable.UnitPromotionImage)
      controlTable.UnitPromotionImage:SetToolTipString(sToolTip)
    end
  end
end

function addGroupedPromotions(groupedPromotions)
  local groupKeys = {}
  for group,_ in pairs(groupedPromotions) do
    table.insert(groupKeys, group)
  end

  table.sort(groupKeys)

  for _,group in ipairs(groupKeys) do
    local promotions = groupedPromotions[group]

    local sColour = "[COLOR_YELLOW]"
    local sToolTip = ""
    local sPrefix = ""
    local unitPromotion = nil

    for _,promotion in pairs(promotions) do
      unitPromotion = promotion

      if (unitPromotion.PortraitIndex == 57) then
        sColour = "[COLOR_RED]"
      end

      local sDesc = Locale.ConvertTextKey(unitPromotion.Description)
      local sHelp = Locale.ConvertTextKey(unitPromotion.Help)

      sToolTip = sToolTip .. sPrefix .. sColour .. sDesc .. "[ENDCOLOR]"

      if (sHelp ~= sDesc) then
        sToolTip = sToolTip .. ": " .. sHelp
      end

      sPrefix = "[NEWLINE]"
    end

    if (unitPromotion ~= nil) then
      local controlTable = g_EarnedPromotionIM:GetInstance()
      IconHookup(unitPromotion.PortraitIndex, 32, unitPromotion.IconAtlas, controlTable.UnitPromotionImage)
      controlTable.UnitPromotionImage:SetToolTipString(sToolTip)
    end
  end
end

---------------------------------------------------
---- Promotion Help
---------------------------------------------------
--function PromotionHelpOpen(iPromotionID)
    --local pPromotionInfo = GameInfo.UnitPromotions[iPromotionID];
    --local promotionHelp = Locale.ConvertTextKey(pPromotionInfo.Description);
    --Controls.HelpText:SetText(promotionHelp);
--end

--------------------------------------------------------------------------------
-- Refresh unit stats
--------------------------------------------------------------------------------
function UpdateUnitStats(unit)
    
    -- update the background image (update this if we get icons for the minors)
    local civType = unit:GetCivilizationType();
	local civInfo = GameInfo.Civilizations[civType];
	local civPortraitIndex = civInfo.PortraitIndex;
    if civPortraitIndex < 0 or civPortraitIndex > 21 then
        civPortraitIndex = 22;
    end
	
	--PMMM Mod Start
	local iPlayer = Game:GetActivePlayer()
	local iUnit = unit:GetID()
	--PMMM Mod End
    
    IconHookup( civPortraitIndex, 128, civInfo.IconAtlas, Controls.BackgroundCivSymbol );
       
    -- Movement
    if (isBNW and unit:IsTrade()) then
	  -- Handled above
    elseif unit:GetDomainType() == DomainTypes.DOMAIN_AIR then
		local iRange = unit:Range();
		local szMoveStr = iRange .. " [ICON_MOVES]";	    
		Controls.UnitStatMovement:SetText(szMoveStr);
		Controls.UnitStatNameMovement:LocalizeAndSetText("TXT_KEY_UPANEL_RANGEMOVEMENT");
		
		local rebaseRange = iRange * GameDefines.AIR_UNIT_REBASE_RANGE_MULTIPLIER;
		rebaseRange = rebaseRange / 100;
		
		szMoveStr = Locale.ConvertTextKey( "TXT_KEY_UPANEL_UNIT_MAY_STRIKE_REBASE", iRange, rebaseRange );
		Controls.UnitStatNameMovement:SetToolTipString(szMoveStr);
		Controls.UnitStatMovement:SetToolTipString(szMoveStr);

    else
		local move_denominator = GameDefines["MOVE_DENOMINATOR"];
		local moves_left = unit:MovesLeft() / move_denominator;
		local max_moves = unit:MaxMoves() / move_denominator;
		local ignore_terrain = (unit:IsHasPromotion(GameInfoTypes.PROMOTION_IGNORE_TERRAIN_COST)) and "*" or "";
		local szMoveStr = math.floor(moves_left) .. "/" .. math.floor(max_moves) .. ignore_terrain .. " [ICON_MOVES]";
	    
		Controls.UnitStatMovement:SetText(szMoveStr);
	    
		szMoveStr = Locale.ConvertTextKey( "TXT_KEY_UPANEL_UNIT_MAY_MOVE", moves_left );
		Controls.UnitStatNameMovement:LocalizeAndSetText("TXT_KEY_UPANEL_MOVEMENT");
		Controls.UnitStatNameMovement:SetToolTipString(szMoveStr);
		Controls.UnitStatMovement:SetToolTipString(szMoveStr);
    end
    
    -- Strength
    local strength = 0;
    if(unit:GetDomainType() == DomainTypes.DOMAIN_AIR) then
        strength = unit:GetBaseRangedCombatStrength();
    elseif (not unit:IsEmbarked()) then
        strength = unit:GetBaseCombatStrength();
    end
    if(strength > 0) then
        strength = strength .. " [ICON_STRENGTH]";
        Controls.UnitStrengthBox:SetHide(false);
        Controls.UnitStatStrength:SetText(strength);
        local strengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_STRENGTH_TT" );
        Controls.UnitStatStrength:SetToolTipString(strengthTT);
        Controls.UnitStatNameStrength:SetToolTipString(strengthTT);
   -- Religious units
    elseif (unit:GetSpreadsLeft() > 0) then
		if (isBNW) then
				strength = math.floor(unit:GetConversionStrength()/GameDefines["RELIGION_MISSIONARY_PRESSURE_MULTIPLIER"]) .. " [ICON_PEACE]";
		else
				strength = unit:GetConversionStrength() .. " [ICON_PEACE]";
		end
        Controls.UnitStrengthBox:SetHide(false);
        Controls.UnitStatStrength:SetText(strength);    
        local strengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_RELIGIOUS_STRENGTH_TT" );
        Controls.UnitStatStrength:SetToolTipString(strengthTT);
        Controls.UnitStatNameStrength:SetToolTipString(strengthTT);
    elseif (isBNW and unit:GetTourismBlastStrength() > 0) then
        strength = unit:GetTourismBlastStrength() .. " [ICON_TOURISM]";
        Controls.UnitStrengthBox:SetHide(false);
        Controls.UnitStatStrength:SetText(strength);    
        local strengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_TOURISM_STRENGTH_TT" );
        Controls.UnitStatStrength:SetToolTipString(strengthTT);
        Controls.UnitStatNameStrength:SetToolTipString(strengthTT);    
    elseif (isBNW and unit:IsTrade() and Game.GetTradeRoute) then
	    -- Handled above
    else
        Controls.UnitStrengthBox:SetHide(true);
    end        
    
    -- Ranged Strength
    local iRangedStrength = 0;
    if(unit:GetDomainType() ~= DomainTypes.DOMAIN_AIR) then
        iRangedStrength = unit:GetBaseRangedCombatStrength();
    else
        iRangedStrength = 0;
    end
    if(iRangedStrength > 0) then
        local szRangedStrength = iRangedStrength .. " [ICON_RANGE_STRENGTH]";
        Controls.UnitRangedAttackBox:SetHide(false);
        local rangeStrengthStr = Locale.ConvertTextKey( "TXT_KEY_UPANEL_RANGED_ATTACK" );
        Controls.UnitStatNameRangedAttack:SetText(rangeStrengthStr);
        Controls.UnitStatRangedAttack:SetText(szRangedStrength);
        local rangeStrengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_RANGED_ATTACK_TT" );
        Controls.UnitStatRangedAttack:SetToolTipString(rangeStrengthTT);
        Controls.UnitStatNameRangedAttack:SetToolTipString(rangeStrengthTT);
	--PMMM Mod: Soul Gem status for Magical Girls
	elseif unit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL and MapModData.PMMM.MagicalGirls[g_MGKey] then
	    Controls.UnitRangedAttackBox:SetHide(false);
		local iCorruption = MapModData.PMMM.MagicalGirls[g_MGKey].SoulGem or 0
		local iPolish = MapModData.PMMM.MagicalGirls[g_MGKey].Polish or 0
		local sStateString = "";
		if MapModData.PMMM.MagicalGirls[g_MGKey].SoulGemState then
			sStateString = Locale.ConvertTextKey(MapModData.gPMMMSoulGemStates[MapModData.PMMM.MagicalGirls[g_MGKey].SoulGemState].Description)
		end
		local bCanBecomeWitch = MapModData.gPMMMSoulGemStates[MapModData.PMMM.MagicalGirls[g_MGKey].SoulGemState].CanBecomeWitch or false
		local rangeStrengthStr = Locale.ConvertTextKey("TXT_KEY_UPANEL_PMMM_SOUL_GEM")
		Controls.UnitStatNameRangedAttack:SetText(rangeStrengthStr);
		if iPolish <= 0 then
			Controls.UnitStatRangedAttack:SetText(iCorruption.."%");
		else
			Controls.UnitStatRangedAttack:SetText(iCorruption.."[COLOR:170:170:170:255]+"..iPolish.."[ENDCOLOR]%");
		end
		local rangeStrengthTT
		if bCanBecomeWitch then
			rangeStrengthTT = Locale.ConvertTextKey("TXT_KEY_UPANEL_PMMM_SOUL_GEM_TT_DANGER", sStateString, MapModData.gPMMMGriefSeedRecoverAmount or 0)
		else
			rangeStrengthTT = Locale.ConvertTextKey("TXT_KEY_UPANEL_PMMM_SOUL_GEM_TT", sStateString, MapModData.gPMMMGriefSeedRecoverAmount or 0)
		end
		Controls.UnitStatRangedAttack:SetToolTipString(rangeStrengthTT);
		Controls.UnitStatNameRangedAttack:SetToolTipString(rangeStrengthTT);
	-- Religious unit
    elseif (unit:GetSpreadsLeft() > 0 and unit:GetBuildType() == -1) then
        iRangedStrength = unit:GetSpreadsLeft() .. "      ";
        Controls.UnitRangedAttackBox:SetHide(false);
        local rangeStrengthStr = Locale.ConvertTextKey( "TXT_KEY_UPANEL_SPREAD_RELIGION_USES" );
        Controls.UnitStatNameRangedAttack:SetText(rangeStrengthStr);
        Controls.UnitStatRangedAttack:SetText(iRangedStrength);    
        local rangeStrengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_SPREAD_RELIGION_USES_TT" );
        Controls.UnitStatRangedAttack:SetToolTipString(rangeStrengthTT);
        Controls.UnitStatNameRangedAttack:SetToolTipString(rangeStrengthTT);
    elseif (GameInfo.Units[unit:GetUnitType()].RemoveHeresy) then
        iRangedStrength = 1;
        Controls.UnitRangedAttackBox:SetHide(false);
        local rangeStrengthStr = Locale.ConvertTextKey( "TXT_KEY_UPANEL_REMOVE_HERESY_USES" );
        Controls.UnitStatNameRangedAttack:SetText(rangeStrengthStr);
        Controls.UnitStatRangedAttack:SetText(iRangedStrength);    
        local rangeStrengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_REMOVE_HERESY_USES_TT" );
        Controls.UnitStatRangedAttack:SetToolTipString(rangeStrengthTT);
        Controls.UnitStatNameRangedAttack:SetToolTipString(rangeStrengthTT);
    elseif (isBNW and unit:CargoSpace() > 0) then
        Controls.UnitRangedAttackBox:SetHide(false);
        local rangeStrengthStr = Locale.ConvertTextKey( "TXT_KEY_UPANEL_CARGO_CAPACITY" );
        Controls.UnitStatNameRangedAttack:SetText(rangeStrengthStr);
        Controls.UnitStatRangedAttack:SetText(unit:CargoSpace() .. "     ");    
        local rangeStrengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_CARGO_CAPACITY_TT", unit:GetName());
        Controls.UnitStatRangedAttack:SetToolTipString(rangeStrengthTT);
        Controls.UnitStatNameRangedAttack:SetToolTipString(rangeStrengthTT);
	--PMMM Mod: Food for Kyouko, and Harmony for Cutlass Conductor
	elseif unit:IsCombatUnit() and MapModData.gPMMMTraits[iPlayer] and MapModData.gPMMMTraits[iPlayer].MaxStolenFood > 0 and
	(unit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MELEE or unit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_GUN or unit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MOUNTED
	or unit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_NAVALMELEE or unit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_ARMOR) then
		Controls.UnitRangedAttackBox:SetHide(false);
		local iStolenFoodMax = MapModData.gPMMMTraits[iPlayer].MaxStolenFood
		local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
		local iStolenFood = MapModData.PMMM.StolenFood[iSpecialID] or 0
		local rangeStrengthStr = Locale.ConvertTextKey("TXT_KEY_UPANEL_PMMM_STOLEN_FOOD");
		Controls.UnitStatNameRangedAttack:SetText(rangeStrengthStr);
		Controls.UnitStatRangedAttack:SetText(iStolenFood .. "/" ..iStolenFoodMax);
		local rangeStrengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_PMMM_STOLEN_FOOD_TT", unit:GetName());
		Controls.UnitStatRangedAttack:SetToolTipString(rangeStrengthTT);
		Controls.UnitStatNameRangedAttack:SetToolTipString(rangeStrengthTT);
	elseif unit:IsCombatUnit() and unit:GetUnitType() == GameInfoTypes.UNIT_PMMM_CUTLASS_CONDUCTOR then
		local iHarmony = MapModData.PMMM.Harmony[GetUnitSpecialID(iPlayer, iUnit)] or 0
		Controls.UnitRangedAttackBox:SetHide(false);
		local rangeStrengthStr = Locale.ConvertTextKey("TXT_KEY_UPANEL_PMMM_HARMONY");
		Controls.UnitStatNameRangedAttack:SetText(rangeStrengthStr);
		Controls.UnitStatRangedAttack:SetText(iHarmony .. "     ");
		local rangeStrengthTT = Locale.ConvertTextKey( "TXT_KEY_UPANEL_PMMM_HARMONY_TT", unit:GetName());
		Controls.UnitStatRangedAttack:SetToolTipString(rangeStrengthTT);
		Controls.UnitStatNameRangedAttack:SetToolTipString(rangeStrengthTT);
	--PMMM Mod
    else
        Controls.UnitRangedAttackBox:SetHide(true);
    end        
    
end

--------------------------------------------------------------------------------
-- Refresh unit health bar
--------------------------------------------------------------------------------
function UpdateUnitHealthBar(unit)
	-- note that this doesn't use the bar type
	local damage = unit:GetDamage();
	if damage == 0 then
		Controls.EarnedPromotions:SetOffsetVal(4,0)

		Controls.HealthBar:SetHide(true);	
	else	
		Controls.EarnedPromotions:SetOffsetVal(7,0)

		local healthPercent = 1.0 - (damage / MaxDamage);
		local healthTimes100 =  math.floor(100 * healthPercent + 0.5);
		local barSize = { x = 9, y = math.floor(123 * healthPercent) };
		if healthTimes100 <= 33 then
			Controls.RedBar:SetSize(barSize);
			Controls.RedAnim:SetSize(barSize);
			Controls.GreenBar:SetHide(true);
			Controls.YellowBar:SetHide(true);
			Controls.RedBar:SetHide(false);
		elseif healthTimes100 <= 66 then
			Controls.YellowBar:SetSize(barSize);
			Controls.GreenBar:SetHide(true);
			Controls.YellowBar:SetHide(false);
			Controls.RedBar:SetHide(true);
		else
			Controls.GreenBar:SetSize(barSize);
			Controls.GreenBar:SetHide(false);
			Controls.YellowBar:SetHide(true);
			Controls.RedBar:SetHide(true);
		end
		
		Controls.HealthBar:SetToolTipString( Locale.ConvertTextKey( "TXT_KEY_UPANEL_SET_HITPOINTS_TT",(MaxDamage-damage), MaxDamage ) );
		--Controls.HealthBar:SetToolTipString(healthPercent.." Hit Points");
		
		Controls.HealthBar:SetHide(false);
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--------------------------------------------------------------------------------

--PMMM Mod
function OnUnitRangedAttackBoxClicked()
	local pUnit = UI.GetHeadSelectedUnit()
	local iPlayer = Game:GetActivePlayer()
	local iUnit = pUnit:GetID()
	--Must be active player's turn and the unit must have moves left
	if pUnit:GetMoves() > 0 and Players[iPlayer]:IsTurnActive() then
		--Only if the selected unit is an MG and its player has a grief seed
		if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL and MapModData.PMMM.GriefSeeds[iPlayer] > 0 then
			Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_GRIEF_SEED, pUnit:GetX(), pUnit:GetY(), 0, false, false)
			UpdateUnitStats(pUnit)
		else
			return
		end
	end
end
Controls.UnitStatRangedAttack:RegisterCallback(Mouse.eLClick, OnUnitRangedAttackBoxClicked)
Controls.UnitStatNameRangedAttack:RegisterCallback(Mouse.eLClick, OnUnitRangedAttackBoxClicked)
--PMMM Mod

--------------------------------------------------------------------------------
-- CycleLeft clicked event handler
--------------------------------------------------------------------------------
function OnCycleLeftClicked()
    -- Cycle to next selection.
    Game.CycleUnits(true, true, false);
end
Controls.CycleLeft:RegisterCallback( Mouse.eLClick, OnCycleLeftClicked );


--------------------------------------------------------------------------------
-- CycleRight clicked event handler
--------------------------------------------------------------------------------
function OnCycleRightClicked()
    -- Cycle to previous selection.
    Game.CycleUnits(true, false, false);
end
Controls.CycleRight:RegisterCallback( Mouse.eLClick, OnCycleRightClicked );

--------------------------------------------------------------------------------
-- Unit Name clicked event handler
--------------------------------------------------------------------------------
function OnUnitNameClicked()
    -- go to this unit
    UI.LookAtSelectionPlot(0);
end
Controls.UnitNameButton:RegisterCallback( Mouse.eLClick, OnUnitNameClicked );
Controls.UnitPortraitButton:RegisterCallback( Mouse.eLClick, OnUnitNameClicked );



function OnUnitRClicked()
	local unit = UI.GetHeadSelectedUnit();
	if unit then
		if unit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL and MapModData.PMMM.MagicalGirls[g_MGKey].OverrideIcon == nil then
			LuaEvents.PMMMOpenMGInfoPanel("Appearance")
		else
			-- search by name
			local searchString = Locale.ConvertTextKey( unit:GetNameKey() );
			Events.SearchForPediaEntry( searchString );
		end
	end
end
Controls.UnitPortraitButton:RegisterCallback( Mouse.eRClick, OnUnitRClicked );

--------------------------------------------------------------------------------
-- InfoPane is now dirty.
--------------------------------------------------------------------------------
function OnInfoPaneDirty()
    
    -- Retrieve the currently selected unit.
    local unit = UI.GetHeadSelectedUnit();
    local name = unit and unit:GetNameKey() or "unit is nil";
    local convertedKey = Locale.ConvertTextKey(name);
	
	--PMMM Mod Start
	g_MGKey = nil
	--PMMM Mod End
	
    
    local unitID = unit and unit:GetID() or -1;
    -- Unit is different than last unit.
    if(unitID ~= g_lastUnitID) then
        local playerID = Game.GetActivePlayer();
        local unitPosition = {
            x = unit and unit:GetX() or 0,
            y = unit and unit:GetY() or 0,
        };
        local hexPosition = ToHexFromGrid(unitPosition);
        
        if(g_lastUnitID ~= -1) then
            Events.UnitSelectionChanged(playerID, g_lastUnitID, 0, 0, 0, false, false);
        end
        
        if(unitID ~= -1) then
            Events.UnitSelectionChanged(playerID, unitID, hexPosition.x, hexPosition.y, 0, true, false);
        end
        
        g_SecondaryOpen = false;
        Controls.PrimaryStack:SetHide( true );
        Controls.PrimaryStretchy:SetHide( true );
        Controls.SecondaryStack:SetHide( true );
        Controls.SecondaryStretchy:SetHide( true );
        Controls.SecondaryImageOpen:SetHide( false );
        Controls.SecondaryImageClosed:SetHide( true );
        Controls.SecondaryButton:SetToolTipString( Locale.ConvertTextKey( "TXT_KEY_SECONDARY_C_TEXT" ));
    end
    g_lastUnitID = unitID;
    
    if (unit ~= nil) then
		--PMMM Mod Start: Get MG Key
		if unit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL then
			local iActivePlayer = Game:GetActivePlayer();
			for k, v in ipairs(MapModData.PMMM.MagicalGirls) do
				if v.UnitID == unitID and v.Owner == iActivePlayer then
					g_AppearanceChanges = {}
					g_MGKey = k
					RefreshMGInfo(unit, k)
					break
				end
			end
		else
			Controls.BodyPortrait:SetHide(true);
			Controls.OutfitPortrait:SetHide(true);
			Controls.FacePortrait:SetHide(true);
			Controls.HairPortrait:SetHide(true);
			Controls.FaceAccPortrait:SetHide(true);
			Controls.HairAccPortrait:SetHide(true);
		end
		local bShowMGStuff = not g_MGKey and true or false
		Controls.QuickMoodButton:SetHide(bShowMGStuff);
		--PMMM Mod End
        UpdateUnitActions(unit);
        UpdateUnitPortrait(unit);
        UpdateUnitPromotionsEx(unit);
        UpdateUnitStats(unit);
        UpdateUnitHealthBar(unit);
        ContextPtr:SetHide( false );
    else
		-- Attempt to show currently selected city.
		local city = UI.GetHeadSelectedCity();
		if(city ~= nil) then
	
			UpdateCityPortrait(city);
				
		    ContextPtr:SetHide( false );
    	else
		    ContextPtr:SetHide( true );
    	end
    
    end
    
end
Events.SerialEventUnitInfoDirty.Add(OnInfoPaneDirty);


local g_iPortraitSize = 256;
local bOkayToProcess = true;

--------------------------------------------------------------------------------
-- UnitAction<idx> was clicked.
--------------------------------------------------------------------------------
function OnUnitActionClicked( action )
	if bOkayToProcess then
		if (GameInfoActions[action].SubType == ActionSubTypes.ACTIONSUBTYPE_PROMOTION) then
			Events.AudioPlay2DSound("AS2D_INTERFACE_UNIT_PROMOTION");	
		end
		--PMMM Mod Start: Custom missions with targeting
		if GameInfoActions[action].MissionType > -1 then
			local targetType = GameInfo.Missions[GameInfoActions[action].MissionType].PMMMTargetType
			if targetType and type(targetType) == "string" then
				LuaEvents.PMMMSetCustomMissionInfo(Game:GetActivePlayer(), UI.GetHeadSelectedUnit():GetID(), GameInfoActions[action].MissionType)
			else
				Game.HandleAction( action );
			end
		else
			Game.HandleAction( action );
		end
		--PMMM Mod End
    end
end

function OnActivePlayerTurnEnd()
	bOkayToProcess = false;
end
Events.ActivePlayerTurnEnd.Add( OnActivePlayerTurnEnd );

function OnActivePlayerTurnStart()
	bOkayToProcess = true;
end
Events.ActivePlayerTurnStart.Add( OnActivePlayerTurnStart );

-------------------------------------------------
-------------------------------------------------
function OnEditNameClick()
	
	if UI.GetHeadSelectedUnit() then
		local popupInfo = {
				Type = ButtonPopupTypes.BUTTONPOPUP_RENAME_UNIT,
				Data1 = UI.GetHeadSelectedUnit():GetID(),
				Data2 = -1,
				Data3 = -1,
				Option1 = false,
				Option2 = false;
			}
		Events.SerialEventGameMessagePopup(popupInfo);
	end
end
Controls.EditButton:RegisterCallback( Mouse.eLClick, OnEditNameClick );

------------------------------------------------------
------------------------------------------------------
local tipControlTable = {};
TTManager:GetTypeControlTable( "TypeUnitAction", tipControlTable );
function TipHandler( control )
	
	local unit = UI.GetHeadSelectedUnit();
	if not unit then
		return
	end
	
	local iAction = control:GetVoid1();
    local action = GameInfoActions[iAction];
    
    local iActivePlayer = Game.GetActivePlayer();
    local pActivePlayer = Players[iActivePlayer];
    local iActiveTeam = Game.GetActiveTeam();
    local pActiveTeam = Teams[iActiveTeam];
    
    local pPlot = unit:GetPlot();
    
    local bBuild = false;

    local bDisabled = false;
	
	-- Build data
	local iBuildID = action.MissionData;
	local pBuild = GameInfo.Builds[iBuildID];
	local strBuildType= "";
	if (pBuild) then
		strBuildType = pBuild.Type;
	end
	
	-- Improvement data
	local iImprovement = -1;
	local pImprovement;
	
	if (pBuild) then
		iImprovement = pBuild.ImprovementType;
		
		if (iImprovement and iImprovement ~= "NONE") then
			pImprovement = GameInfo.Improvements[iImprovement];
			iImprovement = pImprovement.ID;
		end
	end
    
    -- Feature data
	local iFeature = unit:GetPlot():GetFeatureType();
	local pFeature = GameInfo.Features[iFeature];
	local strFeatureType;
	if (pFeature) then
		strFeatureType = pFeature.Type;
	end
	
	-- Route data
	local iRoute = -1;
	local pRoute;
	
	if (pBuild) then
		iRoute = pBuild.RouteType
		
		if (iRoute and iRoute ~= "NONE") then
			pRoute = GameInfo.Routes[iRoute];
			iRoute = pRoute.ID;
		end
	end
	
	local strBuildTurnsString = "";
	local strBuildResourceConnectionString = "";
	local strClearFeatureString = "";
	local strBuildYieldString = "";
	
	local bFirstEntry = true;
	
	local strToolTip = "";
	
    local strDisabledString = "";
    
    local strActionHelp = "";
    
    -- Not able to perform action
    if not Game.CanHandleAction( iAction ) then
		bDisabled = true;
	end
    
    -- Upgrade has special help text
    if (action.Type == "COMMAND_UPGRADE") then
		
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strActionHelp = strActionHelp .. "[NEWLINE]";
		end
		
		strActionHelp = strActionHelp .. "[NEWLINE]";
		
		local iUnitType = unit:GetUpgradeUnitType();
		local iGoldToUpgrade = unit:UpgradePrice(iUnitType);
		strActionHelp = strActionHelp .. Locale.ConvertTextKey("TXT_KEY_UPGRADE_HELP", GameInfo.Units[iUnitType].Description, iGoldToUpgrade);
		
        strToolTip = strToolTip .. strActionHelp;
        
		if bDisabled then
			
			local pActivePlayer = Players[Game.GetActivePlayer()];
			
			-- Can't upgrade because we're outside our territory
			if (pPlot:GetOwner() ~= unit:GetOwner()) then
				
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE][NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_UPGRADE_HELP_DISABLED_TERRITORY");
			end
			
			-- Can't upgrade because we're outside of a city
			if (unit:GetDomainType() == DomainTypes.DOMAIN_AIR and not pPlot:IsCity()) then
				
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE][NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_UPGRADE_HELP_DISABLED_CITY");
			end
			
			-- Can't upgrade because we lack the Gold
			if (iGoldToUpgrade > pActivePlayer:GetGold()) then
				
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE][NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_UPGRADE_HELP_DISABLED_GOLD");
			end
			
			-- Can't upgrade because we lack the Resources
			local strResourcesNeeded = "";
			
			local iNumResourceNeededToUpgrade;
			local iResourceLoop;
			
			-- Loop through all resources to see how many we need. If it's > 0 then add to the string
			for pResource in GameInfo.Resources() do
				iResourceLoop = pResource.ID;
				
				iNumResourceNeededToUpgrade = unit:GetNumResourceNeededToUpgrade(iResourceLoop);
				
				if (iNumResourceNeededToUpgrade > 0 and iNumResourceNeededToUpgrade > pActivePlayer:GetNumResourceAvailable(iResourceLoop)) then
					-- Add separator for non-initial entries
					if (strResourcesNeeded ~= "") then
						strResourcesNeeded = strResourcesNeeded .. ", ";
					end
					
					strResourcesNeeded = strResourcesNeeded .. iNumResourceNeededToUpgrade .. " " .. pResource.IconString .. " " .. Locale.ConvertTextKey(pResource.Description);
				end
			end
			
			-- Build resources required string
			if (strResourcesNeeded ~= "") then
				
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE][NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_UPGRADE_HELP_DISABLED_RESOURCES", strResourcesNeeded);
			end
    
    	        -- if we can't upgrade due to stacking
	        if (pPlot:GetNumFriendlyUnitsOfType(unit) > 1) then
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE][NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_UPGRADE_HELP_DISABLED_STACKING");

	        end
    
	        strDisabledString = "[COLOR_WARNING_TEXT]" .. strDisabledString .. "[ENDCOLOR]";	        
		end
    end
    
    if (action.Type == "MISSION_ALERT" and not unit:IsEverFortifyable()) then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strActionHelp = strActionHelp .. "[NEWLINE]";
		end

		strActionHelp = "[NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_MISSION_ALERT_NO_FORTIFY_HELP");
		strToolTip = strToolTip .. strActionHelp;

    -- Golden Age has special help text
    elseif (action.Type == "MISSION_GOLDEN_AGE") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strActionHelp = strActionHelp .. "[NEWLINE]";
		end
		
		local iGALength = unit:GetGoldenAgeTurns();
		strActionHelp = "[NEWLINE]" .. Locale.ConvertTextKey( "TXT_KEY_MISSION_START_GOLDENAGE_HELP", iGALength );
        strToolTip = strToolTip .. strActionHelp;
		
    -- Spread Religion has special help text
    elseif (action.Type == "MISSION_SPREAD_RELIGION") then

		local iNumFollowers = unit:GetNumFollowersAfterSpread();
		local religionName = Game.GetReligionName(unit:GetReligion());

	
        strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_MISSION_SPREAD_RELIGION_HELP");
        strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
        strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_MISSION_SPREAD_RELIGION_RESULT", religionName, iNumFollowers);
		strToolTip = strToolTip .. " ";  
		    
 		local eMajorityReligion = unit:GetMajorityReligionAfterSpread();
        if (eMajorityReligion < ReligionTypes.RELIGION_PANTHEON) then
			strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_MISSION_MAJORITY_RELIGION_NONE");
		else
			local majorityReligionName = Locale.Lookup(Game.GetReligionName(eMajorityReligion));


			strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_MISSION_MAJORITY_RELIGION", majorityReligionName);		
		end

    -- Create Great Work has special help text
	elseif (isBNW and action.Type == "MISSION_CREATE_GREAT_WORK") then

		strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_MISSION_CREATE_GREAT_WORK_HELP");
		strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
	    
		if (not bDisabled) then
			local pActivePlayer = Players[Game.GetActivePlayer()];
			local eGreatWorkSlotType = unit:GetGreatWorkSlotType();
			local iBuilding = pActivePlayer:GetBuildingOfClosestGreatWorkSlot(unit:GetX(), unit:GetY(), eGreatWorkSlotType);
			local pCity = pActivePlayer:GetCityOfClosestGreatWorkSlot(unit:GetX(), unit:GetY(), eGreatWorkSlotType);	
			strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_MISSION_CREATE_GREAT_WORK_RESULT", GameInfo.Buildings[iBuilding].Description, pCity:GetNameKey());
		end
	
	-- Paradrop
	elseif (action.Type == "INTERFACEMODE_PARADROP") then
		strToolTip = Locale.Lookup("TXT_KEY_INTERFACEMODE_PARADROP_HELP_WITH_RANGE", unit:GetDropRange());

	-- Sell Exotic Goods
	elseif (isBNW and action.Type == "MISSION_SELL_EXOTIC_GOODS") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_SELL_EXOTIC_GOODS_HELP");
		
		if (not bDisabled) then
			strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
			strToolTip = strToolTip .. "+" .. unit:GetExoticGoodsGoldAmount() .. "[ICON_GOLD]";
			strToolTip = strToolTip .. "[NEWLINE]";
			strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_EXPERIENCE_POPUP", unit:GetExoticGoodsXPAmount());
		end
	
	-- Great Scientist
	elseif (isBNW and action.Type == "MISSION_DISCOVER") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_DISCOVER_TECH_HELP");
		
		if (not bDisabled) then
			strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
			strToolTip = strToolTip .. "+" .. unit:GetDiscoverAmount() .. "[ICON_RESEARCH]";
		end
		
	-- Great Engineer
	elseif (isBNW and action.Type == "MISSION_HURRY") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_HURRY_PRODUCTION_HELP");
		
		if (not bDisabled) then
			strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
			strToolTip = strToolTip .. "+" .. unit:GetHurryProduction(unit:GetPlot()) .. "[ICON_PRODUCTION]";
		end
	
	-- Great Merchant
	elseif (isBNW and action.Type == "MISSION_TRADE") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_CONDUCT_TRADE_MISSION_HELP");
		
		if (not bDisabled) then
			strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
			strToolTip = strToolTip .. "+" .. unit:GetTradeInfluence(unit:GetPlot()) .. " [ICON_INFLUENCE]";
			strToolTip = strToolTip .. "[NEWLINE]";
			strToolTip = strToolTip .. "+" .. unit:GetTradeGold(unit:GetPlot()) .. "[ICON_GOLD]";
		end
		
	-- Great Writer
	elseif (isBNW and action.Type == "MISSION_GIVE_POLICIES") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_GIVE_POLICIES_HELP");
		
		if (not bDisabled) then
			strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
			strToolTip = strToolTip .. "+" .. unit:GetGivePoliciesCulture() .. "[ICON_CULTURE]";
		end
	
	-- Great Musician
	elseif (isBNW and action.Type == "MISSION_ONE_SHOT_TOURISM") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_ONE_SHOT_TOURISM_HELP");
		
		if (not bDisabled) then
			strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
			strToolTip = strToolTip .. "+" .. unit:GetBlastTourism() .. "[ICON_TOURISM]";
		end
		
	-- PMMM Mod Start
	--Great General
	elseif (isBNW and action.Type == "MISSION_PMMM_ROUSE_MILITIA") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_HELP");
		
		if (not bDisabled) then
			local ttable = {}
			LuaEvents.PMMMGetRouseMilitiaUnitsAndType(unit:GetOwner(), unit:GetID(), ttable)
			if ttable[0] then
				strToolTip = strToolTip .. "[NEWLINE]----------------[NEWLINE]";
				strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_ADDITIONAL_INFO", ttable[0], ttable[1])
			end
		end
		
	--Time Stop
	elseif (isBNW and action.Type == "MISSION_PMMM_TIME_STOP") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_PMMM_TIME_STOP_HELP");
		
		if bDisabled then
			local iPlayer = Game:GetActivePlayer()
			if (MapModData.PMMM.TimeStopDuration[iPlayer] and MapModData.PMMM.TimeStopDuration[iPlayer] > 0) then
				strToolTip = strToolTip .. "[NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_MISSION_PMMM_TIME_STOP_ACTIVE")
			elseif (MapModData.PMMM.TimeStopCooldown[iPlayer] and MapModData.PMMM.TimeStopCooldown[iPlayer] > 0) then
				strToolTip = strToolTip .. "[NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_MISSION_PMMM_TIME_STOP_COOLDOWN", PMMM.TimeStopCooldown[iPlayer])
			else
				strToolTip = strToolTip .. "[NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_MISSION_PMMM_TIME_STOP_DISABLED")
			end
		end

	--Time Stop
	elseif (isBNW and action.Type == "MISSION_PMMM_SPAR") then
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. "[NEWLINE]" .. Locale.Lookup("TXT_KEY_MISSION_PMMM_SPAR_HELP");
		
		if bDisabled and g_MGKey and MapModData.PMMM.MagicalGirls[g_MGKey].SparringCooldown then
			local iTurns = Game:GetGameTurn() - MapModData.PMMM.MagicalGirls[g_MGKey].SparringCooldown 
			if iTurns < GameDefines.MG_SPARRING_COOLDOWN then
				strToolTip = strToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.Lookup("TXT_KEY_MISSION_PMMM_SPAR_DISABLED_COOLDOWN", GameDefines.MG_SPARRING_COOLDOWN - iTurns).."[ENDCOLOR]"
			end
		end


	--PMMM Mod End

	--MSF Big Boss Missions
	elseif (isBNW and action.Type == "MISSION_MSF_OSP_UPGRADE") then
		local iUpgradeCost = unit:GetBaseCombatStrength() * 5
		local iUpgradeType = unit:GetUpgradeUnitType()
		local sUpgradeUnitDesc = Locale.ConvertTextKey(GameInfo.Units[iUpgradeType].Description)
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_ENEMY_TERRITORY_UPGRADE_BUTTON_TEXT", sUpgradeUnitDesc, iUpgradeCost)
		
		if MapModData.MSF.MSFSalvage[iActivePlayer] and MapModData.MSF.MSFSalvage[iActivePlayer] < iUpgradeCost then
			strToolTip = strToolTip .. "[NEWLINE][NEWLINE]" ..Locale.ConvertTextKey("TXT_KEY_ENEMY_TERRITORY_UPGRADE_BUTTON_NOT_ENOUGH_SALVAGE_TEXT")
		end
		
		local strResourcesNeeded = "";
		local iResourceLoop
		local iNumResourceNeededToUpgrade = 0;
		for pResource in GameInfo.Resources() do
			iResourceLoop = pResource.ID;
		
			iNumResourceNeededToUpgrade = unit:GetNumResourceNeededToUpgrade(iResourceLoop);
					
			if (iNumResourceNeededToUpgrade > 0 and iNumResourceNeededToUpgrade > Players[Game:GetActivePlayer()]:GetNumResourceAvailable(iResourceLoop)) then
				-- Add separator for non-initial entries
				if (strResourcesNeeded ~= "") then
					strResourcesNeeded = strResourcesNeeded .. ", ";
				end
				
				strResourcesNeeded = strResourcesNeeded .. iNumResourceNeededToUpgrade .. " " .. pResource.IconString .. " " .. Locale.ConvertTextKey(pResource.Description);
			end
		end
				
		-- Build resources required string
		if (strResourcesNeeded ~= "") then
			strToolTip = strToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_UPGRADE_HELP_DISABLED_RESOURCES", strResourcesNeeded) .. "[ENDCOLOR]";
		end
	
	elseif (isBNW and action.Type == "MISSION_MSF_MG_UPGRADE") then
		local iUpgradeCost = math.floor((unit:GetBaseCombatStrength() ^ 2) / 8)
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strToolTip = strToolTip .. "[NEWLINE]";
		end
		
		strToolTip = strToolTip .. Locale.ConvertTextKey("TXT_KEY_METAL_GEAR_UPGRADE_BUTTON_TEXT", iUpgradeCost)
			
		if MapModData.MSF.MSFSalvage[iActivePlayer] and MapModData.MSF.MSFSalvage[iActivePlayer] < iUpgradeCost then
			strToolTip = strToolTip .. "[NEWLINE][NEWLINE]" ..Locale.ConvertTextKey("TXT_KEY_ENEMY_TERRITORY_UPGRADE_BUTTON_NOT_ENOUGH_SALVAGE_TEXT")
		end
		if unit:GetPlot() ~= Players[iActivePlayer]:GetCapitalCity():Plot() then
			strToolTip = strToolTip .. "[NEWLINE][NEWLINE]" ..Locale.ConvertTextKey("TXT_KEY_METAL_GEAR_UPGRADE_BUTTON_NOT_IN_CAPITAL_TEXT")
		end	
		
	-- MSF Big Boss Missions End
	
    -- Help text
    elseif (action.Help and action.Help ~= "") then
		
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strActionHelp = strActionHelp .. "[NEWLINE]";
		end
		
		strActionHelp = "[NEWLINE]" .. Locale.ConvertTextKey( action.Help );
        strToolTip = strToolTip .. strActionHelp;
	end
    
    -- Delete has special help text
    if (action.Type == "COMMAND_DELETE") then
		
		strActionHelp = "";
		
		-- Add spacing for all entries after the first
		if (bFirstEntry) then
			bFirstEntry = false;
		elseif (not bFirstEntry) then
			strActionHelp = strActionHelp .. "[NEWLINE]";
		end
		
		strActionHelp = strActionHelp .. "[NEWLINE]";
		
		local iGoldToScrap = unit:GetScrapGold();
		
		strActionHelp = strActionHelp .. Locale.ConvertTextKey("TXT_KEY_SCRAP_HELP", iGoldToScrap);
		
        strToolTip = strToolTip .. strActionHelp;
	end
	
	-- Build?
    if (action.SubType == ActionSubTypes.ACTIONSUBTYPE_BUILD) then
		bBuild = true;
	end
	
    -- Not able to perform action
    if (bDisabled) then
		
		-- Worker build
		if (bBuild) then
			
			-- Figure out what the name of the thing is that we're looking at
			local strImpRouteKey = "";
			if (pImprovement) then
				strImpRouteKey = pImprovement.Description;
			elseif (pRoute) then
				strImpRouteKey = pRoute.Description;
			end
			
			-- Don't have Tech for Build?
			if (pBuild.PrereqTech ~= nil) then
				local pPrereqTech = GameInfo.Technologies[pBuild.PrereqTech];
				local iPrereqTech = pPrereqTech.ID;
				if (iPrereqTech ~= -1 and not pActiveTeam:GetTeamTechs():HasTech(iPrereqTech)) then
					
					-- Must not be a build which constructs something
					if (pImprovement or pRoute) then
						
						-- Add spacing for all entries after the first
						if (bFirstEntry) then
							bFirstEntry = false;
						elseif (not bFirstEntry) then
							strDisabledString = strDisabledString .. "[NEWLINE]";
						end
						
						strDisabledString = strDisabledString .. "[NEWLINE]";
						strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_PREREQ_TECH", pPrereqTech.Description, strImpRouteKey);
					end
				end
			end
			
			-- Trying to build something and are not adjacent to our territory?
			if (pImprovement and pImprovement.InAdjacentFriendly) then
				if (pPlot:GetTeam() ~= unit:GetTeam()) then
					if (not pPlot:IsAdjacentTeam(unit:GetTeam(), true)) then

					
						-- Add spacing for all entries after the first
						if (bFirstEntry) then
							bFirstEntry = false;
						elseif (not bFirstEntry) then
							strDisabledString = strDisabledString .. "[NEWLINE]";
						end
					
						strDisabledString = strDisabledString .. "[NEWLINE]";
						strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_NOT_IN_ADJACENT_TERRITORY", strImpRouteKey);
					end
				end
				
			-- Trying to build something in a City-State's territory?
			elseif (isBNW and pImprovement and pImprovement.OnlyCityStateTerritory) then
				local bCityStateTerritory = false;
				if (pPlot:IsOwned()) then
					local pPlotOwner = Players[pPlot:GetOwner()];
					if (pPlotOwner and pPlotOwner:IsMinorCiv()) then
						bCityStateTerritory = true;
					end
				end
				
				if (not bCityStateTerritory) then
					-- Add spacing for all entries after the first
					if (bFirstEntry) then
						bFirstEntry = false;
					elseif (not bFirstEntry) then
						strDisabledString = strDisabledString .. "[NEWLINE]";
					end
					
					strDisabledString = strDisabledString .. "[NEWLINE]";
					strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_NOT_IN_CITY_STATE_TERRITORY", strImpRouteKey);
				end	

			-- Trying to build something outside of our territory?
			elseif (pImprovement and not pImprovement.OutsideBorders) then
				if (pPlot:GetTeam() ~= unit:GetTeam()) then
				
					
					-- Add spacing for all entries after the first
					if (bFirstEntry) then
						bFirstEntry = false;
					elseif (not bFirstEntry) then
						strDisabledString = strDisabledString .. "[NEWLINE]";
					end
					
					strDisabledString = strDisabledString .. "[NEWLINE]";
					strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_OUTSIDE_TERRITORY", strImpRouteKey);
				end
			end
			
			-- Trying to build something that requires an adjacent luxury?
			if (isBNW and pImprovement and pImprovement.AdjacentLuxury) then
				local bAdjacentLuxury = false;

				for loop, direction in ipairs(direction_types) do
					local adjacentPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction);
					if (adjacentPlot ~= nil) then
						local eResourceType = adjacentPlot:GetResourceType();
						if (eResourceType ~= -1) then
							if (Game.GetResourceUsageType(eResourceType) == ResourceUsageTypes.RESOURCEUSAGE_LUXURY) then
								bAdjacentLuxury = true;
							end
						end
					end
				end
				
				if (not bAdjacentLuxury) then
					-- Add spacing for all entries after the first
					if (bFirstEntry) then
						bFirstEntry = false;
					elseif (not bFirstEntry) then
						strDisabledString = strDisabledString .. "[NEWLINE]";
					end
					
					strDisabledString = strDisabledString .. "[NEWLINE]";
					strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_NO_ADJACENT_LUXURY", strImpRouteKey);
				end
			end
			
			-- Trying to build something where we can't have two adjacent?
			if (isBNW and pImprovement and pImprovement.NoTwoAdjacent) then
				local bTwoAdjacent = false;

				 for loop, direction in ipairs(direction_types) do
					local adjacentPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction);
					if (adjacentPlot ~= nil) then
						local eImprovementType = adjacentPlot:GetImprovementType();
						if (eImprovementType ~= -1) then
							if (eImprovementType == iImprovement) then
								bTwoAdjacent = true;
							end
						end
						local iBuildProgress = adjacentPlot:GetBuildProgress(iBuildID);
						if (iBuildProgress > 0) then
							bTwoAdjacent = true;
						end
					end
				end
				
				if (bTwoAdjacent) then
					-- Add spacing for all entries after the first
					if (bFirstEntry) then
						bFirstEntry = false;
					elseif (not bFirstEntry) then
						strDisabledString = strDisabledString .. "[NEWLINE]";
					end
					
					strDisabledString = strDisabledString .. "[NEWLINE]";
					strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_CANNOT_BE_ADJACENT", strImpRouteKey);
				end
			end
			
			-- Build blocked by a feature here?
			if (pActivePlayer:IsBuildBlockedByFeature(iBuildID, iFeature)) then
				local iFeatureTech;
				
				local filter = "BuildType = '" .. strBuildType .. "' and FeatureType = '" .. strFeatureType .. "'";
				for row in GameInfo.BuildFeatures(filter) do
					iFeatureTech = GameInfo.Technologies[row.PrereqTech].ID;
				end
				
				local pFeatureTech = GameInfo.Technologies[iFeatureTech];
				
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. "[NEWLINE]";
				strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_BY_FEATURE", pFeatureTech.Description, pFeature.Description);
			end
			
		-- Not a Worker build, use normal disabled help from XML
		else
			
            if (action.Type == "MISSION_FOUND" and pActivePlayer:IsEmpireVeryUnhappy()) then
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE][NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_MISSION_BUILD_CITY_DISABLED_UNHAPPY");
			
            elseif (action.Type == "MISSION_CULTURE_BOMB" and pActivePlayer:GetCultureBombTimer() > 0) then
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE][NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. Locale.ConvertTextKey("TXT_KEY_MISSION_CULTURE_BOMB_DISABLED_COOLDOWN", pActivePlayer:GetCultureBombTimer());
				
			elseif (action.DisabledHelp and action.DisabledHelp ~= "") then
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strDisabledString = strDisabledString .. "[NEWLINE][NEWLINE]";
				end
				
				strDisabledString = strDisabledString .. Locale.ConvertTextKey(action.DisabledHelp);
			end
		end
		
        strDisabledString = "[COLOR_WARNING_TEXT]" .. strDisabledString .. "[ENDCOLOR]";
        strToolTip = strToolTip .. strDisabledString;
        
    end
    
	-- Is this a Worker build?
	if (bBuild) then
		
		local iExtraBuildRate = 0;
		
		-- Are we building anything right now?
		local iCurrentBuildID = unit:GetBuildType();
		if (iCurrentBuildID == -1 or iBuildID ~= iCurrentBuildID) then
			iExtraBuildRate = unit:WorkRate(true, iBuildID);
		end
		
		local iBuildTurns = pPlot:GetBuildTurnsLeft(iBuildID, Game.GetActivePlayer(), iExtraBuildRate, iExtraBuildRate);
		--print("iBuildTurns: " .. iBuildTurns);
		if (iBuildTurns > 1) then
			strBuildTurnsString = " ... " .. Locale.ConvertTextKey("TXT_KEY_BUILD_NUM_TURNS", iBuildTurns);
		end
		
		-- Extra Yield from this build
		local iYieldChange;
		
		local bFirstYield = true;
		
		for iYield = 0, YieldTypes.NUM_YIELD_TYPES-1, 1 
		do
			iYieldChange = pPlot:GetYieldWithBuild(iBuildID, iYield, false, iActivePlayer);
			iYieldChange = iYieldChange - pPlot:CalculateYield(iYield);
			
			if (iYieldChange ~= 0) then
				
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					--strBuildYieldString = strBuildYieldString .. "[NEWLINE]";
					bFirstEntry = false;
				elseif (not bFirstEntry and bFirstYield) then
					strBuildYieldString = strBuildYieldString .. "[NEWLINE]";
				end
				
				strBuildYieldString = strBuildYieldString .. "[NEWLINE]";
				
				-- Positive or negative change?
				if (iYieldChange > -1) then
					strBuildYieldString = strBuildYieldString .. "[COLOR_POSITIVE_TEXT]+";
				else
					strBuildYieldString = strBuildYieldString .. "[COLOR_NEGATIVE_TEXT]";
				end
				
				if (iYield == YieldTypes.YIELD_FOOD) then
					strBuildYieldString = strBuildYieldString .. Locale.ConvertTextKey("TXT_KEY_BUILD_FOOD_STRING", iYieldChange);
				elseif (iYield == YieldTypes.YIELD_PRODUCTION) then
					strBuildYieldString = strBuildYieldString .. Locale.ConvertTextKey("TXT_KEY_BUILD_PRODUCTION_STRING", iYieldChange);
				elseif (iYield == YieldTypes.YIELD_GOLD) then
					strBuildYieldString = strBuildYieldString .. Locale.ConvertTextKey("TXT_KEY_BUILD_GOLD_STRING", iYieldChange);
				elseif (iYield == YieldTypes.YIELD_SCIENCE) then
					strBuildYieldString = strBuildYieldString .. Locale.ConvertTextKey("TXT_KEY_BUILD_SCIENCE_STRING", iYieldChange);
				elseif (iYield == YieldTypes.YIELD_CULTURE) then
					strBuildYieldString = strBuildYieldString .. Locale.ConvertTextKey("TXT_KEY_BUILD_CULTURE_STRING", iYieldChange);
				elseif (iYield == YieldTypes.YIELD_FAITH) then
					strBuildYieldString = strBuildYieldString .. Locale.ConvertTextKey("TXT_KEY_BUILD_FAITH_STRING", iYieldChange);
				end
				
				bFirstYield = false;
			end
		end
		
        strToolTip = strToolTip .. strBuildYieldString;
		
		-- Resource connection
		if (pImprovement) then 
			local iResourceID = pPlot:GetResourceType(iActiveTeam);
			if (iResourceID ~= -1) then
				if (pPlot:IsResourceConnectedByImprovement(iImprovement)) then
					if (Game.GetResourceUsageType(iResourceID) ~= ResourceUsageTypes.RESOURCEUSAGE_BONUS) then
						local pResource = GameInfo.Resources[pPlot:GetResourceType(iActiveTeam)];
						local strResourceString = pResource.Description;
						
						-- Add spacing for all entries after the first
						if (bFirstEntry) then
							bFirstEntry = false;
						elseif (not bFirstEntry) then
							strBuildResourceConnectionString = strBuildResourceConnectionString .. "[NEWLINE]";
						end
						
						strBuildResourceConnectionString = strBuildResourceConnectionString .. "[NEWLINE]";
						strBuildResourceConnectionString = strBuildResourceConnectionString .. Locale.ConvertTextKey("TXT_KEY_BUILD_CONNECTS_RESOURCE", pResource.IconString, strResourceString);
						
						strToolTip = strToolTip .. strBuildResourceConnectionString;
					end
				end
			end
		end
		
		-- Production for clearing a feature
		if (pFeature) then
			local bFeatureRemoved = pPlot:IsBuildRemovesFeature(iBuildID);
			if (bFeatureRemoved) then
				
				-- Add spacing for all entries after the first
				if (bFirstEntry) then
					bFirstEntry = false;
				elseif (not bFirstEntry) then
					strClearFeatureString = strClearFeatureString .. "[NEWLINE]";
				end
				
				strClearFeatureString = strClearFeatureString .. "[NEWLINE]";
				strClearFeatureString = strClearFeatureString .. Locale.ConvertTextKey("TXT_KEY_BUILD_FEATURE_CLEARED", pFeature.Description);
			end
			
			local iFeatureProduction = pPlot:GetFeatureProduction(iBuildID, iActiveTeam);
			if (iFeatureProduction > 0) then
				strClearFeatureString = strClearFeatureString .. Locale.ConvertTextKey("TXT_KEY_BUILD_FEATURE_PRODUCTION", iFeatureProduction);
				
			-- Add period to end if we're not going to append info about feature production
			elseif (bFeatureRemoved) then
				strClearFeatureString = strClearFeatureString .. ".";
			end
			
			strToolTip = strToolTip .. strClearFeatureString;
		end
	end
    
    -- Tooltip
    if (strToolTip and strToolTip ~= "") then
        tipControlTable.UnitActionHelp:SetText( strToolTip );
    end
	
	-- Title
    local text = action.TextKey or action.Type or "Action"..(buttonIndex - 1);
    local strTitleString = "[COLOR_POSITIVE_TEXT]" .. Locale.ConvertTextKey( text ) .. "[ENDCOLOR]".. strBuildTurnsString;
    tipControlTable.UnitActionText:SetText( strTitleString );
    
    -- HotKey
    if action.SubType == ActionSubTypes.ACTIONSUBTYPE_PROMOTION then
        tipControlTable.UnitActionHotKey:SetText( "" );
    elseif action.HotKey and action.HotKey ~= "" then
        tipControlTable.UnitActionHotKey:SetText( "("..tostring(action.HotKey)..")" );
    else
        tipControlTable.UnitActionHotKey:SetText( "" );
    end
    
    -- Autosize tooltip
    tipControlTable.UnitActionMouseover:DoAutoSize();
    local mouseoverSize = tipControlTable.UnitActionMouseover:GetSize();
    if mouseoverSize.x < 350 then
		tipControlTable.UnitActionMouseover:SetSizeVal( 350, mouseoverSize.y );
    end

end


function ShowHideHandler( bIshide, bIsInit )
    if( bIshide ) then
        local EnemyUnitPanel = ContextPtr:LookUpControl( "/InGame/WorldView/EnemyUnitPanel" );
        if( EnemyUnitPanel ~= nil ) then
            EnemyUnitPanel:SetHide( true );
        end
    end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );


function IsModActive(sModID, iModMinVersion)
  for _, mod in pairs(Modding.GetActivatedMods()) do
    if (mod.ID == sModID) then
	  return (mod.Version >= iModMinVersion)
	end
  end
end

function OnUpgradeTreeButton()
  if (IsModActive("2b785940-9838-4c64-b76c-20e5d6f97024", 1)) then
    LuaEvents.UpgradeTreeDisplay(UI.GetHeadSelectedUnit():GetID())
  end
end
Controls.UnitFlagButton:RegisterCallback( Mouse.eRClick, OnUpgradeTreeButton );

function OnPromotionTreeButton()
  LuaEvents.PromotionTreeDisplay(UI.GetHeadSelectedUnit():GetID())
end
if (IsModActive("1f0a153b-26ae-4496-a2c0-a106d9b43c95", 3)) then
	Controls.PromotionText:RegisterCallback(Mouse.eLClick, OnPromotionTreeButton)
else
	Controls.PromotionText:SetToolTipString(nil)
end

Controls.UnitNameButton:RegisterCallback( Mouse.eRClick, OnEditNameClick );

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnActivePlayerChanged(iActivePlayer, iPrevActivePlayer)
	g_lastUnitID = -1;
	OnInfoPaneDirty();
end
Events.GameplaySetActivePlayer.Add(OnActivePlayerChanged);

function OnEnemyPanelHide( bIsEnemyPanelHide )
    if( g_bWorkerActionPanelOpen ) then
        Controls.WorkerActionPanel:SetHide( not bIsEnemyPanelHide );
    end
end
LuaEvents.EnemyPanelHide.Add( OnEnemyPanelHide );

OnInfoPaneDirty();


----------------------------------------------------------------
-- PMMM Mod Functions
----------------------------------------------------------------

--Small assets need the Mood button relocated

if OptionsManager.GetSmallUIAssets() then
	Controls.QuickMoodButton:SetSizeX(82)
	Controls.QuickMoodButton:SetOffsetX(50)
	Controls.QuickMoodButton:SetOffsetY(10)
	Controls.QuickMoodButtonLabel:SetFontByName("TwCenMT14")
	Controls.QuickMoodButtonLabel:SetOffsetY(10)
end


function RefreshMagicalGirlPortrait(unit)
	if g_MGKey then
		print("Magical Girl selected with key ID "..g_MGKey)
		if MagicalGirls[g_MGKey].OverrideIcon ~= nil then
			textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].OverrideIcon[2], unitPortraitSize, MagicalGirls[g_MGKey].OverrideIcon[1]);
			if textureOffset == nil then
				textureOffset = nullOffset;
				textureAtlas = defaultErrorTextureSheet;
			end
			Controls.BodyPortrait:SetHide(true);
			Controls.OutfitPortrait:SetHide(true);
			Controls.FacePortrait:SetHide(true);
			Controls.HairPortrait:SetHide(true);
			Controls.FaceAccPortrait:SetHide(true);
			Controls.HairAccPortrait:SetHide(true);
			Controls.UnitPortrait:SetTexture(textureAtlas);
			Controls.UnitPortrait:SetTextureOffset(textureOffset);
		else
			if g_AppearanceChanges[1] then
				textureOffset, textureAtlas = IconLookup( g_AppearanceChanges[1][2], unitPortraitSize, g_AppearanceChanges[1][1]);
				if textureOffset ~= nil then
					Controls.BodyPortrait:SetTexture(textureAtlas);
					Controls.BodyPortrait:SetTextureOffset(textureOffset);
					Controls.BodyPortrait:SetHide(false);
				else
					Controls.BodyPortrait:SetHide(true);
				end
			elseif MagicalGirls[g_MGKey].BodyIcon then
				textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].BodyIcon[2], unitPortraitSize, MagicalGirls[g_MGKey].BodyIcon[1]);
				if textureOffset ~= nil then
					Controls.BodyPortrait:SetTexture(textureAtlas);
					Controls.BodyPortrait:SetTextureOffset(textureOffset);
					Controls.BodyPortrait:SetHide(false);
				else
					Controls.BodyPortrait:SetHide(true);
				end
			end
			if g_AppearanceChanges[2] then
				textureOffset, textureAtlas = IconLookup( g_AppearanceChanges[2][2], unitPortraitSize, g_AppearanceChanges[2][1]);
				if textureOffset ~= nil then
					Controls.BodyPortrait:SetTexture(textureAtlas);
					Controls.BodyPortrait:SetTextureOffset(textureOffset);
					Controls.BodyPortrait:SetHide(false);
				else
					Controls.BodyPortrait:SetHide(true);
				end
			elseif MagicalGirls[g_MGKey].OutfitIcon then
				textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].OutfitIcon[2], unitPortraitSize, MagicalGirls[g_MGKey].OutfitIcon[1]);
				if textureOffset ~= nil then
					Controls.OutfitPortrait:SetTexture(textureAtlas);
					Controls.OutfitPortrait:SetTextureOffset(textureOffset);
					Controls.OutfitPortrait:SetHide(false);
				else
					Controls.OutfitPortrait:SetHide(true);
				end
			end
			if g_AppearanceChanges[3] then
				textureOffset, textureAtlas = IconLookup( g_AppearanceChanges[3][2], unitPortraitSize, g_AppearanceChanges[3][1]);
				if textureOffset ~= nil then
					Controls.BodyPortrait:SetTexture(textureAtlas);
					Controls.BodyPortrait:SetTextureOffset(textureOffset);
					Controls.BodyPortrait:SetHide(false);
				else
					Controls.BodyPortrait:SetHide(true);
				end
			elseif MagicalGirls[g_MGKey].FaceIcon then
				--Faces have Moods to change them
				if MagicalGirls[g_MGKey].MoodLevel then
					local sFExp = GameInfo.MG_Moods[MagicalGirls[g_MGKey].MoodLevel].FacialExpression
					local iFaceType = MagicalGirls[g_MGKey].FaceIcon[3]
					local face = GameInfo.MG_IconFaces[iFaceType]
					if sFExp == "ANGRY" then
						textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].FaceIcon[2], unitPortraitSize, face.AngryIconAtlas);
					elseif sFExp == "DEPRESSED" then
						textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].FaceIcon[2], unitPortraitSize, face.DepressedIconAtlas);
					elseif sFExp == "HAPPY" then
						textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].FaceIcon[2], unitPortraitSize, face.HappyIconAtlas);
					elseif sFExp == "JOYOUS" then
						textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].FaceIcon[2], unitPortraitSize, face.JoyousIconAtlas);
					else
						textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].FaceIcon[2], unitPortraitSize, face.IconAtlas);
					end
				else
					textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].FaceIcon[2], unitPortraitSize, MagicalGirls[g_MGKey].FaceIcon[1]);
				end
				if textureOffset ~= nil then
					Controls.FacePortrait:SetTexture(textureAtlas);
					Controls.FacePortrait:SetTextureOffset(textureOffset);
					Controls.FacePortrait:SetHide(false);
				else
					Controls.FacePortrait:SetHide(true);
				end
			end
			if g_AppearanceChanges[4] then
				textureOffset, textureAtlas = IconLookup( g_AppearanceChanges[4][2], unitPortraitSize, g_AppearanceChanges[4][1]);
				if textureOffset ~= nil then
					Controls.BodyPortrait:SetTexture(textureAtlas);
					Controls.BodyPortrait:SetTextureOffset(textureOffset);
					Controls.BodyPortrait:SetHide(false);
				else
					Controls.BodyPortrait:SetHide(true);
				end
			elseif MagicalGirls[g_MGKey].HairIcon then
				textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].HairIcon[2], unitPortraitSize, MagicalGirls[g_MGKey].HairIcon[1]);
				if textureOffset ~= nil then
					Controls.HairPortrait:SetTexture(textureAtlas);
					Controls.HairPortrait:SetTextureOffset(textureOffset);
					Controls.HairPortrait:SetHide(false);
				else
					Controls.HairPortrait:SetHide(true);
				end
			end
			if g_AppearanceChanges[5] then
				textureOffset, textureAtlas = IconLookup( g_AppearanceChanges[4][2], unitPortraitSize, g_AppearanceChanges[4][1]);
				if textureOffset ~= nil then
					Controls.BodyPortrait:SetTexture(textureAtlas);
					Controls.BodyPortrait:SetTextureOffset(textureOffset);
					Controls.BodyPortrait:SetHide(false);
				else
					Controls.BodyPortrait:SetHide(true);
				end
			elseif MagicalGirls[g_MGKey].FaceAccessory then
				if MagicalGirls[g_MGKey].FaceAccessory[3] > -1 then
					textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].FaceAccessory[2], unitPortraitSize, MagicalGirls[g_MGKey].FaceAccessory[1]);
					if textureOffset ~= nil then
						Controls.FaceAccPortrait:SetTexture(textureAtlas);
						Controls.FaceAccPortrait:SetTextureOffset(textureOffset);
						Controls.FaceAccPortrait:SetHide(false);
					else
						Controls.FaceAccPortrait:SetHide(true);
					end
				else
					Controls.FaceAccPortrait:SetHide(true);
				end
			end
			if g_AppearanceChanges[6] then
				textureOffset, textureAtlas = IconLookup( g_AppearanceChanges[4][2], unitPortraitSize, g_AppearanceChanges[4][1]);
				if textureOffset ~= nil then
					Controls.BodyPortrait:SetTexture(textureAtlas);
					Controls.BodyPortrait:SetTextureOffset(textureOffset);
					Controls.BodyPortrait:SetHide(false);
				else
					Controls.BodyPortrait:SetHide(true);
				end
			elseif MagicalGirls[g_MGKey].HairAccessory then
				if MagicalGirls[g_MGKey].HairAccessory[3] > -1 then
					textureOffset, textureAtlas = IconLookup( MagicalGirls[g_MGKey].HairAccessory[2], unitPortraitSize, MagicalGirls[g_MGKey].HairAccessory[1]);
					if textureOffset ~= nil then
						Controls.HairAccPortrait:SetTexture(textureAtlas);
						Controls.HairAccPortrait:SetTextureOffset(textureOffset);
						Controls.HairAccPortrait:SetHide(false);
					else
						Controls.HairAccPortrait:SetHide(true);
					end
				else
					Controls.HairAccPortrait:SetHide(true);
				end
			end
			local sString = Locale.ConvertTextKey("TXT_KEY_PMMM_UPANEL_HOW_TO_CHANGE_APPEARANCE", MagicalGirls[g_MGKey].Name)
			Controls.BodyPortrait:SetToolTipString(sString);
			Controls.OutfitPortrait:SetToolTipString(sString);
			Controls.FacePortrait:SetToolTipString(sString);
			Controls.HairPortrait:SetToolTipString(sString);
			Controls.FaceAccPortrait:SetToolTipString(sString);
			Controls.HairAccPortrait:SetToolTipString(sString);
			textureOffset, textureAtlas = IconLookup( MapModData.gPMMMIconBuilderBackground[2], unitPortraitSize, MapModData.gPMMMIconBuilderBackground[1]);
			Controls.UnitPortrait:SetTexture(textureAtlas);
			Controls.UnitPortrait:SetTextureOffset(textureOffset);
		end
	else
		textureOffset, textureAtlas = IconLookup( MapModData.gPMMMIconBuilderBackground[2], unitPortraitSize, MapModData.gPMMMIconBuilderBackground[1]);
		Controls.UnitPortrait:SetTexture(textureAtlas);
		Controls.UnitPortrait:SetTextureOffset(textureOffset);
	end
end

LuaEvents.PMMMRefreshAppearance.Add(RefreshMagicalGirlPortrait)



function OnQuickMoodButtonClicked()
	LuaEvents.PMMMOpenMGInfoPanel("Mood")
end

Controls.QuickMoodButton:RegisterCallback(Mouse.eLClick, OnQuickMoodButtonClicked)


function RefreshMGInfo(unit, iMGKey)
	if unit and iMGKey then
		MagicalGirls = MapModData.PMMM.MagicalGirls
		g_MGKey = iMGKey
		local sMoodstring = string.upper(Locale.ConvertTextKey(GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].Description))
		if GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemCorruptionMod > 0 then
			sMoodstring = "[COLOR_WARNING_TEXT]"..sMoodstring.."[ENDCOLOR]"
		elseif GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemCorruptionMod < 0 then
			sMoodstring = "[COLOR_POSITIVE_TEXT]"..sMoodstring.."[ENDCOLOR]"
		end
		sMoodstring = "[ICON_PMMM_MOOD] "..sMoodstring
		local sMoodtooltip;
		if MagicalGirls[iMGKey].Mood < 0 then
			sMoodtooltip = "[COLOR_WARNING_TEXT] "..tostring(MagicalGirls[iMGKey].Mood).."[ENDCOLOR]"
		else
			sMoodtooltip = "[COLOR_POSITIVE_TEXT] +"..tostring(MagicalGirls[iMGKey].Mood).."[ENDCOLOR]"
		end
		sMoodtooltip = Locale.ConvertTextKey("TXT_KEY_PMMM_UPANEL_MOODBUTTON_TT", sMoodtooltip)
		Controls.QuickMoodButtonLabel:SetText(sMoodstring)
		Controls.QuickMoodButton:SetToolTipString(sMoodtooltip)
		RefreshMagicalGirlPortrait(unit)
	end
end