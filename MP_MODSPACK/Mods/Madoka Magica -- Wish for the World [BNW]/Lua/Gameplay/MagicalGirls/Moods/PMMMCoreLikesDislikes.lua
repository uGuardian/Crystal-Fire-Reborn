-- Core Likes & Dislikes
-- Author: Vicevirtuoso
-- DateCreated: 12/27/2014 1:47:59 PM
--------------------------------------------------------------

--Warning: This isn't pretty.

t_LikesDislikes = {}

local LIKE_TYPE = 0
local DISLIKE_TYPE = 1
local LOVE_TYPE = 2
local HATE_TYPE = 3

local tDescHeaders = {
	[LIKE_TYPE] = Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_LIKE_HEADER"),
	[DISLIKE_TYPE] = Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_DISLIKE_HEADER"),
	[LOVE_TYPE] = Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_LOVE_HEADER"),
	[HATE_TYPE] = Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_HATE_HEADER")
}

--Table for when new Likes/Dislikes should be developed.
--The first L/D is determined at unit creation, while others develop over time.
--There is a target turn time, but it has a level of variance for each individual MG.

local iVariancePercent = GameDefines.MG_NEXT_LIKE_DISLIKE_TURN_VARIANCE_PERCENT
local iGameSpeedMod = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ResearchPercent / 100

local tLikeDislikeTurnTargets = {}
for i = 1, GameDefines.MG_MAX_LIKES_DISLIKES - 1, 1 do
	tLikeDislikeTurnTargets[i] = math.floor(GameDefines.MG_TURNS_BETWEEN_NEW_LIKE_DISLIKE * i * iGameSpeedMod)
end


--Category: What's in the MG_LikesDislikes table (ex. GameInfoTypes.MGLIKEDISLIKE_POLICY)
--Type: Whether it's a Like, Dislike, Love, or Hate (see variables above)
--Value: What specific item the L/D is referencing (ex. GameInfoTypes.POLICY_REPRESENTATION for GameInfoTypes.MGLIKEDISLIKE_POLICY)


function ObtainNewLikeDislike(iPlayer, iMGKey, bNotify, bIgnoreMaximum, iCategory, iType, iValue)
	if not MagicalGirls[iMGKey].LikesDislikes then
		MagicalGirls[iMGKey].LikesDislikes = {}
	end
	
	--stop the function if the MG already has the max L/Ds, UNLESS the bIgnoreMaximum variable was set true
	if #MagicalGirls[iMGKey].LikesDislikes >= GameDefines.MG_MAX_LIKES_DISLIKES and bIgnoreMaximum ~= true then return end
	
	local bInfluencedLD = false  		-- Used later in the function for the Notification
	--see if they get a L/D influenced from other MGs first
	if not iCategory and not iValue and not iType and not MagicalGirls[iMGKey].IsLeader then
		if not MagicalGirls[iMGKey].InfluencedLikeDislikes then MagicalGirls[iMGKey].InfluencedLikeDislikes = {} end
		local iRemoveKey;
		for k, v in pairs(MagicalGirls[iMGKey].InfluencedLikeDislikes) do
			local bIdenticalLD = false 			-- Don't grant MGs an LD they've already got
			local iChangedLDKey = -1 			-- For changing LD Types from Influence
			local iChangedLDType = -1			-- For changing LD Types from Influence
			for k2, v2 in pairs(MagicalGirls[iMGKey].LikesDislikes) do
				if v.Category == v2.Category and v2.Value == v.Value then 
					if v2.Type == v.Type then
						--Completely identical LD; do nothing with it.
						bIdenticalLD = true
						break
					else
						--Shift the Type of an existing L/D
						iChangedLDKey = k2
						if v2.Type == LIKE_TYPE and v.Type == LOVE_TYPE then
							iChangedLDType = LOVE_TYPE
						elseif v2.Type == DISLIKE_TYPE and v.Type == HATE_TYPE then
							iChangedLDType = HATE_TYPE
						elseif v2.Type == LIKE_TYPE then
							iChangedLDType = DISLIKE_TYPE
						elseif v2.Type == DISLIKE_TYPE then
							iChangedLDType = LIKE_TYPE
						end
						break
					end
				end
			end
			if not bIdenticalLD then
				local iRand = v.Influence
				if iChangedLDKey > -1 then iRand = math.floor(iRand / 2) end --Changing an existing LD is much less likely
				if (Game.Rand(99, "PMMM Like Dislike Influence Roll") + 1) <= iRand then
					if iChangedLDKey > -1 then
						--Change Existing LD
						MagicalGirls[iMGKey].LikesDislikes[iChangedLDKey].Type = iChangedLDType
						iRemoveKey = k
						table.remove(MagicalGirls[iMGKey].InfluencedLikeDislikes, iRemoveKey)
						
						--Refresh Text
						local sPrevLD = MagicalGirls[iMGKey].LikesDislikes[iChangedLDKey]["Desc"]
						_, MagicalGirls[iMGKey].LikesDislikes[iChangedLDKey]["Desc"], MagicalGirls[iMGKey].LikesDislikes[iChangedLDKey]["Tooltip"] = t_LikesDislikes[v.Category].FulfilledFunc(iPlayer, iMGKey, iChangedLDType, v.Value)
						
						--Do the Notification here; it's a bit different from the one below
						sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_EXISTING_LIKE_DISLIKE_CHANGED_TEXT", MagicalGirls[iMGKey].Name, sPrevLD, MagicalGirls[iMGKey].LikesDislikes[iChangedLDKey]["Desc"])
						sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_EXISTING_LIKE_DISLIKE_CHANGED_TITLE", MagicalGirls[iMGKey].Name)
						Players[iPlayer]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, MagicalGirls[iMGKey].X, MagicalGirls[iMGKey].Y)
						
						return   --Nothing else in this function needed; this is all a special case
					else
						--Set the Category/Type/Value for use later in the function
						iCategory = v.Category
						iValue = v.Value
						iType = v.Type
						iRemoveKey = k
						bInfluencedLD = true
						break
					end
				end
			end
		end
		if iRemoveKey then table.remove(MagicalGirls[iMGKey].InfluencedLikeDislikes, iRemoveKey) end
	end
	
	--Determine Category
	if not iCategory then
		local tValidCategories = {}
		for k, v in pairs(t_LikesDislikes) do
			tValidCategories[k] = v.IsValidFunc(iPlayer, iMGKey)
		end
		local bLoop = true
		while bLoop do
			local iRand = Game.Rand(#tValidCategories, "PMMM Random Like Dislike Category Roll") + 1
			if tValidCategories[iRand] == true then
				iCategory = iRand
				bLoop = false
				break
			end
		end
	end
	
	--Determine Value
	if not iValue then
		iValue = t_LikesDislikes[iCategory].GetValueFunc(iPlayer, iMGKey, {})
	end
	
	--Determine Type
	if not iType then
		if t_LikesDislikes[iCategory].GetTypeFunc then  --Not all L/Ds have Type determination functions; those without them will use the default
			iType = t_LikesDislikes[iCategory].GetTypeFunc(iPlayer, iMGKey, iValue)
		else --Default function is to get the Type randomly
			local tWeight = {
				[LIKE_TYPE] = 70,
				[LOVE_TYPE] = 7,
				[DISLIKE_TYPE] = 20,
				[HATE_TYPE] = 3
			}
			iType = DeckShuffle(tWeight, "PMMM Generic L/D Type Roll")
		end
	end
	
	--A MG should only have one Like/Dislike of a specific Category and Value at once. (i.e., no Liking Russia and Hating it at the same time)
	--So build a table of items in the MG's L/D table which have the same category and value.
	local tIgnoreValues = {}
	local bRetestValue = false
	for k, v in pairs(MagicalGirls[iMGKey].LikesDislikes) do
		if (v.Category and v.Category == iCategory) and (v.Value and v.Value == iValue) then
			tIgnoreValues[v.Value] = true
			bRetestValue = true
		end
	end
	
	if bRetestValue then
		iValue = t_LikesDislikes[iCategory].GetValueFunc(iPlayer, iMGKey, tIgnoreValues)
	end
	
	local iTableKey = #MagicalGirls[iMGKey].LikesDislikes + 1
	MagicalGirls[iMGKey].LikesDislikes[iTableKey] = {
		["Category"] = iCategory,
		["Type"] = iType,
		["Value"] = iValue
	}
	

	_, MagicalGirls[iMGKey].LikesDislikes[iTableKey]["Desc"], MagicalGirls[iMGKey].LikesDislikes[iTableKey]["Tooltip"] = t_LikesDislikes[iCategory].FulfilledFunc(iPlayer, iMGKey, iType, iValue)
	
	if bNotify then
		local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_NEW_LIKE_DISLIKE_TEXT", MagicalGirls[iMGKey].Name, MagicalGirls[iMGKey].LikesDislikes[iTableKey]["Desc"])
		if bInfluencedLD then
			 sText = sText.."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_NEW_LIKE_DISLIKE_INFLUENCED_TEXT")
		end
		local sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_NEW_LIKE_DISLIKE_TITLE", MagicalGirls[iMGKey].Name)
		
		local _, pUnit = RetrieveMGPointers(iMGKey)
		local iX = -1;
		local iY = -1;
		if pUnit then
			iX = pUnit:GetX()
			iY = pUnit:GetY()
		end
		
		Players[iPlayer]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, iX, iY)
	end
