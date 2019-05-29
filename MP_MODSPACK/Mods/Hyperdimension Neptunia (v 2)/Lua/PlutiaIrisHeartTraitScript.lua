-- Plutia/Iris Heart Trait Scripts
-- Author: Vice
--------------------------------------------------------------

print("Plutia's trait...zzz...")

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- INIT
---------------------------------------------------------------------------------------------------------------------------------------------------------
--Constants

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local HDD_SHARE_THRESHOLD = GameDefines.VV_HDN_HDD_SHARE_THRESHOLD

--Plutia has a very large amount of information which needs storing.
HDNMod.PlutiaTurnsToNap = 					HDNMod.PlutiaTurnsToNap 			or {}
HDNMod.PlutiaNapTurns = 					HDNMod.PlutiaNapTurns 				or {}
HDNMod.PlutiaDaycare =						HDNMod.PlutiaDaycare				or {}
HDNMod.PlutiaActiveProductionDoll = 		HDNMod.PlutiaActiveProductionDoll 	or {}
HDNMod.PlutiaReserveDolls = 				HDNMod.PlutiaReserveDolls 			or {}
HDNMod.PlutiaCuddleDoll =					HDNMod.PlutiaCuddleDoll				or {}
HDNMod.PlutiaStressDoll =					HDNMod.PlutiaStressDoll				or {}
HDNMod.PlutiaWeaponDoll =					HDNMod.PlutiaWeaponDoll				or {}
HDNMod.PlutiaPlaytimeDoll =					HDNMod.PlutiaPlaytimeDoll			or {}
HDNMod.PlutiaCuddleDollEffectTracker =		HDNMod.PlutiaCuddleDollEffectTracker or {}
HDNMod.PlutiaStressDollDuration =			HDNMod.PlutiaStressDollDuration 	or {}
HDNMod.PlutiaExistingUnitPromotions =		HDNMod.PlutiaExistingUnitPromotions or {}
HDNMod.PlutiaSewingKits =					HDNMod.PlutiaSewingKits				or {}
HDNMod.PersistentPolicies =					HDNMod.PersistentPolicies			or {}
HDNMod.IrisKills =							HDNMod.IrisKills					or {}
HDNMod.IrisHappy =							HDNMod.IrisHappy					or {}


--UA Constants
local PERSISTENT_POLICY_TURNS	= 3 											--this many turns in HDD = 1 turn the persistent policy lasts in human form
local DOLL_DURABILITY_CUDDLE 	= math.floor(3 * PRODUCTION_SPEED_MOD)			--Goes down by 1 after every Nap
local DOLL_DURABILITY_STRESS 	= math.floor(1 * PRODUCTION_SPEED_MOD)			--Goes down by 1 after every new Denouncement against Plutia
local DOLL_DURABILITY_WEAPON 	= math.floor(3 * PRODUCTION_SPEED_MOD)			--Goes down by 1 after every Animated Doll killed in combat
local DOLL_DURABILITY_PLAYTIME 	= math.floor(10 * PRODUCTION_SPEED_MOD)			--Goes down by 1 after every Citizen born in a City with a Daycare
local DOLL_PROD_TIME_BASE 		= math.floor(20 * PRODUCTION_SPEED_MOD)
local HAPPY_DUMMY 				= GameInfoTypes.BUILDING_VV_IRIS_HAPPINESS


local ANIMATED_DOLL = GameInfoTypes.UNIT_VV_ANIMATED_DOLL

--UB Constants
local DAYCARE 			= GameInfoTypes.BUILDING_VV_DAYCARE
local DAYCARE_DUMMY 	= GameInfoTypes.BUILDING_VV_DAYCARE_FOOD_DUMMY
local DAYCARE_SCALES = {}    --each Key in this table represents a Percentage value of Food required to reach the next Citizen. The function looks up how much Food to provide based on that.
for i = 0, 10 do
	DAYCARE_SCALES[i] = 7
end
for i = 11, 20 do
	DAYCARE_SCALES[i] = 6
end
for i = 21, 30 do
	DAYCARE_SCALES[i] = 5
end
for i = 31, 40 do
	DAYCARE_SCALES[i] = 4
end
for i = 41, 50 do
	DAYCARE_SCALES[i] = 3
end
for i = 51, 70 do
	DAYCARE_SCALES[i] = 2
end
for i = 71, 100 do
	DAYCARE_SCALES[i] = 1
end

if not MapModData.gPlutiaSewingKits then MapModData.gPlutiaSewingKits = {
		{
				["Name"] 			= 	"TXT_KEY_VV_PLUTIA_SEWING_KIT_1",
				["TurnsReduction"]	=	0,
				["Cost"]			=	0,
		},
		{
				["Name"] 			= 	"TXT_KEY_VV_PLUTIA_SEWING_KIT_2",
				["TurnsReduction"]	=	math.floor(5 * PRODUCTION_SPEED_MOD),
				["Cost"]			=	math.floor(500 * PRODUCTION_SPEED_MOD),
		},
		{
				["Name"] 			= 	"TXT_KEY_VV_PLUTIA_SEWING_KIT_3",
				["TurnsReduction"]	=	math.floor(10 * PRODUCTION_SPEED_MOD),
				["Cost"]			=	math.floor(2000 * PRODUCTION_SPEED_MOD),
		},
		{
				["Name"] 			= 	"TXT_KEY_VV_PLUTIA_SEWING_KIT_4",
				["TurnsReduction"]	=	math.floor(15 * PRODUCTION_SPEED_MOD),
				["Cost"]			=	math.floor(6000 * PRODUCTION_SPEED_MOD),
		}
	} end
local tSewingKits = MapModData.gPlutiaSewingKits
	

local iPlutia = GameInfoTypes.LEADER_VV_PLUTIA or -1
local iIrisHeart = GameInfoTypes.LEADER_VV_IRIS_HEART or -1
local iPlutiaCiv = GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PL or -1
local iIrisHeartCiv = GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_IH or -1


local tPlutias = {}
for i = 0, iMaxCivs - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local iLeaderType = pPlayer:GetLeaderType()
		if (iLeaderType == iPlutia or iLeaderType == iIrisHeart) then
			tPlutias[i] = true
		end
	end
end 


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIFYING FUNCTIONS
-- Find out if a civ has one of the following properties:
-- Traits table: PlutiaDollSystem is true or 1
-- Traits table: PlutiaTurnsUntilNap is not 0
-- Civilization_UnitClassOverrides table: UNIT_VV_ANIMATED_DOLL present in that table for given Civ
-- Civilization_BuildingClassOverrides table: BUILDING_VV_DAYCARE present in that table for given Civ

-- We're no longer caching things specifically to leaders, in the hopes of maybe making this compatible with Randomized Uniques.
---------------------------------------------------------------------------------------------------------------------------------------------------------
local tPlutiaTraitLeaders = {}
function CacheLeaderTraits(iPlayer)
	if iPlayer then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsEverAlive() then
			local leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
			local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
			tPlutiaTraitLeaders[iPlayer] = traitType
		end
	else
		for i = 0, iMaxCivs - 1, 1 do
			local pPlayer = Players[i]
			if pPlayer:IsEverAlive() then
				local leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
				local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
				tPlutiaTraitLeaders[i] = traitType
			end
		end
	end
end
CacheLeaderTraits();

tPlutiaTraitValues = {}
function CacheTraitValues()
	for trait in GameInfo.Traits() do
		tPlutiaTraitValues[trait.Type] = {}
		if trait.PlutiaDollSystem == 1 or trait.PlutiaDollSystem == true then
			tPlutiaTraitValues[trait.Type].DollMake = true
			tPlutiaTraitValues[trait.Type].DollUse = true
		elseif trait.PlutiaDollSystemUseOnly == 1 or trait.PlutiaDollSystemUseOnly == true then
			tPlutiaTraitValues[trait.Type].DollUse = true
			tPlutiaTraitValues[trait.Type].DollMake = false
		else
			tPlutiaTraitValues[trait.Type].DollMake = false
			tPlutiaTraitValues[trait.Type].DollUse = false
		end
		tPlutiaTraitValues[trait.Type].NapLength = trait.PlutiaNapTurns
		tPlutiaTraitValues[trait.Type].NapDelay = trait.PlutiaTurnsUntilNap
		tPlutiaTraitValues[trait.Type].BullyShares = trait.CityStateBullyInfluenceShares
		tPlutiaTraitValues[trait.Type].HappyKills = trait.KillsPerHappinessPersistsOnRevert
	end
end	
CacheTraitValues();

local tDaycareUBCivs = {}
function CacheDaycareUB()
	for iPlayer = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[iPlayer]
		if pPlayer:IsEverAlive() then
			local sCivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if sCivilizationType then
				for row in GameInfo.Civilization_BuildingClassOverrides("CivilizationType = '"..sCivilizationType.."'") do
					if string.find(row.BuildingType, "BUILDING_VV_DAYCARE") then
						tDaycareUBCivs[iPlayer] = true
					end
				end
			end
		end
	end
end
CacheDaycareUB();

local tPersistentPolicies = {}
function CachePersistentPolicies()
	for row in GameInfo.Trait_VV_HDD_PersistentPolicies() do
		tPersistentPolicies[row.TraitType] = {
			["Policy"]	 	= row.Policy,
			["Disabled"] 	= row.DisabledPolicy,
			["TurnsNeeded"]	= row.TurnsNeeded
		}
	end
end
CachePersistentPolicies();


function IsDollSystem(iPlayer)
	if iPlayer >= iMaxCivs then return false end
	return tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].DollMake;
end

--Returns true for either UseOnly (Iris) or full (Plutia)
function IsDollSystemUseOnly(iPlayer)
	if iPlayer >= iMaxCivs then return false end
	return tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].DollUse;
end

function IsNapSystem(iPlayer)
	if iPlayer >= iMaxCivs then return false end
	return (tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].NapLength > 0);
end

function IsPersistentPolicy(iPlayer)
	if iPlayer >= iMaxCivs then return false end
	return (tPersistentPolicies[tPlutiaTraitLeaders[iPlayer]] ~= nil);
end


function GetNapLength(iPlayer)
	if iPlayer >= iMaxCivs then return false end
	return tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].NapLength
