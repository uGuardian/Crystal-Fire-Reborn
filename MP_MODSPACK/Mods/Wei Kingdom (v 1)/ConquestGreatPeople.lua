-- Lua Script1
-- Author: lihe
-- DateCreated: 9/11/2012 11:21:23 AM
--------------------------------------------------------------
function ConquestGreatPeople(playerID, bCapital, iX, iY, newPlayerID)
	-- check if winner is valid
	local winner = Players[newPlayerID];
	if not IsMajorCiv(winner) then return end

	local winnerID = GameInfo.Leaders[winner:GetLeaderType()].ID;

	-- check if the city is existed
	local pPlot = Map.GetPlot(iX, iY);
	if not pPlot:IsCity() then return end

	local pCity = pPlot:GetPlotCity();

	-- check if the winner is cao cao and if the city is not his original city
	if winnerID == GameInfo.Leaders["LEADER_CAOCAO"].ID and pCity:GetOriginalOwner() ~= newPlayerID then
		
		-- chance of giving Great Person is increased by the number of population left in the conquered city
		local iPopulation = pCity:GetPopulation();
		local iChance = Game.Rand(10, "Threshold of GP");
		
		if iPopulation > iChance then

			-- give the great person by random
			local iValue = Game.Rand(6, "Type of Great Person");
			if iValue == 0 then 
			iUnitID = GameInfoTypes["UNIT_ARTIST"];
			unit = winner:InitUnit (iUnitID, iX, iY, UNITAI_ARTIST, DirectionTypes.DIRECTION_WEST);
			unit:JumpToNearestValidPlot();

				-- send message
				if newPlayerID == Game:GetActivePlayer() then
					local text = Locale.ConvertTextKey("TXT_KEY_GREAT_PERSON_FROM_CONQUER", pCity:GetName());
					winner:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, text, text);
				end

			elseif iValue == 1 then 
			iUnitID = GameInfoTypes["UNIT_SCIENTIST"];
			unit = winner:InitUnit (iUnitID, iX, iY, UNITAI_SCIENTIST, DirectionTypes.DIRECTION_WEST);
			unit:JumpToNearestValidPlot();

				-- send message
				if newPlayerID == Game:GetActivePlayer() then
					local text = Locale.ConvertTextKey("TXT_KEY_GREAT_PERSON_FROM_CONQUER", pCity:GetName());
					winner:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, text, text);
				end

			elseif iValue == 2 then 
			iUnitID = GameInfoTypes["UNIT_MERCHANT"];
			unit = winner:InitUnit (iUnitID, iX, iY, UNITAI_MERCHANT, DirectionTypes.DIRECTION_WEST);
			unit:JumpToNearestValidPlot();

				-- send message
				if newPlayerID == Game:GetActivePlayer() then
					local text = Locale.ConvertTextKey("TXT_KEY_GREAT_PERSON_FROM_CONQUER", pCity:GetName());
					winner:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, text, text);
				end	

			elseif iValue == 3 then 
			iUnitID = GameInfoTypes["UNIT_WRITER"];
			unit = winner:InitUnit (iUnitID, iX, iY, UNITAI_WRITER, DirectionTypes.DIRECTION_WEST);
			unit:JumpToNearestValidPlot();

				-- send message
				if newPlayerID == Game:GetActivePlayer() then
					local text = Locale.ConvertTextKey("TXT_KEY_GREAT_PERSON_FROM_CONQUER", pCity:GetName());
					winner:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, text, text);
				end

			elseif iValue == 4 then 
			iUnitID = GameInfoTypes["UNIT_MUSICIAN"];
			unit = winner:InitUnit (iUnitID, iX, iY, UNITAI_MUSICIAN, DirectionTypes.DIRECTION_WEST);
			unit:JumpToNearestValidPlot();

				-- send message
				if newPlayerID == Game:GetActivePlayer() then
					local text = Locale.ConvertTextKey("TXT_KEY_GREAT_PERSON_FROM_CONQUER", pCity:GetName());
					winner:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, text, text);
				end

			else
			iUnitID = GameInfoTypes["UNIT_ENGINEER"];
			unit = winner:InitUnit (iUnitID, iX, iY, UNITAI_ENGINEER, DirectionTypes.DIRECTION_WEST);
			unit:JumpToNearestValidPlot();

				-- send message
				if newPlayerID == Game:GetActivePlayer() then
					local text = Locale.ConvertTextKey("TXT_KEY_GREAT_PERSON_FROM_CONQUER", pCity:GetName());
					winner:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, text, text);
				end
			end
		end
	end
end
GameEvents.CityCaptureComplete.Add( ConquestGreatPeople );





function IsValidPlayer(player)
	return player ~= nil and player:IsAlive() and not player:IsBarbarian();
end

function IsMajorCiv(player)
	return IsValidPlayer(player) and player:GetID() <= GameDefines.MAX_MAJOR_CIVS-1;
end