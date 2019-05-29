ContextPtr:SetHide(true)

include( "InstanceManager" );
g_HelpInstance = InstanceManager:new("HelpInstance", "HelpLabel", Controls.Stack)

function ConvertToPercentString(value, tenthousandths)
	if not value then value = 0 end
	value = value / 100
	if tenthousandths then
		return string.format("%.4f%%", value)
	else
		return string.format("%.2f%%", value)
	end
end

function BuildHelpString()
	g_HelpInstance:ResetInstances()
	local instance = g_HelpInstance:GetInstance()
	local sText = "";
	local function MakeGreen(text)
		return "[COLOR_POSITIVE_TEXT]"..text.."[ENDCOLOR]"
	end

	local function LineBreaks(text)
		return text.."[NEWLINE][NEWLINE]"
	end

	--Title
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_TITLE")))
	sText = sText..LineBreaks(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_MAIN", ConvertToPercentString(GameDefines.VV_HDN_HDD_SHARE_LOSS_PER_TURN)))
	--Religion
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_RELIGION_TITLE")))
	sText = sText..LineBreaks(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_RELIGION_TEXT", ConvertToPercentString(GameDefines.VV_HDN_RELIGION_FOLLOWER_SHARES, true)))
	--Buildings
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_BUILDINGS_TITLE")))
	sText = sText..Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_BUILDINGS_TEXT")
	for row in GameInfo.Buildings() do
		if row.VV_SharesChange ~= 0 then
			sText = sText.."[NEWLINE]"..Locale.ConvertTextKey(row.Description).." ("..ConvertToPercentString(row.VV_SharesChange).." / "..ConvertToPercentString(row.VV_SharesChangeOthers)..")"
		end
	end
	sText = LineBreaks(sText)
	--Improvements
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_IMPROVEMENTS_TITLE")))
	sText = sText..Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_IMPROVEMENTS_TEXT")
	for row in GameInfo.Improvements() do
		if row.VV_SharesChange ~= 0 then
			sText = sText.."[NEWLINE]"..Locale.ConvertTextKey(row.Description).." ("..ConvertToPercentString(row.VV_SharesChange).." / "..ConvertToPercentString(row.VV_SharesChangeOthers)..")"
		end
	end
	sText = LineBreaks(sText)
	--Production
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_PRODUCTION_TITLE")))
	local sTech = Locale.ConvertTextKey(GameInfo.Technologies[GameInfo.Processes["PROCESS_VV_HDN_SHARES"].TechPrereq].Description)
	sText = sText..LineBreaks(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_PRODUCTION_TEXT", sTech, GameDefines.VV_HDN_SHARE_PROCESS_MULTIPLIER))
	--Happiness
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_HAPPINESS_TITLE")))
	sText = sText..LineBreaks(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_HAPPINESS_TEXT", ConvertToPercentString(GameDefines.VV_HDN_HAPPINESS_SHARES, true), ConvertToPercentString(GameDefines.VV_HDN_UNHAPPINESS_SHARES)))
	--Tourism
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_TOURISM_TITLE")))
	sText = sText..LineBreaks(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_TOURISM_TEXT", ConvertToPercentString(GameDefines.VV_HDN_INFLUENCE_SHARES)))
	--Combat
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_MILITARY_TITLE")))
	sText = sText..LineBreaks(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_MILITARY_TEXT", ConvertToPercentString(GameDefines.VV_HDN_BARBARIAN_KILL_SHARES), ConvertToPercentString(GameDefines.VV_HDN_OTHERS_KILL_SHARES), ConvertToPercentString(GameDefines.VV_HDN_OTHERS_LOSS_SHARES), ConvertToPercentString(GameDefines.VV_HDN_NEPTUNIA_KILL_SHARES), ConvertToPercentString(GameDefines.VV_HDN_CITY_CAPTURE_SHARES)))
	--Traits
	sText = sText..LineBreaks(MakeGreen(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_UA_TITLE")))
	sText = sText..LineBreaks(Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP_UA_TEXT"))
	
	instance.HelpLabel:SetText(sText)
	-- Controls.HelpLabel:SetText(sText)
	Controls.Stack:CalculateSize()
	Controls.Stack:ReprocessAnchoring()
	Controls.ScrollPanel:CalculateInternalSize()
end

Events.LoadScreenClose.Add(BuildHelpString)

function OnOK()
	ContextPtr:SetHide(true)
end
Controls.OK:RegisterCallback(Mouse.eLClick, OnOK)

function OnDiploCornerPopup()
	ContextPtr:SetHide(false)
end

function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
  table.insert(additionalEntries, {
    text=Locale.ConvertTextKey("TXT_KEY_VV_HDN_SHARES_HELP"), 
    call=OnDiploCornerPopup
  })
end
LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()