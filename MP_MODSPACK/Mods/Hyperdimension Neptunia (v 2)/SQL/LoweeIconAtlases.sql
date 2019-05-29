INSERT INTO IconTextureAtlases 
			(Atlas, 							IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_VV_LOWEE', 		256, 		'VVLoweeAtlas256.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE', 		128, 		'VVLoweeAtlas128.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE', 		80, 		'VVLoweeAtlas80.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE', 		64, 		'VVLoweeAtlas64.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE', 		45, 		'VVLoweeAtlas45.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE', 		32, 		'VVLoweeAtlas32.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE_ULTRA', 	256, 		'VVLoweeUDAtlas256.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE_ULTRA', 	128, 		'VVLoweeUDAtlas128.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE_ULTRA', 	80, 		'VVLoweeUDAtlas80.dds',			3, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE_ULTRA', 	64, 		'VVLoweeUDAtlas64.dds',			3, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE_ULTRA', 	45, 		'VVLoweeUDAtlas45.dds',			3, 				1),
			('CIV_COLOR_ATLAS_VV_LOWEE_ULTRA', 	32, 		'VVLoweeUDAtlas32.dds',			3, 				1),
			('CIV_ALPHA_ATLAS_VV_LOWEE', 		128, 		'VVLoweeAlpha128.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LOWEE',		64, 		'VVLoweeAlpha64.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LOWEE',		48, 		'VVLoweeAlpha48.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LOWEE',		32, 		'VVLoweeAlpha32.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LOWEE',		24, 		'VVLoweeAlpha24.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LOWEE',		16, 		'VVLoweeAlpha16.dds',			1, 				1),
			('RELIGION_ATLAS_VV_LOWEE',			128, 		'VVWhiteHeartReligion128.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LOWEE',			80, 		'VVWhiteHeartReligion80.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LOWEE',			64, 		'VVWhiteHeartReligion64.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LOWEE',			48, 		'VVWhiteHeartReligion48.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LOWEE',			32, 		'VVWhiteHeartReligion32.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LOWEE',			24, 		'VVWhiteHeartReligion24.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LOWEE',			16, 		'VVWhiteHeartReligion16.dds',	1, 				1),
			('UNIT_FLAG_ATLAS_LOWEE',			32,			'LoweeSoldierFlag.dds',			1, 				1),
			('BUILD_ATLAS_VV_LOWEE',			64,			'BuildAtlasLowee64.dds',		1,				1),
			('BUILD_ATLAS_VV_LOWEE',			45,			'BuildAtlasLowee45.dds',		1,				1);

INSERT INTO IconFontTextures
			(IconFontTexture,						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_VV_WHITE_HEART',	'VVWhiteHeartReligionFont');

INSERT INTO IconFontMapping
			(IconName,							IconFontTexture,					IconMapping)
VALUES		('ICON_VV_WHITE_HEART_RELIGION',	'ICON_FONT_TEXTURE_VV_WHITE_HEART',	1);