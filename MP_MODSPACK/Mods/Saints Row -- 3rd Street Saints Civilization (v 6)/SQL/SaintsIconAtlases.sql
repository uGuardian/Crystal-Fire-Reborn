INSERT INTO IconTextureAtlases 
			(Atlas, 											IconSize, 	Filename, 							IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_THIRD_STREET_SAINTS', 			256, 		'SRTTSaintsAtlas256.dds',			4, 				2),
			('CIV_COLOR_ATLAS_THIRD_STREET_SAINTS', 			128, 		'SRTTSaintsAtlas128.dds',			4, 				2),
			('CIV_COLOR_ATLAS_THIRD_STREET_SAINTS', 			80, 		'SRTTSaintsAtlas80.dds',			4, 				2),
			('CIV_COLOR_ATLAS_THIRD_STREET_SAINTS', 			64, 		'SRTTSaintsAtlas64.dds',			4, 				2),
			('CIV_COLOR_ATLAS_THIRD_STREET_SAINTS', 			45, 		'SRTTSaintsAtlas45.dds',			4, 				2),
			('CIV_COLOR_ATLAS_THIRD_STREET_SAINTS', 			32, 		'SRTTSaintsAtlas32.dds',			4, 				2);


INSERT INTO IconFontTextures
			(IconFontTexture,					IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_SRTT_RESPECT',	'SRTTRespectFontIcons');


INSERT INTO IconFontMapping
			(IconName,				IconFontTexture,					IconMapping)
VALUES		('ICON_SRTT_RESPECT',	'ICON_FONT_TEXTURE_SRTT_RESPECT',	1);