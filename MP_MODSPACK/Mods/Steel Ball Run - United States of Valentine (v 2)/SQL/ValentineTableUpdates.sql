ALTER TABLE Traits ADD COLUMN 'EnableD4CSystem' BOOLEAN DEFAULT false NOT NULL;


ALTER TABLE UnitPromotions ADD COLUMN 'OnAdjacentKillCorpsePartChance' INTEGER DEFAULT 0;
ALTER TABLE UnitPromotions ADD COLUMN 'OnMoveOnRoadCorpsePartChance' INTEGER DEFAULT 0;
ALTER TABLE UnitPromotions ADD COLUMN 'CanObtainCorpseParts' BOOLEAN DEFAULT false NOT NULL;