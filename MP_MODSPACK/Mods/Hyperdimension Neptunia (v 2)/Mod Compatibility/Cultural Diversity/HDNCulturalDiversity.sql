CREATE TABLE IF NOT EXISTS 
JFD_CultureTypes(
	ID  									integer 							   primary key autoincrement,
	Type 									text												default null,
	ShortDescription						text												default null,
	DefaultArtDefineTag						text												default null,
	DefaultSoundtrackTag					text												default null,
	DefaultSplashScreenTag					text												default null,
	DefaultUnitDialogueTag					text												default null,
	StartDistance							integer												default	0,
	FontIcon								text												default	null,
	IconAtlas								text		REFERENCES IconTextureAtlases(Atlas)	default	null,
	IconAlphaAtlas							text		REFERENCES IconTextureAtlases(Atlas)	default	null,
	PortraitIndex							integer												default	0,
	AlphaIndex								integer												default	0,
	EmbarkationArtDefineEarly				text												default	null,
	EmbarkationArtDefineMid					text												default	null);

CREATE TABLE IF NOT EXISTS 
JFD_CultureTypes_MythicEvents(
	CultureType 							text												default null,
	Description								text												default null);

CREATE TABLE IF NOT EXISTS 
JFD_CultureTypes_StartingBonuses(
	CultureType 								text 	 										default null,
	Description 								text											default null,
	FreeBuilding								text	REFERENCES BuildingClasses(Type)		default	null,
	FreeBuildingAND								text	REFERENCES BuildingClasses(Type)		default	null,
	FreeCulture									integer											default	0,
	FreeFaith									integer											default	0,
	FreeGold									integer											default	0,
	FreePolicyBranch							text	REFERENCES PolicyBranchTypes(Type)		default	null,
	FreePolicy									text	REFERENCES Policies(Type)				default	null,
	FreePopulation								integer											default	0,
	FreeResource								text	REFERENCES Resources(Type)				default	null,
	FreeResourceCount							integer											default	0,
	FreeResourceImprovement						text	REFERENCES Improvements(Type)			default	null,
	FreeSettlerPromotion						text	REFERENCES UnitPromotions(Type)			default	null,
	FreeTech									text	REFERENCES Technologies(Type)			default	null,
	FreeUnit									text	REFERENCES UnitClasses(Type)			default	null,
	FreeUnitCount								integer											default	0,
	FreeUnitMoves								integer											default	0,
	FreeUnitPromotion							text	REFERENCES UnitPromotions(Type)			default	null,
	FreeUnitXP									integer											default	0,
	FreeWLTKDTurns								integer											default	0,
	NearbyLandsClaim							boolean											default 0,
	NearbyLandsVisible							integer											default 0);

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null);



INSERT INTO JFD_CultureTypes
			(Type,					ShortDescription,							DefaultSoundtrackTag,		DefaultSplashScreenTag,		DefaultUnitDialogueTag,				
			StartDistance,	EmbarkationArtDefineEarly,				EmbarkationArtDefineMid,				FontIcon,								IconAtlas, 
			IconAlphaAtlas, 						PortraitIndex,	AlphaIndex)
VALUES		('JFD_Gamindustri',		'TXT_KEY_JFD_NEPTUNIA_SHORT_DESC',			'JFD_Gamindustri',			'JFD_Gamindustri',			'AS2D_SOUND_JFD_JAPANESE',
			25,				'ART_DEF_UNIT_GALLEY',					'ART_DEF_UNIT_GALLEON',					'[ICON_JFD_CULTURE_GAMINDUSTRI]', 		'VV_HDN_CULTURAL_DIVERSITY_ATLAS',
			'VV_HDN_CULTURAL_DIVERSITY_ALPHA',		0,				0);

UPDATE Civilizations 
SET SoundtrackTag = 'NEPTUNIA'
WHERE Type IN (SELECT DefaultSoundtrackTag FROM JFD_CultureTypes WHERE DefaultSoundtrackTag = 'JFD_Gamindustri')
AND EXISTS (SELECT * FROM Audio_2DSounds WHERE Type = 'SND_NEPTUNIA_PEACE_1');

CREATE TRIGGER HDNCulDivSoundtrack
AFTER INSERT ON Civilization_JFD_CultureTypes
WHEN NEW.SoundtrackTag = 'JFD_Gamindustri'
BEGIN
	UPDATE Civilizations 
	SET SoundtrackTag = 'NEPTUNIA'
	WHERE Type = NEW.CivilizationType
	AND EXISTS (SELECT * FROM Audio_2DSounds WHERE Type = 'SND_NEPTUNIA_PEACE_1');
END;

INSERT INTO	JFD_CultureTypes_MythicEvents
						(CultureType,		Description)
VALUES					('JFD_Gamindustri',	'TXT_KEY_JFD_MYTH_NEPTUNIA_1'),
						('JFD_Gamindustri',	'TXT_KEY_JFD_MYTH_NEPTUNIA_2');


INSERT INTO JFD_CultureTypes_StartingBonuses
			(CultureType,		Description)
VALUES		('JFD_Gamindustri',	'TXT_KEY_JFD_DAWN_NEPTUNIA_BONUSES');

INSERT INTO IconFontTextures 
		(IconFontTexture, 							IconFontTextureFile)
VALUES	('ICON_FONT_TEXTURE_JFD_GAMINDUSTRI',		'VVHDNCulDivFontIcon');

INSERT INTO IconFontMapping 
		(IconName, 									IconFontTexture,							IconMapping)
VALUES	('ICON_JFD_CULTURE_GAMINDUSTRI',			'ICON_FONT_TEXTURE_JFD_GAMINDUSTRI',		1);

INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 							IconsPerRow, 	IconsPerColumn)
VALUES	('VV_HDN_CULTURAL_DIVERSITY_ATLAS', 		256, 		'VVHDNCulDivAtlas256.dds',			1, 				1),
		('VV_HDN_CULTURAL_DIVERSITY_ATLAS', 		128, 		'VVHDNCulDivAtlas128.dds',			1, 				1),
		('VV_HDN_CULTURAL_DIVERSITY_ATLAS', 		80, 		'VVHDNCulDivAtlas80.dds',			1, 				1),
		('VV_HDN_CULTURAL_DIVERSITY_ATLAS', 		64, 		'VVHDNCulDivAtlas64.dds',			1, 				1),
		('VV_HDN_CULTURAL_DIVERSITY_ATLAS', 		45, 		'VVHDNCulDivAtlas45.dds',			1, 				1),
		('VV_HDN_CULTURAL_DIVERSITY_ALPHA', 		32, 		'VVHDNCulDivAlpha32.dds',			1, 				1);