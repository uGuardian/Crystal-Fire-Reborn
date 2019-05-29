-- PleiadesFreezer
-- Author: Vicevirtuoso
-- DateCreated: 8/14/2014 5:57:28 PM
--------------------------------------------------------------

include("IconSupport")
include("InstanceManager")

local g_InstanceManager = InstanceManager:new("MagicalGirlInstance", "MGListRoot", Controls.MGListStack)

ContextPtr:SetHide(true)

include("PMMMDefines.lua");

local iScience = 0;
local iNumAcademies = 0;
local iNumSuccesses = 0;

local iCurrentMG = -1;
local iCurrentPrediction = -1;

local ttable = {}

IconHookup(4, 64, "CIV_COLOR_ATLAS_KAORU_UMIKA", Controls.TitleIcon)

Controls.NoMGsLabel:SetHide(true)
Controls.ResultBox:SetHide(true)

Controls.ResultPrediction:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_RESULTPREDICTION", "[COLOR_WARNING_TEXT]SUPER BAD[ENDCOLOR]")
Controls.NumAcademiesLabel:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_NUM_ACADEMIES", 0)
Controls.PreviousSuccessesLabel:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_PREVIOUS_SUCCESSES", 0)


--v21: Flag for whether or not this is a MP game
local bMulti = Game.IsNetworkMultiPlayer()


function Show()
	ContextPtr:SetHide(false)
end

LuaEvents.PMMMShowFreezerPopup.Add(Show)

function OnCloseButtonClicked()
	ContextPtr:SetHide(true)
end
Controls.CloseButton:RegisterCallback(Mouse.eLClick, OnCloseButtonClicked)

function OnShowHide(bHide, bInit)
	if (not bHide) then
		local iActivePlayer = Game:GetActivePlayer()
		if MapModData.gPMMMTraits then
			if MapModData.gPMMMTraits[iActivePlayer].EnableFreezerSystem == true or MapModData.gPMMMTraits[iActivePlayer].EnableFreezerSystem == 1 then
				Controls.MagicalGirlBox:SetHide(false)
				Controls.ExplanationBox:SetHide(false)
				Controls.NoMGsLabel:SetHide(true)
				Init()
				LuaEvents.PMMMGetNumAcademies(iActivePlayer, ttable)
				iNumAcademies = ttable[0]
				Controls.NumAcademiesLabel:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_NUM_ACADEMIES", iNumAcademies)
				iNumSuccesses = PMMM.FreezerSuccesses[iActivePlayer] or 0
				Controls.PreviousSuccessesLabel:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_PREVIOUS_SUCCESSES", iNumSuccesses)
				return
			end
		end
	end
	LuaEvents.PMMMRefreshGriefSeedDisplay()
	Controls.MagicalGirlBox:SetHide(true)
	Controls.ExplanationBox:SetHide(true)
	Controls.NoMGsLabel:SetHide(false)
end
ContextPtr:SetShowHideHandler(OnShowHide)

function OnMagicalGirlClicked(iMGKey)
	local iPlayer = Game:GetActivePlayer()
	iCurrentMG = iMGKey
	local sNameCaps = string.upper(Locale.ConvertTextKey(MapModData.PMMM.MagicalGirls[iMGKey].Name))
	Controls.SelectedMGNameLabel:SetText(sNameCaps)
	
	--Prediction
	LuaEvents.PMMMGetPleiadesPrediction(iPlayer, iMGKey, iScience, ttable)
	iCurrentPrediction = ttable[0]
	Controls.ResultPrediction:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_RESULTPREDICTION", ttable[1])
	Controls.ResultPredictionDesc:LocalizeAndSetText(ttable[2])


	--Grief Seed Button
	if MapModData.PMMM.MagicalGirls[iMGKey].SoulGem < 100 then
		if PMMM.GriefSeeds[Game:GetActivePlayer()] > 0 then
			Controls.GriefSeedButton:SetDisabled(false)
			Controls.GriefSeedButton:SetVoid1(iMGKey)
			Controls.GriefSeedButton:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_USE_GRIEF_SEED_TT"))
		else
			Controls.GriefSeedButton:SetDisabled(true)
			Controls.GriefSeedButton:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_USE_GRIEF_SEED_TT") .."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_USE_GRIEF_SEED_NO_SEEDS_TT"))
		end
	else
		Controls.GriefSeedButton:SetDisabled(true)
		Controls.GriefSeedButton:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_USE_GRIEF_SEED_TT") .."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_USE_GRIEF_SEED_SOUL_GEM_FULL_TT"))
	end
	
	
	Controls.ResultBox:SetHide(false)
