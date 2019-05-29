ALTER TABLE Traits ADD COLUMN VV_SharesSystem BOOLEAN DEFAULT false;
ALTER TABLE Traits ADD COLUMN VV_Shares_HDDCostChange INTEGER DEFAULT 0;

ALTER TABLE Traits ADD COLUMN VV_Shares_GreatWorks INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN VV_Shares_Friendships INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN VV_Shares_CSAllies INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN VV_Shares_Counterspies INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN VV_Shares_ProcessMultiplier INTEGER DEFAULT 0; --no longer used by Neptune but still here in case
ALTER TABLE Traits ADD COLUMN VV_Shares_AnnexedPopulationTimes100 INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN VV_Shares_Wonders INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN VV_Shares_AfraidCS INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN VV_Shares_AfraidCivs INTEGER DEFAULT 0;

CREATE TABLE Trait_VV_Shares_Terrain (
		TraitType TEXT NOT NULL,
		TerrainType TEXT NOT NULL,
		Shares INTEGER DEFAULT 0,
		FOREIGN KEY(TraitType) REFERENCES Traits(Type),
		FOREIGN KEY(TerrainType) REFERENCES Terrains(Type)
		);

ALTER TABLE Buildings ADD COLUMN VV_SharesChange INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN VV_SharesChangeOthers INTEGER DEFAULT 0;

ALTER TABLE Improvements ADD COLUMN VV_SharesChange INTEGER DEFAULT 0;
ALTER TABLE Improvements ADD COLUMN VV_SharesChangeOthers INTEGER DEFAULT 0;





CREATE TABLE Trait_VV_HDDModes(
	NormalTraitType TEXT NOT NULL UNIQUE,
	HDDTraitType TEXT NOT NULL UNIQUE,
	NormalDummyBuilding TEXT,
	HDDDummyBuilding TEXT,
	NormalDummyPolicy TEXT,
	HDDDummyPolicy TEXT,
	ScriptName TEXT,

	FOREIGN KEY(NormalTraitType) REFERENCES Traits(Type),
	FOREIGN KEY(HDDTraitType) REFERENCES Traits(Type),
	FOREIGN KEY(NormalDummyBuilding) REFERENCES Buildings(Type),
	FOREIGN KEY(HDDDummyBuilding) REFERENCES Buildings(Type),
	FOREIGN KEY(NormalDummyPolicy) REFERENCES Policies(Type),
	FOREIGN KEY(HDDDummyPolicy) REFERENCES Policies(Type)
	);