end

function SetSpecificMGNextLikeDislikeTurn(iPlayer, iMGKey)
	local iCurrNumLikesDislikes = #MagicalGirls[iMGKey].LikesDislikes
	if iCurrNumLikesDislikes >= GameDefines.MG_MAX_LIKES_DISLIKES then return false end
	
	if not tLikeDislikeTurnTargets[iCurrNumLikesDislikes] then tLikeDislikeTurnTargets[iCurrNumLikesDislikes] = math.floor(GameDefines.MG_TURNS_BETWEEN_NEW_LIKE_DISLIKE * iCurrNumLikesDislikes * iGameSpeedMod) end
	
	local iMultiplier = (Game.Rand(iVariancePercent * 2 + 1, "PMMM Next Like Dislike Turn Variance") - iVariancePercent) / 100 + 1
	MagicalGirls[iMGKey].NextLikeDislikeTurn = math.floor(tLikeDislikeTurnTargets[iCurrNumLikesDislikes] * iMultiplier) + Game:GetGameTurn()
end


--After any player adopts the first ideology, all MGs start showing their ideological colors.
function OnAnyPlayerAdoptedIdeologyMGsGetIdeologicalBeliefs(iPlayer)
	if not PMMM.AnyoneHasIdeology then
		local pPlayer = Players[iPlayer]
		if pPlayer:GetLateGamePolicyTree() and pPlayer:GetLateGamePolicyTree() > -1 then
			PMMM.AnyoneHasIdeology = true
			for k, v in pairs(MagicalGirls) do
				tIdeologyLDTable.GetValueFunc(v.Owner, k)
			end
		end
	end
end

if not PMMM.AnyoneHasIdeology then
	GameEvents.PlayerAdoptPolicy.Add(OnAnyPlayerAdoptedIdeologyMGsGetIdeologicalBeliefs)
end

function AddLDTooltipFooter(string, type, value)
	string = string.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_TOTAL", value).."[NEWLINE]"
	if type == LOVE_TYPE then
		string = string.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_LOVES")
	elseif type == DISLIKE_TYPE then
		string = string.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_DISLIKES")
	elseif type == HATE_TYPE then
		string = string.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_HATES")
	end
	return string
end

----------------------------------------------------------------------------------------------------------------------------
-- POLICIES
----------------------------------------------------------------------------------------------------------------------------
row = GameInfo.MG_LikeDislikes["MGLIKEDISLIKE_POLICY"]
local iPolicyLDID = row.ID

-- In v25, this is now Policy Branches rather than individual Policies.
local tLikeDislikePossiblePolicies = {}

for policy in GameInfo.PolicyBranchTypes() do
	if policy.FirstAdopterFreePolicies < 1 and policy.SecondAdopterFreePolicies < 1 then
		local iEra = policy.EraPrereq and GameInfo.Eras[policy.EraPrereq].ID or 0
		tLikeDislikePossiblePolicies[#tLikeDislikePossiblePolicies + 1] = {
			["ID"] = policy.ID,
			["EraReq"] =  iEra
		}
	end
end

t_LikesDislikes[iPolicyLDID] = {}
t_LikesDislikes[iPolicyLDID].Value = row.Value
t_LikesDislikes[iPolicyLDID].TT = row.Tooltip
t_LikesDislikes[iPolicyLDID].Desc = row.Description
t_LikesDislikes[iPolicyLDID].IsValidFunc = (
	function(iPlayer, iMGKey)
		--Policies are always a valid like/dislike.
		return true
	end
)

