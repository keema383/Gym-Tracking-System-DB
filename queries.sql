use GymTrackingDatabase;

-- 1 Finding trainers who are available on specific day and time:

SELECT FirstName, LastName 
FROM Trainers
WHERE WorkingDays LIKE '%Saturday%' and WorkingHours LIKE '10 AM - 6 PM';


-- 2 List of Trainers with the Number of Users They Train

SELECT T.ID, T.FirstName, T.LastName, COUNT(U.ID) AS NumberOfUsers, GROUP_CONCAT(U.FirstName, ' ', U.LastName) AS UserNames
FROM Trainers as T
JOIN Users as U ON T.ID = U.TrainerID
GROUP BY T.ID;

-- 3. Average Age of Users for Each Fitness Level

SELECT FitnessLevel, ROUND(AVG(YEAR(CURDATE()) - YEAR(u.Dob))) AS AverageAge
FROM Users u
GROUP BY FitnessLevel;

-- 4. Find Users who are not healthy and Their Trainers

SELECT U.FirstName AS UserFirstName, U.LastName AS UserLastName, UHC.HealthCondition, T.FirstName AS TrainerFirstName, T.LastName AS TrainerLastName
FROM UserHealthCondition as UHC
JOIN Users as U ON UHC.UserID = U.ID
JOIN Trainers as T ON U.TrainerID = T.ID
WHERE UHC.HealthCondition != 'Healthy';

-- 5. List of Users Who Need to Renew Membership

SELECT U.FirstName, U.LastName,  UG.GymID, UG.EndDate
FROM UserGym as UG
JOIN Users as U ON UG.UserID = U.ID
WHERE UG.EndDate <= CURDATE();

-- 6. Users' Health Conditions, Alergies, Limitations Distribution:

SELECT HealthCondition, COUNT(*) AS UserCount
FROM UserHealthCondition
GROUP BY HealthCondition;

SELECT Alergies, COUNT(*) AS UserCount
FROM UserHealthCondition
GROUP BY Alergies;

SELECT Limitations, COUNT(*) AS UserCount
FROM UserHealthCondition
GROUP BY Limitations;

-- 7. Average Fat Percentage of all Users in each week of the month:

SELECT 
    MIN(Date) AS WeekStartingDate,
    ROUND(AVG(FatPercentage), 2) AS AvgFatPercentage
FROM (
    SELECT 
        *,
        FLOOR(DATEDIFF(Date, '2024-05-01') / 7) AS WeekNumber
    FROM 
        Measurements
    WHERE
        Date >= '2024-05-01' 
) AS WeekGroups
GROUP BY 
    WeekNumber;
    
-- 8)  -- Calculationg how much users need to change in their  mesurements to reach their goals 
SELECT 
	u.ID,
    u.FirstName, 
    u.LastName,
    (m.Weight - g.TargetWeight) AS WeightDifference,
    (m.WaistSize - g.TargetWaistSize) AS WaistSizeDifference,
    (m.HipSize - g.TargetHipSize) AS HipSizeDifference,
    (m.ChestSize - g.TargetChestSize) AS ChestSizeDifference,
    (m.FatPercentage - g.TargetFatPercentage) AS FatPercentageDifference,
    (m.MuscleMass - g.TargetMuscleMass) AS MuscleMassDifference
FROM 
    Users u
JOIN 
    Measurements m ON u.ID = m.UserID
JOIN 
    Goals g ON u.ID = g.UserID;
    
-- 9) find gym centers close for each user using their city and check if they are members there 
SELECT 
    u.FirstName, 
    u.LastName, 
    gc.GymID, 
    gc.Name,
    CASE 
        WHEN ug.UserID IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS IsMember
FROM 
    Users u
JOIN 
    GymCenter gc ON u.City = gc.City
LEFT JOIN 
    UserGym ug ON u.ID = ug.UserID AND gc.GymID = ug.GymID;
    
-- 10) Gym Centers with an average user age less than 32

SELECT 
    gc.Name AS GymName,
    AVG(YEAR(CURDATE()) - YEAR(u.Dob)) AS AverageAge
FROM 
    GymCenter gc
JOIN 
    UserGym ug ON gc.GymID = ug.GymID
JOIN 
    Users u ON ug.UserID = u.ID
GROUP BY 
    gc.Name
HAVING 
    AverageAge < 32;

