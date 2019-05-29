UPDATE Buildings
SET VV_SharesChange = 1
WHERE BuildingClass = 'BUILDINGCLASS_SHRINE';

CREATE TRIGGER VV_Shares_Shrines
AFTER INSERT ON Buildings
WHEN NEW.BuildingClass = 'BUILDINGCLASS_SHRINE' AND NEW.VV_SharesChange = 0
BEGIN
	UPDATE Buildings
	SET VV_SharesChange = 1
	WHERE Type = NEW.Type;
END;

UPDATE Buildings
SET VV_SharesChange = 2, VV_SharesChangeOthers = 1
WHERE BuildingClass = 'BUILDINGCLASS_TEMPLE';

CREATE TRIGGER VV_Shares_Temples
AFTER INSERT ON Buildings
WHEN NEW.BuildingClass = 'BUILDINGCLASS_TEMPLE' AND NEW.VV_SharesChange = 0 AND NEW.VV_SharesChangeOthers = 0
BEGIN
	UPDATE Buildings
	SET VV_SharesChange = 2, VV_SharesChangeOthers = 1
	WHERE Type = NEW.Type;
END;

UPDATE Buildings
SET VV_SharesChange = 4, VV_SharesChangeOthers = 2
WHERE BuildingClass = 'BUILDINGCLASS_VV_BASILICOM';



UPDATE Improvements
SET VV_SharesChange = 3
WHERE Type = 'IMPROVEMENT_HOLY_SITE';