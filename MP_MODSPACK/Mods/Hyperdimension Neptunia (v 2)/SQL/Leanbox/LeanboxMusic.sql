INSERT INTO Audio_Sounds
			(SoundID,									Filename,		LoadType)
VALUES		('SND_LEADER_MUSIC_VV_VERT_PEACE',			'VVVertPeace',	'Streamed'),
			('SND_LEADER_MUSIC_VV_VERT_WAR',			'VVVertWar',	'Streamed'),
			('SND_LEADER_MUSIC_VV_VERT_ULTRA_PEACE',	'VVVertUPeace',	'Streamed'),
			('SND_LEADER_MUSIC_VV_VERT_ULTRA_WAR',		'VVVertUWar',	'Streamed');

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,
			SoundType,			MaxVolume,	MinVolume,	IsMusic)
VALUES		('AS2D_LEADER_MUSIC_VV_VERT_PEACE',			'SND_LEADER_MUSIC_VV_VERT_PEACE',
			'GAME_MUSIC',		55,			55,			1),
			('AS2D_LEADER_MUSIC_VV_VERT_WAR',			'SND_LEADER_MUSIC_VV_VERT_WAR',
			'GAME_MUSIC',		35,			35,			1),
			('AS2D_LEADER_MUSIC_VV_GREEN_HEART_PEACE',	'SND_LEADER_MUSIC_VV_VERT_PEACE',
			'GAME_MUSIC',		55,			55,			1),
			('AS2D_LEADER_MUSIC_VV_GREEN_HEART_WAR',	'SND_LEADER_MUSIC_VV_VERT_WAR',
			'GAME_MUSIC',		35,			35,			1),
			('AS2D_LEADER_MUSIC_VV_VERT_ULTRA_PEACE',	'SND_LEADER_MUSIC_VV_VERT_ULTRA_PEACE',
			'GAME_MUSIC',		35,			35,			1),
			('AS2D_LEADER_MUSIC_VV_VERT_ULTRA_WAR',		'SND_LEADER_MUSIC_VV_VERT_ULTRA_WAR',
			'GAME_MUSIC',		55,			55,			1),
			('AS2D_LEADER_MUSIC_VV_GREEN_ULTRA_HEART_PEACE','SND_LEADER_MUSIC_VV_VERT_ULTRA_PEACE',
			'GAME_MUSIC',		35,			35,			1),
			('AS2D_LEADER_MUSIC_VV_GREEN_ULTRA_HEART_WAR',	'SND_LEADER_MUSIC_VV_VERT_ULTRA_WAR',
			'GAME_MUSIC',		55,			55,			1);