t_LikesDislikes[iPolicyLDID].GetValueFunc = (
	function(iPlayer, iMGKey, tIgnoreValues)
		local pPlayer = Players[iPlayer]
		local tValidPoliciesThisTest = {}
		local iEra = Players[iPlayer]:GetCurrentEra()
		for k, v in pairs(tLikeDislikePossiblePolicies) do
			if v.EraReq <= iEra and tIgnoreValues[v.ID] ~= true then
				--v25: Leaders always pick Policy Trees which the player has taken, but non-leaders don't
				--Exception: LMGs will pick a random one if the player has no policies at all
				if (MagicalGirls[iMGKey].IsLeader and pPlayer:HasPolicyBranch(v.ID)) then
					return v.ID
				else
					tValidPoliciesThisTest[#tValidPoliciesThisTest + 1] = v.ID
				end
			end
		end
		
		return tValidPoliciesThisTest[Game.Rand(#tValidPoliciesThisTest, "PMMM Like Dislike Policy Type Roll") + 1]
	end
)

t_LikesDislikes[iPolicyLDID].GetTypeFunc = (
	function(iPlayer, iMGKey, iValue)
		--Leaders always Like
		if MagicalGirls[iMGKey].IsLeader then
			return LIKE_TYPE
		end

		--Non-leaders
		local pPlayer = Players[iPlayer]
		local tWeight = {
			[LIKE_TYPE] = 9,
			[LOVE_TYPE] = 1,
			[DISLIKE_TYPE] = 9,
			[HATE_TYPE] = 1
		}

		--Statistically speaking, is this policy tree working out well for our country?
		--We will determine this by Happiness and Score when compared with the rest of the known world.
		--Note: this will actually be less strict on higher difficulties for human players.
		--It's impossible for players to keep up with AI Happiness and Scores there; we don't want to compound the player's issues.
		local pTeam = Teams[pPlayer:GetTeam()]
		local iHandicapModifier = 1 - (Game:GetHandicapType() / 15)
		local iNumAlivePlayers = 0
		local iOurHappiness = pPlayer:GetExcessHappiness()
		local iOurScore = pPlayer:GetScore()
		local iAvgHappiness = 0
		local iAvgScore = 0
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
				iAvgHappiness = iAvgHappiness + pLoop:GetExcessHappiness()
				iAvgScore = iAvgScore + pLoop:GetScore()
				iNumAlivePlayers = iNumAlivePlayers + 1
			end
		end
		iAvgHappiness = math.floor(iAvgHappiness / iNumAlivePlayers * iHandicapModifier)
		iAvgScore = math.floor(iAvgScore / iNumAlivePlayers * iHandicapModifier)
		local iHappinessDifference = iOurHappiness - iAvgHappiness
		if iHappinessDifference < 0 then
			tWeight[DISLIKE_TYPE] = tWeight[DISLIKE_TYPE] - iHappinessDifference
			tWeight[HATE_TYPE] = tWeight[HATE_TYPE] - math.floor(iHappinessDifference / 2)
		else
			tWeight[LIKE_TYPE] = tWeight[DISLIKE_TYPE] + iHappinessDifference
			tWeight[LOVE_TYPE] = tWeight[HATE_TYPE] + math.floor(iHappinessDifference / 2)
		end

		local iScoreDifference = iOurScore - iAvgScore
		if iScoreDifference < 0 then
			tWeight[DISLIKE_TYPE] = tWeight[DISLIKE_TYPE] - math.floor(iScoreDifference / 10)
			tWeight[HATE_TYPE] = tWeight[HATE_TYPE] - math.floor(iScoreDifference / 20)
		else
			tWeight[LIKE_TYPE] = tWeight[DISLIKE_TYPE] + math.floor(iScoreDifference / 10)
			tWeight[LOVE_TYPE] = tWeight[HATE_TYPE] + math.floor(iScoreDifference / 20)
		end


		--What about other countries? Do countries we like or dislike have these policies?
		for k, v in pairs(MagicalGirls[iMGKey].LikesDislikes) do
			if v.Category == iCivLDID then
				local pOtherCiv = Players[v.Value]
				if pOtherCiv:IsAlive() then
					local bHasPolicy = pOtherCiv:HasPolicyBranch(iValue)
					if bHasPolicy then
						if v.Type == LIKE_TYPE then
							tWeight[LIKE_TYPE] = tWeight[DISLIKE_TYPE] + 3
							tWeight[LOVE_TYPE] = tWeight[HATE_TYPE] + 1
						elseif v.Type == LOVE_TYPE then
							tWeight[LIKE_TYPE] = tWeight[DISLIKE_TYPE] + 9
							tWeight[LOVE_TYPE] = tWeight[HATE_TYPE] + 3
						elseif v.Type == DISLIKE_TYPE then
							tWeight[DISLIKE_TYPE] = tWeight[DISLIKE_TYPE] + 3
							tWeight[HATE_TYPE] = tWeight[HATE_TYPE] + 1
						else
							tWeight[DISLIKE_TYPE] = tWeight[DISLIKE_TYPE] + 9
							tWeight[HATE_TYPE] = tWeight[HATE_TYPE] + 3
						end
					end
				end
			end
		end
		
		return DeckShuffle(tWeight, "PMMM Like Dislike Policy Branch Value Roll");
	end
)

t_LikesDislikes[iPolicyLDID].FulfilledFunc = (
	function(iPlayer, iMGKey, iType, iValue)
		local sString = ""
		--Determined by how many Policies of the chosen type we've adopted.

		--Cache all policies in this tree
		local tPolicies = {}
		local sPolicyBranch = GameInfo.PolicyBranchTypes[iValue].Type
		local sPolicyBranchName = Locale.ConvertTextKey(GameInfo.PolicyBranchTypes[iValue].Description)
		for policy in GameInfo.Policies() do
			if policy.PolicyBranchType == sPolicyBranch then
				tPolicies[policy.ID] = true
			end
		end

		local iVal = 0
		local pPlayer = Players[iPlayer]
		local iNumPolicies = 0
		for k, v in pairs(tPolicies) do
			if pPlayer:HasPolicy(k) then
				iNumPolicies = iNumPolicies + 1
			end
		end

		--If we have -none- of the policies from that branch, then there is a -50 Penalty.
		if iNumPolicies == 0 then 
			iVal = -50
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_POLICY_NONE_OF_BRANCH", -50).."[NEWLINE]"
		else
			iVal = iNumPolicies * 20
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_POLICY_NUM_POLICIES", iNumPolicies * 20).."[NEWLINE]"
		end

		--If there are other Civs which have more policies from this tree, there is a -10 Penalty from each one.
		--This only applies to Likes and Loves.
		if iType == LOVE_TYPE or iType == LIKE_TYPE then
			local pTeam = Teams[pPlayer:GetTeam()]
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pLoop = Players[i]
				if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
					local iTheirNumPolicies = 0
					for k, v in pairs(tPolicies) do
						if pLoop:HasPolicy(k) then
							iTheirNumPolicies = iTheirNumPolicies + 1
						end
					end
					if iTheirNumPolicies > iNumPolicies then
						iVal = iVal - 10
						sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_POLICY_OTHERS", -10, pLoop:GetCivilizationShortDescription()).."[NEWLINE]"
					end
				end
			end
		end

		sString = AddLDTooltipFooter(sString, iType, iVal)
		
		--Adjust to Type

		if iType == LOVE_TYPE then
			iVal = iVal * 2
		elseif iType == DISLIKE_TYPE then
			iVal = -iVal
		elseif iType == HATE_TYPE then
			iVal = -iVal * 2
		end

		return iVal, tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iPolicyLDID].Desc, sPolicyBranchName), sString
	end
)

--[[t_LikesDislikes[iPolicyLDID].GetTextFunc = (
	function(iPlayer, iMGKey, iType, iValue)

		--Cache all policies in this tree
		local tPolicies = {}
		local sPolicyBranch = GameInfo.PolicyBranchTypes[iValue].Type
		local sPolicyBranchName = Locale.ConvertTextKey(GameInfo.PolicyBranchTypes[iValue].Description)
		for policy in GameInfo.Policies() do
			if policy.PolicyBranchType == sPolicyBranch then
				tPolicies[policy.ID] = true
			end
		end

		local pPlayer = Players[iPlayer]
		local iNumPolicies = 0
		for k, v in pairs(tPolicies) do
			if pPlayer:HasPolicy(k) then
				iNumPolicies = iNumPolicies + 1
			end
		end

		--If we have -none- of the policies from that branch, then there is a -50 Penalty.
		if iNumPolicies == 0 then 
			
		else
			
		end

		--If there are other Civs which have more policies from this tree, there is a -10 Penalty from each one.
		--This only applies to Likes and Loves.
		if iType == LOVE_TYPE or iType == LIKE_TYPE then
			local pTeam = Teams[pPlayer:GetTeam()]
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pLoop = Players[i]
				if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
					local iTheirNumPolicies = 0
					for k, v in pairs(tPolicies) do
						if pLoop:HasPolicy(k) then
							iTheirNumPolicies = iTheirNumPolicies + 1
						end
					end
					if iTheirNumPolicies > iNumPolicies then
						
					end
				end
			end
		end

		

		return
	end
)]]

----------------------------------------------------------------------------------------------------------------------------
-- CIVILIZATIONS
----------------------------------------------------------------------------------------------------------------------------
row = GameInfo.MG_LikeDislikes["MGLIKEDISLIKE_CIVILIZATION"]
local iCivLDID = row.ID

t_LikesDislikes[iCivLDID] = {}
t_LikesDislikes[iCivLDID].Value = row.Value
t_LikesDislikes[iCivLDID].TT = row.Tooltip
t_LikesDislikes[iCivLDID].Desc = row.Description
t_LikesDislikes[iCivLDID].IsValidFunc = (
	function(iPlayer, iMGKey)
		--Must have met at least one other major civ.
		local iNumMetCivs = Teams[Players[iPlayer]:GetTeam()]:GetHasMetCivCount(true)
		if iNumMetCivs > 0 then
			return true
		end
		return false
	end
)

t_LikesDislikes[iCivLDID].GetValueFunc = (
	function(iPlayer, iMGKey, tIgnoreValues)
		local tValidCivsThisTest = {}
		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]

		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i ~= iPlayer and (not tIgnoreValues[i] or tIgnoreValues[i] == false) then
				local pLoop = Players[i]
				if pLoop:IsAlive() then
					local iLoopTeam = pLoop:GetTeam()
					if iLoopTeam ~= iTeam and pTeam:IsHasMet(iLoopTeam) then
						local iTableKey = #tValidCivsThisTest + 1
						tValidCivsThisTest[iTableKey] = i
					end
				end
			end
		end
		
		return tValidCivsThisTest[Game.Rand(#tValidCivsThisTest, "PMMM Like Dislike Civilization Type Roll") + 1]
	end
)

t_LikesDislikes[iCivLDID].GetTypeFunc = (
	function(iPlayer, iMGKey, iValue)
		local iType = 0;
		--Type for a Civilization will be weighted by the following:
		--Currently at war? (If so, much more likely to be a dislike or hate)
		--Currently denouncing one or the other? (If so, more likely to be a dislike or hate, even more so if mutual denouncement)
		--Currently have a DOF? (If so, more likely to be a like or love)
		--Cultural influence (higher values the OTHER Civ has over the MG owner's Civ = more likely to be a like or love)
		--Adopted an ideology? (If so, they will like it if it matches their preferred ideology and dislike it if not)
		
		--Later, after personalities are in place, they will also weight whether or not the Civ's personality and strategy matches up with their personality.
		
		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]
		local pEnemyPlayer = Players[iValue]
		local iEnemyTeam = pEnemyPlayer:GetTeam()
		local pEnemyTeam = Teams[iEnemyTeam]
		
		local tWeight = {
			[LIKE_TYPE] = 9,
			[LOVE_TYPE] = 1,
			[DISLIKE_TYPE] = 9,
			[HATE_TYPE] = 1
		}
		
		if pTeam:IsAtWar(iEnemyTeam) and pEnemyPlayer:IsAlive() then
			tWeight[DISLIKE_TYPE] = tWeight[DISLIKE_TYPE] + 15
			tWeight[HATE_TYPE] = tWeight[HATE_TYPE] + 10
		end
		
		if pPlayer:IsDenouncedPlayer(iValue) then
			tWeight[DISLIKE_TYPE] = tWeight[DISLIKE_TYPE] + 8
			tWeight[HATE_TYPE] = tWeight[HATE_TYPE] + 4
		end
		
		if pEnemyPlayer:IsDenouncedPlayer(iPlayer) then
			tWeight[DISLIKE_TYPE] = tWeight[DISLIKE_TYPE] + 8
			tWeight[HATE_TYPE] = tWeight[HATE_TYPE] + 4
		end
		
		if pPlayer:IsDoF(iValue) then
			tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 12
			tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 6
		end
		
		local iInfluenceLevel = pEnemyPlayer:GetInfluenceLevel(iPlayer);
		if (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_EXOTIC) then
			tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 2
			tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 1
		elseif (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_FAMILIAR) then
			tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 5
			tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 2   
		elseif (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_POPULAR) then
			tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 10
			tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 5  
		elseif (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_INFLUENTIAL) then
			tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 15
			tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 10 
		elseif (iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_DOMINANT) then
			tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 20
			tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 15
		end
		
		local iIdeology = pEnemyPlayer:GetLateGamePolicyTree()
		
		if iIdeology and MagicalGirls[iMGKey].PreferredIdeology then
			if iIdeology == MagicalGirls[iMGKey].PreferredIdeology then
				tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 15
				tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 10
			else
				tWeight[DISLIKE_TYPE] = tWeight[DISLIKE_TYPE] + 15
				tWeight[HATE_TYPE] = tWeight[HATE_TYPE] + 10
			end
		end
		
			
		return DeckShuffle(tWeight, "PMMM Like Dislike Civilization Value Roll");
	end
)

t_LikesDislikes[iCivLDID].FulfilledFunc = (
	function(iPlayer, iMGKey, iType, iValue)
		local sString = ""
		--Mood bonuses:
		----DOF them: 50 points
		----Send them a TR: 5 each
		----Any sort of trade: 5 each
		----Open Borders: 5 for each direction (so mutual OB is 10 points) -- this will also count as a trade

		--How to lose fulfillment points for Likes/Loves (invert if Dislikes/Hates):
		----War them: 75 points
		----Denounce them: 50 points
		----Kill their units: 3 points each (permanent!)
		----Tell them to stop settling near you: 20 points
		----Trade demand: 20 points
		----Tell them to stop spying on you: 10 points
		
		local iFulfillment = 0
		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]
		local pEnemyPlayer = Players[iValue]
		local iEnemyTeam = pEnemyPlayer:GetTeam()
		local pEnemyTeam = Teams[iEnemyTeam]
		local bTestAllValues = true

		if iPlayer == iValue then
			bTestAllValues = false
			iFulfillment = t_LikesDislikes[iCivLDID].Value
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_LIVING_THERE", t_LikesDislikes[iCivLDID].Value).."[NEWLINE]"
		end
		
		if not pEnemyPlayer:IsAlive() then
			bTestAllValues = false
			iFulfillment = -t_LikesDislikes[iCivLDID].Value
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_DESTROYED", -t_LikesDislikes[iCivLDID].Value).."[NEWLINE]"
		end
		
		if bTestAllValues == true then --The previous two values will prevent any other values from accruing
			if pPlayer:IsDoF(iValue) then
				iFulfillment = iFulfillment + 50
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_DOF", 50).."[NEWLINE]"
			end
		
			if pPlayer:IsPlayerHasOpenBorders(iValue) then 
				iFulfillment = iFulfillment + 5
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_OB_TO_US", 5).."[NEWLINE]"
			end
			if pEnemyPlayer:IsPlayerHasOpenBorders(iPlayer) then 
				iFulfillment = iFulfillment + 5
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_OB_TO_THEM", 5).."[NEWLINE]"
			end
		
			local tTRs = pPlayer:GetTradeRoutes()
			local iFromTRs = 0
			for k, v in pairs(tTRs) do
				if v.ToID == iValue then iFromTRs = iFromTRs + 5 end
			end

			if iFromTRs > 0 then
				iFulfillment = iFulfillment + iFromTRs
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_TRADE_ROUTES", iFromTRs).."[NEWLINE]"
			end
		
			local deal = UI.GetScratchDeal();
			local iNumCurrentDeals = UI.GetNumCurrentDeals(iPlayer);
			local iFromDeals = 0
			if( iNumCurrentDeals > 0 ) then
				for i = 0, iNumCurrentDeals - 1 do
					UI.LoadCurrentDeal( iPlayerID, i )
					if deal:GetOtherPlayer(iPlayer) == iValue then iFromDeals = iFromDeals + 5 end
				end
			end

			if iFromDeals > 0 then
				iFulfillment = iFulfillment + iFromDeals
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_DEALS", iFromDeals).."[NEWLINE]"
			end
		
			if pTeam:IsAtWar(iEnemyTeam) and pEnemyPlayer:IsAlive() then
				iFulfillment = iFulfillment - 75
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_WAR", -75).."[NEWLINE]"
			end
		
			if pPlayer:IsDenouncedPlayer(iValue) then 
				iFulfillment = iFulfillment - 50
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_DENOUNCE", -50).."[NEWLINE]"
			end

			local iFromDemands = 0
			if pPlayer:IsPlayerNoSettleRequestEverAsked(iValue) then iFromDemands = iFromDemands + 20 end
		
			if pPlayer:IsPlayerStopSpyingRequestEverAsked(iValue) then iFromDemands = iFromDemands + 10 end
		
			if pPlayer:IsDemandEverMade(iValue) then iFromDemands = iFromDemands + 20 end

			if iFromDemands > 0 then
				iFulfillment = iFulfillment - iFromDemands
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_DEMANDS", -iFromDemands).."[NEWLINE]"
			end
		
			if not PMMM.UnitsEverKilled[iPlayer] then PMMM.UnitsEverKilled[iPlayer] = {} end
			if PMMM.UnitsEverKilled[iPlayer][iValue] then 
				iFulfillment = iFulfillment - (3 * PMMM.UnitsEverKilled[iPlayer][iValue])
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CIVILIZATION_UNITS_KILLED", -(3 * PMMM.UnitsEverKilled[iPlayer][iValue])).."[NEWLINE]"
			end
		
			if iType == LOVE_TYPE or iType == HATE_TYPE then
				iFulfillment = iFulfillment * 2
			end

			if iType == DISLIKE_TYPE or iType == HATE_TYPE then
				iFulfillment = -iFulfillment
			end
		end
				
		
		sString = AddLDTooltipFooter(sString, iType, iFulfillment)
		
		return iFulfillment, tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iCivLDID].Desc, Players[iValue]:GetCivilizationShortDescription()), sString
	end
)

