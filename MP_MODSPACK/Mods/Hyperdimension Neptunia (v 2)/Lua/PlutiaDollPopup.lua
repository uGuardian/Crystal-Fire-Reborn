-- PlutiaDollPopup
-- Author: Vice
-- DateCreated: 12/31/2015 9:25:50 PM
--------------------------------------------------------------


include( "IconSupport" );
include( "InstanceManager" );
local stackReserves = InstanceManager:new("ReserveInstance", "ReserveBox", Controls.ReserveStack)

local DOLL_PROD_TIME_BASE 		= math.floor(20 * (GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100))
local color1 = {19/255,32/255,46/255,60/255};
local color2 = {255/255,181/255,196/255,60/255};

g_SelectedReserve = nil;
g_SelectedSlot = nil;
g_SelectedProduction = nil;

--Data defined in PlutiaIrisHeartTraitScript
local tSewingKits = MapModData.gPlutiaSewingKits
local tDolls = MapModData.gPlutiaDollDefs
local tCuddleDollFunctions 		= MapModData.gCuddleDollFunctions
local tCuddleDollTooltips 		= MapModData.gCuddleDollTooltips
local tStressDollFunctions 		= MapModData.gStressDollFunctions
local tStressDollEndFunctions 	= MapModData.gStressDollEndFunctions
local tStressDollTooltips 		= MapModData.gStressDollTooltips 	

--Network Compatibility Trick
local PRODUCTION_SET_KEY = 64800
local CUDDLE_SET_KEY = 65800
local STRESS_SET_KEY = 66800
local WEAPON_SET_KEY = 67800
local PLAYTIME_SET_KEY = 68800

