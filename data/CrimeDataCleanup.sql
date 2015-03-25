USE CrimeWeather
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OaklandCrimeData]') AND type in (N'U'))
	DROP TABLE [dbo].[OaklandCrimeData]
GO

CREATE TABLE [dbo].[OaklandCrimeData](
	[RawCrimeType] [nvarchar](64) NULL,
	[CrimeType] [nvarchar](64) NULL,
	[DateTime] [datetime] NULL,
	[Month] [smallint] NULL,
	[Day] [smallint] NULL,
	[Year] [smallint] NULL,
	[HourOfDay] [smallint] NULL,
	[CaseNumber] [nvarchar](16) NULL,
	[Description] [nvarchar](255) NULL,
	[PoliceBeat] [nvarchar](16) NULL,
	[Address] [nvarchar](255) NULL
) ON [PRIMARY]
GO

INSERT INTO OaklandCrimeData SELECT CrimeType, NULL, [DateTime], MONTH([Datetime]), DAY([Datetime]), YEAR([Datetime]), DATEPART(hh, [Datetime]), CaseNumber, [Description], PoliceBeat, [Address] FROM [2010Crime] 
INSERT INTO OaklandCrimeData SELECT CrimeType, NULL, [DateTime], MONTH([Datetime]), DAY([Datetime]), YEAR([Datetime]), DATEPART(hh, [Datetime]), CaseNumber, [Description], PoliceBeat, [Address] FROM [2011Crime] 
INSERT INTO OaklandCrimeData SELECT CrimeType, NULL, [DateTime], MONTH([Datetime]), DAY([Datetime]), YEAR([Datetime]), DATEPART(hh, [Datetime]), CaseNumber, [Description], PoliceBeat, [Address] FROM [2012Crime] 
INSERT INTO OaklandCrimeData SELECT CrimeType, NULL, [DateTime], MONTH([Datetime]), DAY([Datetime]), YEAR([Datetime]), DATEPART(hh, [Datetime]), CaseNumber, [Description], PoliceBeat, [Address] FROM [2013Crime] 
INSERT INTO OaklandCrimeData SELECT CrimeType, NULL, [DateTime], MONTH([Datetime]), DAY([Datetime]), YEAR([Datetime]), DATEPART(hh, [Datetime]), CaseNumber, [Description], PoliceBeat, [Address] FROM [2014Crime] 
INSERT INTO OaklandCrimeData SELECT CrimeType, NULL, [DateTime], MONTH([Datetime]), DAY([Datetime]), YEAR([Datetime]), DATEPART(hh, [Datetime]), CaseNumber, [Description], PoliceBeat, [Address] FROM [2015Crime] 

-- Categorize Crimes

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LookupCrime]') AND type in (N'U'))
	DROP TABLE [dbo].[LookupCrime]
GO

CREATE TABLE [dbo].[LookupCrime](
	[RawCrimeType] [varchar](64) NULL,
	[CrimeType] [nvarchar](64) NULL,
	[CrimeCategory] [varchar](64) NULL
) ON [PRIMARY]

GO

-- Populate Missing Crime Types
UPDATE OaklandCrimeData SET RawCrimeType = 'Threats'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'ANNOYING TELEPHONE CALL:OBSCENE/THREATENING'
UPDATE OaklandCrimeData SET RawCrimeType = 'AssaultBattery'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'Assault%'
UPDATE OaklandCrimeData SET RawCrimeType = 'ATTEMPT VEHICLE THEFT-AUTO'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'ATTEMPT VEHICLE THEFT-AUTO'
UPDATE OaklandCrimeData SET RawCrimeType = 'AssaultBattery'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'BATTERY%'
UPDATE OaklandCrimeData SET RawCrimeType = 'Burglary'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'Burglary%'
UPDATE OaklandCrimeData SET RawCrimeType = 'THEFT'
WHERE RawCrimeType = 'Unknown' AND [Description] = 'THEFT'
UPDATE OaklandCrimeData SET RawCrimeType = 'GRAND THEFT'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'GRAND THEFT%'
UPDATE OaklandCrimeData SET RawCrimeType = 'Vandalism'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'VANDALISM'
UPDATE OaklandCrimeData SET RawCrimeType = 'Fraud'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'USE ANOTHER%'
UPDATE OaklandCrimeData SET RawCrimeType = 'STOLEN VEHICLE'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'VEHICLE THEFT - AUTO'
UPDATE OaklandCrimeData SET RawCrimeType = 'Robbery'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'Robbery%'
UPDATE OaklandCrimeData SET RawCrimeType = 'DUI'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'DUI%'
UPDATE OaklandCrimeData SET RawCrimeType = 'DUI'
WHERE RawCrimeType = 'Unknown' AND ([Description] LIKE 'DUI%' OR [Description] LIKE 'DUI%')
UPDATE OaklandCrimeData SET RawCrimeType = 'STOLEN VEHICLE'
WHERE RawCrimeType = 'Unknown' AND [Description] = 'SC STOLEN VEHICLE - AUTO'