--[[t_LikesDislikes[iCivLDID].GetTextFunc = (
	function(iType, iValue)
		local sName = Players[iValue]:GetCivilizationShortDescription()
		local sPositiveKey;
		local sNegativeKey;
		if iType == LIKE_TYPE or iType == LOVE_TYPE then
			sPositiveKey = "[COLOR_POSITIVE_TEXT]"
			sNegativeKey = "[COLOR_WARNING_TEXT]"
		else
			sPositiveKey = "[COLOR_WARNING_TEXT]"
			sNegativeKey = "[COLOR_POSITIVE_TEXT]"
		end
		
		return tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iCivLDID].Desc, sName), Locale.ConvertTextKey(t_LikesDislikes[iCivLDID].TT, sPositiveKey, sNegativeKey)
	end
)]]

function OnUnitKilledInCombatIterateUnitsEverKilled(iKiller, iKilled)
	if not PMMM.UnitsEverKilled[iKiller] then
		PMMM.UnitsEverKilled[iKiller] = {}
	end
	if not PMMM.UnitsEverKilled[iKiller][iKilled] then
		PMMM.UnitsEverKilled[iKiller][iKilled] = 0
	end
	PMMM.UnitsEverKilled[iKiller][iKilled] = PMMM.UnitsEverKilled[iKiller][iKilled] + 1
end



----------------------------------------------------------------------------------------------------------------------------
-- CITY-STATES
----------------------------------------------------------------------------------------------------------------------------
row = GameInfo.MG_LikeDislikes["MGLIKEDISLIKE_CITYSTATE"]
local iCSLDID = row.ID

t_LikesDislikes[iCSLDID] = {}
t_LikesDislikes[iCSLDID].Value = row.Value
t_LikesDislikes[iCSLDID].TT = row.Tooltip
t_LikesDislikes[iCSLDID].Desc = row.Description
t_LikesDislikes[iCSLDID].IsValidFunc = (
	function(iPlayer, iMGKey)
		--Must have met at least one City-State.
		local iNumMetCS = Players[iPlayer]:GetNumMinorCivsMet()
		if iNumMetCS > 0 then
			return true
		end
		return false
	end
)

