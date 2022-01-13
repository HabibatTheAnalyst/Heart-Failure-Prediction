USE DATraining
GO
--- displays all columns in table 
SELECT *
FROM [RAW_HeartFailurePrediction_20211229]
ORDER BY Age DESC;

--- age range and sex with heart disease
SELECT 
	Age,
	Sex,
	Heart_Disease
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
GROUP BY Age, Sex, Heart_Disease
ORDER BY Age DESC;

--- all columns with patients without heart disease
SELECT *
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 0
ORDER BY Age DESC;

--- percentage of both gender with heart disease having serum cholesterol greater than 240
SELECT Heart_Disease, (Count(Heart_Disease)* 100 / (SELECT Count(*) FROM [RAW_HeartFailurePrediction_20211229])) as Percentage_HeartDisease
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	 OR Heart_Disease = 0
GROUP BY Heart_Disease;

--- Shows patients below the age of 40 with heart disease
SELECT *
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	AND Age > 40
ORDER BY Age DESC;

--- Shows the number of male patients with heart disease
SELECT 
	COUNT(Sex) AS count_sex
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Sex = 'Male'
	AND Heart_Disease = 1;

--- Shows the number of female patients with heart disease
SELECT 
	COUNT(Sex) AS count_sex
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Sex = 'Female'
	AND Heart_Disease = 1;

--- Total number of patients with heart disease
SELECT *
	FROM [RAW_HeartFailurePrediction_20211229]
	WHERE Heart_Disease = 1;

--- Patients with diabetes, Typical Angina and cholesterol level greater than 240 that also have heart disease
SELECT *
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	AND Chest_Pain_Type Like 'T%'
	AND Fasting_BS = 1
	AND Cholesterol > 240;

--- patients with heart disease that also have diabetes, BP above 130, serum cholesterol above 240 and experiences pain during exercise
SELECT *
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	AND Resting_BP > 130
	AND cholesterol > 240
	AND Fasting_BS = 1 
	AND Exercise_Angina = 'Yes';

--- chest pain types when patients have BP greater than 130, cholesterol greater than 240 and heart disease
SELECT
CASE 
	WHEN Chest_Pain_Type = 'ASY' THEN 'RED'
	WHEN Chest_Pain_Type = 'TA' THEN 'B'
	WHEN Chest_Pain_Type = 'ATA' THEN 'C'
	ELSE 'D'
	END AS ChestPainGroup
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	 AND Resting_BP > 130
	 AND cholesterol > 240;

--- union select statements to get chest pain types
SELECT
CASE 
	WHEN Chest_Pain_Type = 'ASY' THEN 'RED'
	WHEN Chest_Pain_Type = 'TA' THEN 'B'
	WHEN Chest_Pain_Type = 'ATA' THEN 'C'
	ELSE 'D'
	END AS ChestPainGroup
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	 AND Resting_BP > 130
	 AND cholesterol > 240

UNION

SELECT Chest_Pain_Type
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	 AND Resting_BP > 130
	 AND cholesterol > 240;

--- Total number of heart disease patient with ASY  
SELECT 
	COUNT(Chest_Pain_Type) AS count_ASY
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Chest_Pain_Type = 'ASY'
	AND Heart_Disease = 1;

---Total number of heart disease patient with TA
SELECT 
	COUNT(Chest_Pain_Type) AS count_TA
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Chest_Pain_Type = 'TA'
	AND Heart_Disease = 1;

--- Total number of heart disease patient with ATA
SELECT 
	COUNT(Chest_Pain_Type) AS count_ATA
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Chest_Pain_Type = 'ATA'
	AND Heart_Disease = 1;

--- Total number of heart disease patient with NAP
SELECT 
	COUNT(Chest_Pain_Type) AS count_NAP
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Chest_Pain_Type = 'NAP'
	AND Heart_Disease = 1;

--- percentage chest pain types
SELECT Chest_Pain_Type, (Count(Chest_Pain_Type)* 100 / (SELECT Count(*) FROM [RAW_HeartFailurePrediction_20211229])) as Percentage_ChestPainType
FROM [RAW_HeartFailurePrediction_20211229]
GROUP BY Chest_Pain_Type;

--- percentage chest pain types with heart disease
SELECT Chest_Pain_Type, (Count(Chest_Pain_Type)* 100 / (SELECT Count(*) FROM [RAW_HeartFailurePrediction_20211229])) as Percentage_ChestPainType
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
GROUP BY Chest_Pain_Type;

--- maximum age of patients with heart disease and age above 30
SELECT
	MAX(Age) AS max_age,
	Sex,
	Heart_Disease
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	AND Age > 30
GROUP BY Sex, Heart_Disease
HAVING MAX(Age) > 0
ORDER BY MAX(Age);

--- TOP ten patients with heart disease and age above 30
SELECT TOP (10)
	Age,
	Sex,
	Heart_Disease
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	AND Age > 30
GROUP BY Age, Sex, Heart_Disease
ORDER BY Age DESC;

--- to check if high serum cholesterol indicates heart disease
SELECT *
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Cholesterol > 240
	AND Heart_Disease = 1;

--- count of patients with heart disesae between age 20 and 80
SELECT
	Age,
	Sex,
	Heart_Disease,
	COUNT(Heart_Disease) AS count_HeartDisease
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	AND Age BETWEEN 20 AND 80
GROUP BY Age, Sex, Heart_Disease
HAVING COUNT(Heart_Disease) > 0
ORDER BY count_HeartDisease DESC;

--- maximum and minimum cholesterol for each gender whith and whithout heart disease
SELECT
	Sex,
	Heart_Disease,
	MAX(Cholesterol) AS max_cholesterol,
	MIN(cholesterol) AS min_cholesterol
FROM [RAW_HeartFailurePrediction_20211229]
GROUP BY Sex, Heart_Disease;

--- percentage of both gender
SELECT Sex, (Count(Sex)* 100 / (SELECT Count(*) FROM [RAW_HeartFailurePrediction_20211229])) as MyPercentage
FROM [RAW_HeartFailurePrediction_20211229]
GROUP BY Sex;

--- percentage of both gender with heart disease
SELECT Sex, (Count(Sex)* 100 / (SELECT Count(*) FROM [RAW_HeartFailurePrediction_20211229])) as Percentage_HeartDisease
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
GROUP BY Sex;

--- percentage of both gender without heart disease
SELECT Sex, (Count(Sex)* 100 / (SELECT Count(*) FROM [RAW_HeartFailurePrediction_20211229])) as Percentage_HeartDisease
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 0
GROUP BY Sex;
   
--- percentage of both gender with heart disease having serum cholesterol greater than 240
SELECT Sex, (Count(Sex)* 100 / (SELECT Count(*) FROM [RAW_HeartFailurePrediction_20211229])) as Percentage_HeartDisease
FROM [RAW_HeartFailurePrediction_20211229]
WHERE Heart_Disease = 1
	AND Cholesterol > 240
GROUP BY Sex;