-- VV_NeptuneMCIS
-- Author: Vice
-- DateCreated: 8/4/2015 3:25:58 PM
--------------------------------------------------------------

--A tooltip handler for sukritact's MCIS support, so the player can get information about their Pudding Quests.
include("IconSupport");

g_NeptuneTipControls = {}
TTManager:GetTypeControlTable("NeptuneUATooltip", g_NeptuneTipControls)

--Taken from sukritact's Events & Decisions
function CompileCityID(pCity)
	local iOriginalOwner = pCity:GetOriginalOwner()
	local iTurnFounded = pCity:GetGameTurnFounded ()	--Used to Compile Unique City ID
	local iCityID = ("X" .. pCity:GetX() .. "Y" .. pCity:GetY() .. "P" .. iOriginalOwner .. "T" .. iTurnFounded)
	return iCityID
end

function Vice_DecompileCityID(sKey)
    local iBreak = string.find(sKey, "Y")
	local iBreak2 = string.find(sKey, "P")
    iX = tonumber(string.sub(sKey, 2, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1, iBreak2 - 1))
    local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity()
    return pCity
end

--Civ Identifiers
local iNeptune = GameInfoTypes.LEADER_VV_NEPTUNE
local iPurpleHeart = GameInfoTypes.LEADER_VV_PURPLE_HEART

function NeptuneCityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "HDN_Neptune", ["SortOrder"] = 1})
	table.insert(tEventsToHook, Events.SerialEventScoreDirty)
end

LuaEvents.CityInfoStackDataRefresh.Add(NeptuneCityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function NeptuneCityInfoStackDirty(sKey, pInstance)
	if sKey ~= "HDN_Neptune" then return end
	local pCity = UI.GetHeadSelectedCity()
	if pCity then
		local iPlayer = pCity:GetOwner()
		if iPlayer == Game:GetActivePlayer() then
			local pPlayer = Players[iPlayer]
			if pPlayer:GetLeaderType() == iNeptune or pPlayer:GetLeaderType() == iPurpleHeart then
				local iCity = pCity:GetID()
				local sCity = CompileCityID(pCity)
				local HDNMod = MapModData.HDNMod
				if HDNMod.PuddingQuests[iPlayer] and HDNMod.PuddingQuests[iPlayer][sCity] then
					--Small icon in the CityView itself
					IconHookup(5, 64, "CIV_COLOR_ATLAS_VV_PLANEPTUNE", pInstance.IconImage)

					--Now we build the tooltip for the icon
					pInstance.IconFrame:SetToolTipType("NeptuneUATooltip")
					LuaEvents.VV_GetNeptuneQuestTooltip(HDNMod.PuddingQuests[iPlayer][sCity].QuestType, iPlayer, iCity, sCity, g_NeptuneTipControls.Heading, g_NeptuneTipControls.Subheading, g_NeptuneTipControls.Body)
					g_NeptuneTipControls.Box:DoAutoSize()
					pInstance.IconFrame:SetHide(false)

					if HDNMod.PuddingQuests[iPlayer][sCity].Completed == true then
						pInstance.IconFrame:RegisterCallback(Mouse.eLClick, function() LuaEvents.VV_NeptuneAnnex(UI.GetHeadSelectedCity()) end)
					end
				else
					pInstance.IconFrame:SetHide(true)
				end
			else
				pInstance.IconFrame:SetHide(true)
			end
		else
			pInstance.IconFrame:SetHide(true)
		end
	end
end

LuaEvents.CityInfoStackDirty.Add(NeptuneCityInfoStackDirty)