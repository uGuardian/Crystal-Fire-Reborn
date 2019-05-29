INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_VV_LASTATION_UN', 	256, 		'VVUniAtlas256.dds',		4, 				3),
			('CIV_COLOR_ATLAS_VV_LASTATION_UN', 	128, 		'VVUniAtlas128.dds',		4, 				3),
			('CIV_COLOR_ATLAS_VV_LASTATION_UN', 	80, 		'VVUniAtlas80.dds',			4, 				3),
			('CIV_COLOR_ATLAS_VV_LASTATION_UN', 	64, 		'VVUniAtlas64.dds',			4, 				3),
			('CIV_COLOR_ATLAS_VV_LASTATION_UN', 	45, 		'VVUniAtlas45.dds',			4, 				3),
			('CIV_COLOR_ATLAS_VV_LASTATION_UN', 	32, 		'VVUniAtlas32.dds',			4, 				3),
			('CIV_ALPHA_ATLAS_VV_LASTATION_UN', 	128, 		'VVLastationAlpha128.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION_UN', 	64, 		'VVLastationAlpha64.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION_UN', 	48, 		'VVLastationAlpha48.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION_UN', 	32, 		'VVLastationAlpha32.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION_UN', 	24, 		'VVLastationAlpha24.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION_UN', 	16, 		'VVLastationAlpha16.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LASTATION_UN',		128, 		'VVUniReligion128.dds',		1, 				1),
			('RELIGION_ATLAS_VV_LASTATION_UN',		80, 		'VVUniReligion80.dds',		1, 				1),
			('RELIGION_ATLAS_VV_LASTATION_UN',		64, 		'VVUniReligion64.dds',		1, 				1),
			('RELIGION_ATLAS_VV_LASTATION_UN',		48, 		'VVUniReligion48.dds',		1, 				1),
			('RELIGION_ATLAS_VV_LASTATION_UN',		32, 		'VVUniReligion32.dds',		1, 				1),
			('RELIGION_ATLAS_VV_LASTATION_UN',		24, 		'VVUniReligion24.dds',		1, 				1),
			('RELIGION_ATLAS_VV_LASTATION_UN',		16, 		'VVUniReligion16.dds',		1, 				1),
			('UNIT_FLAG_ATLAS_LASTATION_UN',		32,			'VVUniUnitFlagIcon.dds',	1, 				1);


INSERT INTO IconFontTextures
			(IconFontTexture,						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_VV_BLACK_SISTER',	'VVUniReligionFont');

INSERT INTO IconFontMapping
			(IconName,							IconFontTexture,						IconMapping)
VALUES		('ICON_VV_BLACK_SISTER_RELIGION',	'ICON_FONT_TEXTURE_VV_BLACK_SISTER',	1);