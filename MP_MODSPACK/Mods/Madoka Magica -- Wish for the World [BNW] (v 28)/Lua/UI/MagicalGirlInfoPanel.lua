-- MagicalGirlInfoPanel
-- Author: Vice
-- DateCreated: 1/20/2015 8:06:54 PM
--------------------------------------------------------------

include( "IconSupport" );
include( "InstanceManager" );
include( "PMMMGeneralFunctions.lua" );
include( "PMMMEntertainmentSystem.lua" );

MagicalGirls = nil
g_MGKey = nil
g_CurrentTab = nil
g_MoodInstance = InstanceManager:new("MoodletInstance", "MoodletRoot", Controls.MoodStack)
g_LDInstance = InstanceManager:new("LikeDislikeInstance", "LikeDislikeRoot", Controls.LDStack)
g_AppearanceChanges = {}
g_MPAppearanceChanges = {}

local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL
local ltBlue = {19/255,32/255,46/255,120/255};
local dkBlue = {12/255,22/255,30/255,120/255};

local pink = {x=255/255,y=181/255,z=196/255,w=255/255};
local orange = {x=255/255,y=100/255,z=0/255,w=255/255};
local red = {x=255/255,z=0/255,z=0/255,w=255/255};

-------------------------------------------------
-- Global Constants
-------------------------------------------------
g_Tabs = {
	["Mood"] = {
		Panel = Controls.MoodBox,
		SelectHighlight = Controls.MoodSelectHighlight,
	},
	
	-- ["Relationships"] = {
		-- Panel = Controls.SwapGreatWorksPanel,
		-- SelectHighlight = Controls.RelationshipsSelectHighlight,
	-- },
	
	-- ["Skills"] = {
		-- Panel = Controls.CultureVictoryPanel,
		-- SelectHighlight = Controls.SkillsSelectHighlight,
	-- },
	
	["Appearance"] = {
		Panel = Controls.ChangeAppearanceBox,
		SelectHighlight = Controls.AppearanceSelectHighlight,
	},
}


function TabSelect(tab)
	for i,v in pairs(g_Tabs) do
		local bHide = i ~= tab;
		v.Panel:SetHide(bHide);
		v.SelectHighlight:SetHide(bHide);
	end
	g_CurrentTab = tab;
	g_Tabs[tab].RefreshContent();	
end
Controls.TabButtonMood:RegisterCallback( Mouse.eLClick, function() TabSelect("Mood"); end);
-- Controls.TabButtonRelationships:RegisterCallback( Mouse.eLClick, function() TabSelect("Relationships"); end);
-- Controls.TabButtonSkills:RegisterCallback( Mouse.eLClick, function() TabSelect("Skills"); end );
Controls.TabButtonAppearance:RegisterCallback( Mouse.eLClick, function() TabSelect("Appearance"); end );