t_LikesDislikes[iCSLDID].GetValueFunc = (
	function(iPlayer, iMGKey, tIgnoreValues)
		local tValidCSThisTest = {}
		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]

		for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
			if i ~= iPlayer and (not tIgnoreValues[i] or tIgnoreValues[i] == false) then
				local pLoop = Players[i]
				if pLoop:IsEverAlive() then
					local iLoopTeam = pLoop:GetTeam()
					if iLoopTeam ~= iTeam and pTeam:IsHasMet(iLoopTeam) then
						local iTableKey = #tValidCSThisTest + 1
						tValidCSThisTest[iTableKey] = i
					end
				end
			end
		end
		
		return tValidCSThisTest[Game.Rand(#tValidCSThisTest, "PMMM Like Dislike Civilization Type Roll") + 1]
	end
)

t_LikesDislikes[iCSLDID].FulfilledFunc = (
	function(iPlayer, iMGKey, iType, iValue)
		local sString = ""
		--+25 if friends; +50 if allies.
		--+10 for a Pledge to Protect.
		-- -25 if influence is negative.
		--+15 for every Trade Route sent to it.
		-- -100 if the CS is dead.
		-- -50 if the City-State has another Ally.
		
		local iVal = 0
		
		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]
		local pCityState = Players[iValue]
		local iCSTeam = pCityState:GetTeam()
		local pCSTeam = Teams[iCSTeam]
		
		if pCityState:IsAlive() then
			if pCityState:GetAlly() and pCityState:GetAlly() == iPlayer then
				iVal = iVal + 50
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CITYSTATE_ALLY", 50).."[NEWLINE]"
			elseif pCityState:GetMinorCivFriendshipLevelWithMajor(iPlayer) == 1 then
				iVal = iVal + 25
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CITYSTATE_FRIEND", 25).."[NEWLINE]"
			elseif pCityState:GetMinorCivFriendshipWithMajor() < 0 then
				iVal = iVal - 25
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CITYSTATE_BAD_RELATIONS", -25).."[NEWLINE]"
			end
			if pCityState:IsProtectedByMajor(iPlayer) then
				iVal = iVal + 10
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CITYSTATE_PLEDGE", 10).."[NEWLINE]"
			end

			local tTRs = pPlayer:GetTradeRoutes()
			local iFromTRs = 0
			for k, v in pairs(tTRs) do
				if v.ToID == iValue then iFromTRs = iFromTRs + 15 end
			end
			if iFromTRs > 0 then
				iVal = iVal + iFromTRs
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CITYSTATE_TRADE_ROUTES", iFromTRs).."[NEWLINE]"
			end
		else
			iVal = iVal - 100
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_CITYSTATE_DEAD", -100).."[NEWLINE]"
		end
		
		sString = AddLDTooltipFooter(sString, iType, iVal)

		if iType == LOVE_TYPE or iType == HATE_TYPE then
			iVal = iVal * 2
		end

		if iType == DISLIKE_TYPE or iType == HATE_TYPE then
			iVal = -iVal
		end
				

		
		return iVal, tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iCSLDID].Desc, Players[iValue]:GetCivilizationShortDescription()), sString
	end
)

--[[t_LikesDislikes[iCSLDID].GetTextFunc = (
	function(iType, iValue)
		local sName = Players[iValue]:GetCivilizationShortDescription()
		local sPositiveKey;
		local sNegativeKey;
		if iType == LIKE_TYPE or iType == LOVE_TYPE then
			sPositiveKey = "[COLOR_POSITIVE_TEXT]"
			sNegativeKey = "[COLOR_WARNING_TEXT]"
		else
			sPositiveKey = "[COLOR_WARNING_TEXT]"
			sNegativeKey = "[COLOR_POSITIVE_TEXT]"
		end
		
		return tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iCSLDID].Desc, sName), Locale.ConvertTextKey(t_LikesDislikes[iCSLDID].TT, sPositiveKey, sNegativeKey)
	end
)]]

----------------------------------------------------------------------------------------------------------------------------
-- GREAT WORKS
-- Disabled in v25
----------------------------------------------------------------------------------------------------------------------------
--[[row = GameInfo.MG_LikeDislikes["MGLIKEDISLIKE_GREATWORK"]
local iGWLDID = row.ID

t_LikesDislikes[iGWLDID] = {}
t_LikesDislikes[iGWLDID].Value = row.Value
t_LikesDislikes[iGWLDID].TT = row.Tooltip
t_LikesDislikes[iGWLDID].Desc = row.Description
t_LikesDislikes[iGWLDID].IsValidFunc = (
	function(iPlayer, iMGKey)
		--Either must have created a great work, or met another Civ which has created one.
		local pPlayer = Players[iPlayer]
		local pTeam = Teams[pPlayer:GetTeam()]
		if pPlayer:GetNumGreatWorks() > 0 then return true end
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				local iLoopTeam = pLoop:GetTeam()
				if iLoopTeam ~= iTeam and pTeam:IsHasMet(iLoopTeam) then
					if pLoop:GetNumGreatWorks() > 0 then return true end
				end
			end
		end
		return false
	end
)

t_LikesDislikes[iGWLDID].GetValueFunc = (
	function(iPlayer, iMGKey, tIgnoreValues)
		local tValidGWThisTest = {}
		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]
		
		for i = 1, 4, 1 do
			if i ~= 2 then  --no Artifacts!
				for k, v in pairs(pPlayer:GetGreatWorks(i)) do
					if not tIgnoreValues[v.Index] then
						tValidGWThisTest[#tValidGWThisTest + 1] = v.Index
					end
				end
			end
		end
		
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				local iLoopTeam = pLoop:GetTeam()
				if iLoopTeam ~= iTeam and pTeam:IsHasMet(iLoopTeam) then
					for i = 1, 4, 1 do
						if i ~= 2 then  --no Artifacts!
							for k, v in pairs(pLoop:GetGreatWorks(i)) do
								if not tIgnoreValues[v.Index] then
									tValidGWThisTest[#tValidGWThisTest + 1] = v.Index
								end
							end
						end
					end
				end
			end
		end
		
		return tValidGWThisTest[Game.Rand(#tValidGWThisTest, "PMMM Like Dislike Great Work Type Roll") + 1]
	end
)

t_LikesDislikes[iGWLDID].FulfilledFunc = (
	function(iPlayer, iMGKey, iType, iValue)
		
		--For now, Likes/Loves are fulfilled simply if you possess that GW, and the opposite for Dislike/Hate.
		
		local bFulfilled = false
		local bLike = true
		if iType == DISLIKE_TYPE or iType == HATE_TYPE then bLike = false end
		local iVal = 0
		
		if Game.GetGreatWorkController(iValue) == iPlayer then
			bFulfilled = bLike
		else
			bFulfilled = not bLike
		end
		
		
		if bFulfilled then
			if iType == LIKE_TYPE or iType == DISLIKE_TYPE then
				iVal = t_LikesDislikes[iGWLDID].Value
			elseif iType == LOVE_TYPE or iType == HATE_TYPE then
				iVal = t_LikesDislikes[iGWLDID].Value * 2
			end
		else
			if iType == LIKE_TYPE or iType == DISLIKE_TYPE then
				iVal = -t_LikesDislikes[iGWLDID].Value
			elseif iType == LOVE_TYPE or iType == HATE_TYPE then
				iVal = -(t_LikesDislikes[iGWLDID].Value * 2)
			end
		end
		
		
		return iVal
	end
)

t_LikesDislikes[iGWLDID].GetTextFunc = (
	function(iType, iValue)
		local sName = Locale.ConvertTextKey(Game.GetGreatWorkName(iValue))
		local sPositiveKey;
		local sNegativeKey;
		if iType == LIKE_TYPE or iType == LOVE_TYPE then
			sPositiveKey = "[COLOR_POSITIVE_TEXT]"
			sNegativeKey = "[COLOR_WARNING_TEXT]"
		else
			sPositiveKey = "[COLOR_WARNING_TEXT]"
			sNegativeKey = "[COLOR_POSITIVE_TEXT]"
		end
		
		return tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iGWLDID].Desc, sName), Locale.ConvertTextKey(t_LikesDislikes[iGWLDID].TT, sPositiveKey, sNegativeKey)
	end
)]]


----------------------------------------------------------------------------------------------------------------------------
-- RELIGION
----------------------------------------------------------------------------------------------------------------------------
row = GameInfo.MG_LikeDislikes["MGLIKEDISLIKE_RELIGION"]
local iReligionLDID = row.ID

t_LikesDislikes[iReligionLDID] = {}
t_LikesDislikes[iReligionLDID].Value = row.Value
t_LikesDislikes[iReligionLDID].TT = row.Tooltip
t_LikesDislikes[iReligionLDID].Desc = row.Description
t_LikesDislikes[iReligionLDID].IsValidFunc = (
	function(iPlayer, iMGKey)
		--The player Civ or a met Civ must have founded a religion.
		if Game.AnyoneHasAnyReligion() then
			local pTeam = Teams[Players[iPlayer]:GetTeam()]
			for i = 0, GameDefines.MAX_CIV_PLAYERS - 1 do	
				local pPlayer = Players[iPlayer];
				if (pPlayer:IsEverAlive()) then
					if (pPlayer:HasCreatedReligion()) and (pPlayer:GetID() == iPlayer or pTeam:IsHasMet(pPlayer:GetTeam())) then
						return true
					end
				end
			end
		end
		return false
	end
)

t_LikesDislikes[iReligionLDID].GetValueFunc = (
	function(iPlayer, iMGKey, tIgnoreValues)
		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]

		local tWeights = {}
		
		if pPlayer:HasCreatedReligion() then
			local iCreatedReligion = pPlayer:GetReligionCreatedByPlayer()
			if (not tIgnoreValues[iCreatedReligion] or tIgnoreValue[iCreatedReligion] == false) then
				--Leaders always like their own Religions
				if MagicalGirls[iMGKey].IsLeader == true then
					return iCreatedReligion
				else
					tWeights[iCreatedReligion] = 50
				end
			end
		end
		
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				local iLoopTeam = pLoop:GetTeam()
				if iLoopTeam ~= iTeam and pTeam:IsHasMet(iLoopTeam) then
					if pLoop:HasCreatedReligion() then
						local iCreatedReligion = pLoop:GetReligionCreatedByPlayer()
						if Game.GetNumCitiesFollowing(iCreatedReligion) > 0 and not tIgnoreValues[iCreatedReligion] then
							tWeights[iCreatedReligion] = 20
						end
					end
				end
			end
		end
		
		return DeckShuffle(tWeights, "PMMM Like Dislike Religion Type Roll");
	end
)

