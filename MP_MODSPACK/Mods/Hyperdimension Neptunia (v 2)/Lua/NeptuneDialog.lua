local iMaxCivs = GameDefines.MAX_MAJOR_CIVS

--Civ Identifiers
local iNeptune = GameInfoTypes.LEADER_VV_NEPTUNE
local iPurpleHeart = GameInfoTypes.LEADER_VV_PURPLE_HEART
local iNeptuneCiv = GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE
local iPurpleHeartCiv = GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PH
local tNeptunes = {}
for i = 0, iMaxCivs - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local iLeaderType = pPlayer:GetLeaderType()
		if (iLeaderType == iNeptune or iLeaderType == iPurpleHeart) then
			tNeptunes[i] = true
		end
	end
end

---------------------------------------------------------------------------------------------------------------
-- DEBUG MODE
---------------------------------------------------------------------------------------------------------------
--Make print a nil-returning function if debug mode is off.
local bDebug = false
function dprint(str)
	if bDebug then print(str) end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- FLUFF
---------------------------------------------------------------------------------------------------------------------------------------------------------
local tDenounceResponses = {}

function RefreshDenounceResponses()
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	for row in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag LIKE '%_RESPONSE_TO_BEING_DENOUNCED_%' OR Tag LIKE '%_RESPONSE_TO_DENOUNCEMENT_%'") do
		tDenounceResponses[row.Text] = true
	end
end
RefreshDenounceResponses()

--Special Leaderscene logic for Neptune:
--If the player denounces her, a certain special face comes up.
function NeptuneSpecialLeaderscene( iPlayer, iDiploUIState, szLeaderMessage, iAnimationAction, iData1 )
	local pPlayer = Players[iPlayer]
	if pPlayer:GetLeaderType() == iNeptune then
		if tDenounceResponses[szLeaderMessage] then
			for row in DB.Query("SELECT * FROM VV_NeptuneModOptions WHERE Type = 'OUTFIT' AND Value = 2") do
				return "VVNeptuneSceneDynamicYukkuriAlt.dds"
			end
			return "VVNeptuneSceneDynamicYukkuri.dds"
		end
	end

	return nil
end
Events.LoadScreenClose.Add(function () LuaEvents.AddFunctionToLeaderSceneTable(NeptuneSpecialLeaderscene) end)



function SetAndResizeLeaderHeadDialogBox(sString)
	if sString then
		--LeaderHeadRoot
		local speechBox = ContextPtr:LookUpControl("/LeaderHeadRoot/LeaderSpeech")
		if speechBox then
			speechBox:SetText(sString)
			local border = ContextPtr:LookUpControl("/LeaderHeadRoot/LeaderSpeechBorderFrame")
			local frame = ContextPtr:LookUpControl("/LeaderHeadRoot/LeaderSpeechFrame")
			if border and frame then
			local contentSize = speechBox:GetSizeY() + 48;
				border:SetSizeY( contentSize );
				frame:SetSizeY( contentSize - 4 );
			end
		end
		--DiscussionDialog
		local speechBox2 = ContextPtr:LookUpControl("/LeaderHeadRoot/DiscussionDialog/LeaderSpeech")
		if speechBox2 then
			speechBox2:SetText(sString)
			local border2 = ContextPtr:LookUpControl("/LeaderHeadRoot/DiscussionDialog/LeaderSpeechBorderFrame")
			local frame2 = ContextPtr:LookUpControl("/LeaderHeadRoot/DiscussionDialog/LeaderSpeechFrame")
			if border2 and frame2 then
			local contentSize = speechBox:GetSizeY() + 48;
				border2:SetSizeY( contentSize );
				frame2:SetSizeY( contentSize - 4 );
			end
		end	
		--DiploTrade
		local speechBox2 = ContextPtr:LookUpControl("/LeaderHeadRoot/DiploTrade/DiscussionText")
		if speechBox2 then
			speechBox2:SetText(sString)
			local border2 = ContextPtr:LookUpControl("/LeaderHeadRoot/DiploTrade/LeaderSpeechBorderFrame")
			local frame2 = ContextPtr:LookUpControl("/LeaderHeadRoot/DiploTrade/LeaderSpeechFrame")
			if border2 and frame2 then
			local contentSize = speechBox:GetSizeY() + 48;
				border2:SetSizeY( contentSize );
				frame2:SetSizeY( contentSize - 4 );
			end
		end
	end
end


--Localized Lua string functions 
local gsub = string.gsub
local reverse = string.reverse
local sub = string.sub
local find = string.find




function SubstituteEndNumberForPercentSign(sString)
	dprint("String before substitution: "..sString)
	local sReverse = reverse(sString)
	local iStop = find(sReverse, "_")
	if not iStop then return sString end
	sReverse = sub(sReverse, iStop + 1)
	sString = reverse(sReverse).."%"
	dprint("String after substitution: "..sString)
	return sString