-- 11) Users enrolled in training programs that are more advanced than their level

SELECT u.ID, u.FirstName, u.LastName, u.FitnessLevel, tp.MuscleGroup, tp.DificultyLevel
FROM Users u
JOIN UserTrainingProgram utp ON u.ID = utp.UserID
JOIN TrainingProgram tp ON utp.ProgramID = tp.ProgramID
WHERE (u.FitnessLevel = 'Beginner' AND tp.DificultyLevel IN ('Intermediate', 'Advanced'))
   OR (u.FitnessLevel = 'Intermediate' AND tp.DificultyLevel = 'Advanced');
   
-- 12) the average amounts of each component in diets for people of different age groups  

SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, u.Dob, CURDATE()) BETWEEN 0 AND 18 THEN '0-18'
        WHEN TIMESTAMPDIFF(YEAR, u.Dob, CURDATE()) BETWEEN 19 AND 30 THEN '19-30'
        WHEN TIMESTAMPDIFF(YEAR, u.Dob, CURDATE()) BETWEEN 31 AND 50 THEN '31-50'
        ELSE '51+'
    END AS AgeGroup,
    AVG(d.Carbs) AS AvgCarbs,
    AVG(d.Protein) AS AvgProtein,
    AVG(d.Vegies) AS AvgVeggies,
    AVG(d.Fruits) AS AvgFruites,
    AVG(d.Water) AS AvgWater
FROM
    Users u
JOIN
    Diet d ON u.DietID = d.DietID
GROUP BY
    AgeGroup;
    
-- 13)  The number of users at each gym

SELECT
    ug.GymID,
    gc.Name AS GymName,
    COUNT(ug.UserID) AS NumberOfUsers
FROM
    UserGym ug
JOIN
    GymCenter gc ON ug.GymID = gc.GymID
GROUP BY
    ug.GymID, gc.Name;
    
-- 14) determine each user's goal in terms of weight

SELECT
    u.FirstName,
    u.LastName,
    CASE
        WHEN g.TargetWeight < m.Weight THEN 'Weight loss'
        WHEN g.TargetWeight > m.Weight THEN 'Weight gain'
        ELSE 'Maintain weight'
    END AS Weight,
	CASE
        WHEN g.TargetWaistSize < m.WaistSize THEN 'Smaller Waist'
        WHEN g.TargetWaistSize > m.WaistSize THEN 'Bigger Waist'
        ELSE 'Same size waist'
    END AS Waist,
	CASE
        WHEN g.TargetChestSize < m.ChestSize THEN 'Smaller Chest'
        WHEN g.TargetChestSize > m.ChestSize THEN 'Bigger Chest'
        ELSE 'Same size chest'
    END AS Waist,
	CASE
        WHEN g.TargetHipSize < m.HipSize THEN 'Smaller Hips'
        WHEN g.TargetHipSize > m.HipSize THEN 'Bigger Hips'
        ELSE 'Same size hips'
    END AS Waist
FROM
    Users u
JOIN
    Goals g ON u.ID = g.UserID
JOIN
    Measurements m ON u.ID = m.UserID;
    
-- 15) Trainers and their Capacity (used and free)

SELECT 
    FirstName, 
    LastName, 
    Capacity,
    (SELECT COUNT(*) FROM Users WHERE TrainerID = Trainers.ID) AS AssignedUsers,
    (Capacity - (SELECT COUNT(*) FROM Users WHERE TrainerID = Trainers.ID)) AS FreeCapacity
FROM Trainers
ORDER BY FreeCapacity ASC;

-- 16) Find the shortest diets 

WITH MinDuration AS (
    SELECT MIN(
        CASE 
            WHEN Duration LIKE '% week%' THEN CAST(SUBSTRING_INDEX(Duration, ' week', 1) AS UNSIGNED) * 7
            WHEN Duration LIKE '% month%' THEN CAST(SUBSTRING_INDEX(Duration, ' month', 1) AS UNSIGNED) * 30
        END
    ) AS MinDurationInDays
    FROM Diet
)
SELECT *
FROM Diet
WHERE 
    (SELECT MinDurationInDays FROM MinDuration) =
    CASE 
        WHEN Duration LIKE '% week%' THEN CAST(SUBSTRING_INDEX(Duration, ' week', 1) AS UNSIGNED) * 7
        WHEN Duration LIKE '% month%' THEN CAST(SUBSTRING_INDEX(Duration, ' month', 1) AS UNSIGNED) * 30
    END;
  
