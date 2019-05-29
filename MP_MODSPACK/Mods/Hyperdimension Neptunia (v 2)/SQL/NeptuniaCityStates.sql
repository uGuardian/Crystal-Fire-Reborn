INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,					Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_3DO'),		('TXT_KEY_MINOR_CIV_HDN_3DO'),		('TXT_KEY_MINOR_CIV_HDN_3DO'),	('TXT_KEY_MINOR_CIV_HDN_3DO_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_3DO_PEDIA'),
			('PLAYERCOLOR_MINOR_GRAY'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MARITIME')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);

INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_PIPPIN'),	('TXT_KEY_MINOR_CIV_HDN_PIPPIN'),	('TXT_KEY_MINOR_CIV_HDN_PIPPIN'),	('TXT_KEY_MINOR_CIV_HDN_PIPPIN_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_PIPPIN_PEDIA'),
			('PLAYERCOLOR_MINOR_WHITE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_CULTURED')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);

INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_OUYA'),	('TXT_KEY_MINOR_CIV_HDN_OUYA'),	('TXT_KEY_MINOR_CIV_HDN_OUYA'),	('TXT_KEY_MINOR_CIV_HDN_OUYA_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_OUYA_PEDIA'),
			('PLAYERCOLOR_MINOR_LIGHT_ORANGE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_RELIGIOUS')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);

INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_PHANTOM'),	('TXT_KEY_MINOR_CIV_HDN_PHANTOM'),	('TXT_KEY_MINOR_CIV_HDN_PHANTOM'),	('TXT_KEY_MINOR_CIV_HDN_PHANTOM_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_PHANTOM_PEDIA'),
			('PLAYERCOLOR_MINOR_MIDDLE_CYAN'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MILITARISTIC')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);


INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_CD-I'),	('TXT_KEY_MINOR_CIV_HDN_CD-I'),	('TXT_KEY_MINOR_CIV_HDN_CD-I'),	('TXT_KEY_MINOR_CIV_HDN_CD-I_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_CD-I_PEDIA'),
			('PLAYERCOLOR_MINOR_GRAY'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MERCANTILE')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);


INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_N-GAGE'),	('TXT_KEY_MINOR_CIV_HDN_N-GAGE'),	('TXT_KEY_MINOR_CIV_HDN_N-GAGE'),	('TXT_KEY_MINOR_CIV_HDN_N-GAGE_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_N-GAGE_PEDIA'),
			('PLAYERCOLOR_MINOR_LIGHT_ORANGE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_CULTURED')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);


INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_CHANNEL_F'),	('TXT_KEY_MINOR_CIV_HDN_CHANNEL_F'),	('TXT_KEY_MINOR_CIV_HDN_CHANNEL_F'),	('TXT_KEY_MINOR_CIV_HDN_CHANNEL_F_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_CHANNEL_F_PEDIA'),
			('PLAYERCOLOR_MINOR_DARK_LEMON'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MERCANTILE')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);


INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_COLECOVISION'),	('TXT_KEY_MINOR_CIV_HDN_COLECOVISION'),	('TXT_KEY_MINOR_CIV_HDN_COLECOVISION'),	('TXT_KEY_MINOR_CIV_HDN_COLECOVISION_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_COLECOVISION_PEDIA'),
			('PLAYERCOLOR_MINOR_LIGHT_BLUE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MILITARISTIC')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);


INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_ASTROCADE'),	('TXT_KEY_MINOR_CIV_HDN_ASTROCADE'),	('TXT_KEY_MINOR_CIV_HDN_ASTROCADE'),	('TXT_KEY_MINOR_CIV_HDN_ASTROCADE_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_ASTROCADE_PEDIA'),
			('PLAYERCOLOR_MINOR_DARK_LEMON'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_RELIGIOUS')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);


INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_IMAGINATION'),	('TXT_KEY_MINOR_CIV_HDN_IMAGINATION'),	('TXT_KEY_MINOR_CIV_HDN_IMAGINATION'),	('TXT_KEY_MINOR_CIV_HDN_IMAGINATION_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_IMAGINATION_PEDIA'),
			('PLAYERCOLOR_MINOR_PURPLE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MARITIME')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);




INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_VECTREX'),	('TXT_KEY_MINOR_CIV_HDN_VECTREX'),	('TXT_KEY_MINOR_CIV_HDN_VECTREX'),	('TXT_KEY_MINOR_CIV_HDN_VECTREX_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_VECTREX_PEDIA'),
			('PLAYERCOLOR_MINOR_BLUE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MERCANTILE')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_TELSTAR'),	('TXT_KEY_MINOR_CIV_HDN_TELSTAR'),	('TXT_KEY_MINOR_CIV_HDN_TELSTAR'),	('TXT_KEY_MINOR_CIV_HDN_TELSTAR_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_TELSTAR_PEDIA'),
			('PLAYERCOLOR_MINOR_YELLOW'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_CULTURED')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_ODYSSEY'),	('TXT_KEY_MINOR_CIV_HDN_ODYSSEY'),	('TXT_KEY_MINOR_CIV_HDN_ODYSSEY'),	('TXT_KEY_MINOR_CIV_HDN_ODYSSEY_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_ODYSSEY_PEDIA'),
			('PLAYERCOLOR_MINOR_GOLDENROD'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_RELIGIOUS')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_INTELLIVISION'),	('TXT_KEY_MINOR_CIV_HDN_INTELLIVISION'),	('TXT_KEY_MINOR_CIV_HDN_INTELLIVISION'),	('TXT_KEY_MINOR_CIV_HDN_INTELLIVISION_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_INTELLIVISION_PEDIA'),
			('PLAYERCOLOR_MINOR_PEACH'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MILITARISTIC')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_ARCADIA'),	('TXT_KEY_MINOR_CIV_HDN_ARCADIA'),	('TXT_KEY_MINOR_CIV_HDN_ARCADIA'),	('TXT_KEY_MINOR_CIV_HDN_ARCADIA_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_ARCADIA_PEDIA'),
			('PLAYERCOLOR_MINOR_MIDDLE_BLUE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MARITIME')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_NEO-GEO'),	('TXT_KEY_MINOR_CIV_HDN_NEO-GEO'),	('TXT_KEY_MINOR_CIV_HDN_NEO-GEO'),	('TXT_KEY_MINOR_CIV_HDN_NEO-GEO_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_NEO-GEO_PEDIA'),
			('PLAYERCOLOR_MINOR_YELLOW'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_ASIAN'),	('_ASIA'),		('ASIAN'),	('MINOR_TRAIT_MILITARISTIC')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_LASERACTIVE'),	('TXT_KEY_MINOR_CIV_HDN_LASERACTIVE'),	('TXT_KEY_MINOR_CIV_HDN_LASERACTIVE'),	('TXT_KEY_MINOR_CIV_HDN_LASERACTIVE_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_LASERACTIVE_PEDIA'),
			('PLAYERCOLOR_MINOR_LIGHT_YELLOW'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MARITIME')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_MARTY'),	('TXT_KEY_MINOR_CIV_HDN_MARTY'),	('TXT_KEY_MINOR_CIV_HDN_MARTY'),	('TXT_KEY_MINOR_CIV_HDN_MARTY_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_MARTY_PEDIA'),
			('PLAYERCOLOR_MINOR_WHITE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_ASIAN'),	('_ASIA'),		('ASIAN'),			('MINOR_TRAIT_MERCANTILE')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_SHIELD'),	('TXT_KEY_MINOR_CIV_HDN_SHIELD'),	('TXT_KEY_MINOR_CIV_HDN_SHIELD'),	('TXT_KEY_MINOR_CIV_HDN_SHIELD_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_SHIELD_PEDIA'),
			('PLAYERCOLOR_MINOR_LIGHT_GREEN'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_RELIGIOUS')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_HALCYON'),	('TXT_KEY_MINOR_CIV_HDN_HALCYON'),	('TXT_KEY_MINOR_CIV_HDN_HALCYON'),	('TXT_KEY_MINOR_CIV_HDN_HALCYON_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_HALCYON_PEDIA'),
			('PLAYERCOLOR_MINOR_MIDDLE_PURPLE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_CULTURED')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_PLAYDIA'),	('TXT_KEY_MINOR_CIV_HDN_PLAYDIA'),	('TXT_KEY_MINOR_CIV_HDN_PLAYDIA'),	('TXT_KEY_MINOR_CIV_HDN_PLAYDIA_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_PLAYDIA_PEDIA'),
			('PLAYERCOLOR_MINOR_LIGHT_PURPLE'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_ASIAN'),	('_ASIA'),		('ASIAN'),	('MINOR_TRAIT_RELIGIOUS')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_VIS'),	('TXT_KEY_MINOR_CIV_HDN_VIS'),	('TXT_KEY_MINOR_CIV_HDN_VIS'),	('TXT_KEY_MINOR_CIV_HDN_VIS_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_VIS_PEDIA'),
			('PLAYERCOLOR_MINOR_GOLDENROD'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MILITARISTIC')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_GIZMONDO'),	('TXT_KEY_MINOR_CIV_HDN_GIZMONDO'),	('TXT_KEY_MINOR_CIV_HDN_GIZMONDO'),	('TXT_KEY_MINOR_CIV_HDN_GIZMONDO_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_GIZMONDO_PEDIA'),
			('PLAYERCOLOR_MINOR_GRAY'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_EUROPEAN'),	('_EURO'),		('EUROPEAN'),	('MINOR_TRAIT_MARITIME')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);



INSERT INTO MinorCivilizations
			(Type,						Description,						ShortDescription,						Adjective,
			Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,			ArtStylePrefix,	ArtStyleSuffix,	MinorCivTrait)
SELECT		('MINOR_CIV_HDN_WONDERSWAN'),	('TXT_KEY_MINOR_CIV_HDN_WONDERSWAN'),	('TXT_KEY_MINOR_CIV_HDN_WONDERSWAN'),	('TXT_KEY_MINOR_CIV_HDN_WONDERSWAN_ADJ'),
			('TXT_KEY_MINOR_CIV_HDN_WONDERSWAN_PEDIA'),
			('PLAYERCOLOR_MINOR_CYAN'),	('ART_DEF_CIVILIZATION_MINOR'),	('ARTSTYLE_ASIAN'),	('_ASIA'),		('ASIAN'),	('MINOR_TRAIT_CULTURED')
WHERE EXISTS (SELECT * FROM VV_NeptuniaOptions WHERE Type = 'MINORCIVS' AND Value = 1);






INSERT INTO MinorCivilization_CityNames
			(MinorCivType,			CityName)
SELECT		Type,					Description
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');






INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_NUKE'),	0
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_EXPANSION'),	0
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_WONDER'),	0
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_GROWTH'),	5
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_CULTURE'),	5
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_OFFENSE'),	5
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_NAVAL'),	5
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_GOLD'),	5
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		Type,					('FLAVOR_CITY_DEFENSE'),	5
FROM MinorCivilizations WHERE Type LIKE ('MINOR_CIV_HDN_%');