t_LikesDislikes[iReligionLDID].GetTypeFunc = (
	function(iPlayer, iMGKey, iValue)
		local iType = 0;

		--Type for a Religion will be weighted by the following:
		--Religion we founded? (If so, major increase of likelihood of Like/Love)
		--If not a religion we founded, is it our majority? (If so, moderate increase of likelihood of Like/Love)
		
		
		local pPlayer = Players[iPlayer]
		
		local tWeight = {
			[LIKE_TYPE] = 9,
			[LOVE_TYPE] = 1,
			[DISLIKE_TYPE] = 9,
			[HATE_TYPE] = 1
		}
		
		if pPlayer:GetReligionCreatedByPlayer() == iValue then
			if MagicalGirls[iMGKey].IsLeader == true then
				return LIKE_TYPE
			else
				tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 15
				tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 10
			end
		elseif pPlayer:HasReligionInMostCities(iValue) then
			tWeight[LIKE_TYPE] = tWeight[LIKE_TYPE] + 8
			tWeight[LOVE_TYPE] = tWeight[LOVE_TYPE] + 4
		end
		
		return DeckShuffle(tWeight, "PMMM Like Dislike Religion Value Roll");
	end
)

t_LikesDislikes[iReligionLDID].FulfilledFunc = (
	function(iPlayer, iMGKey, iType, iValue)
		local sString = ""
		---Is this the majority religion in our empire? If so:
		----+50 if it's a religion we founded
		----+30 if it isn't one we founded
		---+10 for every domestic city following it
		---+5 for every foreign city in the world following it
		---+25 if it's the World Religion
		--- -100 If we control its Holy City, yet we didn't found it,and have inquisited the religion out of it
		--- -100 If the religion has been eliminated (0 cities following)
		--- -20 for Denouncing Civs which follow the religion
		--- -50 for being at War with Civs which follow the religion
		--- +10 for DOFing Civs which follow the religion
		
		local iFulfillment = 0

		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]
		
		if pPlayer:HasReligionInMostCities(iValue) then
			if pPlayer:GetReligionCreatedByPlayer() == iValue then
				iFulfillment = iFulfillment + 50
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_RELIGION_MAJORITY", 50).."[NEWLINE]"
			else
				iFulfillment = iFulfillment + 30
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_RELIGION_MAJORITY", 32).."[NEWLINE]"
			end
		end
		


		iFulfillment = iFulfillment + Game.GetNumCitiesFollowing(iValue) * 5
		if Game.GetNumCitiesFollowing(iValue) > 0 then
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_RELIGION_WORLD_CITIES", Game.GetNumCitiesFollowing(iValue) * 5).."[NEWLINE]"
		end
		
		local iFromDomesticCitiesFollowing = 0
		for pCity in pPlayer:Cities() do
			if pCity:GetReligiousMajority() == iValue then
				iFromDomesticCitiesFollowing = iFromDomesticCitiesFollowing + 5
			end
			if pCity:IsHolyCityForReligion(iValue) and pCity:GetOriginalOwner() ~= iPlayer and pCity:GetReligiousMajority() ~= iValue then
				iFulfillment = iFulfillment - 100
				sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_RELIGION_CRUSADED", -100).."[NEWLINE]"
			end
		end

		iFulfillment = iFulfillment + iFromDomesticCitiesFollowing
		if iFromDomesticCitiesFollowing > 0 then
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_RELIGION_YOUR_CITIES", iFromDomesticCitiesFollowing).."[NEWLINE]"
		end
		
		local iFromDOFs = 0
		local iFromDenounce = 0
		local iFromWar = 0
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				if pLoop:IsAlive() and (pLoop:HasReligionInMostCities(iValue) or pLoop:GetReligionCreatedByPlayer() == iValue) then
					if pLoop:IsDoF(iPlayer) then
						iFromDOFs = iFromDOFs + 10
					end
					if pPlayer:IsDenouncedPlayer(i) then
						iFromDenounce = iFromDenounce + 20
					end
					if Teams[pLoop:GetTeam()]:IsAtWar(iTeam) then
						iFromWar = iFromWar + 50
					end
				end
			end
		end
		iFulfillment = iFulfillment + iFromDOFs
		iFulfillment = iFulfillment - iFromDenounce
		iFulfillment = iFulfillment - iFromWar

		if iFromDOFs > 0 then
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_RELIGION_FRIENDSHIP", iFromDOFs).."[NEWLINE]"
		end

		if iFromDenounce > 0 then
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_RELIGION_DENOUNCE", -iFromDenounce).."[NEWLINE]"
		end

		if iFromWar > 0 then
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_RELIGION_WAR", -iFromWar).."[NEWLINE]"
		end

		sString = AddLDTooltipFooter(sString, iType, iFulfillment)
		
		if iType == LOVE_TYPE or iType == HATE_TYPE then
			iFulfillment = iFulfillment * 2
		end
		
		if iType == DISLIKE_TYPE or iType == HATE_TYPE then
			iFulfillment = -iFulfillment
		end
		
		
		
		
		return iFulfillment, tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iReligionLDID].Desc, Locale.ConvertTextKey(GameInfo.Religions[iValue].Description)), sString
	end
)

--[[t_LikesDislikes[iReligionLDID].GetTextFunc = (
	function(iType, iValue)
		local sName = Locale.ConvertTextKey(GameInfo.Religions[iValue].Description)
		local sPositiveKey;
		local sNegativeKey;
		if iType == LIKE_TYPE or iType == LOVE_TYPE then
			sPositiveKey = "[COLOR_POSITIVE_TEXT]"
			sNegativeKey = "[COLOR_WARNING_TEXT]"
		else
			sPositiveKey = "[COLOR_WARNING_TEXT]"
			sNegativeKey = "[COLOR_POSITIVE_TEXT]"
		end
		
		return tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iReligionLDID].Desc, sName), Locale.ConvertTextKey(t_LikesDislikes[iReligionLDID].TT, sPositiveKey, sNegativeKey)
	end
)]]


