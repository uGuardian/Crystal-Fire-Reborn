UPDATE Unit_UniqueNames
SET UniqueName = UniqueName||'_PMMM_FEMALEREPLACE'
WHERE EXISTS (SELECT * FROM Language_en_US WHERE Tag=UniqueName||'_PMMM_FEMALEREPLACE') AND EXISTS(SELECT * FROM WishForTheWorldOptions WHERE Option='FeminizeProdigyNames' AND Value != 0);

CREATE TRIGGER PMMMFeminizeUnitUniqueNames
AFTER INSERT ON Unit_UniqueNames
WHEN EXISTS (SELECT * FROM Language_en_US WHERE Tag=NEW.UniqueName||'_PMMM_FEMALEREPLACE') AND EXISTS(SELECT * FROM WishForTheWorldOptions WHERE Option='FeminizeProdigyNames' AND Value != 0)
BEGIN
	UPDATE Unit_UniqueNames
	SET UniqueName = NEW.UniqueName||'_PMMM_FEMALEREPLACE'
	WHERE UniqueName = NEW.UniqueName;
END;
