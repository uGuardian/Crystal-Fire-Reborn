INSERT INTO MG_IconBodies
			(ID,Type,					Description,					ColorDescriptionTag,		IconAtlas,			NumColors)
VALUES		(0,	'PMMM_MGICONBODY_1',	'TXT_KEY_PMMM_MGICONBODY_1',	'TXT_KEY_PMMM_SKIN_TONE_',	'MGIB_BODY_ATLAS',	4);


INSERT INTO MG_IconOutfits
			(ID,Type,					Description,					ColorDescriptionTag,			IconAtlas,				NumColors)
VALUES		(0,	'PMMM_MGICONOUTFIT_1',	'TXT_KEY_PMMM_MGICONOUTFIT_1',	'TXT_KEY_PMMM_OUTFIT1COLOR_',	'MGIB_OUTFIT1_ATLAS',	16);


INSERT INTO MG_IconFaces
			(ID,Type,					Description,					ColorDescriptionTag,		IconAtlas,
			AngryIconAtlas,				DepressedIconAtlas,				HappyIconAtlas,				JoyousIconAtlas,			NumColors)
VALUES		(0,	'PMMM_MGICONFACE_1',	'TXT_KEY_PMMM_MGICONFACE_1',	'TXT_KEY_PMMM_FACE1COLOR_',	'MGIB_FACE1_ATLAS',
			'MGIB_FACE1_ANGRY_ATLAS',	'MGIB_FACE1_DEPRESSED_ATLAS',	'MGIB_FACE1_HAPPY_ATLAS',	'MGIB_FACE1_JOYOUS_ATLAS',	12);


INSERT INTO MG_IconHairs
			(ID,Type,					Description,					ColorDescriptionTag,		IconAtlas,			NumColors)
VALUES		(0,	'PMMM_MGICONHAIR_1',	'TXT_KEY_PMMM_MGICONHAIR_1',	'TXT_KEY_PMMM_HAIR1COLOR_',	'MGIB_HAIR1_ATLAS',	16);

INSERT INTO MG_IconHairs
			(Type,					Description,					ColorDescriptionTag,		IconAtlas,			NumColors)
VALUES		('PMMM_MGICONHAIR_2',	'TXT_KEY_PMMM_MGICONHAIR_2',	'TXT_KEY_PMMM_HAIR1COLOR_',	'MGIB_HAIR2_ATLAS',	16),
			('PMMM_MGICONHAIR_3',	'TXT_KEY_PMMM_MGICONHAIR_3',	'TXT_KEY_PMMM_HAIR1COLOR_',	'MGIB_HAIR3_ATLAS',	16),
			('PMMM_MGICONHAIR_4',	'TXT_KEY_PMMM_MGICONHAIR_4',	'TXT_KEY_PMMM_HAIR1COLOR_',	'MGIB_HAIR4_ATLAS',	16),
			('PMMM_MGICONHAIR_5',	'TXT_KEY_PMMM_MGICONHAIR_5',	'TXT_KEY_PMMM_HAIR1COLOR_',	'MGIB_HAIR5_ATLAS',	16),
			('PMMM_MGICONHAIR_6',	'TXT_KEY_PMMM_MGICONHAIR_6',	'TXT_KEY_PMMM_HAIR1COLOR_',	'MGIB_HAIR6_ATLAS',	16);

INSERT INTO MG_IconFaceAccessories
			(ID,Type,				Description,				ColorDescriptionTag,		IconAtlas,				NumAccessories)
VALUES		(0,	'PMMM_MGICONFA_1',	'TXT_KEY_PMMM_MGICONFA_1',	'TXT_KEY_PMMM_FACEACC1_',	'MGIB_ICONFA1_ATLAS',	4);

INSERT INTO MG_IconHairAccessories
			(ID,Type,				Description,				ColorDescriptionTag,		IconAtlas,				NumAccessories)
VALUES		(0,	'PMMM_MGICONHA_1',	'TXT_KEY_PMMM_MGICONHA_1',	'TXT_KEY_PMMM_HAIRACC1_',	'MGIB_ICONHA1_ATLAS',	4);



UPDATE Civilizations
SET DefaultMagicalGirlColor = 0
WHERE ArtStyleType IN ('ARTSTYLE_EUROPEAN', 'ARTSTYLE_ASIAN') AND EXISTS(SELECT * FROM WishForTheWorldOptions WHERE Option='CulturalMGSkinTones' AND Value != 0);

UPDATE Civilizations
SET DefaultMagicalGirlColor = 1
WHERE ArtStyleType IN ('ARTSTYLE_GRECO_ROMAN', 'ARTSTYLE_BARBARIAN') AND EXISTS(SELECT * FROM WishForTheWorldOptions WHERE Option='CulturalMGSkinTones' AND Value != 0);

UPDATE Civilizations
SET DefaultMagicalGirlColor = 2
WHERE ArtStyleType IN ('ARTSTYLE_SOUTH_AMERICA', 'ARTSTYLE_POLYNESIAN') AND EXISTS(SELECT * FROM WishForTheWorldOptions WHERE Option='CulturalMGSkinTones' AND Value != 0);

UPDATE Civilizations
SET DefaultMagicalGirlColor = 3
WHERE ArtStyleType IN ('ARTSTYLE_MIDDLE_EAST') AND EXISTS(SELECT * FROM WishForTheWorldOptions WHERE Option='CulturalMGSkinTones' AND Value != 0);


UPDATE Civilizations
SET DefaultMagicalGirlColor = -1
WHERE Type LIKE ('%AMERICA%') OR Type LIKE ('%BRAZIL%') OR Type LIKE ('CIVILIZATION_MADOKA');

UPDATE Civilizations
SET DefaultMagicalGirlColor = 2
WHERE Type IN ('%ARABIA%', '%PERSIA%') AND EXISTS(SELECT * FROM WishForTheWorldOptions WHERE Option='CulturalMGSkinTones' AND Value != 0);