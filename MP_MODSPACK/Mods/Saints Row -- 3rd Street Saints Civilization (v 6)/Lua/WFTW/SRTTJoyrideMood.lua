-- SRTTJoyrideMood
-- Author: Vice
-- DateCreated: 1/16/2015 3:10:35 PM
--------------------------------------------------------------

local row = GameInfo.MG_MoodModifiers["MGMOODMOD_SRTT_JOYRIDE"]
local iJoyrideID = row.ID
t_MoodMods[iJoyrideID] = {}
t_MoodMods[iJoyrideID].Value = row.Value
t_MoodMods[iJoyrideID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal;
		if MagicalGirls[iMGKey].Joyrides then
			iVal = math.min(#MagicalGirls[iMGKey].Joyrides * t_MoodMods[iJoyrideID].Value, t_MoodMods[iJoyrideID].Max)
		else
			iVal = 0
		end

		return iVal
	end
)
t_MoodMods[iJoyrideID].Accumulator = (
	function(iMGKey, pPlayer, pUnit)
		if MagicalGirls[iMGKey].Joyrides then
			for i = #MagicalGirls[iMGKey].Joyrides, 1, -1 do
				if MagicalGirls[iMGKey].Joyrides[i] + t_MoodMods[iJoyrideID].Decay <= Game:GetGameTurn() then
					table.remove(MagicalGirls[iMGKey].Joyrides, i)
				end
			end
		end
	end
)
t_MoodMods[iJoyrideID].Desc = row.Description
t_MoodMods[iJoyrideID].PosTT = row.PositiveTooltip
t_MoodMods[iJoyrideID].Max = row.MaxValue


local iJoyrideMission = GameInfoTypes.MISSION_SRTT_JOYRIDE
local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL

function AddToJoyrideCount(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass and iMission == iJoyrideMission then
		local iMGKey = GetMagicalGirlKey(pUnit:GetOwner(), pUnit:GetID())
		if iMGKey then
			if not MagicalGirls[iMGKey].Joyrides then
				MagicalGirls[iMGKey].Joyrides = {}
				MagicalGirls[iMGKey].Joyrides[#MagicalGirls[iMGKey].Joyrides + 1] = Game:GetGameTurn()
			end
		end
	end
	return 0
end

GameEvents.CustomMissionStart.Add(AddToJoyrideCount)