-- 17) Find all users who train without trainers using EXISTS

SELECT *
FROM Users u
WHERE NOT EXISTS (
    SELECT *
    FROM Trainers t
    WHERE t.ID = u.TrainerID
);

-- 18) Find all users who train without trainers using LEFT JOIN


SELECT
    u.ID,
    u.FirstName,
    u.LastName,
    u.FitnessLevel,
    u.City,
    u.ContactPhone,
    u.Gender
FROM
    Users u
LEFT JOIN
    Trainers t ON u.TrainerID = t.ID
WHERE
    u.TrainerID IS NULL;

-- 19) Find the most popular training programmes

WITH ProgramCounts AS (
    SELECT ProgramID, COUNT(*) AS UserCount
    FROM UserTrainingProgram
    GROUP BY ProgramID
)
SELECT tp.*, pc.UserCount AS UsageCount
FROM TrainingProgram tp
JOIN ProgramCounts pc ON tp.ProgramID = pc.ProgramID
WHERE pc.UserCount = (
    SELECT MAX(UserCount)
    FROM ProgramCounts
);

-- 20) User Statistics by Fitness Level and Gender

CREATE VIEW UserStatistics AS
SELECT
    FitnessLevel,
    Gender,
    COUNT(*) AS TotalUsers,
    AVG(YEAR(CURRENT_DATE) - YEAR(Dob)) AS AverageAge,
    AVG(Measurements.Weight) AS AverageWeight
FROM
    Users JOIN Measurements
GROUP BY
    FitnessLevel,
    Gender;
    
select *
from UserStatistics;

-- 21) Getting the user ID as annput return the weight change the user need to each to their goal

DELIMITER //

CREATE FUNCTION weight_change_target(user_id INT) 
RETURNS DECIMAL(5,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE target_weight_change DECIMAL(5,2);
    DECLARE initial_weight DECIMAL(5,2);
    DECLARE target_weight DECIMAL(5,2);
    
    SELECT Weight INTO initial_weight
    FROM Measurements
    WHERE UserID = user_id
    ORDER BY Date ASC
    LIMIT 1;
    
    SELECT TargetWeight INTO target_weight
    FROM Goals
    WHERE UserID = user_id
    ORDER BY Date DESC
    LIMIT 1;
    
    SET target_weight_change = initial_weight - target_weight;
    
    RETURN target_weight_change;
END //

DELIMITER ;
SELECT weight_change_target(1);

-- 22) Find all gyms in the given city

DELIMITER //

CREATE FUNCTION get_gyms_in_city(city_name VARCHAR(50))
RETURNS VARCHAR(255)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE gym_names VARCHAR(255);
    
    SET gym_names = '';
    
    SELECT GROUP_CONCAT(Name SEPARATOR ', ') INTO gym_names
    FROM GymCenter
    WHERE City = city_name;
    
    RETURN gym_names;
END //

DELIMITER ;

SELECT get_gyms_in_city('Hrazdan');

-- 23) Return the names of the trainers for the given Gym

DELIMITER //
create procedure gym_trainers (Gym_id varchar(50))
begin
  select t.firstName, t.lastName
  from Trainers t left join TrainerGym  tg on t.ID = tg.TrainerID
        where tg.GymID = Gym_id;
        
end;

//             
DELIMITER ;

call gym_trainers(1);

-- 24) Calculate the BMI(Body Mass Index) of the user given the user ID
DELIMITER $$

CREATE FUNCTION CalculateBMI(UserID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE userWeight DECIMAL(10,2);
    DECLARE userHeightCM DECIMAL(10,2);  -- Store height in centimeters
    DECLARE userHeightM DECIMAL(10,2);   -- Convert height to meters
    DECLARE userBMI DECIMAL(10,2);

    SELECT Weight, Height INTO userWeight, userHeightCM
    FROM Measurements
    WHERE UserID = UserID
    ORDER BY Date DESC
    LIMIT 1;

    SET userHeightM = userHeightCM / 100;
    SET userBMI = userWeight / (userHeightM * userHeightM);

    RETURN userBMI;
END$$

DELIMITER ;

Select CalculateBMI(1);


CREATE INDEX idx_measurement_weight ON Measurements (UserID, Date DESC, Weight);

