ALTER TABLE Traits ADD COLUMN 'SciencePerMoreAdvancedEnemyUnit' INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN 'GreatPeopleSpawnAsVillains' BOOLEAN DEFAULT false;
ALTER TABLE Traits ADD COLUMN 'VictoryPointsPerStrengthPoint' INTEGER DEFAULT 0;




ALTER TABLE UnitPromotions ADD COLUMN 'AdjacentDamageWhenKilled' INTEGER DEFAULT 0;