----------------------------------------------------------------------------------------------------------------------------
-- WONDERS
-- Disabled in v25
----------------------------------------------------------------------------------------------------------------------------
--[[row = GameInfo.MG_LikeDislikes["MGLIKEDISLIKE_WONDER"]
local iWonderLDID = row.ID

local tWonders = {}

for wonder in GameInfo.Buildings() do
	local buildingClass = GameInfo.BuildingClasses[wonder.BuildingClass]
	if buildingClass.MaxGlobalInstances == 1 then
		local iEra = GameInfoTypes.ERA_ANCIENT
		if wonder.PrereqTech then
			local era = GameInfo.Eras[GameInfo.Technologies[wonder.PrereqTech].Era].ID
			if era then iEra = era end
			tWonders[#tWonders + 1] = {
				["ID"] = wonder.ID,
				["Era"] = iEra
			}
		end
	end
end

t_LikesDislikes[iWonderLDID] = {}
t_LikesDislikes[iWonderLDID].Value = row.Value
t_LikesDislikes[iWonderLDID].TT = row.Tooltip
t_LikesDislikes[iWonderLDID].Desc = row.Description
t_LikesDislikes[iWonderLDID].IsValidFunc = (
	function(iPlayer, iMGKey)
		--Always returns true.
		return true
	end
)

t_LikesDislikes[iWonderLDID].GetValueFunc = (
	function(iPlayer, iMGKey, tIgnoreValues)
		local tValidWondersThisTest = {}
		local pPlayer = Players[iPlayer]
		local iEra = pPlayer:GetCurrentEra()
		
		--Only can return Wonders buildable in this era, or previous eras.
		
		for k, v in pairs(tWonders) do
			if v.Era <= iEra and not tIgnoreValues[v.ID]then
				tValidWondersThisTest[#tValidWondersThisTest + 1] = v.ID
			end
		end
		
		return tValidWondersThisTest[Game.Rand(#tValidWondersThisTest, "PMMM Like Dislike Wonder Type Roll") + 1]
	end
)

t_LikesDislikes[iWonderLDID].FulfilledFunc = (
	function(iPlayer, iMGKey, iType, iValue)
		
		--For now, Likes/Loves are fulfilled simply if you possess that wonder, and the opposite for Dislike/Hate.
		--Wonders which haven't yet been built have return no mood value at all.
		
		if not Game.AnyoneHasWonder(iValue) then return 0 end
		
		local bFulfilled = false
		local bLike = true
		if iType == DISLIKE_TYPE or iType == HATE_TYPE then bLike = false end
		local pPlayer = Players[iPlayer]
		local iVal = 0
		
		if pPlayer:HasBuilding(iValue)then
			bFulfilled = bLike
		else
			bFulfilled = not bLike
		end
		
		
		if bFulfilled then
			if iType == LIKE_TYPE or iType == DISLIKE_TYPE then
				iVal = t_LikesDislikes[iWonderLDID].Value
			elseif iType == LOVE_TYPE or iType == HATE_TYPE then
				iVal = t_LikesDislikes[iWonderLDID].Value * 2
			end
		else
			if iType == LIKE_TYPE or iType == DISLIKE_TYPE then
				iVal = -t_LikesDislikes[iWonderLDID].Value
			elseif iType == LOVE_TYPE or iType == HATE_TYPE then
				iVal = -(t_LikesDislikes[iWonderLDID].Value * 2)
			end
		end
		
		
		return iVal
	end
)

t_LikesDislikes[iWonderLDID].GetTextFunc = (
	function(iType, iValue)
		local sName = Locale.ConvertTextKey(GameInfo.Buildings[iValue].Description)
		local sPositiveKey;
		local sNegativeKey;
		if iType == LIKE_TYPE or iType == LOVE_TYPE then
			sPositiveKey = "[COLOR_POSITIVE_TEXT]"
			sNegativeKey = "[COLOR_WARNING_TEXT]"
		else
			sPositiveKey = "[COLOR_WARNING_TEXT]"
			sNegativeKey = "[COLOR_POSITIVE_TEXT]"
		end
		
		return tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iWonderLDID].Desc, sName), Locale.ConvertTextKey(t_LikesDislikes[iWonderLDID].TT, sPositiveKey, sNegativeKey)
	end
)]]


----------------------------------------------------------------------------------------------------------------------------
-- LUXURIES
----------------------------------------------------------------------------------------------------------------------------
row = GameInfo.MG_LikeDislikes["MGLIKEDISLIKE_LUXURY"]
local iLuxuryLDID = row.ID


t_LikesDislikes[iLuxuryLDID] = {}
t_LikesDislikes[iLuxuryLDID].Value = row.Value
t_LikesDislikes[iLuxuryLDID].TT = row.Tooltip
t_LikesDislikes[iLuxuryLDID].Desc = row.Description
t_LikesDislikes[iLuxuryLDID].IsValidFunc = (
	function(iPlayer, iMGKey)
		--Always returns true.
		return true
	end
)

t_LikesDislikes[iLuxuryLDID].GetValueFunc = (
	function(iPlayer, iMGKey, tIgnoreValues)
		local tValidLuxuriesThisTest = {}
		local pPlayer = Players[iPlayer]
		
		--Only can return Luxuries which are present on the map, AND/OR are possessed by any Civ in the world.
		--This is so that any resources granted only via buildings can be added.
		--Ideally, this will never return a resource unobtainable in the current map.
		
		for resource in GameInfo.Resources() do
			if (not tIgnoreValues[resource.ID] or tIgnoreValues[resource.ID] == false) then
				if resource.ResourceClassType == "RESOURCECLASS_LUXURY" then
					if Map.GetNumResources(resource.ID) > 0 then
						--Leaders will always pick up Likes for something they have
						if MagicalGirls[iMGKey].IsLeader == true and pPlayer:GetNumResourceTotal(resource.ID, false) > 0 then
							return resource.ID
						else
							tValidLuxuriesThisTest[#tValidLuxuriesThisTest + 1] = resource.ID
						end
					else --For Luxuries that don't appear on the map, like Pleiades Teddy Bears
						for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
							local pLoop = Players[i]
							if pLoop:GetHappinessFromLuxury(resource.ID) > 0 then
								--Leaders will always pick up Likes for something they have
								if MagicalGirls[iMGKey].IsLeader == true and pLoop == pPlayer and pPlayer:GetNumResourceTotal(resource.ID, false) > 0 then
									return resource.ID
								else
									tValidLuxuriesThisTest[#tValidLuxuriesThisTest + 1] = resource.ID
									break
								end
							end
						end
					end
				end
			end
		end
		
		return tValidLuxuriesThisTest[Game.Rand(#tValidLuxuriesThisTest, "PMMM Like Dislike Luxury Type Roll") + 1]
	end
)

t_LikesDislikes[iLuxuryLDID].GetTypeFunc = (
	function(iPlayer, iMGKey, iValue)
		local pPlayer = Players[iPlayer]
		
		if MagicalGirls[iMGKey].IsLeader and pPlayer:GetNumResourceTotal(iValue, false) > 0 then
			return LIKE_TYPE
		end
		
		local tWeight = {
			[LIKE_TYPE] = 70,
			[LOVE_TYPE] = 7,
			[DISLIKE_TYPE] = 20,
			[HATE_TYPE] = 3
		}
		return DeckShuffle(tWeight, "PMMM Luxury L/D Type Roll")
	end
)

t_LikesDislikes[iLuxuryLDID].FulfilledFunc = (
	function(iPlayer, iMGKey, iType, iValue)
		local sString = ""
		-- +50 if this resource is in the trade network at all.
		-- -100 if it isn't and yet someone else we know has it.
		-- +20 for surplus copies.
		-- +10 for every copy that we have direct control of (even if it is being traded away)
		
		local iFulfillment = 0
		local pPlayer = Players[iPlayer]
		local pTeam = Teams[pPlayer:GetTeam()]
		
		if pPlayer:GetHappinessFromLuxury(iValue) > 0 then
			iFulfillment = iFulfillment + 50
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_LUXURY_BASE", 50).."[NEWLINE]"
		else
			local bAnyoneHasIt = false
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				if i ~= iPlayer then
					local pLoop = Players[i]
					if pTeam:IsHasMet(pLoop:GetTeam()) and pLoop:GetHappinessFromLuxury(iValue) > 0 then
						iFulfillment = iFulfillment - 100
						sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_LUXURY_LACKING", -100).."[NEWLINE]"
						break
					end
				end
			end
		end

		local iSurplus = pPlayer:GetNumResourceAvailable(iValue, true)
		if iSurplus > 1 then
			iSurplus = (iSurplus - 1) * 20
			iFulfillment = iFulfillment + iSurplus
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_LUXURY_SURPLUS", 20).."[NEWLINE]"
		end
		
		local iDirectControl = pPlayer:GetNumResourceTotal(iValue, false)
		if iSurplus > 1 then
			iDirectControl = iDirectControl * 10
			iFulfillment = iFulfillment + iDirectControl
			sString = sString.."[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_LUXURY_DIRECT", iDirectControl).."[NEWLINE]"
		end
		
		sString = AddLDTooltipFooter(sString, iType, iFulfillment)

		if iType == LOVE_TYPE or iType == HATE_TYPE then
			iFulfillment = iFulfillment * 2
		end
		
		if iType == DISLIKE_TYPE or iType == HATE_TYPE then
			iFulfillment = -iFulfillment
		end
				
		
		
		return iFulfillment, tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iLuxuryLDID].Desc, Locale.ConvertTextKey(GameInfo.Resources[iValue].Description)), sString
	
	end
)

--[[t_LikesDislikes[iLuxuryLDID].GetTextFunc = (
	function(iType, iValue)
		local sName = Locale.ConvertTextKey(GameInfo.Resources[iValue].Description)
		local sPositiveKey;
		local sNegativeKey;
		if iType == LIKE_TYPE or iType == LOVE_TYPE then
			sPositiveKey = "[COLOR_POSITIVE_TEXT]"
			sNegativeKey = "[COLOR_WARNING_TEXT]"
		else
			sPositiveKey = "[COLOR_WARNING_TEXT]"
			sNegativeKey = "[COLOR_POSITIVE_TEXT]"
		end
		
		return tDescHeaders[iType].." "..Locale.ConvertTextKey(t_LikesDislikes[iLuxuryLDID].Desc, sName), Locale.ConvertTextKey(t_LikesDislikes[iLuxuryLDID].TT, sPositiveKey, sNegativeKey)
	end
)]]


----------------------------------------------------------------------------------------------------------------------------
-- IDEOLOGY
-- ***************THIS DOESN'T WORK LIKE THE OTHERS! ********************************
-- It ignores the like/dislike limit, and is given to all MGs.
-- Also, it is always a "Ideological Belief" rather than a Like/Dislike/Love/Hate -- so only one Type.
----------------------------------------------------------------------------------------------------------------------------
row = GameInfo.MG_LikeDislikes["MGLIKEDISLIKE_IDEOLOGY"]
tIdeologyLDTable = {}
tIdeologyLDTable.Value = row.Value
tIdeologyLDTable.TT = row.Tooltip
tIdeologyLDTable.Desc = row.Description

tIdeologyLDTable.GetValueFunc = (
	function(iPlayer, iMGKey)
		MagicalGirls[iMGKey].IdeologicalBelief = {
			[GameInfoTypes.POLICY_BRANCH_FREEDOM] = 100 + Game.Rand(50, "PMMM MG Preferred Ideology Randomization"),
			[GameInfoTypes.POLICY_BRANCH_ORDER] = 100 + Game.Rand(50, "PMMM MG Preferred Ideology Randomization"),
			[GameInfoTypes.POLICY_BRANCH_AUTOCRACY] = 100 + Game.Rand(50, "PMMM MG Preferred Ideology Randomization")
		}
		
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() then
			local iPlayerIdeology = pPlayer:GetLateGamePolicyTree()
		

			--Leaders always have a strong preference for the player's chosen ideology if they have one
			if MagicalGirls[iMGKey].IsLeader then
				if iPlayerIdeology and iPlayerIdeology > -1 then
					MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] = MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] + 250
				else
					--If the player has NOT adopted an Ideology, they will not pick up a belief until the player adopts one.
					MagicalGirls[iMGKey].IdeologicalBelief = nil
				end
				return 
			end
		
			--Significantly more likely to choose the player's ideology (if they have one), unless public opinion is stacked against it

			if iPlayerIdeology and iPlayerIdeology > -1 then
				local iOpinion = pPlayer:GetPublicOpinionType();
				if (iOpinion == PublicOpinionTypes.PUBLIC_OPINION_CONTENT) then
					MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] = MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] + 100
				elseif (iOpinion == PublicOpinionTypes.PUBLIC_OPINION_DISSIDENTS) then
					MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] = MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] + 50
				elseif (iOpinion == PublicOpinionTypes.PUBLIC_OPINION_CIVIL_RESISTANCE) then
					--no change
				elseif (iOpinion == PublicOpinionTypes.PUBLIC_OPINION_REVOLUTIONARY_WAVE) then
					MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] = math.max(MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] - 50, 0)
				end
			end
		
			--Influenced by Civs they like or dislike
			for k, v in pairs(MagicalGirls[iMGKey].LikesDislikes) do
				if v.Category == iCivLDID then
					local iTheirIdeology = Players[v.Value]:GetLateGamePolicyTree()
					if iTheirIdeology and iTheirIdeology > -1 then
						if v.Type == LIKE_TYPE then
							MagicalGirls[iMGKey].IdeologicalBelief[iTheirIdeology] = MagicalGirls[iMGKey].IdeologicalBelief[iTheirIdeology] + 30
						elseif v.Type == LOVE_TYPE then
							MagicalGirls[iMGKey].IdeologicalBelief[iTheirIdeology] = MagicalGirls[iMGKey].IdeologicalBelief[iTheirIdeology] + 80
						elseif v.Type == DISLIKE_TYPE then
							MagicalGirls[iMGKey].IdeologicalBelief[iTheirIdeology] = math.max(MagicalGirls[iMGKey].IdeologicalBelief[iTheirIdeology] - 30, 0)
						elseif v.Type == HATE_TYPE then
							MagicalGirls[iMGKey].IdeologicalBelief[iTheirIdeology] = math.max(MagicalGirls[iMGKey].IdeologicalBelief[iTheirIdeology] - 80, 0)
						end
					end
				end
			end
		end
	end
)

