INSERT INTO IconTextureAtlases 
			(Atlas, 					IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('VV_HDN_SHARED_ATLAS', 	256, 		'HDNSharesIcon256.dds',		2, 				1),
			('VV_HDN_SHARED_ATLAS', 	128, 		'HDNSharesIcon128.dds',		2, 				1),
			('VV_HDN_SHARED_ATLAS', 	80, 		'HDNSharesIcon80.dds',		2, 				1),
			('VV_HDN_SHARED_ATLAS', 	64, 		'HDNSharesIcon64.dds',		2, 				1),
			('VV_HDN_SHARED_ATLAS', 	45, 		'HDNSharesIcon45.dds',		2, 				1),
			('VV_HDN_SHARED_ATLAS', 	32, 		'HDNSharesIcon32.dds',		2, 				1);

INSERT INTO IconFontTextures
			(IconFontTexture,				IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_VV_SHARES',	'VVSharesFontIcon');

INSERT INTO IconFontMapping
			(IconName,			IconFontTexture,				IconMapping)
VALUES		('ICON_VV_SHARES',	'ICON_FONT_TEXTURE_VV_SHARES',	1);