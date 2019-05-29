--Update Germany's trait, and any mod Civs which have the same sort of trait.


UPDATE Traits
SET ConvertNearbyFamiliarRadius = 2, LandBarbarianConversionPercent = 0
WHERE LandBarbarianConversionPercent > 0;

CREATE TRIGGER OtherModsConvertFamiliarsTrait
AFTER INSERT ON Traits
WHEN NEW.LandBarbarianConversionPercent > 0
BEGIN
	UPDATE Traits
	SET ConvertNearbyFamiliarRadius = 2, LandBarbarianConversionPercent = 0
	WHERE Type = NEW.Type;
END;


--CBP
CREATE TABLE IF NOT EXISTS COMMUNITY(Type, Value);

UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_CONVERTS_LAND_BARBARIANS_PMMM'
WHERE Type = 'TRAIT_CONVERTS_LAND_BARBARIANS' AND NOT EXISTS(SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1);


UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_RAZE_AND_HORSES_PMMM_CBP'
WHERE Type = 'TRAIT_RAZE_AND_HORSES' AND EXISTS(SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1);