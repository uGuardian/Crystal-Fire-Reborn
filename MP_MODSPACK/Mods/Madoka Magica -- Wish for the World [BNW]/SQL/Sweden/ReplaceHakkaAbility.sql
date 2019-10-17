--This replaces ANY Promotion with the GreatGeneralReceivesMovement tag with the new tag AdjacentCommanderMovement set to 1.
--Reason being: you aren't taking Great Generals into combat with you anymore, you're taking Commander MGs, which cannot normally stack with Hakkas
--or any other military units.

/* CREATE TRIGGER ReplaceGGRMPromotionTag
AFTER INSERT ON UnitPromotions
BEGIN
	UPDATE UnitPromotions
	SET GreatGeneralReceivesMovement=0,AdjacentCommanderMovement=1
	WHERE GreatGeneralReceivesMovement=1;
END; */