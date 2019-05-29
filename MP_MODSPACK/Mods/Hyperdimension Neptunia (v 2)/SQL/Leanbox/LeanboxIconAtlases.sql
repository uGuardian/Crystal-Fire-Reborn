INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_VV_LEANBOX', 			256, 		'VVLeanboxAtlas256.dds',		6, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX',			128, 		'VVLeanboxAtlas128.dds',		6, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX',			80, 		'VVLeanboxAtlas80.dds',			6, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX',			64, 		'VVLeanboxAtlas64.dds',			6, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX', 			45, 		'VVLeanboxAtlas45.dds',			6, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX',			32, 		'VVLeanboxAtlas32.dds',			6, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA', 	256, 		'VVLeanboxUDAtlas256.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA', 	128, 		'VVLeanboxUDAtlas128.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA', 	80, 		'VVLeanboxUDAtlas80.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA', 	64, 		'VVLeanboxUDAtlas64.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA', 	45, 		'VVLeanboxUDAtlas45.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA', 	32, 		'VVLeanboxUDAtlas32.dds',		3, 				1),
			('CIV_ALPHA_ATLAS_VV_LEANBOX', 			128, 		'VVLeanboxAlpha128.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_LEANBOX',			64, 		'VVLeanboxAlpha64.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LEANBOX', 			48, 		'VVLeanboxAlpha48.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LEANBOX',			32, 		'VVLeanboxAlpha32.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LEANBOX',			24, 		'VVLeanboxAlpha24.dds',			1, 				1),
			('CIV_ALPHA_ATLAS_VV_LEANBOX',			16, 		'VVLeanboxAlpha16.dds',			1, 				1),
			('RELIGION_ATLAS_VV_LEANBOX',			128, 		'VVGreenHeartReligion128.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LEANBOX',			80, 		'VVGreenHeartReligion80.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LEANBOX',			64, 		'VVGreenHeartReligion64.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LEANBOX',			48, 		'VVGreenHeartReligion48.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LEANBOX', 			32, 		'VVGreenHeartReligion32.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LEANBOX', 			24, 		'VVGreenHeartReligion24.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LEANBOX',			16, 		'VVGreenHeartReligion16.dds',	1, 				1),
			('UNIT_FLAG_ATLAS_RANRAN',				32, 		'RanRanFlag.dds',				1, 				1),
			('UNIT_FLAG_ATLAS_GAME_DEV',			32, 		'GreatGameDevFlag.dds',			1, 				1);


INSERT INTO IconFontTextures
			(IconFontTexture,						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_VV_GREEN_HEART',	'VVGreenHeartReligionFont');

INSERT INTO IconFontMapping
			(IconName,							IconFontTexture,					IconMapping)
VALUES		('ICON_VV_GREEN_HEART_RELIGION',	'ICON_FONT_TEXTURE_VV_GREEN_HEART',	1);