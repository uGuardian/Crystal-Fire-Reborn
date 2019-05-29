-- JFD_SharedEvents
-- Author: JFD
--=======================================================================================================================
print("JFD's CulDiV Shared Events: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
include("EventsAndDecisions_Utilities")
include("JFD_CulDivUtilities")
include("JFD_CulDivSettings")
include("JFD_PietyUtils")
--=======================================================================================================================
-- Civ Specific Events
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local myth = nil
--------------------------------------------------------------------------------------------------------------------------
-- RawSasquatchAppeared
--------------------------------------------------------------------------------------------------------------------------
local Event_JFDCulDivRawSasquatchAppeared = {}
	Event_JFDCulDivRawSasquatchAppeared.Name = "TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST"
	Event_JFDCulDivRawSasquatchAppeared.Desc = "TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_DESC"
	Event_JFDCulDivRawSasquatchAppeared.Weight = 1
	Event_JFDCulDivRawSasquatchAppeared.CanFunc = (
		function(player)			
			if g_JFDMythicalEvent ~= 1 then return false end
			if load(player, "Event_JFDCulDivRawSasquatchAppeared") == true then return false end

			local cultureGroup = JFD_GetCultureType(player:GetID())
			local mythicalBeasts = {}
				mythicalBeasts["JFD_Andean"]			=	{[1]="TXT_KEY_JFD_MYTH_ANDEAN",			[2]="TXT_KEY_JFD_MYTH_ANDEAN_2",			[3]="TXT_KEY_JFD_MYTH_ANDEAN_3",			[4]="TXT_KEY_JFD_MYTH_ANDEAN_4",			[5]="TXT_KEY_JFD_MYTH_ANDEAN_5",		[6]="TXT_KEY_JFD_MYTH_ANDEAN_6",		[7]="TXT_KEY_JFD_MYTH_ANDEAN_6",			[8]="TXT_KEY_JFD_MYTH_ANDEAN_6"}
				mythicalBeasts["JFD_Bantu"]				=	{[1]="TXT_KEY_JFD_MYTH_BANTU",			[2]="TXT_KEY_JFD_MYTH_BANTU_2",				[3]="TXT_KEY_JFD_MYTH_BANTU_3",				[4]="TXT_KEY_JFD_MYTH_BANTU_4"}
				mythicalBeasts["JFD_Bharata"]			=	{[1]="TXT_KEY_JFD_MYTH_BHARATA",		[2]="TXT_KEY_JFD_MYTH_BHARATA_2",			[3]="TXT_KEY_JFD_MYTH_BHARATA_3"}
				mythicalBeasts["JFD_Central"]			=	{[1]="TXT_KEY_JFD_MYTH_CENTRAL",		[2]="TXT_KEY_JFD_MYTH_CENTRAL_2",			[3]="TXT_KEY_JFD_MYTH_CENTRAL_3",			[4]="TXT_KEY_JFD_MYTH_CENTRAL_4",			[5]="TXT_KEY_JFD_MYTH_CENTRAL_5",		[6]="TXT_KEY_JFD_MYTH_CENTRAL_6",		[7]="TXT_KEY_JFD_MYTH_CENTRAL_7"}
				mythicalBeasts["JFD_Colonial"]			=	{[1]="TXT_KEY_JFD_MYTH_COLONIAL",		[2]="TXT_KEY_JFD_MYTH_COLONIAL_2",			[3]="TXT_KEY_JFD_MYTH_COLONIAL_3",			[4]="TXT_KEY_JFD_MYTH_COLONIAL_4",			[5]="TXT_KEY_JFD_MYTH_COLONIAL_5",		[6]="TXT_KEY_JFD_MYTH_COLONIAL_6",		[7]="TXT_KEY_JFD_MYTH_COLONIAL_7", 			[8]="TXT_KEY_JFD_MYTH_COLONIAL_8",		[9]="TXT_KEY_JFD_MYTH_COLONIAL_9",	[12]="TXT_KEY_JFD_MYTH_COLONIAL_12",	[11]="TXT_KEY_JFD_MYTH_COLONIAL_11"}
				mythicalBeasts["JFD_Eastern"]			=	{[1]="TXT_KEY_JFD_MYTH_EASTERN",		[2]="TXT_KEY_JFD_MYTH_EASTERN_2",			[3]="TXT_KEY_JFD_MYTH_EASTERN_3",			[4]="TXT_KEY_JFD_MYTH_EASTERN_4",			[5]="TXT_KEY_JFD_MYTH_EASTERN_5"}
				mythicalBeasts["JFD_Islamic"]			=	{[1]="TXT_KEY_JFD_MYTH_ISLAMIC",		[2]="TXT_KEY_JFD_MYTH_ISLAMIC_2",			[3]="TXT_KEY_JFD_MYTH_ISLAMIC_3",			[4]="TXT_KEY_JFD_MYTH_ISLAMIC_4",			[5]="TXT_KEY_JFD_MYTH_ISLAMIC_5"}
				mythicalBeasts["JFD_Mandala"]			=	{[1]="TXT_KEY_JFD_MYTH_MANDALA",		[2]="TXT_KEY_JFD_MYTH_MANDALA_2",			[3]="TXT_KEY_JFD_MYTH_MANDALA_3"}
				mythicalBeasts["JFD_Mediterranean"]		=	{[1]="TXT_KEY_JFD_MYTH_MEDITERRANEAN",	[2]="TXT_KEY_JFD_MYTH_MEDITERRANEAN_2",		[3]="TXT_KEY_JFD_MYTH_MEDITERRANEAN_3",		[4]="TXT_KEY_JFD_MYTH_MEDITERRANEAN_4",		[5]="TXT_KEY_JFD_MYTH_MEDITERRANEAN_5"}
				mythicalBeasts["JFD_Mesoamerican"]		=	{[1]="TXT_KEY_JFD_MYTH_MESOAMERICAN",   [2]="TXT_KEY_JFD_MYTH_MESOAMERICAN_2"}
				mythicalBeasts["JFD_Mesopotamic"]		=	{[1]="TXT_KEY_JFD_MYTH_MESOPOTAMIC",	[2]="TXT_KEY_JFD_MYTH_MESOPOTAMIC_2",		[3]="TXT_KEY_JFD_MYTH_MESOPOTAMIC_3"}
				mythicalBeasts["JFD_Northern"]			=	{[1]="TXT_KEY_JFD_MYTH_NORTHERN",		[2]="TXT_KEY_JFD_MYTH_NORTHERN_2",			[3]="TXT_KEY_JFD_MYTH_NORTHERN_3",			[4]="TXT_KEY_JFD_MYTH_NORTHERN_4",			[5]="TXT_KEY_JFD_MYTH_NORTHERN_5",		[6]="TXT_KEY_JFD_MYTH_NORTHERN_6",		[7]="TXT_KEY_JFD_MYTH_NORTHERN_7",			[8]="TXT_KEY_JFD_MYTH_NORTHERN_8"}
				mythicalBeasts["JFD_Oceanic"]			=	{[1]="TXT_KEY_JFD_MYTH_OCEANIC",		[2]="TXT_KEY_JFD_MYTH_OCEANIC_2",			[3]="TXT_KEY_JFD_MYTH_OCEANIC_3",			[4]="TXT_KEY_JFD_MYTH_OCEANIC_4"}
				mythicalBeasts["JFD_Oriental"]			=	{[1]="TXT_KEY_JFD_MYTH_ORIENTAL",		[2]="TXT_KEY_JFD_MYTH_ORIENTAL_2",			[3]="TXT_KEY_JFD_MYTH_ORIENTAL_3",			[4]="TXT_KEY_JFD_MYTH_ORIENTAL_4",			[5]="TXT_KEY_JFD_MYTH_ORIENTAL_5"}
				mythicalBeasts["JFD_Semitic"]			=	{[1]="TXT_KEY_JFD_MYTH_SEMITIC"}
				mythicalBeasts["JFD_Steppe"]			=	{[1]="TXT_KEY_JFD_MYTH_STEPPE",			[2]="TXT_KEY_JFD_MYTH_STEPPE_2",			[3]="TXT_KEY_JFD_MYTH_STEPPE_3"}
				mythicalBeasts["JFD_Totalitarian"]		=	{[1]="TXT_KEY_JFD_MYTH_TOTALITARIAN"}
				mythicalBeasts["JFD_TribalAmerican"]	=	{[1]="TXT_KEY_JFD_MYTH_TRIBALAMERICAN", [2]="TXT_KEY_JFD_MYTH_TRIBALAMERICAN_2",	[3]="TXT_KEY_JFD_MYTH_TRIBALAMERICAN_3",	[4]="TXT_KEY_JFD_MYTH_TRIBALAMERICAN_4",	[5]="TXT_KEY_JFD_MYTH_TRIBALAMERICAN_5"}
				mythicalBeasts["JFD_WestAfrican"]		=	{[1]="TXT_KEY_JFD_MYTH_WESTAFRICAN",	[2]="TXT_KEY_JFD_MYTH_WESTAFRICAN_2"}
				mythicalBeasts["JFD_Western"]			=	{[1]="TXT_KEY_JFD_MYTH_WESTERN",		[2]="TXT_KEY_JFD_MYTH_WESTERN_2",			[3]="TXT_KEY_JFD_MYTH_WESTERN_3",			[4]="TXT_KEY_JFD_MYTH_WESTERN_4",			[5]="TXT_KEY_JFD_MYTH_WESTERN_5",		[6]="TXT_KEY_JFD_MYTH_WESTERN_6",		[7]="TXT_KEY_JFD_MYTH_WESTERN_7"}
				--Vicevirtuoso
				mythicalBeasts["JFD_Madoka"]			=	{[1]="TXT_KEY_JFD_MYTH_MADOKA", [2]="TXT_KEY_JFD_MYTH_MADOKA_2"}

			local randomMyth = GetRandom(1, #mythicalBeasts[cultureGroup])
			myth = mythicalBeasts[cultureGroup][randomMyth]	

			if myth == nil then return false end
			
			local cities = {}
			local cityID = nil

			local count = 1
			for city in player:Cities() do
				cities[count] = city:GetID()
				count = count + 1
			end

			cityID = cities[GetRandom(1, #cities)]
			if cityID == nil then return false end
			
			local desc = Locale.ConvertTextKey(myth .. "_DESC", player:GetCityByID(cityID):GetName())

			Event_JFDCulDivRawSasquatchAppeared.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_DESC", desc)
			return true
		end
		)
	Event_JFDCulDivRawSasquatchAppeared.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[1] = {}
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_OUTCOME_1"
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_OUTCOME_RESULT_1"
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[1].CanFunc = (
		function(player)	
			local button = myth .. "_BUTTON"

			Event_JFDCulDivRawSasquatchAppeared.Outcomes[1].Name = Locale.ConvertTextKey(button)
			Event_JFDCulDivRawSasquatchAppeared.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			player:ChangeGoldenAgeTurns(10)

			local notification = Locale.ConvertTextKey(myth .. "_NOTIFICATION")
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey(notification), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_CULDIV_MYTHICAL_BEAST", myth, player:GetCivilizationShortDescription())) 
			save(player, "Event_JFDCulDivRawSasquatchAppeared", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[2] = {}
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_OUTCOME_2"
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_OUTCOME_RESULT_2"
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[2].CanFunc = (
		function(player)	
			local playerID = player:GetID()
			local reward = math.ceil(50 * iMod)
			local yield = "[ICON_PEACE] Faith"
			if JFD_IsUsingPietyPrestige() then
				if JFD_HasStateReligion(playerID) then
					yield = "[ICON_JFD_PIETY] Piety"
					reward = math.ceil(10 * iMod)
				end
			end

			Event_JFDCulDivRawSasquatchAppeared.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_OUTCOME_RESULT_2", reward, yield)
			return true
		end
		)
	Event_JFDCulDivRawSasquatchAppeared.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local reward = math.ceil(50 * iMod)
			if JFD_IsUsingPietyPrestige() then
				if JFD_HasStateReligion(playerID) then
					reward = math.ceil(10 * iMod)
					JFD_ChangePiety(playerID, reward)
				end
			else
				player:ChangeFaith(reward)
			end			

			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST_NOTIFICATION", myth), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_CULDIV_MYTHICAL_BEAST"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_CULDIV_MYTHICAL_BEAST", myth, player:GetCivilizationShortDescription())) 
			save(player, "Event_JFDCulDivRawSasquatchAppeared", true)
		end)

tEvents.Event_JFDCulDivRawSasquatchAppeared = Event_JFDCulDivRawSasquatchAppeared
--=======================================================================================================================
--=======================================================================================================================