ContextPtr:SetHide(true)


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tooltip Functions
---------------------------------------------------------------------------------------------------------------------------------------------------------
function SewingKitUI(label, button)
	local HDNMod = MapModData.HDNMod
	local iPlayer = Game:GetActivePlayer()
	label:SetText(Locale.ConvertTextKey(tSewingKits[HDNMod.PlutiaSewingKits[iPlayer]].Name))
	label:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_SEWING_KIT_TOOLTIP", tSewingKits[HDNMod.PlutiaSewingKits[iPlayer]].TurnsReduction))
	if tSewingKits[HDNMod.PlutiaSewingKits[iPlayer] + 1] then
		button:SetText(Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_SEWING_KIT_BUTTON", tSewingKits[HDNMod.PlutiaSewingKits[iPlayer] + 1].Cost))
		button:SetDisabled(Players[iPlayer]:GetGold() < tSewingKits[HDNMod.PlutiaSewingKits[iPlayer] + 1].Cost)
		button:EnableToolTip(false)
	else
		button:SetText(Locale.ConvertTextKey("Max Upgrade Reached!"))
		button:SetDisabled(true)
		button:EnableToolTip(false)
	end
end


function GetCuddleEffectTooltip(dollType, control, tooltip)
	local iPlayer = Game:GetActivePlayer()
	local doll = tDolls[dollType]
	local sString = ""

	if doll and doll.CuddleEffect and doll.CuddleEffect.Function and tCuddleDollTooltips[doll.CuddleEffect.Function] then
		sString = tCuddleDollTooltips[doll.CuddleEffect.Function](iPlayer, doll.CuddleEffect.Data1 or nil, doll.CuddleEffect.Data2 or nil, doll.CuddleEffect.Data3 or nil)
	end

	if control then
		if tooltip then
			control:SetToolTipString(sString)
		else
			control:SetText(sString)
		end
	end
	return sString
end

function GetStressEffectTooltip(dollType, control, tooltip)
	local iPlayer = Game:GetActivePlayer()
	local doll = tDolls[dollType]
	local sString = ""

	if doll and doll.StressEffect and doll.StressEffect.Function and tStressDollTooltips[doll.StressEffect.Function] then
		sString = tStressDollTooltips[doll.StressEffect.Function](iPlayer, doll.StressEffect.Data1 or nil, doll.StressEffect.Data2 or nil, doll.StressEffect.Data3 or nil)
	end

	if control then
		if tooltip then
			control:SetToolTipString(sString)
		else
			control:SetText(sString)
		end
	end
	return sString
end

function GetWeaponEffectTooltip(dollType, control, tooltip)
	local iPlayer = Game:GetActivePlayer()
	local doll = tDolls[dollType]
	local sString = ""

	if doll and doll.WeaponPromo and GameInfo.UnitPromotions[doll.WeaponPromo] then
		sString = Locale.ConvertTextKey(GameInfo.UnitPromotions[doll.WeaponPromo].Description).."[NEWLINE]"..Locale.ConvertTextKey(GameInfo.UnitPromotions[doll.WeaponPromo].Help)
	end

	if control then
		if tooltip then
			control:SetToolTipString(sString)
		else
			control:SetText(sString)
		end
	end
	return sString
end

function GetPlaytimeEffectTooltip(dollType, control, tooltip)
	local iPlayer = Game:GetActivePlayer()
	local doll = tDolls[dollType]
	local sString = ""

	if doll and doll.Playtime and doll.Playtime.Building and GameInfo.Buildings[doll.Playtime.Building] then
		sString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_PLAYTIME", GameInfo.Buildings[doll.Playtime.Building].Help, doll.Playtime.Pop or 1)
	end

	if control then
		if tooltip then
			control:SetToolTipString(sString)
		else
			control:SetText(sString)
		end
	end
	return sString
end


function GetCompleteDollTooltip(dollType, control, tooltip)
	local iPlayer = Game:GetActivePlayer()
	local doll = tDolls[dollType]
	local sString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_EFFECT_AS", "TXT_KEY_VV_PLUTIA_CUDDLE")..
	"[NEWLINE]"..
	GetCuddleEffectTooltip(dollType)..
	"[NEWLINE][NEWLINE]"..
	Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_EFFECT_AS", "TXT_KEY_VV_PLUTIA_STRESS")..
	"[NEWLINE]"..
	GetStressEffectTooltip(dollType)..
	"[NEWLINE][NEWLINE]"..
	Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_EFFECT_AS", "TXT_KEY_VV_PLUTIA_WEAPON")..
	"[NEWLINE]"..
	GetWeaponEffectTooltip(dollType)..
	"[NEWLINE][NEWLINE]"..
	Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_EFFECT_AS", "TXT_KEY_VV_PLUTIA_PLAYTIME")..
	"[NEWLINE]"..
	GetPlaytimeEffectTooltip(dollType)
	
	local _, bCanMake = CanMakeDoll(iPlayer, dollType)
	if bCanMake == false then
		sString = sString.."[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]"..Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_DOLL_MUST_BE_FRIENDS", GameInfo.Leaders[tDolls[dollType].Leader].Description)
	end
	

	if control then
		if tooltip then
			control:SetToolTipString(sString)
		else
			control:SetText(sString)
		end
	end
	return sString
end


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Trait Checker
---------------------------------------------------------------------------------------------------------------------------------------------------------
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
function IsDollSystem(iPlayer)
	if iPlayer >= iMaxCivs then return false end
	local pPlayer = Players[iPlayer]
	local sLeaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
	if sLeaderType then
		local sTrait = GameInfo.Leader_Traits("LeaderType = '"..sLeaderType.."'")().TraitType
		if sTrait then
			local pTrait = GameInfo.Traits[sTrait]
			if pTrait and (pTrait.PlutiaDollSystem == 1 or pTrait.PlutiaDollSystem == true) then
				return true
			end
		end
	end
	return false
end

--Returns true for either UseOnly (Iris) or full (Plutia)
function IsDollSystemUseOnly(iPlayer)
	local pPlayer = Players[iPlayer]
	local sLeaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
	if sLeaderType then
		local sTrait = GameInfo.Leader_Traits("LeaderType = '"..sLeaderType.."'")().TraitType
		if sTrait then
			local pTrait = GameInfo.Traits[sTrait]
			if (pTrait and (pTrait.PlutiaDollSystem == 1 or pTrait.PlutiaDollSystem == true) or (pTrait.PlutiaDollSystemUseOnly == 1 or pTrait.PlutiaDollSystemUseOnly == true)) then
				return true
			end
		end
	end
	return false
end


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- DiploCorner Hookup
---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDiploCornerPopup()
	ContextPtr:SetHide(not ContextPtr:IsHidden())
end



function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
	if IsDollSystemUseOnly(Game:GetActivePlayer()) then
		  table.insert(additionalEntries, {
			text=Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_DOLL_OVERVIEW"), 
			call=OnDiploCornerPopup
		  })
	end
end

LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()


function OnSewingKitUpgradeClicked()
	LuaEvents.VV_UpgradeSewingKit(Game:GetActivePlayer())
	Refresh()
end
Controls.KitUpgradeButton:RegisterCallback(Mouse.eLClick, OnSewingKitUpgradeClicked)


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Refresh Screen Functions
---------------------------------------------------------------------------------------------------------------------------------------------------------
function SetSelected(i)
	print(i)
	if g_SelectedReserve == i then
		g_SelectedReserve = nil
	else
		g_SelectedReserve = i
	end
	PopulateEquippedDolls()
end

function CanMakeDoll(iPlayer, iType)
	--returns two booleans: first makes it show in the list, second makes it available to produce
	if not tDolls[iType].Leader then
		return true, true
	elseif iPlayer == tDolls[iType].Leader then
		return false, false
	else
		local iTeam = Teams[Players[iPlayer]:GetTeam()]
		local pOtherPlayer = Players[tDolls[iType].Leader]
		if pOtherPlayer:IsAlive() and Teams[pOtherPlayer:GetTeam()]:IsHasMet(iTeam) then
			if pOtherPlayer:IsDoF(iPlayer) then
				return true, true
			else
				return true, false
			end
		else
			return false, false
		end
	end
end

function BuildReserveDollList()
	local HDNMod = MapModData.HDNMod
	stackReserves:ResetInstances()
	local iPlayer = Game:GetActivePlayer()
	if not HDNMod.PlutiaReserveDolls[iPlayer] then return end
	local bCanSet = IsDollSystem(iPlayer)
	local bTickTock = false
	for k, v in pairs(HDNMod.PlutiaReserveDolls[iPlayer]) do
		local instance = stackReserves:GetInstance()
		instance.ReserveButton:LocalizeAndSetText(tDolls[v].Name)
		instance.ReserveButton:SetVoid1(k)
		instance.ReserveButton:SetDisabled(not bCanSet)
		instance.ReserveButton:RegisterCallback(Mouse.eLClick, SetSelected)
		
		
		--Reserve Dolls will show every effect of a Doll when moused over.
		GetCompleteDollTooltip(v, instance.ReserveButton, true)

		if(bTickTock == false) then
			instance.ReserveBox:SetColorVal(unpack(color1));
		else
			instance.ReserveBox:SetColorVal(unpack(color2));
		end
		bTickTock = not bTickTock;
		
		Controls.ReserveStack:CalculateSize()
		Controls.ReserveStack:ReprocessAnchoring()
		Controls.ReserveScrollPanel:CalculateInternalSize()
	end
end

function PopulateProductionDropdownAndMeter()
	local HDNMod = MapModData.HDNMod
	local tDolls = MapModData.gPlutiaDollDefs or {}
	local iPlayer = Game:GetActivePlayer()
	if HDNMod.PlutiaActiveProductionDoll[iPlayer] then
		Controls.ProductionList:GetButton():LocalizeAndSetText(tDolls[HDNMod.PlutiaActiveProductionDoll[iPlayer].Type].Name)
	else
		Controls.ProductionList:GetButton():SetText("")
	end

	local function AddToPulldown(control, text, id, bool)
		local controlTable = {};
		control:BuildEntry( "InstanceOne", controlTable );
		
		controlTable.Button:SetVoids(id, data);
		controlTable.Button:LocalizeAndSetText(text);
		GetCompleteDollTooltip(id, controlTable.Button, true)
		controlTable.Button:SetDisabled(not bool)
	end

	Controls.ProductionList:ClearEntries()
	for k, v in pairs(tDolls) do
		local bShow, bEnable = CanMakeDoll(iPlayer, k)
		if bShow == true then
			AddToPulldown(Controls.ProductionList, v.Name, k, bEnable)
		end
	end
	Controls.ProductionList:CalculateInternals();
	--This pulldown is too close to the bottom of the screen; make it expand upward instead of downward (thanks whoward for how to do this!)
	local offsetY = -(Controls.ProductionList:GetSizeY() + Controls.ProductionList:GetGrid():GetSizeY())
	Controls.ProductionList:GetGrid():SetOffsetVal(0, offsetY)
	Controls.ProductionList:RegisterSelectionCallback(function(v1, v2)
		if HDNMod.PlutiaActiveProductionDoll[iPlayer] then
			g_SelectedProduction = v1
			Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_CONFIRM_REPLACE_PRODUCTION")
			Controls.ChooseConfirm:SetHide(false)
		else
			Network.SendSellBuilding(Players[iPlayer]:GetCapitalCity():GetID(), v1 + PRODUCTION_SET_KEY)
			PopulateProductionDropdownAndMeter()
		end
	end)
	
	local iPercent = 0;
	local sTurnsLeftText = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_DOLL_PROGRESS")
	if HDNMod.PlutiaActiveProductionDoll[iPlayer] then
		local iTurnsNeededTotal = DOLL_PROD_TIME_BASE - tSewingKits[HDNMod.PlutiaSewingKits[iPlayer]].TurnsReduction
		sTurnsLeftText = sTurnsLeftText.." ("..(iTurnsNeededTotal - HDNMod.PlutiaActiveProductionDoll[iPlayer].TurnsLeft).."/"..iTurnsNeededTotal..")"
		iPercent = (iTurnsNeededTotal - HDNMod.PlutiaActiveProductionDoll[iPlayer].TurnsLeft) / iTurnsNeededTotal
	end
	Controls.DollProgressLabel:SetText(sTurnsLeftText)
	Controls.DollProgressMeter:SetPercent(iPercent)
	
	--If Iris Heart, you cannot set new production
	Controls.ProductionList:SetDisabled(not IsDollSystem(iPlayer))
end





function PopulateEquippedDolls()
	local HDNMod = MapModData.HDNMod
	local tDolls = MapModData.gPlutiaDollDefs or {}
	local iPlayer = Game:GetActivePlayer()


	--Set text for existing dolls in each slot
	if HDNMod.PlutiaCuddleDoll[iPlayer] then
		Controls.CuddleButton:LocalizeAndSetText(tDolls[HDNMod.PlutiaCuddleDoll[iPlayer].Type].Name)
		GetCuddleEffectTooltip(HDNMod.PlutiaCuddleDoll[iPlayer].Type, Controls.CuddleText)
		Controls.CuddleDurability:SetText(Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_DURABILITY", HDNMod.PlutiaCuddleDoll[iPlayer].Durability).."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_DURABILITY_CUDDLE"))
		Controls.CuddleDurability:SetHide(false)
	else
		Controls.CuddleButton:LocalizeAndSetText("TXT_KEY_CITY_STATE_QUEST_NONE")
		Controls.CuddleText:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_NO_DOLL_EQUIPPED")
		Controls.CuddleDurability:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_TT_DURABILITY_CUDDLE")
		Controls.CuddleDurability:SetHide(true)
	end

	if HDNMod.PlutiaStressDoll[iPlayer] then
		Controls.StressButton:LocalizeAndSetText(tDolls[HDNMod.PlutiaStressDoll[iPlayer].Type].Name)
		GetStressEffectTooltip(HDNMod.PlutiaStressDoll[iPlayer].Type, Controls.StressText)
		Controls.StressDurability:SetText(Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_DURABILITY", HDNMod.PlutiaStressDoll[iPlayer].Durability).."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_DURABILITY_STRESS"))
		Controls.StressDurability:SetHide(false)
	else
		Controls.StressButton:LocalizeAndSetText("TXT_KEY_CITY_STATE_QUEST_NONE")
		Controls.StressText:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_NO_DOLL_EQUIPPED")
		Controls.StressDurability:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_TT_DURABILITY_STRESS")
		Controls.StressDurability:SetHide(true)
	end

	if HDNMod.PlutiaWeaponDoll[iPlayer] then
		Controls.WeaponButton:LocalizeAndSetText(tDolls[HDNMod.PlutiaWeaponDoll[iPlayer].Type].Name)
		GetWeaponEffectTooltip(HDNMod.PlutiaWeaponDoll[iPlayer].Type, Controls.WeaponText)
		Controls.WeaponDurability:SetText(Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_DURABILITY", HDNMod.PlutiaWeaponDoll[iPlayer].Durability).."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_DURABILITY_WEAPON"))
		Controls.WeaponDurability:SetHide(false)
	else
		Controls.WeaponButton:LocalizeAndSetText("TXT_KEY_CITY_STATE_QUEST_NONE")
		Controls.WeaponText:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_NO_DOLL_EQUIPPED")
		Controls.WeaponDurability:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_TT_DURABILITY_WEAPON")
		Controls.WeaponDurability:SetHide(true)
	end

	if HDNMod.PlutiaPlaytimeDoll[iPlayer] then
		Controls.PlaytimeButton:LocalizeAndSetText(tDolls[HDNMod.PlutiaPlaytimeDoll[iPlayer].Type].Name)
		GetPlaytimeEffectTooltip(HDNMod.PlutiaPlaytimeDoll[iPlayer].Type, Controls.PlaytimeText)
		Controls.PlaytimeDurability:SetText(Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_DURABILITY", HDNMod.PlutiaPlaytimeDoll[iPlayer].Durability).."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_DURABILITY_PLAYTIME"))
		Controls.PlaytimeDurability:SetHide(false)
	else
		Controls.PlaytimeButton:LocalizeAndSetText("TXT_KEY_CITY_STATE_QUEST_NONE")
		Controls.PlaytimeText:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_NO_DOLL_EQUIPPED")
		Controls.PlaytimeDurability:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_TT_DURABILITY_PLAYTIME")
		Controls.PlaytimeDurability:SetHide(true)
	end

	--Highlight if needed 
	if not HDNMod.PlutiaReserveDolls[iPlayer] then return end

	local highlights 	= {Controls.CuddleHighlight, Controls.StressHighlight, Controls.WeaponHighlight, Controls.PlaytimeHighlight}
	local buttons 		= {Controls.CuddleButton, Controls.StressButton, Controls.WeaponButton, Controls.PlaytimeButton}
	local bSelectMode = g_SelectedReserve and true or false
	for i= 1, 4, 1 do
		highlights[i]:SetHide(not bSelectMode)
		buttons[i]:SetDisabled(not bSelectMode)
	end
end

function OnDollEquipSlotClicked(v1)
	if not g_SelectedReserve then return end
	local alreadyUsed = false
	local HDNMod = MapModData.HDNMod
	if v1 == 1 then
		g_SelectedSlot = CUDDLE_SET_KEY
		if HDNMod.PlutiaCuddleDoll[Game:GetActivePlayer()] then
			alreadyUsed = true
		end
	elseif v1 == 2 then
		g_SelectedSlot = STRESS_SET_KEY
		if HDNMod.PlutiaStressDoll[Game:GetActivePlayer()] then
			alreadyUsed = true
		end
	elseif v1 == 3 then
		g_SelectedSlot = WEAPON_SET_KEY
		if HDNMod.PlutiaWeaponDoll[Game:GetActivePlayer()] then
			alreadyUsed = true
		end
	elseif v1 == 4 then
		g_SelectedSlot = PLAYTIME_SET_KEY
		if HDNMod.PlutiaPlaytimeDoll[Game:GetActivePlayer()] then
			alreadyUsed = true
		end
	else
		print("error: invalid slot selected for doll")
	end
	if alreadyUsed == true then
		Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_VV_PLUTIA_CONFIRM_REPLACE_SLOT")
		Controls.ChooseConfirm:SetHide(false)
	else
		local iPlayer = Game:GetActivePlayer()
		Network.SendSellBuilding(Players[iPlayer]:GetCapitalCity():GetID(), g_SelectedReserve + g_SelectedSlot)
		Refresh()
	end
end

local buttons 		= {Controls.CuddleButton, Controls.StressButton, Controls.WeaponButton, Controls.PlaytimeButton}
for i= 1, 4, 1 do
	buttons[i]:SetVoid1(i)
	buttons[i]:RegisterCallback(Mouse.eLClick, OnDollEquipSlotClicked)
end
buttons = nil

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- RefreshAll
---------------------------------------------------------------------------------------------------------------------------------------------------------

function Refresh(player, city, building)
	if not ContextPtr:IsHidden() then
		print("SewingKitUI")
		SewingKitUI(Controls.SewingKitLabel, Controls.KitUpgradeButton)
		--print("PopulateProductionDropdownAndMeter")
		--PopulateProductionDropdownAndMeter()
		print("BuildReserveDollList")
		BuildReserveDollList()
		print("PopulateEquippedDolls")
		PopulateEquippedDolls()
		print("UpdatePlutiaTopPanel")
		UpdatePlutiaTopPanel()
		print("Complete")
	end
end
GameEvents.CitySoldBuilding.Add(Refresh)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- ShowHideHandler
---------------------------------------------------------------------------------------------------------------------------------------------------------
function ShowHideHandler( bIsHide, bInitState )

	-- Set player icon at top of screen
	if not bIsHide then
		CivIconHookup( 0, 64, Controls.Icon, Controls.CivIconBG, Controls.CivIconShadow, false, true );
		Refresh()
		PopulateProductionDropdownAndMeter()
	end


end
ContextPtr:SetShowHideHandler( ShowHideHandler );

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- OnClose
---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnClose()
	g_SelectedProduction = nil
	g_SelectedReserve  = nil
	g_SelectedSlot = nil
    ContextPtr:SetHide(true)
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose);


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Confirmation Popup Yes/No
---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnYes( )
	Controls.ChooseConfirm:SetHide(true);
	local iPlayer = Game:GetActivePlayer()
	if g_SelectedReserve and g_SelectedSlot then
		Network.SendSellBuilding(Players[iPlayer]:GetCapitalCity():GetID(), g_SelectedReserve + g_SelectedSlot)
	elseif g_SelectedProduction then
		Network.SendSellBuilding(Players[iPlayer]:GetCapitalCity():GetID(), g_SelectedProduction + PRODUCTION_SET_KEY)
		PopulateProductionDropdownAndMeter()
	end
	g_SelectedProduction = nil
	g_SelectedReserve  = nil
	g_SelectedSlot = nil
	Refresh();	
end
Controls.Yes:RegisterCallback( Mouse.eLClick, OnYes );

function OnNo( )
	Controls.ChooseConfirm:SetHide(true);
	Refresh();
end
Controls.No:RegisterCallback( Mouse.eLClick, OnNo );


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- ShowHideHandler
---------------------------------------------------------------------------------------------------------------------------------------------------------
function InputHandler( uiMsg, wParam, lParam )
    ----------------------------------------------------------------        
    -- Key Down Processing
    ----------------------------------------------------------------        
    if uiMsg == KeyEvents.KeyDown then
        if (wParam == Keys.VK_RETURN or wParam == Keys.VK_ESCAPE) then
			if(Controls.ChooseConfirm:IsHidden())then
	            OnClose();
	        else
				OnNo();
           	end
			return true;
        end
    end
end
ContextPtr:SetInputHandler( InputHandler );


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- TopPanel hookup
---------------------------------------------------------------------------------------------------------------------------------------------------------


function UpdatePlutiaTopPanel()
	local iPlayer = Game:GetActivePlayer()
	if IsDollSystemUseOnly(iPlayer) == false then 
		Controls.PlutiaDollTP:SetHide(true)
	else
		local HDNMod = MapModData.HDNMod
		local sString = "[ICON_VV_PLUTIA_DOLL][COLOR_PLAYER_VV_PLANEPTUNE_PL_BACKGROUND] "
		local sString2 = "[ICON_VV_IRIS_CLIMAX][COLOR_WARNING_TEXT] "
		
		if HDNMod.PlutiaActiveProductionDoll[iPlayer] then
			local iTurnsNeededTotal = DOLL_PROD_TIME_BASE - tSewingKits[HDNMod.PlutiaSewingKits[iPlayer]].TurnsReduction
			sString = sString..(iTurnsNeededTotal - HDNMod.PlutiaActiveProductionDoll[iPlayer].TurnsLeft).."/"..iTurnsNeededTotal
		else
			sString = sString..Locale.ConvertTextKey("TXT_KEY_CITY_STATE_QUEST_NONE")
		end
		
		if HDNMod.PersistentPolicies[iPlayer] and HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"] and HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Turns and HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Progress then
			sString2 = sString2..HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Turns.." ("..HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Progress.."/3)[ENDCOLOR]"
			Controls.PlutiaPolicyTP:SetHide(false)
			Controls.PlutiaPolicyTP:SetText(sString2)
		else
			Controls.PlutiaPolicyTP:SetHide(true)
		end
		
		sString = sString.."[ENDCOLOR]"
		Controls.PlutiaDollTP:SetHide(false)
		Controls.PlutiaDollTP:SetText(sString)
	end
end
Events.SerialEventGameDataDirty.Add(UpdatePlutiaTopPanel)


local tipControlTable = {}
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable )
function DollTPTooltip()
	local sTTString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_DOLL_TP_TT")
	local HDNMod = MapModData.HDNMod
	local iPlayer = Game:GetActivePlayer()
	
	if HDNMod.PlutiaActiveProductionDoll[iPlayer] then
		sTTString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TP_PRODUCING_TEXT", tDolls[HDNMod.PlutiaActiveProductionDoll[iPlayer].Type].Name).."[NEWLINE][NEWLINE]"..sTTString
	else
		sTTString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_NO_DOLL_PRODUCED_TEXT").."[NEWLINE][NEWLINE]"..sTTString
	end
	
	if(sTTString ~= "") then
		tipControlTable.TopPanelMouseover:SetHide(false)
		tipControlTable.TooltipLabel:SetText( sTTString )
	else
		tipControlTable.TopPanelMouseover:SetHide(true)
	end
	tipControlTable.TopPanelMouseover:DoAutoSize()
end

local tipControlTable2 = {}
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable2 )
function PolicyTPTooltip()
	local HDNMod = MapModData.HDNMod
	local iPlayer = Game:GetActivePlayer()
	local sTTString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_POLICY_TP_TT", 0, 0)
	
	if HDNMod.PersistentPolicies[iPlayer] and HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"] then
		sTTString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_POLICY_TP_TT", HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Turns, HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Progress)
	end
	
	tipControlTable2.TopPanelMouseover:SetHide(false)
	tipControlTable2.TooltipLabel:SetText( sTTString )
	tipControlTable2.TopPanelMouseover:DoAutoSize()
end

function TopPanelInit()
	Controls.PlutiaDollTP:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
	Controls.PlutiaPolicyTP:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
	ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"):ReprocessAnchoring()
	Controls.PlutiaDollTP:SetToolTipCallback( DollTPTooltip );
	Controls.PlutiaDollTP:RegisterCallback(Mouse.eLClick, OnDiploCornerPopup)
	Controls.PlutiaPolicyTP:SetToolTipCallback( PolicyTPTooltip );
	UpdatePlutiaTopPanel()
end
Events.LoadScreenClose.Add(TopPanelInit)