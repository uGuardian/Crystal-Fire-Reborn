INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_DOGOO_KNIGHT'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_KNIGHT');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_DOGOO_KNIGHT'), ('ART_DEF_UNIT_MEMBER_DOGOO_KNIGHT'), NumMembers
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_KNIGHT');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_DOGOO_KNIGHT'),			EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType,	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_DOGOO_KNIGHT'),				"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_UnitMemberInfos (Type,		Scale, ZOffset, Domain, Model,						MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_DOGOO_KNIGHT'),	Scale, ZOffset, Domain, ('dogooknight.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_StrategicView
			(StrategicViewType,				TileType,	Asset)
VALUES		('ART_DEF_UNIT_DOGOO_KNIGHT',	'Unit',		'SV_VV_NeptuneUnit.dds');





INSERT INTO  Audio_Sounds (SoundID,				Filename,					LoadType)
VALUES		('SND_UNIT_DEATH_VOX_DOGOO',		'VVSlimeDeath',				'DynamicResident'),
			('SND_UNIT_LIGHT_STEP_DOGOO',		'VVLightSlimeSound',		'DynamicResident'),	
			('SND_UNIT_STEP_DOGOO',				'VVSlimeSoundB',			'DynamicResident'),
			('SND_UNIT_VOCALIZE_VOX_DOGOO',		'VVSlimeSoundC',			'DynamicResident');



INSERT INTO Audio_3DSounds
			(ScriptID,							SoundID,						SoundType,			MaxVolume,	MinVolume,	PitchChangeDown, PitchChangeUp, DontPlayMoreThan)
VALUES		('AS3D_UNIT_DOGOO_STEP_VOX',		'SND_UNIT_STEP_DOGOO',			'GAME_SFX',			80,			65,			-1,				 1,				4),
			('AS3D_UNIT_DOGOO_DEATH_VOX',		'SND_UNIT_DEATH_VOX_DOGOO',		'GAME_SFX',			80,			65,			-1,				 1,				1),
			('AS3D_UNIT_DOGOO_LIGHT_STEP_VOX',	'SND_UNIT_LIGHT_STEP_DOGOO',	'GAME_SFX',			80,			65,			-1,				 1,				6),
			('AS3D_UNIT_DOGOO_VOCALIZE_VOX',	'SND_UNIT_VOCALIZE_VOX_DOGOO',	'GAME_SFX',			80,			65,			-1,				 1,				1);