LuaEvents.PMMMGetMGIdeologicalBelief.Add(tIdeologyLDTable.GetValueFunc)

tIdeologyLDTable.FulfilledFunc = (
	function(iPlayer, iMGKey, iValue)
		--Return the twice the value of the player's chosen Ideology in the MG's Ideology table, minus the values of both other Ideologies.
		--
		local iVal = 0
		local sString = ""
		local pPlayer = Players[iPlayer]
		if not pPlayer:IsMinorCiv() then
			local pPlayer = Players[iPlayer]
			local iIdeology = pPlayer:GetLateGamePolicyTree()
			if iIdeology > -1 then
				local iOurIdeologyAmount = 0
				local iHighestIdeologyAmount = 0
				for k, v in pairs(MagicalGirls[iMGKey].IdeologicalBelief) do
					if k ~= iIdeology then
						if v > iHighestIdeologyAmount then
							iHighestIdeologyAmount = v
						end
						sString = sString..Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_IDEOLOGY_OTHERS", v, GameInfo.PolicyBranchTypes[k].Description).."[NEWLINE]"
					else
						iOurIdeologyAmount = v
						sString = sString..Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_IDEOLOGY_YOURS", v, GameInfo.PolicyBranchTypes[iIdeology].Description).."[NEWLINE]"
					end
				end
				
				sString = sString.."[NEWLINE]"
		
				if iOurIdeologyAmount >= iHighestIdeologyAmount then
					iVal = tIdeologyLDTable.Value
					sString = sString..Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_IDEOLOGY_FAVORITE_ADOPTED", tIdeologyLDTable.Value, GameInfo.PolicyBranchTypes[iIdeology].Description).."[NEWLINE]"
				else
					iVal = (iOurIdeologyAmount - iHighestIdeologyAmount) * 5
					sString = sString..Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_IDEOLOGY_DIFFERENCE", iVal).."[NEWLINE]"
				end
			else
				sString = sString..Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_IDEOLOGY_NOT_YET_ADOPTED")
				return 0, sString
			end
		end
		
	
		sString = sString.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_TT_LD_TOTAL", iVal).."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_MGLIKEDISLIKE_IDEOLOGY_CHANGES_HELP")
		
		
		return iVal, sString
	end
)

-- tIdeologyLDTable.GetTextFunc = (
	-- function(iType, iValue)
		-- local sName = Locale.ConvertTextKey(GameInfo.PolicyBranchTypes[iValue].Description)
		
		-- return Locale.ConvertTextKey(tIdeologyLDTable.Desc, sName), Locale.ConvertTextKey(tIdeologyLDTable.TT)
	-- end
-- )

----------------------------------------------------------------------------------------------------------------------------
-- ADD L/Ds FROM OTHER MODS
-- Uses include statements for the ExternalScript value of the MG_LikeDislikes in the database.
----------------------------------------------------------------------------------------------------------------------------

row = nil
for row in GameInfo.MG_LikeDislikes() do
	if not t_LikesDislikes[row.ID] then
		if row.ExternalScript then
			include(row.ExternalScript)
		end
	end
end