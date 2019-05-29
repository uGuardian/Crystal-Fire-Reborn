-- Lua Script1
-- Author: lihe
-- DateCreated: 9/6/2012 9:15:12 PM
--------------------------------------------------------------
function NewUnitGiveCultureGold(playerID, unitID, hexVec, unitType, cultureType, civID, primaryColor, secondaryColor, unitFlagIndex, fogState, selected, military, notInvisible)
	
	local player = Players[playerID];
	if not IsMajorCiv(player) then return 
	end
	
	local unit = player:GetUnitByID(unitID);
		if unit == nil then
		return
		end
	local plot = unit:GetPlot();
	local leaderID = GameInfo.Leaders[player:GetLeaderType()].ID;

	-- Determine if the player is Li Jue; if the unit is a military unit; if the units is produced in a city (not given)
	if leaderID == GameInfo.Leaders["LEADER_LUBU"].ID and unit:IsCombatUnit() and plot:IsCity() then
		
		local bonusCulture = math.floor(0.50 * unit:GetBaseCombatStrength());
		local bonusGold = (2 * unit:GetBaseCombatStrength());

		player:ChangeJONSCulture(bonusCulture);
		player:ChangeGold(bonusGold);

		-- Send a notification to the player
		if playerID == Game:GetActivePlayer() then
			local text = Locale.ConvertTextKey("TXT_KEY_CULTURE_AND_GOLD_FROM_NEW_UNIT", tostring(bonusCulture), tostring(bonusGold), unit:GetName());
			player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, text, text);
		end
	end
end
Events.SerialEventUnitCreated.Add( NewUnitGiveCultureGold );

function IsValidPlayer(player)
	return player ~= nil and player:IsAlive() and not player:IsBarbarian();
end


function IsMajorCiv(player)
	return IsValidPlayer(player) and player:GetID() <= GameDefines.MAX_MAJOR_CIVS-1;
end