g_Tabs["Mood"].RefreshContent = function()
	MagicalGirls = MapModData.PMMM.MagicalGirls

	--Mood Stack
	g_MoodInstance:ResetInstances()
	local bTickTock = false;
	if g_MGKey and MagicalGirls[g_MGKey].MoodMods and #MagicalGirls[g_MGKey].MoodMods > 0 then
		local bHide = true
		for k, v in pairs(MagicalGirls[g_MGKey].MoodMods) do
			if v.Desc then
				bHide = false
				local instance = g_MoodInstance:GetInstance()
				instance.MoodletInstanceLabel:SetText("[ICON_BULLET]"..v.Desc)
				if v.Tooltip then
					instance.MoodletInstanceLabel:SetToolTipString(v.Tooltip)
				else
					instance.MoodletInstanceLabel:SetToolTipString("")
				end
				if(bTickTock == false) then
					instance.MoodletRoot:SetColorVal(unpack(ltBlue));
				else
					instance.MoodletRoot:SetColorVal(unpack(dkBlue));
				end
				bTickTock = not bTickTock;
			end
		end
		Controls.MoodStack:CalculateSize()
		Controls.MoodStack:ReprocessAnchoring()
		Controls.MoodScrollPanel:CalculateInternalSize()
	end
	
	--LD Stack
	Controls.LikeDislikeListTitle:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_PMMM_MGIP_MOODTAB_LD_TOOLTIP", GameDefines.MG_LIKE_DISLIKE_STARTING_TURN))
	g_LDInstance:ResetInstances()
	if g_MGKey and MagicalGirls[g_MGKey].LikesDislikes and #MagicalGirls[g_MGKey].LikesDislikes > 0 then
		local bHide = true
		--Ideological Belief always comes first
		if MagicalGirls[g_MGKey].IdeologicalBelief then
			local iHighestVal = 0
			local iHighestBranch = -1
			for k, v in pairs(MagicalGirls[g_MGKey].IdeologicalBelief) do
				if v > iHighestVal then 
					iHighestVal = v
					iHighestBranch = k
				end
			end
			if iHighestBranch > -1 then
				local instance = g_LDInstance:GetInstance()
				instance.LikeDislikeInstanceLabel:LocalizeAndSetText("TXT_KEY_MGLIKEDISLIKE_IDEOLOGY", GameInfo.PolicyBranchTypes[iHighestBranch].Description)
				instance.LikeDislikeInstanceLabel:SetToolTipString(MagicalGirls[g_MGKey].IdeologicalBeliefString)
			end
		end
		for k, v in pairs(MagicalGirls[g_MGKey].LikesDislikes) do
			--LuaEvents.PMMMRefreshLDText(g_MGKey, k)
			if v.Desc then
				bHide = false
				local instance = g_LDInstance:GetInstance()
				instance.LikeDislikeInstanceLabel:SetText("[ICON_BULLET]"..v.Desc)
				if v.Tooltip then
					instance.LikeDislikeInstanceLabel:SetToolTipString(v.Tooltip)
				else
					instance.LikeDislikeInstanceLabel:SetToolTipString("")
				end
				if(bTickTock == false) then
					instance.LikeDislikeRoot:SetColorVal(unpack(ltBlue));
				else
					instance.LikeDislikeRoot:SetColorVal(unpack(dkBlue));
				end
				bTickTock = not bTickTock;
			end
		end
		Controls.LDStack:CalculateSize()
		Controls.LDStack:ReprocessAnchoring()
		Controls.LDScrollPanel:CalculateInternalSize()
	end

	--Loyalty Bar
	local iPercent = MagicalGirls[g_MGKey].Loyalty
	if iPercent >= 30 and iPercent < 60 then
		Controls.LoyaltyBar:SetFGColor(orange)
	elseif iPercent < 30 then
		Controls.LoyaltyBar:SetFGColor(red)
	else
		Controls.LoyaltyBar:SetFGColor(pink)
	end
	Controls.LoyaltyBar:SetPercent(iPercent / 100)

	local sTooltip = "[COLOR_POSITIVE_TEXT]"..tostring(iPercent).."%[ENDCOLOR]"
	
	if MagicalGirls[g_MGKey].IsLeader == true then
		sTooltip = Locale.ConvertTextKey("TXT_KEY_MGIP_LOYALTY_LEADER_ALWAYS_AT_100")
	end
	
	sTooltip = sTooltip.."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_MGIP_LOYALTY_TOOLTIP")
	
	if not MagicalGirls[g_MGKey].IsLeader then
		--From Mood
		local iChange = GameInfo.MG_Moods[MagicalGirls[g_MGKey].MoodLevel].LoyaltyChange
		if iChange ~= 0 then
			if iChange > 0 then
				sTooltip = sTooltip.."[NEWLINE]+[COLOR_POSITIVE_TEXT]"
			else
				sTooltip = sTooltip.."[NEWLINE][COLOR_WARNING_TEXT]"
			end
			sTooltip = sTooltip..Locale.ConvertTextKey("TXT_KEY_MGIP_LOYALTY_TOOLTIP_MOOD", GameInfo.MG_Moods[MagicalGirls[g_MGKey].MoodLevel].LoyaltyChange).."[ENDCOLOR]"
		end
		
		--From Tourism & Entertainment
		local pPlayer = Players[Game:GetActivePlayer()]
		local iTourismVal = math.floor((pPlayer:GetTourism() + GetEmpireEntertainment(pPlayer)) / GameDefines.LOYALTY_TOURISM_ENTERTAINMENT_DIVISOR)
		if iTourismVal > 0 then
			sTooltip = sTooltip.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_MGIP_LOYALTY_TOOLTIP_TOURISM", iTourismVal)
		end

		--From LDs
		if not MagicalGirls[g_MGKey].LDLoyaltyChange then MagicalGirls[g_MGKey].LDLoyaltyChange  = 0 end

		if MagicalGirls[g_MGKey].LDLoyaltyChange > 0 then
			sTooltip = sTooltip.."[NEWLINE][COLOR_POSITIVE_TEXT]+"..Locale.ConvertTextKey("TXT_KEY_MGIP_LOYALTY_TOOLTIP_LDS", MagicalGirls[g_MGKey].LDLoyaltyChange).."[ENDCOLOR]"
		elseif MagicalGirls[g_MGKey].LDLoyaltyChange < 0 then
			sTooltip = sTooltip.."[NEWLINE][COLOR_WARNING_TEXT]"..Locale.ConvertTextKey("TXT_KEY_MGIP_LOYALTY_TOOLTIP_LDS", MagicalGirls[g_MGKey].LDLoyaltyChange).."[ENDCOLOR]"
		end

		--From Influence
		local tInfTable = {}
		if not MagicalGirls[g_MGKey].Influence then MagicalGirls[g_MGKey].Influence = {} end
		local iInfNeeded = GameDefines.MG_INFLUENCE_NEEDED_PER_LOYALTY_POINT_DEDUCTION
		for k, v in pairs(MagicalGirls[g_MGKey].Influence) do
			local pInfluencePlayer = Players[k]
			if pInfluencePlayer:IsAlive() then
				local iAmount = math.floor(v / iInfNeeded)
				if iAmount > 0 then
					sTooltip = sTooltip.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_MGIP_LOYALTY_TOOLTIP_INFLUENCE", iAmount, pInfluencePlayer:GetCivilizationShortDescription())
				end
			end
		end
	end

	Controls.LoyaltyBar:SetToolTipString(sTooltip)
