INSERT INTO MinorCivilizations
			(Type,					Description,				ShortDescription,				Adjective,					Civilopedia,	
			DefaultPlayerColor,				ArtDefineTag,					ArtStyleType,		ArtStyleSuffix,	ArtStylePrefix,	MinorCivTrait)
VALUES		('MINOR_CIV_MISAKI',	'TXT_KEY_CITYSTATE_MISAKI',	'TXT_KEY_CITYSTATE_MISAKI',	'TXT_KEY_CITYSTATE_MISAKI_ADJ', 'TXT_KEY_CITYSTATE_MISAKI_TEXT',
			'PLAYERCOLOR_MINOR_LIGHT_BLUE',	'ART_DEF_CIVILIZATION_MINOR',	'ARTSTYLE_ASIAN',	'_ASIA',		'ASIAN',		'MINOR_TRAIT_MARITIME');

INSERT INTO MinorCivilization_Flavors
			(MinorCivType,			FlavorType,			Flavor)
SELECT		('MINOR_CIV_MISAKI'),	FlavorType,			Flavor
FROM MinorCivilization_Flavors WHERE MinorCivType = 'MINOR_CIV_UR' OR MinorCivType = 'MINOR_CIV_BUDAPEST' OR MinorCivType = 'MINOR_CIV_GENEVA';


INSERT INTO MinorCivilization_CityNames
			(MinorCivType,			CityName)
VALUES		('MINOR_CIV_MISAKI',	'TXT_KEY_CITYSTATE_MISAKI');


DELETE FROM MinorCivilizations WHERE Type = 'MINOR_CIV_UR';
DELETE FROM MinorCivilization_Flavors WHERE MinorCivType = 'MINOR_CIV_UR';
DELETE FROM MinorCivilization_CityNames WHERE MinorCivType = 'MINOR_CIV_UR';