-- CombatGoldenAges
-- Author: Moriboe
--------------------------------------------------------------

print("Loaded combat golden ages")

function CombatGoldenAges(iPlayer, iKilledPlayer)
	
	-- applicable?
	local winner = Players[iPlayer];
	if not IsMajorCiv(winner) then return end
	local leader = GameInfo.Leaders[winner:GetLeaderType()];
	local leaderTrait = GameInfo.Leader_Traits("LeaderType ='" .. leader.Type .. "'")();
	local trait = GameInfo.Traits[leaderTrait.TraitType];
	if not trait.CombatGoldenAges then return end

	-- not for barbarians
	local loser = Players[iKilledPlayer];
	if IsValidPlayer(loser) and not winner:IsGoldenAge() then
		local gaPoints = 50;
		local loserEra = GameInfo.Eras[loser:GetCurrentEra()].ID;
		local winnerEra = GameInfo.Eras[winner:GetCurrentEra()].ID;
		if loserEra > 4 then
			gaPoints = gaPoints + 15;
		elseif loserEra > 2 then
			gaPoints = gaPoints + 10;
		end
		local eraDiff = loserEra - winnerEra;
		if eraDiff > 1 then
			gaPoints = gaPoints * eraDiff;
		end
		winner:ChangeGoldenAgeProgressMeter(gaPoints);
		if iPlayer == Game:GetActivePlayer() then
			UpdateGoldenAgeData(winner);
		end
	end
end
GameEvents.UnitKilledInCombat.Add(CombatGoldenAges);


-- copied from TopPanel.lua
function UpdateGoldenAgeData(pPlayer)
	local strGoldenAgeStr;
	
	if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_HAPPINESS)) then
		strGoldenAgeStr = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_GOLDEN_AGES_OFF");
	else
		if (pPlayer:GetGoldenAgeTurns() > 0) then
			strGoldenAgeStr = string.format(Locale.ToUpper(Locale.ConvertTextKey("TXT_KEY_GOLDEN_AGE_ANNOUNCE")) .. " (%i)", pPlayer:GetGoldenAgeTurns());
		else
			strGoldenAgeStr = string.format("%i/%i", pPlayer:GetGoldenAgeProgressMeter(), pPlayer:GetGoldenAgeProgressThreshold());
		end
	
		strGoldenAgeStr = "[ICON_GOLDEN_AGE][COLOR:255:255:255:255]" .. strGoldenAgeStr .. "[/COLOR]";
	end

	Controls.GoldenAgeString:SetText(strGoldenAgeStr);
end

function IsValidPlayer(player)
	return player ~= nil and player:IsAlive() and not player:IsBarbarian();
end

function IsMinorCiv(player)
	return IsValidPlayer(player) and player:IsMinorCiv();
end

function IsMajorCiv(player)
	return IsValidPlayer(player) and player:GetID() <= GameDefines.MAX_MAJOR_CIVS-1;
end