UPDATE OaklandCrimeData SET RawCrimeType = 'AssaultBattery'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'FORCE/ADW-OTHER DANGEROUS WEAPON:GBI'
UPDATE OaklandCrimeData SET RawCrimeType = 'ARSON'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'MAL SET/ETC FIRE PROP/ETC - MOTOR VEHICLES'
UPDATE OaklandCrimeData SET RawCrimeType = 'ObstructionResistingArrest'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'OBSTRUCT/RESIST/ETC PUBLIC/PEACE OFFICER/EMERGENCY MED TECH'
UPDATE OaklandCrimeData SET RawCrimeType = 'POSSESSION - STOLEN PROPERTY'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'OWN/ETC CHOP SHOP'
UPDATE OaklandCrimeData SET RawCrimeType = 'PANDERING'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'PANDERING'
UPDATE OaklandCrimeData SET RawCrimeType = 'DrugPossessionSale'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'POSSESS CONTROLLED SUBSTANCE FOR SALE'
UPDATE OaklandCrimeData SET RawCrimeType = 'DrugPossessionSale'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'POSSESS/PURCHASE COCAINE BASE FOR SALE'
UPDATE OaklandCrimeData SET RawCrimeType = 'Weapons'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'PROHIBITED POSSESS AMMUNITION OR RELOADED AMMUNITION'
UPDATE OaklandCrimeData SET RawCrimeType = 'Unknown'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'SC ADW - OTHER DANGEROUS WEAPON'
UPDATE OaklandCrimeData SET RawCrimeType = 'SHOOT AT INHABITED DWELLING/VEHICLE/ETC'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'SHOOT AT INHABITED DWELLING/VEHICLE/ETC'
UPDATE OaklandCrimeData SET RawCrimeType = 'SHOOT AT UNOCCUPIED DWELLING/VEHICLE/ETC'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'SHOOT AT UNOCCUPIED DWELLING/VEHICLE/ETC'
UPDATE OaklandCrimeData SET RawCrimeType = 'WILLFUL DISCHARGE FIREARM IN NEGLIGENT MANNER'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'WILLFUL DISCHARGE FIREARM IN NEGLIGENT MANNER'
UPDATE OaklandCrimeData SET RawCrimeType = 'Carjacking'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'CARJACKING WITH FIREARM'
UPDATE OaklandCrimeData SET RawCrimeType = 'THREATS'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'CRIMINAL THREATS  THREATED CRIME W/INTENT TO TERRORIZE'
UPDATE OaklandCrimeData SET RawCrimeType = 'ChildElderAbuse'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'CRUELTY TO ELDER/DEPENDENT ADULT'
UPDATE OaklandCrimeData SET RawCrimeType = 'PROSTITUTION'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'DISORDERLY CONDUCT:PROSTITUTION'
UPDATE OaklandCrimeData SET RawCrimeType = 'DISTURBING THE PEACE'
WHERE RawCrimeType = 'Unknown' AND [Description] LIKE 'DISTURB THE PEACE'

SELECT Description, COUNT(1) AS CrimeCount FROM OaklandCrimeData WHERE CrimeType = 'Unknown' GROUP BY [Description] ORDER BY CrimeCount DESC

INSERT INTO LookupCrime (RawCrimeType)
SELECT DISTINCT RawCrimeType FROM OaklandCrimeData 

