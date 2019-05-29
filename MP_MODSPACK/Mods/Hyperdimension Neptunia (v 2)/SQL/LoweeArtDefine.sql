INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_LOWEE_SOLDIER'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_MUSKETMAN');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_LOWEE_SOLDIER'), ('ART_DEF_UNIT_MEMBER_LOWEE_SOLDIER'), NumMembers
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_MUSKETMAN');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_LOWEE_SOLDIER'),			EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType,	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_LOWEE_SOLDIER'),				"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN');

INSERT INTO ArtDefine_UnitMemberInfos (Type,		Scale, ZOffset, Domain, Model,						MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_LOWEE_SOLDIER'),	Scale, ZOffset, Domain, ('loweesoldier.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_MUSKETMAN');

INSERT INTO ArtDefine_StrategicView
			(StrategicViewType,				TileType,	Asset)
VALUES		('ART_DEF_UNIT_LOWEE_SOLDIER',	'Unit',		'SV_VV_LoweeSoldier.dds');





INSERT INTO  Audio_Sounds (SoundID,						Filename,					LoadType)
VALUES		('SND_UNIT_DEATH_VOX_LOWEE_SOLDIER',		'LoweeSoldierHurt-003',		'DynamicResident'),
			('SND_UNIT_FORTIFY_VOX_LOWEE_SOLDIER',		'LoweeSoldierFortify-001',	'DynamicResident'),
			('SND_UNIT_SELECT_LOWEE_SOLDIER',			'LoweeSoldierSelect',		'DynamicResident');



INSERT INTO Audio_3DSounds
			(ScriptID,									SoundID,								SoundType,			MaxVolume,	MinVolume,	PitchChangeDown, PitchChangeUp, DontPlayMoreThan)
VALUES		('AS3D_UNIT_LOWEE_SOLDIER_FORTIFY_VOX',		'SND_UNIT_FORTIFY_VOX_LOWEE_SOLDIER',	'GAME_SFX',			45,			15,			-1,				 1,				4),
			('AS3D_UNIT_LOWEE_SOLDIER_DEATH_VOX',		'SND_UNIT_DEATH_VOX_LOWEE_SOLDIER',		'GAME_SFX',			45,			15,			-1,				 1,				-1);


INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,
			SoundType,			MaxVolume,	MinVolume,	IsMusic)
VALUES		('AS2D_UNIT_SELECT_LOWEE_SOLDIER',			'SND_UNIT_SELECT_LOWEE_SOLDIER',
			'GAME_SFX',			45,			45,			0);