end

local tNeptuneResponses = {}
local tPurpleHeartResponses = {}
for row in DB.Query("SELECT * FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_LEADER_VV_NEPTUNE_%')") do
	tNeptuneResponses[row.Text] = SubstituteEndNumberForPercentSign(row.Tag)
end
for row in DB.Query("SELECT * FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_LEADER_VV_PURPLE_HEART_%')") do
	tPurpleHeartResponses[row.Text] = SubstituteEndNumberForPercentSign(row.Tag)
end



local tLeaderAliases = {}
function AddLeaderAlias(sLeaderType, sAlias)
	if not sLeaderType and not sAlias then return end
	if not tLeaderAliases[sLeaderType] then tLeaderAliases[sLeaderType] = {} end
	tLeaderAliases[sLeaderType][#tLeaderAliases[sLeaderType] + 1] = sAlias
end
LuaEvents.VV_AddLeaderAlias.Add(AddLeaderAlias)


AddLeaderAlias("LEADER_VV_PURPLE_HEART", "LEADER_VV_NEPTUNE")
AddLeaderAlias("LEADER_VV_PURPLE_SISTER", "LEADER_VV_NEPGEAR")
AddLeaderAlias("LEADER_VV_BLACK_HEART", "LEADER_VV_NOIRE")
AddLeaderAlias("LEADER_VV_NOIRE_ULTRA", "LEADER_VV_NOIRE")
AddLeaderAlias("LEADER_VV_BLACK_HEART_ULTRA", "LEADER_VV_NOIRE")
AddLeaderAlias("LEADER_VV_BLACK_HEART_ULTRA", "LEADER_VV_NOIRE_ULTRA")
AddLeaderAlias("LEADER_VV_GREEN_HEART", "LEADER_VV_VERT")
AddLeaderAlias("LEADER_VV_VERT_ULTRA", "LEADER_VV_VERT")
AddLeaderAlias("LEADER_VV_GREEN_HEART_ULTRA", "LEADER_VV_VERT")
AddLeaderAlias("LEADER_VV_GREEN_HEART_ULTRA", "LEADER_VV_VERT_ULTRA")
AddLeaderAlias("LEADER_VV_WHITE_HEART", "LEADER_VV_BLANC")
AddLeaderAlias("LEADER_VV_BLANC_ULTRA", "LEADER_VV_BLANC")
AddLeaderAlias("LEADER_VV_WHITE_HEART_ULTRA", "LEADER_VV_BLANC")
AddLeaderAlias("LEADER_VV_WHITE_HEART_ULTRA", "LEADER_VV_BLANC_ULTRA")
AddLeaderAlias("LEADER_VV_BLACK_SISTER", "LEADER_VV_UNI")
AddLeaderAlias("LEADER_VV_IRIS_HEART", "LEADER_VV_PLUTIA")


function GetRandomDiploString(sString)
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type
	local t = {}
	for row in DB.Query("SELECT * FROM "..locale.." WHERE Tag LIKE ('"..sString.."')") do
		t[#t + 1] = row.Text
	end
	if #t > 0 then
		return t[Game.Rand(#t, "Random Text Roll") + 1]
	end
end




function DialogOverride(iPlayer, iDiploUIState, szLeaderMessage, iAnimation, iData)
	local sString;
	local startTime = os.clock()
	local function DoOverride(tableType)
		local iActivePlayer = Game:GetActivePlayer()
		local pActivePlayer = Players[iActivePlayer]
		local sActivePlayerType = GameInfo.Leaders[pActivePlayer:GetLeaderType()].Type
		dprint("Active Player's Type is "..sActivePlayerType)
		local sNewTag = gsub(tableType[szLeaderMessage], "LEADER_VV_", "UD_VS_"..gsub(sActivePlayerType, "LEADER_", "").."_")
		dprint("Tag created is "..sNewTag)
		sString = GetRandomDiploString(sNewTag)
		if sString then
			dprint("Message: "..sString)
		elseif tLeaderAliases[sActivePlayerType] then
			for k, v in pairs(tLeaderAliases[sActivePlayerType]) do
				sNewTag = gsub(tableType[szLeaderMessage], "LEADER_VV_", "UD_VS_"..gsub(v, "LEADER_", "").."_")
				dprint("Tag created is "..sNewTag)
				sString = GetRandomDiploString(sNewTag)
				if sString then dprint("Message: "..sString) break end
			end
		end
	end

	if tNeptuneResponses[szLeaderMessage] then
		DoOverride(tNeptuneResponses)
	elseif tPurpleHeartResponses[szLeaderMessage] then
		DoOverride(tPurpleHeartResponses)
	end

	if sString then
		SetAndResizeLeaderHeadDialogBox(sString)
	end
	dprint("Total Time to accomplish unique dialog: "..os.clock() - startTime)
end
Events.AILeaderMessage.Add(DialogOverride)