UPDATE LookupCrime SET CrimeType = 'Arson', CrimeCategory = 'Property' WHERE RawCrimeType LIKE '%Arson%'
UPDATE LookupCrime SET CrimeType = 'AssaultBattery', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%Assault%'
UPDATE LookupCrime SET CrimeType = 'RapeAttemptedRape', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%RAPE%'
UPDATE LookupCrime SET CrimeType = 'BombThreat', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%BOMB%'
UPDATE LookupCrime SET CrimeType = 'BrandishingWeapon', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%BRANDISHING%'
UPDATE LookupCrime SET CrimeType = 'Burglary', CrimeCategory = 'Property' WHERE RawCrimeType LIKE 'Burg %' OR RawCrimeType LIKE 'Burglary%'
UPDATE LookupCrime SET CrimeType = 'Carjacking', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE 'Carjacking%'
UPDATE LookupCrime SET CrimeType = 'ChildElderAbuse', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%Child Abuse%' OR RawCrimeType LIKE '%ChildElderAbuse%'
UPDATE LookupCrime SET CrimeType = 'CurfewLoitering', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%Curfew%'
UPDATE LookupCrime SET CrimeType = 'DisorderlyConduct', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%DISORDERLY CONDUCT%'
UPDATE LookupCrime SET CrimeType = 'DomesticViolence', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%DOMESTIC VIOLENCE%'
UPDATE LookupCrime SET CrimeType = 'DrugPossesionSale', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%DRUG ABUSE VIOLATION%' OR RawCrimeType LIKE '%NARCOTICS%' OR RawCrimeType = 'DrugPossessionSale'
UPDATE LookupCrime SET CrimeType = 'PublicDrunkenness', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%DRUNKENNESS%'
UPDATE LookupCrime SET CrimeType = 'DisturbingThePeace', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType = 'DISTURBING THE PEACE'
UPDATE LookupCrime SET CrimeType = 'DUI', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%DUI%'
UPDATE LookupCrime SET CrimeType = 'Embezzlement', CrimeCategory = 'Property' WHERE RawCrimeType LIKE '%EMBEZZLEMENT%'
UPDATE LookupCrime SET CrimeType = 'Warrant', CrimeCategory = 'Other' WHERE RawCrimeType LIKE '%WARRANT%'
UPDATE LookupCrime SET CrimeType = 'ForgeryCounterfeiting', CrimeCategory = 'Property' WHERE RawCrimeType LIKE '%Forgery%'
UPDATE LookupCrime SET CrimeType = 'Fraud', CrimeCategory = 'Property' WHERE RawCrimeType LIKE '%FRAUD%'
UPDATE LookupCrime SET CrimeType = 'Gambling', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%GAMBLING%'
UPDATE LookupCrime SET CrimeType = 'Theft', CrimeCategory = 'Property' WHERE RawCrimeType LIKE '%GRAND THEFT%' OR RawCrimeType LIKE '%LARCENY THEFT%' OR RawCrimeType LIKE 'PETTY THEFT' OR RawCrimeType = 'THEFT'
UPDATE LookupCrime SET CrimeType = 'Homicide', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%Homicide%'
UPDATE LookupCrime SET CrimeType = 'None', CrimeCategory = 'None' WHERE RawCrimeType LIKE '%INCIDENT TYPE%' OR RawCrimeType LIKE '%RUNAWAY%'
UPDATE LookupCrime SET CrimeType = 'Kidnapping', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%KIDNAPPING%'
UPDATE LookupCrime SET CrimeType = 'None', CrimeCategory = 'None' WHERE RawCrimeType LIKE '%LOST VEHICLE%' OR RawCrimeType LIKE '%Recovered%'
UPDATE LookupCrime SET CrimeType = 'Other', CrimeCategory = 'Other' WHERE RawCrimeType LIKE '%MISSING%' OR RawCrimeType LIKE '%OAKLAND MUNI CODE%' OR RawCrimeType LIKE 'OTHER' OR RawCrimeType LIKE 'OUTSIDE AGENCY INCIDENT'
UPDATE LookupCrime SET CrimeType = 'OtherSexOffenses', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType = 'PANDERING'
UPDATE LookupCrime SET CrimeType = 'Pandering', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%OTHER SEX OFFENSES%'
UPDATE LookupCrime SET CrimeType = 'ObstructionResistingArrest', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType = 'ObstructionResistingArrest'
UPDATE LookupCrime SET CrimeType = 'Prostitution', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%PROSTITUTION%'
UPDATE LookupCrime SET CrimeType = 'PossesionStolenProperty', CrimeCategory = 'Property' WHERE RawCrimeType LIKE '%POSSESSION - STOLEN PROPERTY%'
UPDATE LookupCrime SET CrimeType = 'Robbery', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%Robbery%'
UPDATE LookupCrime SET CrimeType = 'VehicleTheft', CrimeCategory = 'Property' WHERE RawCrimeType LIKE '%STOLEN AND RECOVERED VEHICLE%' OR RawCrimeType LIKE '%STOLEN VEHICLE%' OR RawCrimeType LIKE 'MOTOR VEHICLE THEFT%' OR RawCrimeType = 'ATTEMPT VEHICLE THEFT-AUTO'
UPDATE LookupCrime SET CrimeType = 'Threats', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE '%THREATS%'
UPDATE LookupCrime SET CrimeType = 'Traffic', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%TOWED VEHICLE%' OR RawCrimeType LIKE '%MISCELLANEOUS TRAFFIC CRIME%'
UPDATE LookupCrime SET CrimeType = 'Unknown', CrimeCategory = 'Other' WHERE RawCrimeType LIKE '%Unknown%'
UPDATE LookupCrime SET CrimeType = 'Vandalism', CrimeCategory = 'Property' WHERE RawCrimeType LIKE 'VANDALISM%%'
UPDATE LookupCrime SET CrimeType = 'IllegalWeaponsPossesion', CrimeCategory = 'QualityOfLife' WHERE RawCrimeType LIKE '%WEAPONS%'
UPDATE LookupCrime SET CrimeType = 'FirearmDischarge', CrimeCategory = 'Violent' WHERE RawCrimeType LIKE 'SHOOT%' OR RawCrimeType LIKE 'WILLFUL DISCHARGE FIREARM%'

SELECT * FROM LookupCrime 
WHERE CrimeType IS NULL OR CrimeType = 'Unknown'
ORDER BY RawCrimeType ASC

UPDATE OaklandCrimeData 
SET CrimeType = L.CrimeType
FROM OaklandCrimeData O
	INNER JOIN LookupCrime L ON O.RawCrimeType = L.RawCrimeType
WHERE O.CrimeType IS NULL

SELECT * FROM OaklandCrimeData 
WHERE CrimeType IS NULL 

SELECT CrimeType, Count(1) AS CrimeCount FROM OaklandCrimeData 
GROUP BY CrimeType
ORDER BY CrimeCount DESC
