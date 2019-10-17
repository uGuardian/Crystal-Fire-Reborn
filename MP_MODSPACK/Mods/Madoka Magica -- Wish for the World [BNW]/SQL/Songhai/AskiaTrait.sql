--Update Songhai's trait, and any mod Civs which have the same sort of trait.
CREATE TABLE IF NOT EXISTS COMMUNITY(Type, Value);

UPDATE Traits
SET WitchBarrierXPMultiplier = 2, PlunderModifier = 0
WHERE PlunderModifier > 0;



CREATE TRIGGER OtherModsDoubleXPTrait
AFTER INSERT ON Traits
WHEN NEW.PlunderModifier > 0
BEGIN
	UPDATE Traits
	SET WitchBarrierXPMultiplier = 2, PlunderModifier = 0
	WHERE Type = NEW.Type;
END;


UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_AMPHIB_WARLORD_PMMM'
WHERE Type = 'TRAIT_AMBHIB_WARLORD' AND NOT EXISTS(SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1);