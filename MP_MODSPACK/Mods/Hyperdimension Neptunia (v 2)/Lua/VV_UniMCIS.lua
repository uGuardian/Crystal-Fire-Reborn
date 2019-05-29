-- VV_UniMCIS
-- Author: Vice
-- DateCreated: 8/4/2015 3:25:58 PM
--------------------------------------------------------------

--A tooltip handler for sukritact's MCIS support, so the player can get the exact bonus amount from Uni's UA alongside cute little flavor text.
include("IconSupport");

g_UniTipControls = {}
TTManager:GetTypeControlTable("UniUATooltip", g_UniTipControls)

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS

local tScoreDiffLevels = {
	[0] =	{
				["MinDiff"] = 0.95,
				["MaxDiff"] = 1.00,
				["Bonus"] = 0,
				["PortraitIndex"] = 9,
				["FlavorText"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_0"
			},
	[1] =	{
				["MinDiff"] = 0.80,
				["MaxDiff"] = 0.94,
				["Bonus"] = 5,
				["PortraitIndex"] = 5,
				["FlavorText"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_1"
			},
	[2] =	{
				["MinDiff"] = 0.65,
				["MaxDiff"] = 0.79,
				["Bonus"] = 10,
				["PortraitIndex"] = 6,
				["FlavorText"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_2"
			},
	[3] =	{
				["MinDiff"] = 0.50,
				["MaxDiff"] = 0.64,
				["Bonus"] = 15,
				["PortraitIndex"] = 7,
				["FlavorText"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_3"
			},
	[4] =	{
				["MinDiff"] = 0.00,
				["MaxDiff"] = 0.49,
				["Bonus"] = 20,
				["PortraitIndex"] = 8,
				["FlavorText"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_4"
			}
}

--Civ Identifiers
local iUniCiv = GameInfoTypes.CIVILIZATION_VV_LASTATION_UN


--Find the top-scoring player that Uni has met, and return their score and player ID.
function CheckUniTopScoringPlayerMet(iPlayer)
	local pPlayer = Players[iPlayer]
	local iOurScore = pPlayer:GetScore()
	local iHighestScore = iOurScore
	local iHighestScorePlayer = iPlayer
	local pTeam = Teams[pPlayer:GetTeam()]
	for i = 0, iMaxCivs - 1, 1 do
		if i ~= iPlayer then
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) and pLoop:GetScore() > iHighestScore then 
				iHighestScore = pLoop:GetScore()
				iHighestScorePlayer = i
			end
		end
	end
	return iHighestScore, iHighestScorePlayer
end


--Get the difference between Uni's score and another score, as a percent represented by decimals.
function GetUniScoreDifference(iPlayer, iScore)
	local pPlayer = Players[iPlayer]
	local iOurScore = pPlayer:GetScore()
	local iPercentOfTheirScore = math.floor(iOurScore / iScore * 100) * 0.01  --rounds to two decimal places
	return iPercentOfTheirScore
end

--Get the Level of UA bonus from the score difference.
function GetUniScoreDifferenceLevel(iPlayer, iScoreDifference)
	for k, v in pairs(tScoreDiffLevels) do
		if v.MinDiff <= iScoreDifference and v.MaxDiff >= iScoreDifference then
			return k
		end
	end
	return 0
end



function UniCityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "HDN_Uni", ["SortOrder"] = 1})
	table.insert(tEventsToHook, Events.SerialEventScoreDirty)
end

LuaEvents.CityInfoStackDataRefresh.Add(UniCityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function UniCityInfoStackDirty(sKey, pInstance)
	if sKey ~= "HDN_Uni" then return end
	local pCity = UI.GetHeadSelectedCity()
	if pCity then
		local iPlayer = pCity:GetOwner()
		local pPlayer = Players[iPlayer]
		if pPlayer:GetCivilizationType() == iUniCiv then --do not check Black Sister's civ; she doesn't use this UA!

			local iHighScore, iHighScorePlayer = CheckUniTopScoringPlayerMet(iPlayer)
			local iScoreDiff = 1
			if iHighScorePlayer ~= iPlayer then
				iScoreDiff = GetUniScoreDifference(iPlayer, iHighScore)
			end
			local iLevel = GetUniScoreDifferenceLevel(iPlayer, iScoreDiff)

			--Small icon in the CityView itself
			IconHookup(tScoreDiffLevels[iLevel].PortraitIndex, 64, "CIV_COLOR_ATLAS_VV_LASTATION_UN", pInstance.IconImage)

			--Now we build the tooltip for the icon
			pInstance.IconFrame:SetToolTipType("UniUATooltip")
			IconHookup(tScoreDiffLevels[iLevel].PortraitIndex, 256, "CIV_COLOR_ATLAS_VV_LASTATION_UN", g_UniTipControls.UniIcon)
			g_UniTipControls.Heading:SetText("[COLOR_YELLOW]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_UNI_UA_TOOLTIP_HEADING", iLevel)).."[ENDCOLOR]")

			local subheading;
			if iHighScorePlayer == iPlayer then
				subheading = "[COLOR_YELLOW]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_UNI_UA_TOOLTIP_SUBHEADING_LEADING")).."[ENDCOLOR]"
			else
				subheading = "[COLOR_YELLOW]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_UNI_UA_TOOLTIP_SUBHEADING", string.format("%.2f%%", iScoreDiff * 100), Players[iHighScorePlayer]:GetCivilizationShortDescription())).."[ENDCOLOR]"
			end

			g_UniTipControls.Subheading:SetText(subheading)

			g_UniTipControls.Body:SetText(Locale.ConvertTextKey(tScoreDiffLevels[iLevel].FlavorText, Players[iHighScorePlayer]:GetCivilizationShortDescription()))
			g_UniTipControls.Box:DoAutoSize()
			pInstance.IconFrame:SetHide(false)
		else
			pInstance.IconFrame:SetHide(true)
		end
	end
end

LuaEvents.CityInfoStackDirty.Add(UniCityInfoStackDirty)