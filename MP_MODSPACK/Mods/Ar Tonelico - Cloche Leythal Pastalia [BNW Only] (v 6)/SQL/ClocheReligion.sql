----------------------------------------------------------------------------------------------------------------------------
--Religion
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO Religions
			(Type,					Description,					Civilopedia,						IconAtlas,					PortraitIndex,		IconString)
VALUES		('RELIGION_CLOCHE_AQUA',	'TXT_KEY_RELIGION_CLOCHE_AQUA',	'TXT_KEY_RELIGION_CLOCHE_AQUA_PEDIA',	'RELIGION_ATLAS_CLOCHE_AQUA',	0,					'[ICON_CLOCHE_AQUA_RELIGION]');

----------------------------------------------------------------------------------------------------------------------------
-- Religion Sounds
----------------------------------------------------------------------------------------------------------------------------
UPDATE Religions SET JFD_ReligionTheme = 'AS2D_CLOCHE_AQUA' WHERE Type = 'RELIGION_CLOCHE_AQUA';