end

function OnGriefSeedButtonClicked(iMGKey)
	if not bMulti then
		LuaEvents.PMMMUseGriefSeed(iMGKey, Game:GetActivePlayer(), true)
		LuaEvents.PMMMRefreshGriefSeedDisplay()  -- for some reason this isn't working, but i'll fix it later
		ContextPtr:SetHide(true)
	else
		--in multiplayer, we will spawn a dummy unit and push a mission to it
		local pPlayer = Players[Game:GetActivePlayer()]
		local unit = pPlayer:InitUnit(GameInfoTypes.UNIT_WARRIOR, pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY())
		UI.SelectUnit(unit)
		Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_PLEIADES_FREEZER_GRIEF_SEED, iMGKey, 0, 0, false, false)
		LuaEvents.PMMMRefreshGriefSeedDisplay() -- for some reason this isn't working, but i'll fix it later
		ContextPtr:SetHide(true)
		unit:Kill(true)
	end
end

Controls.GriefSeedButton:RegisterCallback(Mouse.eLClick, OnGriefSeedButtonClicked)

function OnBeginButtonClicked()
	local iPlayer = Game:GetActivePlayer()
	if iCurrentMG > 0 and iCurrentPrediction > 0 then
		if not bMulti then
			LuaEvents.PMMMDoPleiadesRevival(iPlayer, iCurrentMG, iCurrentPrediction, iScience)
		else
			--in multiplayer, we will spawn a dummy unit and push a mission to it
			local pPlayer = Players[Game:GetActivePlayer()]
			local table = {
				["iCurrentMG"] = iCurrentMG,
				["iCurrentPrediction"] = iCurrentPrediction,
				["iScience"] = iScience
			}
			local unit = pPlayer:InitUnit(GameInfoTypes.UNIT_WARRIOR, pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY())
			UI.SelectUnit(unit)
			Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_PLEIADES_FREEZER, iCurrentMG, iCurrentPrediction, iScience, false, false)
			unit:Kill(true)
		end
		Init()
		LuaEvents.PMMMGetNumAcademies(iPlayer, ttable)
		iNumAcademies = ttable[0]
		Controls.NumAcademiesLabel:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_NUM_ACADEMIES", iNumAcademies)
		iNumSuccesses = PMMM.FreezerSuccesses[iPlayer] or 0
		Controls.PreviousSuccessesLabel:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_PREVIOUS_SUCCESSES", iNumSuccesses)
		iScience = 0;
		Controls.ScienceValue:SetText(tostring(iScience))
		Controls.ScienceSlider:SetValue(iScience)
		ContextPtr:SetHide(true)
	end
end

Controls.BeginButton:RegisterCallback(Mouse.eLClick, OnBeginButtonClicked)