end

function GetNapCountdownBase(iPlayer)
	if iPlayer >= iMaxCivs then return 0 end
	return tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].NapDelay
end


function IsDaycareUB(iPlayer)
	if iPlayer >= iMaxCivs then return false end
	return tDaycareUBCivs[iPlayer] or false
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- DOLL DEFINITIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------

local tDolls; 

if not MapModData.gPlutiaDollDefs then
	MapModData.gPlutiaDollDefs = {}
	tDolls = MapModData.gPlutiaDollDefs
	--Default Dolls
	tDolls[1] = {
		["Name"]				= "TXT_KEY_VV_PLUTIA_DOLL_NAME_1",
		["CuddleEffect"]		= {
				["Function"] 	= "YIELD",
				["Data1"] 		= "YIELD_SCIENCE",
				["Data2"]		= 20
			},
		["StressEffect"]		= {
				["Function"]	= "PROMOTION",
				["Data1"]		= GameInfoTypes.PROMOTION_PLUTIA_SD_GET_EVEN,
				["Data2"]	= math.floor(10 * PRODUCTION_SPEED_MOD)
		},
		["WeaponPromo"]			= GameInfoTypes.PROMOTION_SHOCK_1 or GameInfoTypes.PROMOTION_DRILL_1,
		["Playtime"]	= {
			["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_SCIENCE,
			["Pop"]			=	3
		}
	}

	tDolls[2] = {
		["Name"]				= "TXT_KEY_VV_PLUTIA_DOLL_NAME_2",
		["CuddleEffect"]		= {
				["Function"] 	= "YIELD",
				["Data1"] 		= "YIELD_FOOD",
				["Data2"]		= 40
			},
		["StressEffect"]		= {
				["Function"]	= "ALLCITIES_BUILDING",
				["Data1"]		= GameInfoTypes.BUILDING_PLUTIA_SD_MILITARY,
				["Data2"]	= math.floor(10 * PRODUCTION_SPEED_MOD)
		},
		["WeaponPromo"]			= GameInfoTypes.PROMOTION_DRILL_1,
		["Playtime"]	= {
			["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_FOOD,
			["Pop"]			=	2
		}
	}

	tDolls[3] = {
		["Name"]				= "TXT_KEY_VV_PLUTIA_DOLL_NAME_3",
		["CuddleEffect"]		= {
				["Function"] 	= "YIELD",
				["Data1"] 		= "YIELD_PRODUCTION",
				["Data2"]		= 40
			},
		["StressEffect"]		= {
				["Function"]	= "DENOUNCER_ANARCHY",
				["Data1"]	= math.max(math.floor(2 * PRODUCTION_SPEED_MOD), 1)
		},
		["WeaponPromo"]			= GameInfoTypes.PROMOTION_COVER_1,
		["Playtime"]	= {
			["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_PRODUCTION,
			["Pop"]			=	3
		}
	}

	tDolls[4] = {
		["Name"]				= "TXT_KEY_VV_PLUTIA_DOLL_NAME_4",
		["CuddleEffect"]		= {
				["Function"] 	= "YIELD",
				["Data1"] 		= "YIELD_GOLD",
				["Data2"]		= 80
			},
		["StressEffect"]		= {
				["Function"]	= "YIELD",
				["Data1"]		= "YIELD_FOOD",
				["Data2"]		= math.floor(20 * PRODUCTION_SPEED_MOD),
				["Data3"]		= true
		},
		["WeaponPromo"]			= GameInfoTypes.PROMOTION_MEDIC,
		["Playtime"]	= {
			["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_GOLD,
			["Pop"]			=	2
		}
	}

	tDolls[5] = {
		["Name"]				= "TXT_KEY_VV_PLUTIA_DOLL_NAME_5",
		["CuddleEffect"]		= {
				["Function"] 	= "YIELD",
				["Data1"] 		= "YIELD_CULTURE",
				["Data2"]		= 30
			},
		["StressEffect"]		= {
				["Function"]	= "DENOUNCER_PROMOTION",
				["Data1"]		= GameInfoTypes.PROMOTION_PLUTIA_SD_XP_MINUS,
				["Data2"]	= math.floor(20 * PRODUCTION_SPEED_MOD)
		},
		["WeaponPromo"]			= GameInfoTypes.PROMOTION_SCOUTING_1,
		["Playtime"]	={
			["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_CULTURE,
			["Pop"]			=	3
		}
	}

	tDolls[6] = {
		["Name"]				= "TXT_KEY_VV_PLUTIA_DOLL_NAME_6",
		["CuddleEffect"]		= {
				["Function"] 	= "YIELD",
				["Data1"] 		= "YIELD_FAITH",
				["Data2"]		= 20
			},
		["StressEffect"]		= {
				["Function"]	= "CAPITAL_BUILDING",
				["Data1"]		= GameInfoTypes.BUILDING_PLUTIA_SD_HAPPINESS,
				["Data2"]	= math.floor(10 * PRODUCTION_SPEED_MOD)
		},
		["WeaponPromo"]			= GameInfoTypes.PROMOTION_SURVIVALISM_1,
		["Playtime"]	= {
			["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_FAITH,
			["Pop"]			=	3
		}
	}

	tDolls[7] = {
		["Name"]				= "TXT_KEY_VV_PLUTIA_DOLL_NAME_7",
		["CuddleEffect"]		= {
				["Function"] 	= "YIELD",
				["Data1"] 		= "YIELD_GOLDEN_AGE_POINTS",
				["Data2"]		= 100
			},
		["StressEffect"]		= {
				["Function"]	= "PROMOTION",
				["Data1"]		= GameInfoTypes.PROMOTION_PLUTIA_SD_SMASH,
				["Data2"]	= math.floor(10 * PRODUCTION_SPEED_MOD)
		},
		["WeaponPromo"]			= GameInfoTypes.PROMOTION_AMPHIBIOUS,
		["Playtime"]	= {
			["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_DEFENSE,
			["Pop"]			=	0.50
		}
	}

	tDolls[8] = {
		["Name"]				= "TXT_KEY_VV_PLUTIA_DOLL_NAME_8",
		["CuddleEffect"]		= {
				["Function"] 	= "YIELD",
				["Data1"] 		= "YIELD_VV_SHARES",
				["Data2"]		= 100
			},
		["StressEffect"]		= {
				["Function"]	= "YIELD",
				["Data1"]		= "YIELD_VV_SHARES",
				["Data2"]		= 100
		},
		["WeaponPromo"]			= GameInfoTypes.PROMOTION_SIEGE,
		["Playtime"]	= {
			["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_SHARES,
			["Pop"]			=	3
		}
	}

	--Leader Dolls
	for i = 0, iMaxCivs - 1, 1 do
		local pLoop = Players[i]
		if pLoop:IsEverAlive() then
			local leader = GameInfo.Leaders[pLoop:GetLeaderType()]
			local civilization = GameInfo.Civilizations[pLoop:GetCivilizationType()].Type
			local uniqueUnits = {}
			for row in GameInfo.Civilization_UnitClassOverrides("CivilizationType = '"..civilization.."'") do
				if row.UnitType and GameInfo.Units[row.UnitType] then
					uniqueUnits[#uniqueUnits + 1] = GameInfo.Units[row.UnitType]
				end
			end
			local key = #tDolls+ 1
			tDolls[key] = {
				["Name"] = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_LEADER_DOLL", leader.Description),
				["Leader"] = i
			}

			--Determine Cuddle and Playtime dolls based on Leader Flavors.
			local yields = {
				["YIELD_SCIENCE"] = 0,
				["YIELD_GOLD"] = 0,
				["YIELD_PRODUCTION"] = 0,
				["YIELD_CULTURE"] = 0,
				["YIELD_FAITH"] = 0,
				["YIELD_FOOD"] = 0,
				["YIELD_GOLDEN_AGE_POINTS"] = 0,
				["YIELD_VV_SHARES"] = 0
			}

			--Shares will only be granted by Neps.
			if string.find(civilization, "PLANEPTUNE") or string.find(civilization, "LASTATION") or string.find(civilization, "LOWEE") or string.find(civilization, "LEANBOX") then
				yields["YIELD_VV_SHARES"] = 1000
			else
				--Determine cuddle and daycare dolls based on leader flavors.
				for row in GameInfo.Leader_Flavors("LeaderType = '"..leader.Type.."'") do
					if row.FlavorType == "FLAVOR_SCIENCE" or row.FlavorType == "FLAVOR_SPACESHIP" then
						yields["YIELD_SCIENCE"] = yields["YIELD_SCIENCE"] + row.Flavor
					elseif row.FlavorType == "FLAVOR_GOLD" or row.FlavorType == "FLAVOR_DIPLOMACY" then
						yields["YIELD_GOLD"] = yields["YIELD_GOLD"] + row.Flavor
					elseif row.FlavorType == "FLAVOR_PRODUCTION" or row.FlavorType == "FLAVOR_INFRASTRUCTURE" then
						yields["YIELD_PRODUCTION"] = yields["YIELD_PRODUCTION"] + row.Flavor
					elseif row.FlavorType == "FLAVOR_CULTURE" or row.FlavorType == "FLAVOR_GREAT_PEOPLE" then
						yields["YIELD_CULTURE"] = yields["YIELD_CULTURE"] + row.Flavor
					elseif row.FlavorType == "FLAVOR_RELIGION" or row.FlavorType == "FLAVOR_WONDER" then
						yields["YIELD_FAITH"] = yields["YIELD_FAITH"] + row.Flavor
					elseif row.FlavorType == "FLAVOR_GROWTH" or row.FlavorType == "FLAVOR_TILE_IMPROVEMENT" then
						yields["YIELD_FOOD"] = yields["YIELD_FOOD"] + row.Flavor
					elseif row.FlavorType == "FLAVOR_HAPPINESS" or row.FlavorType == "FLAVOR_EXPANSION" then
						yields["YIELD_GOLDEN_AGE_POINTS"] = yields["YIELD_GOLDEN_AGE_POINTS"] + row.Flavor
					end
				end
			end

			local chosenType;
			local highestFlavor = 0
			for k, v in pairs(yields) do
				if v > highestFlavor then
					highestFlavor = v
					chosenType = k
				end
			end
			print(chosenType, highestFlavor)

			local types = {
				["YIELD_SCIENCE"] = {
					["CuddleEffect"]		= {
						["Function"] 	= "YIELD",
						["Data1"] 		= "YIELD_SCIENCE",
						["Data2"]		= 50
					},
					["Playtime"]	= {
						["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_SCIENCE,
						["Pop"]			=	2
					},
				},
				["YIELD_GOLD"] = {
					["CuddleEffect"]		= {
						["Function"] 	= "YIELD",
						["Data1"] 		= "YIELD_GOLD",
						["Data2"]		= 120
					},
					["Playtime"]	= {
						["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_GOLD,
						["Pop"]			=	1
					},
				},
				["YIELD_FOOD"] = {
					["CuddleEffect"]		= {
						["Function"] 	= "YIELD",
						["Data1"] 		= "YIELD_FOOD",
						["Data2"]		= 60
					},
					["Playtime"]	= {
						["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_FOOD,
						["Pop"]			=	2
					},
				},
				["YIELD_PRODUCTION"] = {
					["CuddleEffect"]		= {
						["Function"] 	= "YIELD",
						["Data1"] 		= "YIELD_PRODUCTION",
						["Data2"]		= 60
					},
					["Playtime"]	= {
						["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_PRODUCTION,
						["Pop"]			=	2
					},
				},
				["YIELD_CULTURE"] = {
					["CuddleEffect"]		= {
						["Function"] 	= "YIELD",
						["Data1"] 		= "YIELD_CULTURE",
						["Data2"]		= 50
					},
					["Playtime"]	= {
						["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_CULTURE,
						["Pop"]			=	2
					},
				},
				["YIELD_FAITH"] = {
					["CuddleEffect"]		= {
						["Function"] 	= "YIELD",
						["Data1"] 		= "YIELD_FAITH",
						["Data2"]		= 40
					},
					["Playtime"]	= {
						["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_FAITH,
						["Pop"]			=	2
					},
				},
				["YIELD_GOLDEN_AGE_POINTS"] = {
					["CuddleEffect"]		= {
						["Function"] 	= "YIELD",
						["Data1"] 		= "YIELD_GOLDEN_AGE_POINTS",
						["Data2"]		= 200
					},
					["Playtime"]	= {
						["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_DEFENSE,
						["Pop"]			=	0.25
					},
				},
				["YIELD_VV_SHARES"] = {
					["CuddleEffect"]		= {
						["Function"] 	= "YIELD",
						["Data1"] 		= "YIELD_VV_SHARES",
						["Data2"]		= 200
					},
					["Playtime"]	= {
						["Building"]	=	GameInfoTypes.BUILDING_VV_DCD_SHARES,
						["Pop"]			=	2
					},
				}
			}
			
			--If the Civ has a unique Great Person, make earning it the Cuddle Effect after 6 naps (Standard)
			for _, row in pairs(uniqueUnits) do
				if row.Special == "SPECIALUNIT_PEOPLE" then
					tDolls[key].CuddleEffect = {
						["Function"]	= "UNIT",
						["Data1"]		= row.ID,
						["Data2"]		= math.ceil(6 * PRODUCTION_SPEED_MOD)
					}
					break
				end
			end
			--Otherwise, it just takes the function from the above table
			if not tDolls[key].CuddleEffect then tDolls[key].CuddleEffect = types[chosenType].CuddleEffect end
			tDolls[key].Playtime = types[chosenType].Playtime

			--Weapon Doll: Look for UU promotions
			local UniquePromotions = {}
			for k, v in pairs(uniqueUnits) do
				--Only steal from UUs with the same domain
				if v.Domain == "DOMAIN_LAND" then
					--Do not steal from civilian units or Great People
					if not v.Special and v.Combat >= 0 then
						--Only steal promotions which are not available to the base unit
						local pUnitClass = GameInfo.UnitClasses("Type = '" ..v.Class.. "'")()
						local pDefaultUnit = GameInfo.Units("Type = '" ..pUnitClass.DefaultUnit.. "'")()
						--Find stuff in the free promotions table for the UU. Then look to see if the default unit gets it. If not, add it to the table. 
						for row in GameInfo.Unit_FreePromotions() do
							if row.UnitType == v.Type then
								bIsUniquePromotion = true
								if pDefaultUnit then
									for row2 in GameInfo.Unit_FreePromotions() do
										if row2.UnitType == pDefaultUnit.Type and row2.PromotionType == row.PromotionType then
											bIsUniquePromotion = false
											break
										end
									end
								end
								if bIsUniquePromotion then
									local promotion = GameInfo.UnitPromotions("Type = '" ..row.PromotionType.. "'")()
									if (promotion.IconAtlas ~= "ABILITY_ATLAS" or promotion.PortraitIndex ~= 57) then	--it is generally assumed that we don't want promotions with ABILITY_ATLAS icon #57, the red down-arrow!
										local iPromotion = promotion.ID
										table.insert(UniquePromotions, iPromotion)
									end
								end
							end		
						end
					end
				end
			end
			if #UniquePromotions > 0 then
				--Choose one at random
				iChosenPromotion = Game.Rand(#UniquePromotions, "Random Doll Promotion") + 1
				tDolls[key].WeaponPromo = UniquePromotions[iChosenPromotion]
			end
			
			--Otherwise just pick one from the original 8
			if not tDolls[key].WeaponPromo then
				local iRand = Game.Rand(7, "Plutia Doll Roll") + 1
				tDolls[key].WeaponPromo = tDolls[iRand].WeaponPromo
			end
			
			
			--Stress Doll: Currently just use existing ones from the original 8 
			local iRand = Game.Rand(7, "Plutia Doll Roll") + 1
			tDolls[key].StressEffect = tDolls[iRand].StressEffect
		end
	end
else
	tDolls = MapModData.gPlutiaDollDefs
end



function AddToDollsTable(t)
	if t and type(t) == "table" then
		--First find out if the Leader already exists in the table. If so, replace that entry in the table. Otherwise, add a new entry.
		local key;
		if t.Leader then
			for k, v in pairs(tDolls) do
				if v.Leader == t.Leader then
					key = k
					break
				end
			end
			if not key then key = #tDolls + 1 end
			tDolls[key] = t
		end
	end
end
LuaEvents.VV_AddToDollsTable.Add(AddToDollsTable)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- DOLL EFFECTS
---------------------------------------------------------------------------------------------------------------------------------------------------------
MapModData.gCuddleDollFunctions 	= {}
MapModData.gCuddleDollTooltips 		= {}
MapModData.gStressDollFunctions 	= {}
MapModData.gStressDollEndFunctions 	= {}
MapModData.gStressDollTooltips 		= {}

local tCuddleDollFunctions 		= MapModData.gCuddleDollFunctions
local tCuddleDollTooltips 		= MapModData.gCuddleDollTooltips
local tStressDollFunctions 		= MapModData.gStressDollFunctions
local tStressDollEndFunctions 	= MapModData.gStressDollEndFunctions
local tStressDollTooltips 		= MapModData.gStressDollTooltips 	
-- Weapon and Playtime dolls will only ever have one type of effect.



--Increase a given Yield by a value which scales by Era.
tCuddleDollFunctions["YIELD"] = function(iPlayer, sYield, iValue, bAllCities)
	local pPlayer = Players[iPlayer]
	local pCapital = pPlayer:GetCapitalCity()
	local iEra = pPlayer:GetCurrentEra() + 1  --Eras start at 0!
	iValue = math.floor(iValue * iEra)
	VV_ChangeYield(iPlayer, sYield, iValue, bAllCities)
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_CD_BONUS_TEXT", CreateYieldString(iValue, sYield)), Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_CD_BONUS_TITLE"),
	pCapital:GetX(), pCapital:GetY())
end

tCuddleDollTooltips["YIELD"] = function(iPlayer, sYield, iValue)
	local pPlayer = Players[iPlayer]
	local iEra = pPlayer:GetCurrentEra() + 1  --Eras start at 0!
	iValue = math.floor(iValue * iEra)
	sString = CreateYieldString(iValue, sYield)
	return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_CUDDLE_YIELD", sString)
end


--Grant a Unit after [iValue] naps (scales by game speed)
tCuddleDollFunctions["UNIT"] = function(iPlayer, iUnitType, iValue)
	if GameInfo.Units[iUnitType] then
		iValue = math.floor(iValue * PRODUCTION_SPEED_MOD)
		if not HDNMod.PlutiaCuddleDollEffectTracker[iPlayer] then HDNMod.PlutiaCuddleDollEffectTracker[iPlayer] = {} end
		if not HDNMod.PlutiaCuddleDollEffectTracker[iPlayer][HDNMod.PlutiaCuddleDoll[iPlayer].Type] then
			HDNMod.PlutiaCuddleDollEffectTracker[iPlayer][HDNMod.PlutiaCuddleDoll[iPlayer].Type] = 1
		else
			HDNMod.PlutiaCuddleDollEffectTracker[iPlayer][HDNMod.PlutiaCuddleDoll[iPlayer].Type] = HDNMod.PlutiaCuddleDollEffectTracker[iPlayer][HDNMod.PlutiaCuddleDoll[iPlayer].Type] + 1
		end
		if HDNMod.PlutiaCuddleDollEffectTracker[iPlayer][HDNMod.PlutiaCuddleDoll[iPlayer].Type] >= iValue then
			local pPlayer = Players[iPlayer]
			local pCapital = pPlayer:GetCapitalCity()
			local pNewUnit = pPlayer:InitUnit(iUnitType, pCapital:GetX(), pCapital:GetY())
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_CD_UNIT_TEXT", GameInfo.Units[iUnitType].Description), Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_CD_UNIT_TITLE"),
			pCapital:GetX(), pCapital:GetY())
			HDNMod.PlutiaCuddleDollEffectTracker[iPlayer][HDNMod.PlutiaCuddleDoll[iPlayer].Type] = 0
		end
	end
end

tCuddleDollTooltips["UNIT"] = function(iPlayer, iUnitType, iValue)
	if GameInfo.Units[iUnitType] then
		local sUnitDesc = Locale.ConvertTextKey(GameInfo.Units[iUnitType].Description)
		if not HDNMod.PlutiaCuddleDollEffectTracker[iPlayer] or not HDNMod.PlutiaCuddleDoll[iPlayer] or not HDNMod.PlutiaCuddleDollEffectTracker[iPlayer][HDNMod.PlutiaCuddleDoll[iPlayer].Type] then
			return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_CUDDLE_UNIT", sUnitDesc, 0, iValue)
		else
			return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_CUDDLE_UNIT", sUnitDesc, HDNMod.PlutiaCuddleDollEffectTracker[iPlayer][HDNMod.PlutiaCuddleDoll[iPlayer].Type], iValue)
		end
	end
	return ""
end


function AddToCuddleDollTable(key, t1, t2)
	if key and t1 and t2 then
		tCuddleDollFunctions[key] = t1
		tCuddleDollTooltips[key] = t2
	end
end
LuaEvents.VV_AddToCuddleDollTable.Add(AddToCuddleDollTable)



tStressDollFunctions["PROMOTION"] = function(iPlayer, iPromotion, iDuration)
	if not HDNMod.PlutiaStressDollDuration[iPlayer] then HDNMod.PlutiaStressDollDuration[iPlayer] = {} end
	HDNMod.PlutiaStressDollDuration[iPlayer][HDNMod.PlutiaStressDoll[iPlayer].Type] = iDuration
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:IsCombatUnit() or pUnit:GetDomainType() == GameInfoTypes.DOMAIN_AIR then
			pUnit:SetHasPromotion(iPromotion, true)
		end
	end	
end
tStressDollEndFunctions["PROMOTION"] = function(iPlayer, iPromotion)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:IsCombatUnit() or pUnit:GetDomainType() == GameInfoTypes.DOMAIN_AIR then
			pUnit:SetHasPromotion(iPromotion, false)
		end
	end	
end
tStressDollTooltips["PROMOTION"] = function(iPlayer, iPromotion, iDuration)
	return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_STRESS_PROMOTION", GameInfo.UnitPromotions[iPromotion].Description, iDuration, GameInfo.UnitPromotions[iPromotion].Help)
end

tStressDollFunctions["DENOUNCER_PROMOTION"] = function(iPlayer, iPromotion, iDuration)
	if not HDNMod.PlutiaStressDollDuration[iPlayer] then HDNMod.PlutiaStressDollDuration[iPlayer] = {} end
	HDNMod.PlutiaStressDollDuration[iPlayer][HDNMod.PlutiaStressDoll[iPlayer].Type] = iDuration
	local pPlayer = Players[iPlayer]
	for i = 0, iMaxCivs - 1, 1 do
		local pLoop = Players[i]
		if pPlayer ~= pLoop and pLoop:IsAlive() and pLoop:IsDenouncedPlayer(iPlayer) then
			for pUnit in pLoop:Units() do
				if pUnit:IsCombatUnit() or pUnit:GetDomainType() == GameInfoTypes.DOMAIN_AIR then
					pUnit:SetHasPromotion(iPromotion, true)
				end
			end	
		end
	end
end
tStressDollEndFunctions["DENOUNCER_PROMOTION"] = function(iPlayer, iPromotion)
	local pPlayer = Players[iPlayer]
	for i = 0, iMaxCivs - 1, 1 do
		local pLoop = Players[i]
		if pPlayer ~= pLoop and pLoop:IsAlive() then
			for pUnit in pLoop:Units() do
				if pUnit:IsCombatUnit() or pUnit:GetDomainType() == GameInfoTypes.DOMAIN_AIR then
					pUnit:SetHasPromotion(iPromotion, false)
				end
			end	
		end
	end
end
tStressDollTooltips["DENOUNCER_PROMOTION"] = function(iPlayer, iPromotion, iDuration)
	return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_STRESS_DENOUNCER_PROMOTION", GameInfo.UnitPromotions[iPromotion].Description, iDuration, GameInfo.UnitPromotions[iPromotion].Help)
end

tStressDollFunctions["CAPITAL_BUILDING"] = function(iPlayer, iBuilding, iDuration)
	if not HDNMod.PlutiaStressDollDuration[iPlayer] then HDNMod.PlutiaStressDollDuration[iPlayer] = {} end
	HDNMod.PlutiaStressDollDuration[iPlayer][HDNMod.PlutiaStressDoll[iPlayer].Type] = iDuration
	local pPlayer = Players[iPlayer]
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then
		pCapital:SetNumRealBuilding(iBuilding, 1)
	end
end
tStressDollEndFunctions["CAPITAL_BUILDING"] = function(iPlayer, iBuilding)
	local pPlayer = Players[iPlayer]
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then
		pCapital:SetNumRealBuilding(iBuilding, 0)
	end
end
tStressDollTooltips["CAPITAL_BUILDING"] = function(iPlayer, iBuilding, iDuration)
	return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_STRESS_CAPITAL_BUILDING", GameInfo.Buildings[iBuilding].Help, iDuration)
end

tStressDollFunctions["ALLCITIES_BUILDING"] = function(iPlayer, iBuilding, iDuration)
	if not HDNMod.PlutiaStressDollDuration[iPlayer] then HDNMod.PlutiaStressDollDuration[iPlayer] = {} end
	HDNMod.PlutiaStressDollDuration[iPlayer][HDNMod.PlutiaStressDoll[iPlayer].Type] = iDuration
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		pCity:SetNumRealBuilding(iBuilding, 1)
	end
end
tStressDollEndFunctions["ALLCITIES_BUILDING"] = function(iPlayer, iBuilding)
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		pCity:SetNumRealBuilding(iBuilding, 0)
	end
end
tStressDollTooltips["ALLCITIES_BUILDING"] = function(iPlayer, iBuilding, iDuration)
	return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_STRESS_ALLCITIES_BUILDING", GameInfo.Buildings[iBuilding].Help, iDuration)
end


tStressDollFunctions["DENOUNCER_ALLCITIES_BUILDING"] = function(iPlayer, iBuilding, iDuration)
	if not HDNMod.PlutiaStressDollDuration[iPlayer] then HDNMod.PlutiaStressDollDuration[iPlayer] = {} end
	HDNMod.PlutiaStressDollDuration[iPlayer][HDNMod.PlutiaStressDoll[iPlayer].Type] = iDuration
	local pPlayer = Players[iPlayer]
	for i = 0, iMaxCivs - 1, 1 do
		local pLoop = Players[i]
		if pPlayer ~= pLoop and pLoop:IsAlive() and pLoop:IsDenouncedPlayer(iPlayer) then
			for pCity in pLoop:Cities() do
				pCity:SetNumRealBuilding(iBuilding, 1)
			end
		end
	end
end
tStressDollFunctions["DENOUNCER_ALLCITIES_BUILDING"] = function(iPlayer, iBuilding, iDuration)
	local pPlayer = Players[iPlayer]
	for i = 0, iMaxCivs - 1, 1 do
		local pLoop = Players[i]
		if pPlayer ~= pLoop and pLoop:IsAlive() then
			for pCity in pLoop:Cities() do
				pCity:SetNumRealBuilding(iBuilding, 0)
			end
		end
	end
end
tStressDollTooltips["DENOUNCER_ALLCITIES_BUILDING"] = function(iPlayer, iBuilding, iDuration)
	return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_STRESS_DENOUNCER_ALLCITIES_BUILDING", GameInfo.Buildings[iBuilding].Help, iDuration)
end


tStressDollFunctions["DENOUNCER_ANARCHY"] = function(iPlayer, iAnarchyDuration)
	local pPlayer = Players[iPlayer]
	for i = 0, iMaxCivs - 1, 1 do
		local pLoop = Players[i]
		if pPlayer ~= pLoop and pLoop:IsAlive() and pLoop:IsDenouncedPlayer(iPlayer) then
			pLoop:ChangeAnarchyNumTurns(iAnarchyDuration)
		end
	end
end
tStressDollTooltips["DENOUNCER_ANARCHY"] = function(iPlayer, iAnarchyDuration)
	return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_STRESS_DENOUNCER_ANARCHY", iAnarchyDuration)
end

tStressDollFunctions["YIELD"] = function(iPlayer, sYield, iValue, bAllCities)
	local pPlayer = Players[iPlayer]
	local pCapital = pPlayer:GetCapitalCity()
	local iEra = pPlayer:GetCurrentEra() + 1  --Eras start at 0!
	iValue = math.floor(iValue * iEra)
	VV_ChangeYield(iPlayer, sYield, iValue, bAllCities)
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_CD_BONUS_TEXT", CreateYieldString(iValue, sYield)), Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_CD_BONUS_TITLE"),
	pCapital:GetX(), pCapital:GetY())
end
tStressDollTooltips["YIELD"] = function(iPlayer, sYield, iValue)
	local pPlayer = Players[iPlayer]
	local iEra = pPlayer:GetCurrentEra() + 1  --Eras start at 0!
	iValue = math.floor(iValue * iEra)
	sString = CreateYieldString(iValue, sYield)
	return Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_TT_STRESS_YIELD", sString)
end


function AddToStressDollTable(key, t1, t2, t3)
	if key and t1 and t2 then
		tStressDollFunctions[key] = t1
		tStressDollEndFunctions[key] = t2
		tStressDollTooltips[key] = t3
	end
end
LuaEvents.VV_AddToStressDollTable.Add(AddToStressDollTable)


--Add/Remove Promotions to/from every Melee/Gunpowder Unit owned.
function WeaponDollHandler(iPlayer, bRemove, bInit)
	if HDNMod.PlutiaWeaponDoll[iPlayer] then
		local pPlayer = Players[iPlayer]
		for pUnit in pPlayer:Units() do	
			if pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MELEE or pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_GUN then
				local iPromotionType = tDolls[HDNMod.PlutiaWeaponDoll[iPlayer].Type].WeaponPromo
				if bRemove == true then
					local iUnit = pUnit:GetID()
					if not HDNMod.PlutiaExistingUnitPromotions[iUnit] then HDNMod.PlutiaExistingUnitPromotions[iUnit] = {} end
					if HDNMod.PlutiaExistingUnitPromotions[iUnit][iPromotionType] ~= true then
						pUnit:SetHasPromotion(iPromotionType, false)
					end
				else
					if bInit and pUnit:IsHasPromotion(iPromotionType) then
						local iUnit = pUnit:GetID()
						if not HDNMod.PlutiaExistingUnitPromotions[iUnit] then HDNMod.PlutiaExistingUnitPromotions[iUnit] = {} end
						HDNMod.PlutiaExistingUnitPromotions[iUnit][iPromotionType] = true
					end
					pUnit:SetHasPromotion(iPromotionType, true)
				end
			end
		end
	end
end





---------------------------------------------------------------------------------------------------------------------------------------------------------
-- HELPER FUNCTIONS
-- None of these are directly assigned to any Events or GameEvents.
---------------------------------------------------------------------------------------------------------------------------------------------------------
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



--Global handler for changing any yield, other than Tourism which is difficult to do even with CP or DVMC.
--Handles negative values by virtue of clamping values to 0 if the player's total goes below 0 for a given yield.
--Kills and births Citizens in the case of Food.
--boolean at end allows for adding Food or Production to all cities; otherwise it goes to the Capital.
function VV_ChangeYield(iPlayer, sYield, iValue, bAllCities)
	local pPlayer = Players[iPlayer]

	if sYield == "YIELD_SCIENCE" then
		local iTech = pPlayer:GetCurrentResearch()
		if iTech == -1 then return end
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		pTeamTechs:ChangeResearchProgress(iTech, iValue, iPlayer)
		if pTeamTechs:GetResearchProgress(iTech) < 0 then pTeamTechs:SetResearchProgress(iTech, 0, iPlayer) end
	if pTeamTechs:HasTech(iTech) then return end
	elseif sYield == "YIELD_FOOD" then
		local function ChangeFoodWithPopAdjust(city, value)
			city:ChangeFood(value)
			while city:GetFood() >= city:GrowthThreshold() do
				newvalue = city:GetFood() - city:GrowthThreshold()
				city:ChangePopulation(1, true)
				city:SetFood(newvalue)
			end
			while city:GetFood() < 0 do
				--If the city only has 1 Pop, just set it to 0 and stop the loop
				if city:GetPopulation() <= 1 then
					city:SetFood(0)
					break
				else
					newvalue = city:GetFood()
					city:ChangePopulation(-1, true)
					city:SetFood(city:GrowthThreshold() + newvalue)
				end
			end
		end

		if bAllCities then
			for pCity in pPlayer:Cities() do
				ChangeFoodWithPopAdjust(pCity, iValue)
			end
		else
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				ChangeFoodWithPopAdjust(pCapital, iValue)
			end
		end
	elseif sYield == "YIELD_PRODUCTION" then
		if bAllCities then
			for pCity in pPlayer:Cities() do
				pCity:ChangeProduction(iValue)
				if pCity:GetProduction() < 0 then pCity:SetProduction(0) end
			end
		else
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				pCapital:ChangeProduction(iValue)
				if pCapital:GetProduction() < 0 then pCapital:SetProduction(0) end
			end
		end
	elseif sYield == "YIELD_GOLD" then
		pPlayer:ChangeGold(iValue)
		if pPlayer:GetGold() < 0 then pPlayer:SetGold(0) end
	elseif sYield == "YIELD_CULTURE" then
		pPlayer:ChangeJONSCulture(iValue)
		if pPlayer:GetJONSCulture() < 0 then pPlayer:SetJONSCulture(0) end
	elseif sYield == "YIELD_FAITH" then
		pPlayer:ChangeFaith(iValue)
		if pPlayer:GetFaith() < 0 then pPlayer:SetFaith(0) end
	elseif sYield == "YIELD_GOLDEN_AGE_POINTS" then
		--This doesn't actually need DLL VMC or Community Patch even though it uses its Yield ID. It's just to make it look nice.
		pPlayer:ChangeGoldenAgeProgressMeter(iValue)
		if pPlayer:GetGoldenAgeProgressMeter() < 0 then
			pPlayer:SetGoldenAgeProgressMeter(0)
		end
	elseif sYield == "YIELD_VV_SHARES" then
		--My ChangeShares function already handles both negative and positive values because I'm super smart.
		LuaEvents.HDNChangeShares(iPlayer, iValue)
	end
end

function GetYieldIcon(sYield)
	if not sYield then return end
	local sString;
	if sYield == "YIELD_VV_SHARES" then 
		sString = "[ICON_VV_SHARES]"
	elseif sYield == "YIELD_GOLDEN_AGE_POINTS" then
		sString = "[ICON_VV_GOLDEN_AGE]"
	else
		yieldtype = GameInfo.Yields[sYield]
		if yieldtype then 
			sString = yieldtype.IconString
		end
	end
	return sString
end

function CreateYieldString(iValue, sYield)
	if not sYield or not iValue then return end
	local sString = ""
	if sYield == "YIELD_VV_SHARES" then
		sString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_SHARES_YIELD", ConvertToPercentString(iValue))
	elseif sYield == "YIELD_GOLDEN_AGE_POINTS" and not GameInfo.Yields[sYield] then
		sString = Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_GOLDEN_AGE_YIELD", iValue)
	else
		sString = iValue.." "..GameInfo.Yields[sYield].IconString.." "..Locale.ConvertTextKey(GameInfo.Yields[sYield].Description)
	end
	return sString
end



function ChangeDollDurability(iPlayer, sSlot, iValue)
	local pPlayer = Players[iPlayer]
	local function BreakNotification()
		local sDollType;
		if sSlot == "CUDDLE" then sDollType = "TXT_KEY_VV_PLUTIA_CUDDLE"
		elseif sSlot == "STRESS" then sDollType = "TXT_KEY_VV_PLUTIA_STRESS"
		elseif sSlot == "WEAPON" then sDollType = "TXT_KEY_VV_PLUTIA_WEAPON"
		elseif sSlot == "PLAYTIME" then sDollType = "TXT_KEY_VV_PLUTIA_PLAYTIME" end
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_DOLL_BROKEN_TEXT", sDollType), Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_DOLL_BROKEN_TITLE"))
	end
	
	if sSlot == "CUDDLE" then
		HDNMod.PlutiaCuddleDoll[iPlayer].Durability = HDNMod.PlutiaCuddleDoll[iPlayer].Durability + iValue
		if HDNMod.PlutiaCuddleDoll[iPlayer].Durability <= 0 then
			ClearActiveUseDoll(iPlayer, sSlot)
			BreakNotification()
		end
	elseif sSlot == "STRESS" then
		HDNMod.PlutiaStressDoll[iPlayer].Durability = HDNMod.PlutiaStressDoll[iPlayer].Durability + iValue
		if HDNMod.PlutiaStressDoll[iPlayer].Durability <= 0 then
			ClearActiveUseDoll(iPlayer, sSlot)
			BreakNotification()
		end
	elseif sSlot == "WEAPON" then
		HDNMod.PlutiaWeaponDoll[iPlayer].Durability = HDNMod.PlutiaWeaponDoll[iPlayer].Durability + iValue
		if HDNMod.PlutiaWeaponDoll[iPlayer].Durability <= 0 then
			ClearActiveUseDoll(iPlayer, sSlot)
			BreakNotification()
		end
	elseif sSlot == "PLAYTIME" then
		HDNMod.PlutiaPlaytimeDoll[iPlayer].Durability = HDNMod.PlutiaPlaytimeDoll[iPlayer].Durability + iValue
		if HDNMod.PlutiaPlaytimeDoll[iPlayer].Durability <= 0 then
			ClearActiveUseDoll(iPlayer, sSlot)
			BreakNotification()
		end
	end
end

--Change progress towards production doll. Positive values decrease time to finish, negative values increase it.
function ChangeDollmakingProgress(iPlayer, iValue)
	if not HDNMod.PlutiaActiveProductionDoll[iPlayer] then return end
	HDNMod.PlutiaActiveProductionDoll[iPlayer].TurnsLeft = HDNMod.PlutiaActiveProductionDoll[iPlayer].TurnsLeft - iValue
	if HDNMod.PlutiaActiveProductionDoll[iPlayer].TurnsLeft <= 0 then
		AddNewDoll(iPlayer, HDNMod.PlutiaActiveProductionDoll[iPlayer].Type)
		Players[iPlayer]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_DOLL_FINISHED_TEXT", tDolls[HDNMod.PlutiaActiveProductionDoll[iPlayer].Type].Name), Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_NO_DOLL_PRODUCED_TITLE"))
		HDNMod.PlutiaActiveProductionDoll[iPlayer] = nil
	end
end


--Set a new doll to be the one being produced.
function SetActiveProductionDoll(iPlayer, iType)
	if not HDNMod.PlutiaSewingKits[iPlayer] then HDNMod.PlutiaSewingKits[iPlayer] = 1 end
	local iTurns = DOLL_PROD_TIME_BASE - tSewingKits[HDNMod.PlutiaSewingKits[iPlayer]].TurnsReduction
	HDNMod.PlutiaActiveProductionDoll[iPlayer] = {
		["Type"] 		= iType,
		["TurnsLeft"]	= iTurns
	}
end
LuaEvents.VV_SetActiveProductionDoll.Add(SetActiveProductionDoll)


function UpgradeSewingKit(iPlayer)
	if not HDNMod.PlutiaSewingKits[iPlayer] then HDNMod.PlutiaSewingKits[iPlayer] = 1 end
	local iNewType = HDNMod.PlutiaSewingKits[iPlayer] + 1
	if tSewingKits[iNewType] then
		local pPlayer = Players[iPlayer]
		if pPlayer:GetGold() >= tSewingKits[iNewType].Cost then
			pPlayer:ChangeGold(-tSewingKits[iNewType].Cost)
			if HDNMod.PlutiaActiveProductionDoll[iPlayer] then
				HDNMod.PlutiaActiveProductionDoll[iPlayer].TurnsLeft = HDNMod.PlutiaActiveProductionDoll[iPlayer].TurnsLeft - (tSewingKits[iNewType].TurnsReduction - tSewingKits[HDNMod.PlutiaSewingKits[iPlayer]].TurnsReduction)
			end
			HDNMod.PlutiaSewingKits[iPlayer] = iNewType
		end
	end
end
LuaEvents.VV_UpgradeSewingKit.Add(UpgradeSewingKit)

--Put an already created doll in one of the four usage slots.
function SetActiveUseDoll(iPlayer, iDoll, sSlot)
	local doll = HDNMod.PlutiaReserveDolls[iPlayer][iDoll]
	if doll then
		if sSlot == "CUDDLE" then
			HDNMod.PlutiaCuddleDoll[iPlayer] =	{
				["Type"]		 	= doll,
				["Durability"]		= DOLL_DURABILITY_CUDDLE	
			}
		elseif sSlot == "STRESS" then
			HDNMod.PlutiaStressDoll[iPlayer] =	{
				["Type"]		 	= doll,
				["Durability"]		= DOLL_DURABILITY_STRESS	
			}
		elseif sSlot == "WEAPON" then
			WeaponDollHandler(iPlayer, true)
			HDNMod.PlutiaWeaponDoll[iPlayer] =	{
				["Type"]		 	= doll,
				["Durability"]		= DOLL_DURABILITY_WEAPON
			}
			WeaponDollHandler(iPlayer, false, true)
		elseif sSlot == "PLAYTIME" then
			HDNMod.PlutiaPlaytimeDoll[iPlayer] =	{
				["Type"]		 	= doll,
				["Durability"]		= DOLL_DURABILITY_PLAYTIME
			}
		end
	end
	table.remove(HDNMod.PlutiaReserveDolls[iPlayer], iDoll)
end
LuaEvents.VV_SetActiveUseDoll.Add(SetActiveUseDoll)

function ClearActiveUseDoll(iPlayer, sSlot)
	if sSlot == "CUDDLE" then
		HDNMod.PlutiaCuddleDoll[iPlayer] =	nil
	elseif sSlot == "STRESS" then
		HDNMod.PlutiaStressDoll[iPlayer] =	nil
	elseif sSlot == "WEAPON" then
		WeaponDollHandler(iPlayer, true)
		HDNMod.PlutiaWeaponDoll[iPlayer] =	nil
	elseif sSlot == "PLAYTIME" then
		HDNMod.PlutiaPlaytimeDoll[iPlayer] =	nil
	end
end

--Add a new doll to a player's inventory.
--If iType is not provided, it will grant one at random (will be used in Events & Decisions)
function AddNewDoll(iPlayer, iType)
	if not HDNMod.PlutiaReserveDolls[iPlayer] then HDNMod.PlutiaReserveDolls[iPlayer] = {} end
	if not iType then iType = Game.Rand(#tDolls, "Plutia Random Doll Roll") + 1 end
	HDNMod.PlutiaReserveDolls[iPlayer][#HDNMod.PlutiaReserveDolls[iPlayer] + 1] = iType
end
LuaEvents.PlutiaAddNewDoll.Add(AddNewDoll)


--Decrement or increment Plutia's nap time counter. (Negative numbers increase it.)
--Maintain Resistance in the Capital if still napping, if for whatever reason something else eliminated the capital's resistance.
--bForcedUp is used when Plutia's capital is captured, and causes Cuddle Dolls not to trigger.
function ChangeNapTimeTurns(iPlayer, iValue, bForcedUp)
	if not HDNMod.PlutiaNapTurns[iPlayer] then
		HDNMod.PlutiaNapTurns[iPlayer] = iValue
	else
		HDNMod.PlutiaNapTurns[iPlayer] = HDNMod.PlutiaNapTurns[iPlayer] + iValue
	end
	if HDNMod.PlutiaNapTurns[iPlayer] < 0 then HDNMod.PlutiaNapTurns[iPlayer] = 0 end
	
	local pPlayer = Players[iPlayer]
	if HDNMod.PlutiaNapTurns[iPlayer] == 0 then
		--Cuddle Doll bonus
		if HDNMod.PlutiaCuddleDoll[iPlayer] then
			local dolltype = tDolls[HDNMod.PlutiaCuddleDoll[iPlayer].Type].CuddleEffect
			tCuddleDollFunctions[dolltype.Function](iPlayer, dolltype.Data1 or 0, dolltype.Data2 or 0, dolltype.Data3 or 0)
			ChangeDollDurability(iPlayer, "CUDDLE", -1)
		end
		
		ChangeTurnsUntilNap(iPlayer, GetNapCountdownBase(iPlayer))
	else
		--ensure Resistance turns are equal to Nap turns
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iCurTurns = pCapital:GetResistanceTurns()
			if iCurTurns ~= HDNMod.PlutiaNapTurns[iPlayer] then
				pCapital:ChangeResistanceTurns(HDNMod.PlutiaNapTurns[iPlayer] - iCurTurns)
			end
		end
	end
end
LuaEvents.PlutiaChangeNapTimeTurns.Add(ChangeNapTimeTurns)


--Decrement or increment Plutia's countdown to a nap. (Negative numbers increase it.)
--When it hits 0, call ChangeNapTimeTurns automatically.
function ChangeTurnsUntilNap(iPlayer, iValue)
	if not HDNMod.PlutiaTurnsToNap[iPlayer] then
		HDNMod.PlutiaTurnsToNap[iPlayer] = GetNapCountdownBase(iPlayer)
	end
	
	HDNMod.PlutiaTurnsToNap[iPlayer] = HDNMod.PlutiaTurnsToNap[iPlayer] + iValue
	if HDNMod.PlutiaTurnsToNap[iPlayer] < 0 then HDNMod.PlutiaTurnsToNap[iPlayer] = 0 end
	
	if HDNMod.PlutiaTurnsToNap[iPlayer] == 0 then
		ChangeNapTimeTurns(iPlayer, GetNapLength(iPlayer))
	end
end
LuaEvents.PlutiaChangeTurnsUntilNap.Add(ChangeTurnsUntilNap)


--Get Food bonus from Daycare.
function GetDaycareFood(pCity)
	return DAYCARE_SCALES[math.floor((pCity:GetFood() / pCity:GrowthThreshold() * 100))] or 0
end

--Adjust the Food bonus for Daycares based on current stored Food amount.
function SetDaycareFood(pCity)
	local iValue = pCity:IsHasBuilding(DAYCARE) and GetDaycareFood(pCity) or 0
	pCity:SetNumRealBuilding(DAYCARE_DUMMY, iValue)
end


function SetDaycarePopBuildings(pCity)
	local sCity = CompileCityID(pCity)
	if HDNMod.PlutiaDaycare[sCity] then
		local tBuildings = {}
		--initialize every building found in the tDolls table to 0 buildings.
		for k, v in pairs(tDolls) do
			if v.Playtime and v.Playtime.Building then
				tBuildings[v.Playtime.Building] = 0
			end
		end
		--loop over every entry in HDNMod.PlutiaDaycare (each entry is made for every individual unit of population).
		--Add number of buildings based on the number of buildings each individual doll gives per pop.
		for k, v in pairs(HDNMod.PlutiaDaycare[sCity]) do
			for k2, v2 in pairs(v) do
				local doll = tDolls[v2]
				if doll and doll.Playtime then
					local pt = doll.Playtime
					if tBuildings[pt.Building] then
						tBuildings[pt.Building] = tBuildings[pt.Building] + (1 / pt.Pop)
					end
				end
			end
		end
		for k, v in pairs(tBuildings) do
			pCity:SetNumRealBuilding(k, math.floor(v))
		end
	end
end

function CanMakeDoll(iPlayer, iType)
	--returns two booleans: first makes it show in the list, second makes it available to produce
	if not tDolls[iType].Leader then
		return true, true
	elseif iPlayer == tDolls[iType].Leader then
		return false, false
	else
		local iTeam = Teams[Players[iPlayer]:GetTeam()]
		local pOtherPlayer = Players[tDolls[iType].Leader]
		if pOtherPlayer:IsAlive() and Teams[pOtherPlayer:GetTeam()]:IsHasMet(iTeam) then
			if pOtherPlayer:IsDoF(iPlayer) then
				return true, true
			else
				return true, false
			end
		else
			return false, false
		end
	end
end


function PersistentPolicyHandler(iPlayer, iProgressChange, iDurationChange)
	--iProgressChange changes the progress towards the next turn of retaining the policy.
	--iDurationChange changes the actual number of turns you keep the policy directly.
	if not iProgressChange then iProgressChange = 0 end
	if not iDurationChange then iDurationChange = 0 end
	local pPlayer = Players[iPlayer]
	if IsPlayerHDDMode(pPlayer) == true then
		if tPersistentPolicies[tPlutiaTraitLeaders[iPlayer]] then
			local thisTrait = tPersistentPolicies[tPlutiaTraitLeaders[iPlayer]]
			if not HDNMod.PersistentPolicies[iPlayer] then HDNMod.PersistentPolicies[iPlayer] = {} end
			local iDummy = GameInfo.Policies[thisTrait.Disabled].ID
			local iPolicy = GameInfo.Policies[thisTrait.Policy].ID
			
			if pPlayer:HasPolicy(iDummy) == false and pPlayer:HasPolicy(iPolicy) == false then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
			end
			pPlayer:SetHasPolicy(iPolicy, true)
			
			if not HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]] then HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]] = {} end
			if not HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Progress then HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Progress = iProgressChange
			else HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Progress = HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Progress + iProgressChange end
			
			if HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Progress >= thisTrait.TurnsNeeded then
				HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Progress = HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Progress - thisTrait.TurnsNeeded
				if not HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Turns then HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Turns = 1 
				else HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Turns  = HDNMod.PersistentPolicies[iPlayer][tPlutiaTraitLeaders[iPlayer]].Turns + 1 end
			end
			
		end
	elseif HDNMod.PersistentPolicies[iPlayer] then
		for k, v in pairs(HDNMod.PersistentPolicies[iPlayer]) do
			local thisTrait = tPersistentPolicies[k]
			if v.Turns and v.Turns > 0 then
				v.Turns = v.Turns + iDurationChange
				if v.Turns <= 0 then
					v.Turns = 0
					local iDummy = GameInfo.Policies[thisTrait.Disabled].ID
					local iPolicy = GameInfo.Policies[thisTrait.Policy].ID
					if pPlayer:HasPolicy(iDummy) == false and pPlayer:HasPolicy(iPolicy) == false then
						pPlayer:SetNumFreePolicies(1)
						pPlayer:SetNumFreePolicies(0)
					end
					pPlayer:SetHasPolicy(iPolicy, false)
					pPlayer:SetHasPolicy(iDummy, true)
				end
			end
		end
	end
end

function SetHappinessFromKills(iPlayer)
	local pPlayer = Players[iPlayer]
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then
		if tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].HappyKills ~= 0 then
			if not HDNMod.IrisKills[iPlayer] then HDNMod.IrisKills[iPlayer] = 0 end 
			HDNMod.IrisHappy[iPlayer] = math.floor(HDNMod.IrisKills[iPlayer] / tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].HappyKills)
		end

		pCapital:SetNumRealBuilding(HAPPY_DUMMY, HDNMod.IrisHappy[iPlayer] or 0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerDoTurn
---------------------------------------------------------------------------------------------------------------------------------------------------------


function OnPlayerDoTurnPlutia(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		if IsNapSystem(iPlayer) then
			--Are we napping? Or about to start one?
			if HDNMod.PlutiaNapTurns[iPlayer] and HDNMod.PlutiaNapTurns[iPlayer] > 0 then
				ChangeNapTimeTurns(iPlayer, -1)
			else
				ChangeTurnsUntilNap(iPlayer, -1)
			end
		end
			
		if IsDollSystem(iPlayer) then
			--Progress on current Doll
			if HDNMod.PlutiaActiveProductionDoll[iPlayer] then
				ChangeDollmakingProgress(iPlayer, 1)
			else
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_NO_DOLL_PRODUCED_TEXT"), Locale.ConvertTextKey("TXT_KEY_VV_PLUTIA_NO_DOLL_PRODUCED_TITLE"))
			end
			
			--AI Logic
			--For now, simplicity dictates to just make them work on and assign random dolls.
			if not pPlayer:IsHuman() then
				--Make a doll if not working on one
				local tMakeableDolls = {}
				if not HDNMod.PlutiaActiveProductionDoll[iPlayer] then
					local tMakeableDolls = {}
					for k, v in pairs(tDolls) do
						local bShow, bMake = CanMakeDoll(iPlayer, k)
						if bMake == true then
							tMakeableDolls[#tMakeableDolls + 1] = k
						end
					end
					if #tMakeableDolls > 0 then
						local iDoll = tMakeableDolls[Game.Rand(#tMakeableDolls, "Plutia AI Roll") + 1]
						SetActiveProductionDoll(iPlayer, iDoll)
					end
				end
				
				--Assign dolls to unused slots
				if HDNMod.PlutiaReserveDolls[iPlayer] and #HDNMod.PlutiaReserveDolls[iPlayer] > 0 then
					local function GetRandomDoll()
						return Game.Rand(#HDNMod.PlutiaReserveDolls[iPlayer], "Plutia AI Roll 2") + 1
					end
				
					if not HDNMod.PlutiaCuddleDoll[iPlayer] then
						SetActiveUseDoll(iPlayer, "CUDDLE", GetRandomDoll())
					elseif not HDNMod.PlutiaStressDoll[iPlayer] then
						SetActiveUseDoll(iPlayer, "STRESS", GetRandomDoll())
					elseif not HDNMod.PlutiaWeaponDoll[iPlayer] then
						SetActiveUseDoll(iPlayer, "WEAPON", GetRandomDoll())
					elseif not HDNMod.PlutiaPlaytimeDoll[iPlayer] then
						SetActiveUseDoll(iPlayer, "PLAYTIME", GetRandomDoll())
					end
				end
			end
		end
			
		if IsDollSystemUseOnly(iPlayer) then
			--Weapon Dolls
			WeaponDollHandler(iPlayer)
			
			--Stress Dolls
			if HDNMod.PlutiaStressDollDuration[iPlayer] then
				for k, v in pairs(HDNMod.PlutiaStressDollDuration[iPlayer]) do
					v = v - 1
					if v <= 0 then
						local dolltype = tDolls[k].StressEffect
						tStressDollEndFunctions[dolltype.Function](iPlayer, dolltype.Data1 or 0, dolltype.Data2 or 0, dolltype.Data3 or 0)
					end
				end
			end
			
			if HDNMod.PlutiaStressDoll[iPlayer] then
				for i = 0, iMaxCivs - 1, 1 do
					if i ~= iPlayer then
						local pLoop = Players[i]
						if pLoop:IsAlive() and pLoop:IsDenouncingPlayer(iPlayer) then
							print("Player "..i.." is denouncing player "..iPlayer..", who has a Stress Doll!")
							local dolltype = tDolls[HDNMod.PlutiaStressDoll[iPlayer].Type].StressEffect
							tStressDollFunctions[dolltype.Function](iPlayer, dolltype.Data1 or 0, dolltype.Data2 or 0, dolltype.Data3 or 0)
							ChangeDollDurability(iPlayer, "STRESS", -1)
							break
						end
					end
				end
			end
		end
		
		PersistentPolicyHandler(iPlayer, 1, -1)
		SetHappinessFromKills(iPlayer)
		
		if tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].BullyShares ~= 0 then
			local iChange = math.floor(HDNMod.Shares[iPlayer] / tPlutiaTraitValues[tPlutiaTraitLeaders[iPlayer]].BullyShares)
			if iChange > 0 then
				for i = iMaxCivs, GameDefines.MAX_CIV_PLAYERS, 1 do
					local pCityState = Players[i]
					if pCityState:IsAlive() and pCityState:CanMajorBullyGold(iPlayer) or pCityState:CanMajorBullyUnit(iPlayer) then
						pCityState:ChangeMinorCivFriendshipWithMajor(iPlayer, iChange)
					end
				end
			end
		end
		
		if IsDaycareUB(iPlayer) then
			for pCity in pPlayer:Cities() do
				SetDaycareFood(pCity)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurnPlutia)


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CityConstructed
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnCityConstructedPlutia(iPlayer, iCity, iBuildingType)
	if iBuildingType == DAYCARE then 
		local pPlayer = Players[iPlayer]
		local pCity = pPlayer:GetCityByID(iCity)
		SetDaycareFood(pCity)
	end
end
GameEvents.CityConstructed.Add(OnCityConstructedPlutia)


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- SetPopulation
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnSetPopulationPlutia(iX, iY, iOldPop, iNewPop)
	local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity()
	if pCity and pCity:IsHasBuilding(DAYCARE) then
		local iPlayer = pCity:GetOwner()
		local pPlayer = Players[iOwner]
		local sCity = CompileCityID(pCity)
		if not HDNMod.PlutiaDaycare[sCity] then HDNMod.PlutiaDaycare[sCity] = {} end
		local bReduced = (iOldPop > iNewPop) and true or false
		if bReduced then
			HDNMod.PlutiaDaycare[sCity][iOldPop] = nil
		else
			if IsDollSystemUseOnly(iPlayer) and HDNMod.PlutiaPlaytimeDoll[iPlayer] and HDNMod.PlutiaPlaytimeDoll[iPlayer].Type then
				HDNMod.PlutiaDaycare[sCity][iNewPop] = {
					HDNMod.PlutiaPlaytimeDoll[iPlayer].Type
				}
				ChangeDollDurability(iPlayer, "PLAYTIME", -1)
			end
		end
		SetDaycarePopBuildings(pCity)
	end
end
GameEvents.SetPopulation.Add(OnSetPopulationPlutia)

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CityCaptureComplete
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnCityCaptureCompletePlutia(iPlayer, bCapital, iX, iY)
	local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity()
	if pCity then
		local sCity = CompileCityID(pCity)
		HDNMod.PlutiaDaycare[sCity] = nil
	end
end
GameEvents.CityCaptureComplete.Add(OnCityCaptureCompletePlutia)

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CitySoldBuilding
--------------------------------------------------------------------------------------------------------------------------------------------------------
--Network Compatibility Trick
local PRODUCTION_SET_KEY = 64800
local CUDDLE_SET_KEY = 65800
local STRESS_SET_KEY = 66800
local WEAPON_SET_KEY = 67800
local PLAYTIME_SET_KEY = 68800


function OnCitySoldBuildingPlutia(iPlayer, iCity, iBuildingType)
	--Daycare
	if iBuildingType == DAYCARE then 
		local pPlayer = Players[iPlayer]
		local pCity = pPlayer:GetCityByID(iCity)
		if pCity then
			local sCity = CompileCityID(pCity)
			HDNMod.PlutiaDaycare[sCity] = nil
			SetDaycarePopBuildings(pCity)
		end
	--Network compatibility
	-- NOTE TO SELF: Seriously, do that NetSyncTool utility soon.
	elseif iBuildingType > PRODUCTION_SET_KEY and iBuildingType < CUDDLE_SET_KEY then
		local iDoll = iBuildingType - PRODUCTION_SET_KEY
		SetActiveProductionDoll(iPlayer, iDoll)
	elseif iBuildingType > CUDDLE_SET_KEY and iBuildingType < STRESS_SET_KEY then
		local iDoll = iBuildingType - CUDDLE_SET_KEY
		SetActiveUseDoll(iPlayer, iDoll, "CUDDLE")
	elseif iBuildingType > STRESS_SET_KEY and iBuildingType < WEAPON_SET_KEY then
		local iDoll = iBuildingType - STRESS_SET_KEY
		SetActiveUseDoll(iPlayer, iDoll, "STRESS")
	elseif iBuildingType > WEAPON_SET_KEY and iBuildingType < PLAYTIME_SET_KEY then
		local iDoll = iBuildingType - WEAPON_SET_KEY
		SetActiveUseDoll(iPlayer, iDoll, "WEAPON")
	elseif iBuildingType > PLAYTIME_SET_KEY and iBuildingType < (PLAYTIME_SET_KEY + 1000) then
		local iDoll = iBuildingType - PLAYTIME_SET_KEY
		SetActiveUseDoll(iPlayer, iDoll, "PLAYTIME")
	end
end
GameEvents.CitySoldBuilding.Add(OnCitySoldBuildingPlutia)

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- UnitKilledInCombat
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnUnitKilledInCombatPlutia(iWinner, iLoser, iUnitType)
	if iUnitType ~= ANIMATED_DOLL and IsDollSystemUseOnly(iLoser) and HDNMod.PlutiaWeaponDoll[iLoser] then
		local unit = GameInfo.Units[iUnitType]
		if unit.CombatClass and (unit.CombatClass == GameInfoTypes.UNITCOMBAT_GUN or unit.CombatClass == GameInfoTypes.UNITCOMBAT_MELEE) then
			ChangeDollDurability(iLoser, "WEAPON", -1)
		end
	end

	if tPlutiaTraitLeaders[iWinner] and tPlutiaTraitValues[tPlutiaTraitLeaders[iWinner]].HappyKills ~= 0 then
		if not HDNMod.IrisKills[iWinner] then HDNMod.IrisKills[iWinner] = 1 else HDNMod.IrisKills[iWinner] = HDNMod.IrisKills[iWinner] + 1 end
		SetHappinessFromKills(iWinner)
	end
	if tPlutiaTraitLeaders[iLoser] and tPlutiaTraitValues[tPlutiaTraitLeaders[iLoser]].HappyKills ~= 0 then
		if not HDNMod.IrisKills[iLoser] then HDNMod.IrisKills[iLoser] = 1 else HDNMod.IrisKills[iLoser] = HDNMod.IrisKills[iLoser] + 1 end
		SetHappinessFromKills(iLoser)
	end
end
GameEvents.UnitKilledInCombat.Add(OnUnitKilledInCombatPlutia)


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- SequenceGameInitComplete
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnGameInitCompletePlutia()
	for i = 0, iMaxCivs - 1, 1 do
		if not HDNMod.PlutiaSewingKits[i] then HDNMod.PlutiaSewingKits[i] = 1 end
	end
end
Events.SequenceGameInitComplete.Add(OnGameInitCompletePlutia)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- VV_ConvertHDNLeader
---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnTransformedPlutia(iPlayer, bHDDOn)
	CacheLeaderTraits(iPlayer)
	PersistentPolicyHandler(iPlayer)
end
LuaEvents.VV_ConvertHDNLeader.Add(OnTransformedPlutia)


function PlutiaTransformationAILogic(iPlayer)
	local bShouldTransform = false
	if HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD * 1.5 then
		local pPlayer = Players[iPlayer]
		--Transform if we're building a Wonder and have at least 20%.
		if not bShouldTransform and (HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD * 2) then
			for pCity in pPlayer:Cities() do
				local iBuilding = pCity:GetProductionBuilding()
				if GameInfo.Buildings[iBuilding] then
					local sBuildingClass = GameInfo.Buildings[iBuilding].BuildingClass
					if sBuildingClass and GameInfo.BuildingClasses[sBuildingClass] and GameInfo.BuildingClasses[sBuildingClass].MaxGlobalInstances == 1 then
						bShouldTransform = true
						break
					end
				end
			end
		end
	end
	return bShouldTransform
end

function IrisHeartTransformationAILogic(iPlayer)
	local bShouldRevert = true
	--Revert if not building any wonders.
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		local iBuilding = pCity:GetProductionBuilding()
		if GameInfo.Buildings[iBuilding] then
			local sBuildingClass = GameInfo.Buildings[iBuilding].BuildingClass
			if sBuildingClass and GameInfo.BuildingClasses[sBuildingClass] and GameInfo.BuildingClasses[sBuildingClass].MaxGlobalInstances == 1 then
				bShouldRevert = false
				break
			end
		end
	end
	return bShouldRevert
end
LuaEvents.VV_AddToTransformLogicTable(iPlutia, PlutiaTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iIrisHeart, IrisHeartTransformationAILogic)


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- USER INTERFACE
-- Most of this is handled in PlutiaDollPopup.
---------------------------------------------------------------------------------------------------------------------------------------------------------
ContextPtr:LoadNewContext("PlutiaDollPopup")


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- FLUFF
---------------------------------------------------------------------------------------------------------------------------------------------------------

--Unique Dialog Text for specific leaders.


local tNeptuneCivs = {
	["CIVILIZATION_PLANEPTUNE"] = true,
	["CIVILIZATION_VV_PLANEPTUNE"] = true,
	["CIVILIZATION_VV_PLANEPTUNE_PH"] = true
}

local tNepgearCivs = {
	["CIVILIZATION_VV_PLANEPTUNE_NG"] = true,
	["CIVILIZATION_VV_PLANEPTUNE_PS"] = true
}

local tNoireCivs = {
	["CIVILIZATION_LASTATION"] = true,
	["CIVILIZATION_VV_LASTATION"] = true,
	["CIVILIZATION_VV_LASTATION_ULTRA"] = true,
	["CIVILIZATION_VV_LASTATION_BH"] = true,
	["CIVILIZATION_VV_LASTATION_BH_ULTRA"] = true
}

local tHDNoireCivs = {
	["CIVILIZATION_LASTATION"] = true,
	["CIVILIZATION_VV_LASTATION"] = true,
	["CIVILIZATION_VV_LASTATION_BH"] = true
}

local tUDNoireCivs = {
	["CIVILIZATION_VV_LASTATION_ULTRA"] = true,
	["CIVILIZATION_VV_LASTATION_BH_ULTRA"] = true
}

local tUniCivs = {
	["CIVILIZATION_VV_LASTATION_UN"] = true,
	["CIVILIZATION_VV_LASTATION_PL_BS"] = true
}

local tVertCivs = {
	["CIVILIZATION_LEANBOX"] = true,
	["CIVILIZATION_VV_LEANBOX"] = true,
	["CIVILIZATION_VV_LEANBOX_GH"] = true,
	["CIVILIZATION_VV_LEANBOX_ULTRA"] = true,
	["CIVILIZATION_VV_LEANBOX_GH_ULTRA"] = true
}

local tBlancCivs = {
	["CIVILIZATION_LOWEE"] = true,
	["CIVILIZATION_VV_LOWEE"] = true,
	["CIVILIZATION_VV_LOWEE_WH"] = true,
	["CIVILIZATION_VV_LOWEE_ULTRA"] = true,
	["CIVILIZATION_VV_LOWEE_WH_ULTRA"] = true
}


include("UniqueDiplomacyUtilsV3.lua")

function PlutiaCharacterSpecificDialogText()
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	local pActivePlayer = Players[Game:GetActivePlayer()]
	local sCivilizationType = GameInfo.Civilizations[pActivePlayer:GetCivilizationType()].Type

	
	if tNeptuneCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_DOW_LAND%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_DOW_GENERIC%", "TXT_KEY_UD_VS_NEPTUNE_IRIS_HEART_DECLARES_WAR%")
	elseif tNoireCivs[sCivilizationType] then
		if tHDNoireCivs[sCivilizationType] then
			ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_HDNOIRE_IRIS_HEART_FIRSTGREETING%")
		else
			ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_UDNOIRE_IRIS_HEART_FIRSTGREETING%")
		end
	elseif tNepgearCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_IRIS_HEART_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_IRIS_HEART_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_IRIS_HEART_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_IRIS_HEART_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_IRIS_HEART_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_IRIS_HEART_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_IRIS_HEART_GREETING_HOSTILE%")
	elseif tUniCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_UNI_IRIS_HEART_FIRSTGREETING%")
	elseif tBlancCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_UDBLANC_IRIS_HEART_FIRSTGREETING%")
	elseif tVertCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_UDVERT_IRIS_HEART_FIRSTGREETING%")
	end
end


--If Neptune or Nepgear are in the game, Plutia's description is changed to differentiate.
function UpdatePlutiaCivDescriptions()
	local bIsNep;
	local iPlutiaPlayer;  --note: only one copy of Nepgear will get renamed to mk2 if there are multiples
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			local sCivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if tNeptuneCivs[sCivilizationType] or tNepgearCivs[sCivilizationType] then
				bIsNep = true
			elseif (pPlayer:GetCivilizationType() == iPlutiaCiv or pPlayer:GetCivilizationType() == iIrisHeartCiv) and not iPlutiaPlayer then
				iPlutiaPlayer = i
			end
		end
	end
	if bIsNep and iPlutiaPlayer then
		local pPlutia = Players[iPlutiaPlayer]
		if pPlutia:GetCivilizationShortDescription() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_PLANEPTUNE_PL_SHORT_DESC") then
			PreGame.SetCivilizationShortDescription(iPlutiaPlayer, "TXT_KEY_CIV_VV_PLANEPTUNE_PL_SHORT_DESC_ALT")
		end
		if pPlutia:GetCivilizationDescription() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_PLANEPTUNE_PL_DESC") then
			PreGame.SetCivilizationDescription(iPlutiaPlayer, "TXT_KEY_CIV_VV_PLANEPTUNE_PL_DESC_ALT")
		end
		if pPlutia:GetCivilizationAdjective() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_PLANEPTUNE_PL_ADJECTIVE") then
			PreGame.SetCivilizationAdjective(iPlutiaPlayer, "TXT_KEY_CIV_VV_PLANEPTUNE_PL_ADJECTIVE_ALT")
		end

		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_PLANEPTUNE_PL_DESC", "TXT_KEY_CIV_VV_PLANEPTUNE_PL_DESC_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_PLANEPTUNE_PL_SHORT_DESC", "TXT_KEY_CIV_VV_PLANEPTUNE_PL_SHORT_DESC_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_PLANEPTUNE_PL_ADJECTIVE", "TXT_KEY_CIV_VV_PLANEPTUNE_PL_ADJECTIVE_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE_PL", "TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE_PL_ALT")
		Locale.SetCurrentLanguage(Locale.GetCurrentLanguage().Type)
	end
end

function OnLoadScreenClosePlutiaText()
	--PlutiaCharacterSpecificDialogText()
	-- if not HDNMod.PlutiaTextInit then
		UpdatePlutiaCivDescriptions()
		-- HDNMod.PlutiaTextInit = true
	-- end
end

Events.LoadScreenClose.Add(OnLoadScreenClosePlutiaText)