end

g_Tabs["Appearance"].RefreshContent = function()
	MagicalGirls = MapModData.PMMM.MagicalGirls
	local function ShowHideAppearanceChangers(bool)
		Controls.BodyType:SetHide(bool)
		Controls.BodyTypeList:SetHide(bool)
		Controls.BodyTypePrevButton:SetHide(bool)
		Controls.BodyTypeNextButton:SetHide(bool)
		Controls.OutfitType:SetHide(bool)
		Controls.OutfitTypeList:SetHide(bool)
		Controls.OutfitTypePrevButton:SetHide(bool)
		Controls.OutfitTypeNextButton:SetHide(bool)
		Controls.FaceType:SetHide(bool)
		Controls.FaceTypeList:SetHide(bool)
		Controls.FaceTypePrevButton:SetHide(bool)
		Controls.FaceTypeNextButton:SetHide(bool)
		Controls.HairType:SetHide(bool)
		Controls.HairTypeList:SetHide(bool)
		Controls.HairTypePrevButton:SetHide(bool)
		Controls.HairTypeNextButton:SetHide(bool)
		Controls.BodyColor:SetHide(bool)
		Controls.BodyColorList:SetHide(bool)
		Controls.BodyColorPrevButton:SetHide(bool)
		Controls.BodyColorNextButton:SetHide(bool)
		Controls.OutfitColor:SetHide(bool)
		Controls.OutfitColorList:SetHide(bool)
		Controls.OutfitColorPrevButton:SetHide(bool)
		Controls.OutfitColorNextButton:SetHide(bool)
		Controls.FaceColor:SetHide(bool)
		Controls.FaceColorList:SetHide(bool)
		Controls.FaceColorPrevButton:SetHide(bool)
		Controls.FaceColorNextButton:SetHide(bool)
		Controls.HairColor:SetHide(bool)
		Controls.HairColorList:SetHide(bool)
		Controls.HairColorPrevButton:SetHide(bool)
		Controls.HairColorNextButton:SetHide(bool)
		Controls.FaceAcc:SetHide(bool)
		Controls.FaceAccList:SetHide(bool)
		Controls.FaceAccPrevButton:SetHide(bool)
		Controls.FaceAccNextButton:SetHide(bool)
		Controls.HairAcc:SetHide(bool)
		Controls.HairAccList:SetHide(bool)
		Controls.HairAccPrevButton:SetHide(bool)
		Controls.HairAccNextButton:SetHide(bool)

		Controls.NoCustomsLabel:SetHide(not bool)
	end
	if MagicalGirls[g_MGKey].OverrideIcon then
		ShowHideAppearanceChangers(true)
	else
		ShowHideAppearanceChangers(false)
		local function AddToPulldown(control, text, id, data)
			local controlTable = {};
			control:BuildEntry( "InstanceOne", controlTable );
		
			controlTable.Button:SetVoids(id, data);
			controlTable.Button:LocalizeAndSetText(text);
		end
	
		--Bodies
		local dropdown = Controls.BodyTypeList
		dropdown:ClearEntries();
		for row in GameInfo.MG_IconBodies() do
			AddToPulldown(dropdown, row.Description, row.ID)
			if (g_MGKey and MagicalGirls[g_MGKey].BodyIcon[3] == row.ID) and not g_AppearanceChanges[1] then
				dropdown:GetButton():LocalizeAndSetText(row.Description);
				dropdown:GetButton():SetToolTipString("");
			end
		end
		dropdown:CalculateInternals();
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				MagicalGirls[g_MGKey].BodyIcon[1] = GameInfo.MG_IconBodies[v1].IconAtlas
				MagicalGirls[g_MGKey].BodyIcon[2] = 0
				MagicalGirls[g_MGKey].BodyIcon[3] = v1
			else
				g_MPAppearanceChanges = {
					["Type"] = "BODY",
					[1] = GameInfo.MG_IconBodies[v1].IconAtlas, 
					[2] = 0,
					[3] = v1
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end			
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][1] then
				dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconBodies[g_AppearanceChanges[1][1]].Description);
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
		local dropdown = Controls.BodyColorList
		dropdown:ClearEntries();
		for row in GameInfo.MG_IconBodies() do
			if g_MGKey and MagicalGirls[g_MGKey].BodyIcon[3] == row.ID then
				for i = 0, row.NumColors - 1, 1 do
					AddToPulldown(dropdown, row.ColorDescriptionTag..tostring(i), i)
					if i == MagicalGirls[g_MGKey].BodyIcon[2] then
						dropdown:GetButton():LocalizeAndSetText(row.ColorDescriptionTag..tostring(i));
						dropdown:GetButton():SetToolTipString("");
					end
				end
			end
		end
		dropdown:CalculateInternals();
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				MagicalGirls[g_MGKey].BodyIcon[2] = v1
			else
				g_MPAppearanceChanges = {
					["Type"] = "BODY",
					[2] = v1
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][2] then
				dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconBodies[g_AppearanceChanges[1][2]].ColorDescriptionTag..tostring(g_AppearanceChanges[1][2]));
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
		--Outfits
		local dropdown = Controls.OutfitTypeList
		dropdown:ClearEntries();
		for row in GameInfo.MG_IconOutfits() do
			AddToPulldown(dropdown, row.Description, row.ID)
			if (g_MGKey and MagicalGirls[g_MGKey].OutfitIcon[3] == row.ID) and not g_AppearanceChanges[1] then
				dropdown:GetButton():LocalizeAndSetText(row.Description);
				dropdown:GetButton():SetToolTipString("");
			end
		end
		dropdown:CalculateInternals();
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				MagicalGirls[g_MGKey].OutfitIcon[1] = GameInfo.MG_IconOutfits[v1].IconAtlas
				MagicalGirls[g_MGKey].OutfitIcon[2] = 0
				MagicalGirls[g_MGKey].OutfitIcon[3] = v1
			else
				g_MPAppearanceChanges = {
					["Type"] = "OUTFIT",
					[1] = GameInfo.MG_IconOutfits[v1].IconAtlas, 
					[2] = 0,
					[3] = v1
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][1] then
				dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconOutfits[g_AppearanceChanges[1][1]].Description);
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
		local dropdown = Controls.OutfitColorList
		dropdown:ClearEntries();
		for row in GameInfo.MG_IconOutfits() do
			if g_MGKey and MagicalGirls[g_MGKey].OutfitIcon[3] == row.ID then
				for i = 0, row.NumColors - 1, 1 do
					AddToPulldown(dropdown, row.ColorDescriptionTag..tostring(i), i)
					if i == MagicalGirls[g_MGKey].OutfitIcon[2] then
						dropdown:GetButton():LocalizeAndSetText(row.ColorDescriptionTag..tostring(i));
						dropdown:GetButton():SetToolTipString("");
					end
				end
			end
		end
		dropdown:CalculateInternals();
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				MagicalGirls[g_MGKey].OutfitIcon[2] = v1
			else
				g_MPAppearanceChanges = {
					["Type"] = "OUTFIT",
					[2] = v1
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][2] then
				dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconOutfits[g_AppearanceChanges[1][2]].ColorDescriptionTag..tostring(g_AppearanceChanges[1][2]));
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
	
		--Faces
		local dropdown = Controls.FaceTypeList
		dropdown:ClearEntries();
		for row in GameInfo.MG_IconFaces() do
			AddToPulldown(dropdown, row.Description, row.ID)
			if (g_MGKey and MagicalGirls[g_MGKey].FaceIcon[3] == row.ID) and not g_AppearanceChanges[1] then
				dropdown:GetButton():LocalizeAndSetText(row.Description);
				dropdown:GetButton():SetToolTipString("");
			end
		end
		dropdown:CalculateInternals();
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				MagicalGirls[g_MGKey].FaceIcon[1] = GameInfo.MG_IconFaces[v1].IconAtlas
				MagicalGirls[g_MGKey].FaceIcon[2] = 0
				MagicalGirls[g_MGKey].FaceIcon[3] = v1
			else
				g_MPAppearanceChanges = {
					["Type"] = "FACE",
					[1] = GameInfo.MG_IconFaces[v1].IconAtlas, 
					[2] = 0,
					[3] = v1
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][1] then
				dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconFaces[g_AppearanceChanges[1][1]].Description);
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
		local dropdown = Controls.FaceColorList
		dropdown:ClearEntries();
		for row in GameInfo.MG_IconFaces() do
			if g_MGKey and MagicalGirls[g_MGKey].FaceIcon[3] == row.ID then
				for i = 0, row.NumColors - 1, 1 do
					AddToPulldown(dropdown, row.ColorDescriptionTag..tostring(i), i)
					if i == MagicalGirls[g_MGKey].FaceIcon[2] then
						dropdown:GetButton():LocalizeAndSetText(row.ColorDescriptionTag..tostring(i));
						dropdown:GetButton():SetToolTipString("");
					end
				end
			end
		end
		dropdown:CalculateInternals();
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				MagicalGirls[g_MGKey].FaceIcon[2] = v1
			else
				g_MPAppearanceChanges = {
					["Type"] = "FACE",
					[2] = v1
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][2] then
				dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconFaces[g_AppearanceChanges[1][2]].ColorDescriptionTag..tostring(g_AppearanceChanges[1][2]));
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
	
		--Hairs
		local dropdown = Controls.HairTypeList
		dropdown:ClearEntries();
		for row in GameInfo.MG_IconHairs() do
			AddToPulldown(dropdown, row.Description, row.ID)
			if (g_MGKey and MagicalGirls[g_MGKey].HairIcon[3] == row.ID) and not g_AppearanceChanges[1] then
				dropdown:GetButton():LocalizeAndSetText(row.Description);
				dropdown:GetButton():SetToolTipString("");
			end
		end
		dropdown:CalculateInternals();
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				MagicalGirls[g_MGKey].HairIcon[1] = GameInfo.MG_IconHairs[v1].IconAtlas
				MagicalGirls[g_MGKey].HairIcon[2] = 0
				MagicalGirls[g_MGKey].HairIcon[3] = v1
			else
				g_MPAppearanceChanges = {
					["Type"] = "HAIR",
					[1] = GameInfo.MG_IconHairs[v1].IconAtlas, 
					[2] = 0,
					[3] = v1
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][1] then
				dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconHairs[g_AppearanceChanges[1][1]].Description);
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
		local dropdown = Controls.HairColorList
		dropdown:ClearEntries();
		for row in GameInfo.MG_IconHairs() do
			if g_MGKey and MagicalGirls[g_MGKey].HairIcon[3] == row.ID then
				for i = 0, row.NumColors - 1, 1 do
					AddToPulldown(dropdown, row.ColorDescriptionTag..tostring(i), i)
					if i == MagicalGirls[g_MGKey].HairIcon[2] then
						dropdown:GetButton():LocalizeAndSetText(row.ColorDescriptionTag..tostring(i));
						dropdown:GetButton():SetToolTipString("");
					end
				end
			end
		end
		dropdown:CalculateInternals();
		--This one is too close to the bottom of the screen; make it expand upward instead of downward (thanks whoward for how to do this!)
		local offsetY = -(dropdown:GetSizeY() + dropdown:GetGrid():GetSizeY())
		dropdown:GetGrid():SetOffsetVal(0, offsetY)
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				MagicalGirls[g_MGKey].HairIcon[2] = v1
			else
				g_MPAppearanceChanges = {
					["Type"] = "HAIR",
					[2] = v1
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][2] then
				dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconHairs[g_AppearanceChanges[1][2]].ColorDescriptionTag..tostring(g_AppearanceChanges[1][2]));
				dropdown:GetButton():SetToolTipString("");
			end
		end
	

		--Face Accessories
		local dropdown = Controls.FaceAccList
		dropdown:ClearEntries();
		--An MG can wear no accessory, so add that as a potential value
		AddToPulldown(dropdown, "TXT_KEY_SV_ICONS_NONE", 99999, 99999) --arbitrary numbers
		dropdown:GetButton():LocalizeAndSetText("TXT_KEY_SV_ICONS_NONE");
		dropdown:GetButton():SetToolTipString("");
		for row in GameInfo.MG_IconFaceAccessories() do
			for i = 0, row.NumAccessories - 1, 1 do
				AddToPulldown(dropdown, row.ColorDescriptionTag..tostring(i), i, row.ID)
				if i == MagicalGirls[g_MGKey].FaceAccessory[2] then
					dropdown:GetButton():LocalizeAndSetText(row.ColorDescriptionTag..tostring(i));
					dropdown:GetButton():SetToolTipString("");
				end
			end
		end
		dropdown:CalculateInternals();
		--This one is too close to the bottom of the screen; make it expand upward instead of downward (thanks whoward for how to do this!)
		local offsetY = -(dropdown:GetSizeY() + dropdown:GetGrid():GetSizeY())
		dropdown:GetGrid():SetOffsetVal(0, offsetY)
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				if v1 == 99999 then
					MagicalGirls[g_MGKey].FaceAccessory[1] = -1
					MagicalGirls[g_MGKey].FaceAccessory[2] = -1
					MagicalGirls[g_MGKey].FaceAccessory[3] = -1
				else
					MagicalGirls[g_MGKey].FaceAccessory[1] = GameInfo.MG_IconFaceAccessories[v2].IconAtlas
					MagicalGirls[g_MGKey].FaceAccessory[2] = v1
					MagicalGirls[g_MGKey].FaceAccessory[3] = v2 or -1
				end
			else
				if v1 == 99999 then
					g_MPAppearanceChanges = {
						["Type"] = "FACEACC",
						[1] = -1,
						[2] = -1,
						[3] = -1
					}
				else
					g_MPAppearanceChanges = {
						["Type"] = "FACEACC",
						[1] = GameInfo.MG_IconFaceAccessories[v2].IconAtlas,
						[2] = v1,
						[3] = v2 or -1
					}
				end
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][2] then
				if g_AppearanceChanges[1][2] == -1 then
					dropdown:GetButton():LocalizeAndSetText("TXT_KEY_SV_ICONS_NONE")
				else
					dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconFaceAccessories[g_AppearanceChanges[1][2]].ColorDescriptionTag..tostring(g_AppearanceChanges[1][2]));
				end
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
		--Hair Accessories
		local dropdown = Controls.HairAccList
		dropdown:ClearEntries();
		--An MG can wear no accessory, so add that as a potential value
		AddToPulldown(dropdown, "TXT_KEY_SV_ICONS_NONE", 99999, 99999)  --arbitrary numbers
		dropdown:GetButton():LocalizeAndSetText("TXT_KEY_SV_ICONS_NONE");
		dropdown:GetButton():SetToolTipString("");
		for row in GameInfo.MG_IconHairAccessories() do
			for i = 0, row.NumAccessories - 1, 1 do
				AddToPulldown(dropdown, row.ColorDescriptionTag..tostring(i), i, row.ID)
				if i == MagicalGirls[g_MGKey].HairAccessory[2] then
					dropdown:GetButton():LocalizeAndSetText(row.ColorDescriptionTag..tostring(i));
					dropdown:GetButton():SetToolTipString("");
				end
			end
		end
		dropdown:CalculateInternals();
		--This one is too close to the bottom of the screen; make it expand upward instead of downward (thanks whoward for how to do this!)
		local offsetY = -(dropdown:GetSizeY() + dropdown:GetGrid():GetSizeY())
		dropdown:GetGrid():SetOffsetVal(0, offsetY)
		dropdown:RegisterSelectionCallback(function(v1, v2)
			if not bMulti then
				if v1 == 99999 then
					MagicalGirls[g_MGKey].HairAccessory[1] = -1
					MagicalGirls[g_MGKey].HairAccessory[2] = -1
					MagicalGirls[g_MGKey].HairAccessory[3] = -1
				else
					MagicalGirls[g_MGKey].HairAccessory[1] = GameInfo.MG_IconHairAccessories[v2].IconAtlas
					MagicalGirls[g_MGKey].HairAccessory[2] = v1
					MagicalGirls[g_MGKey].HairAccessory[3] = v2 or -1
				end
			else
				if v1 == 99999 then
					g_MPAppearanceChanges = {
						["Type"] = "HAIRACC",
						[1] = -1,
						[2] = -1,
						[3] = -1
					}
				else
					g_MPAppearanceChanges = {
						["Type"] = "HAIRACC",
						[1] = GameInfo.MG_IconHairAccessories[v2].IconAtlas,
						[2] = v1,
						[3] = v2 or -1
					}
				end
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end);
		if g_AppearanceChanges[1] then
			if g_AppearanceChanges[1][2] then
				if g_AppearanceChanges[1][2] == -1 then
					dropdown:GetButton():LocalizeAndSetText("TXT_KEY_SV_ICONS_NONE")
				else
					dropdown:GetButton():LocalizeAndSetText(GameInfo.MG_IconHairAccessories[g_AppearanceChanges[1][2]].ColorDescriptionTag..tostring(g_AppearanceChanges[1][2]));
				end
				dropdown:GetButton():SetToolTipString("");
			end
		end
	
	
	
		--Arrows
		Controls.BodyTypePrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].BodyIcon[3] - 1, 0)
			if not bMulti then
				MagicalGirls[g_MGKey].BodyIcon[3] = iNewVal
				MagicalGirls[g_MGKey].BodyIcon[1] = GameInfo.MG_IconBodies[iNewVal].IconAtlas
				MagicalGirls[g_MGKey].BodyIcon[2] = 0
			else
				g_MPAppearanceChanges = {
					["Type"] = "BODY",
					[1] = GameInfo.MG_IconBodies[iNewVal].IconAtlas,
					[2] = 0,
					[3] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.BodyTypeNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].BodyIcon[3]
			if GameInfo.MG_IconBodies[iNewVal + 1] then
				iNewVal = iNewVal + 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].BodyIcon[3] = iNewVal
				MagicalGirls[g_MGKey].BodyIcon[1] = GameInfo.MG_IconBodies[iNewVal].IconAtlas
				MagicalGirls[g_MGKey].BodyIcon[2] = 0
			else
				g_MPAppearanceChanges = {
					["Type"] = "BODY",
					[1] = GameInfo.MG_IconBodies[iNewVal].IconAtlas,
					[2] = 0,
					[3] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.BodyColorPrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].BodyIcon[2] - 1, 0)
			if not bMulti then
				MagicalGirls[g_MGKey].BodyIcon[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "BODY",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.BodyColorNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].BodyIcon[2] + 1
			if GameInfo.MG_IconBodies[MagicalGirls[g_MGKey].BodyIcon[3]].NumColors <= iNewVal then
				iNewVal = iNewVal - 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].BodyIcon[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "BODY",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
	
		Controls.OutfitTypePrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].OutfitIcon[3] - 1, 0)
			if not bMulti then
				MagicalGirls[g_MGKey].OutfitIcon[3] = iNewVal
				MagicalGirls[g_MGKey].OutfitIcon[1] = GameInfo.MG_IconOutfits[iNewVal].IconAtlas
				MagicalGirls[g_MGKey].OutfitIcon[2] = 0
			else
				g_MPAppearanceChanges = {
					["Type"] = "OUTFIT",
					[1] = GameInfo.MG_IconOutfits[iNewVal].IconAtlas,
					[2] = 0,
					[3] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.OutfitTypeNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].OutfitIcon[3]
			if GameInfo.MG_IconOutfits[iNewVal + 1] then
				iNewVal = iNewVal + 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].OutfitIcon[3] = iNewVal
				MagicalGirls[g_MGKey].OutfitIcon[1] = GameInfo.MG_IconOutfits[iNewVal].IconAtlas
				MagicalGirls[g_MGKey].OutfitIcon[2] = 0
			else
				g_MPAppearanceChanges = {
					["Type"] = "OUTFIT",
					[1] = GameInfo.MG_IconOutfits[iNewVal].IconAtlas,
					[2] = 0,
					[3] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.OutfitColorPrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].OutfitIcon[2] - 1, 0)
			if not bMulti then
				MagicalGirls[g_MGKey].OutfitIcon[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "OUTFIT",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.OutfitColorNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].OutfitIcon[2] + 1
			if GameInfo.MG_IconOutfits[MagicalGirls[g_MGKey].OutfitIcon[3]].NumColors <= iNewVal then
				iNewVal = iNewVal - 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].OutfitIcon[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "OUTFIT",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
	
			Controls.FaceTypePrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].FaceIcon[3] - 1, 0)
			if not bMulti then
				MagicalGirls[g_MGKey].FaceIcon[3] = iNewVal
				MagicalGirls[g_MGKey].FaceIcon[1] = GameInfo.MG_IconFaces[iNewVal].IconAtlas
				MagicalGirls[g_MGKey].FaceIcon[2] = 0
			else
				g_MPAppearanceChanges = {
					["Type"] = "FACE",
					[1] = GameInfo.MG_IconFaces[iNewVal].IconAtlas,
					[2] = 0,
					[3] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.FaceTypeNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].FaceIcon[3]
			if GameInfo.MG_IconFaces[iNewVal + 1] then
				iNewVal = iNewVal + 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].FaceIcon[3] = iNewVal
				MagicalGirls[g_MGKey].FaceIcon[1] = GameInfo.MG_IconFaces[iNewVal].IconAtlas
				MagicalGirls[g_MGKey].FaceIcon[2] = 0
			else
				g_MPAppearanceChanges = {
					["Type"] = "FACE",
					[1] = GameInfo.MG_IconFaces[iNewVal].IconAtlas,
					[2] = 0,
					[3] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.FaceColorPrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].FaceIcon[2] - 1, 0)
			if not bMulti then
				MagicalGirls[g_MGKey].FaceIcon[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "FACE",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.FaceColorNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].FaceIcon[2] + 1
			if GameInfo.MG_IconFaces[MagicalGirls[g_MGKey].FaceIcon[3]].NumColors <= iNewVal then
				iNewVal = iNewVal - 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].FaceIcon[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "FACE",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
	
		Controls.HairTypePrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].HairIcon[3] - 1, 0)
			if not bMulti then
				MagicalGirls[g_MGKey].HairIcon[3] = iNewVal
				MagicalGirls[g_MGKey].HairIcon[1] = GameInfo.MG_IconHairs[iNewVal].IconAtlas
				MagicalGirls[g_MGKey].HairIcon[2] = 0
			else
				g_MPAppearanceChanges = {
					["Type"] = "HAIR",
					[1] = GameInfo.MG_IconHairs[iNewVal].IconAtlas,
					[2] = 0,
					[3] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.HairTypeNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].HairIcon[3]
			if GameInfo.MG_IconHairs[iNewVal + 1] then
				iNewVal = iNewVal + 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].HairIcon[3] = iNewVal
				MagicalGirls[g_MGKey].HairIcon[1] = GameInfo.MG_IconHairs[iNewVal].IconAtlas
				MagicalGirls[g_MGKey].HairIcon[2] = 0
			else
				g_MPAppearanceChanges = {
					["Type"] = "HAIR",
					[1] = GameInfo.MG_IconHairs[iNewVal].IconAtlas,
					[2] = 0,
					[3] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.HairColorPrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].HairIcon[2] - 1, 0)
			if not bMulti then
				MagicalGirls[g_MGKey].HairIcon[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "HAIR",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.HairColorNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].HairIcon[2] + 1
			if GameInfo.MG_IconHairs[MagicalGirls[g_MGKey].HairIcon[3]].NumColors <= iNewVal then
				iNewVal = iNewVal - 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].HairIcon[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "HAIR",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.FaceAccPrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].FaceAccessory[2] - 1, -1)
			if not bMulti then
				MagicalGirls[g_MGKey].FaceAccessory[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "FACEACC",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.FaceAccNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].FaceAccessory[2] + 1
			if GameInfo.MG_IconFaceAccessories[MagicalGirls[g_MGKey].FaceAccessory[3]] and GameInfo.MG_IconFaceAccessories[MagicalGirls[g_MGKey].FaceAccessory[3]].NumAccessories <= iNewVal then
				iNewVal = iNewVal - 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].FaceAccessory[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "FACEACC",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.HairAccPrevButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = math.max(MagicalGirls[g_MGKey].HairAccessory[2] - 1, -1)
			if not bMulti then
				MagicalGirls[g_MGKey].HairAccessory[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "HAIRACC",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
		Controls.HairAccNextButton:RegisterCallback(Mouse.eLClick,
		function()
			local iNewVal = MagicalGirls[g_MGKey].HairAccessory[2] + 1
			if GameInfo.MG_IconHairAccessories[MagicalGirls[g_MGKey].HairAccessory[3]] and GameInfo.MG_IconHairAccessories[MagicalGirls[g_MGKey].HairAccessory[3]].NumAccessories <= iNewVal then
				iNewVal = iNewVal - 1
			end
			if not bMulti then
				MagicalGirls[g_MGKey].HairAccessory[2] = iNewVal
			else
				g_MPAppearanceChanges = {
					["Type"] = "HAIRACC",
					[2] = iNewVal
				}
				Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE, g_MGKey, 0, 0, false, false)
			end	
			g_Tabs["Appearance"].RefreshContent();
			LuaEvents.PMMMRefreshAppearance(UI.GetHeadSelectedUnit())
		end)
	end
end



function OnCloseClicked()
	Controls.MainBox:SetHide(true)
end

Controls.CloseButton:RegisterCallback(Mouse.eLClick, OnCloseClicked)


function LuaEventOpen(str)
	Controls.MainBox:SetHide(false)
	TabSelect(str)
end

LuaEvents.PMMMOpenMGInfoPanel.Add(LuaEventOpen)




function OnUnitDirty()
	local pUnit = UI.GetHeadSelectedUnit()
	local bShow = pUnit and pUnit:GetUnitClassType() == iMagicalGirlClass
	if bShow then
		MagicalGirls = MapModData.PMMM.MagicalGirls
		g_MGKey = GetMagicalGirlKey(Game:GetActivePlayer(), pUnit:GetID())
		if g_CurrentTab then
			g_Tabs[g_CurrentTab].RefreshContent()
		end
	else	
		g_MGKey = nil
		Controls.MainBox:SetHide(true)
	end
end
Events.SerialEventUnitInfoDirty.Add(OnUnitDirty)



function ShowHideHandler(bIsHide, bInitState)
	if not bIsHide then
		local pUnit = UI.GetHeadSelectedUnit()
		local bShow = pUnit and pUnit:GetUnitClassType() == iMagicalGirlClass
		if bShow then
			MagicalGirls = MapModData.PMMM.MagicalGirls
			local iMGKey = GetMagicalGirlKey(Game:GetActivePlayer(), UI.GetHeadSelectedUnit():GetID())
			if iMGKey then
				g_MGKey = iMGKey
			else
				g_MGKey = nil
				ContextPtr:SetHide(true)
			end
		end
	end
end

ContextPtr:SetShowHideHandler( ShowHideHandler );



--Custom Mission call for MP

function AppearanceUpdateCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == MissionTypes.MISSION_PMMM_APPEARANCE_UPDATE then
		local icon
		MagicalGirls = MapModData.PMMM.MagicalGirls
		if g_MPAppearanceChanges.Type == "BODY" then
			icon = MapModData.PMMM.MagicalGirls[iData1].BodyIcon
		elseif g_MPAppearanceChanges.Type == "OUTFIT" then
			icon = MapModData.PMMM.MagicalGirls[iData1].OutfitIcon
		elseif g_MPAppearanceChanges.Type == "FACE" then
			icon = MapModData.PMMM.MagicalGirls[iData1].FaceIcon
		elseif g_MPAppearanceChanges.Type == "HAIR" then
			icon = MapModData.PMMM.MagicalGirls[iData1].HairIcon
		elseif g_MPAppearanceChanges.Type == "FACEACC" then
			icon = MapModData.PMMM.MagicalGirls[iData1].FaceAccessory
		elseif g_MPAppearanceChanges.Type == "HAIRACC" then
			icon = MapModData.PMMM.MagicalGirls[iData1].HairAccessory
		else
			print("Error: attempting to change a nonexistent MG icon layer")
			return 0
		end
		for i = 1, 6, 1 do
			if g_MPAppearanceChanges[i] then icon[i] = g_MPAppearanceChanges[i] end
		end
	end
	g_MPAppearanceChanges = {}
	return 0
end

GameEvents.CustomMissionStart.Add(AppearanceUpdateCustomMissionStart)