function Init()
	g_InstanceManager:ResetInstances()
	iCurrentMG = -1;
	iCurrentPrediction = -1;

	local bAnyMagicalGirls;
	
	if MapModData.PMMM.MagicalGirls then
		for k, v in pairs(MapModData.PMMM.MagicalGirls) do
			if v.FreezerPlayer == Game:GetActivePlayer() then
				bAnyMagicalGirls = true
				local instance = g_InstanceManager:GetInstance()
				instance.MagicalGirlNameLabel:LocalizeAndSetText(v.Name)
				instance.MagicalGirlSGLabel:SetText("[ICON_PMMM_SOUL_GEM] "..v.SoulGem.."%")
				instance.MagicalGirlSGLabel:EnableToolTip(true)
				instance.MagicalGirlSGLabel:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_SOUL_GEM_TT", Locale.ConvertTextKey(v.Name)))
				
				
				instance.SubIconFrame:SetHide(true);
				if (v.OriginalOwner) then
					CivIconHookup(v.OriginalOwner, 32, instance.SubIcon, instance.SubIconBG, instance.SubIconShadow, true, true);
					instance.SubIconFrame:SetHide(false);
				end
				
				instance.SubIconFrame:EnableToolTip(true)
				instance.SubIcon:EnableToolTip(true)
				instance.SubIconBG:EnableToolTip(true)
				instance.SubIconShadow:EnableToolTip(true)
				
				local sOwnerString = Players[v.OriginalOwner]:GetCivilizationAdjective()
				
				instance.SubIconFrame:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_ORIGINAL_OWNER_TT", Locale.ConvertTextKey(v.Name), sOwnerString))
				instance.SubIcon:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_ORIGINAL_OWNER_TT", Locale.ConvertTextKey(v.Name), sOwnerString))
				instance.SubIconBG:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_ORIGINAL_OWNER_TT", Locale.ConvertTextKey(v.Name), sOwnerString))
				instance.SubIconShadow:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_UI_FREEZER_ORIGINAL_OWNER_TT", Locale.ConvertTextKey(v.Name), sOwnerString))
				
				instance.MagicalGirlButton:SetVoid1(k)
				instance.MagicalGirlButton:RegisterCallback(Mouse.eLClick, OnMagicalGirlClicked)
			end
		end
		Controls.MGListStack:CalculateSize()
		Controls.MGListStack:ReprocessAnchoring()
		Controls.MGScrollPanel:CalculateInternalSize()
		Controls.MGListLabel:SetHide(true)
	else
		Controls.MGListLabel:SetHide(false)
	end
	if not bAnyMagicalGirls then
		Controls.MGListLabel:SetHide(false)
	end
	Controls.ResultBox:SetHide(true)
end

Init()



function GetAvailableDivertScience()
	local pPlayer = Players[Game:GetActivePlayer()]
	local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
	local iProgressThisTech = pTeamTechs:GetResearchProgress(pPlayer:GetCurrentResearch())
	
	return iProgressThisTech
end


function OnScienceSliderValueChanged(fValue)
	local iProgressThisTech = GetAvailableDivertScience()
	iScience = math.floor(fValue * iProgressThisTech)

	local iPlayer = Game:GetActivePlayer()
	LuaEvents.PMMMGetPleiadesPrediction(iPlayer, iCurrentMG, iScience, ttable)
	iCurrentPrediction = ttable[0]
	Controls.ResultPrediction:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_RESULTPREDICTION", ttable[1])
	Controls.ResultPredictionDesc:LocalizeAndSetText(ttable[2])
	
	Controls.ScienceValue:SetText(iScience)
end

Controls.ScienceSlider:RegisterSliderCallback(OnScienceSliderValueChanged)

function OnScienceValueChanged(sValue, control, bFire)
	if bFire then
		local iValue = tonumber(sValue)
		local iProgressThisTech = GetAvailableDivertScience()
		
		if iValue < 0 then
			iValue = 0
		elseif iValue > iProgressThisTech then
			iValue = iProgressThisTech
		end
		
		iScience = iValue
		
		iSliderSetValue = iValue / iProgressThisTech

		local iPlayer = Game:GetActivePlayer()
		LuaEvents.PMMMGetPleiadesPrediction(iPlayer, iCurrentMG, iScience, ttable)
		iCurrentPrediction = ttable[0]
		Controls.ResultPrediction:LocalizeAndSetText("TXT_KEY_PMMM_UI_FREEZER_RESULTPREDICTION", ttable[1])
		Controls.ResultPredictionDesc:LocalizeAndSetText(ttable[2])
		
		Controls.ScienceValue:SetText(tostring(iScience))
		Controls.ScienceSlider:SetValue(iSliderSetValue)
	end
end	

Controls.ScienceValue:RegisterCallback(OnScienceValueChanged)

Controls.ScienceValue:SetText(tostring(0))
Controls.ScienceSlider:SetValue(0)


--Add option to open this in the DiploCorner

function OnDiploCornerPopup()
	Show()
end

function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
  table.insert(additionalEntries, {
    text=Locale.ConvertTextKey("TXT_KEY_PMMM_UI_DIPLOCORNER_FREEZER"), 
    call=OnDiploCornerPopup
  })
end

--Don't use the cached trait table since it has issues when first loading -- find it directly from the DB
local leaderType = GameInfo.Leaders[Players[Game:GetActivePlayer()]:GetLeaderType()].Type
local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
local trait = GameInfo.Traits[traitType]

if trait.EnableFreezerSystem == true or trait.EnableFreezerSystem == 1 then
	LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
	LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()
end

trait = nil --keep pointers to traits in the DB out of memory since it can cause issues