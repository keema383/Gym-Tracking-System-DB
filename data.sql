use GymTrackingDatabase;

DELIMITER $$

CREATE TRIGGER DecreaseTrainerCapacity BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    DECLARE current_capacity INT;
    SELECT Capacity INTO current_capacity FROM Trainers WHERE ID = NEW.TrainerID;
    IF current_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Trainer capacity has been reached.';
    ELSE
        UPDATE Trainers SET Capacity = Capacity - 1 WHERE ID = NEW.TrainerID;
    END IF;
END$$
DELIMITER ;

Select *
From Trainers;

INSERT INTO Diet (Water, Carbs, Protein, Vegies, Fruits, Duration) 
VALUES 
    (2000.00, 150.00, 120.50, 200.75, 180.25, '2 weeks'),
    (2500.00, 100.25, 150.75, 250.00, 200.50, '1 month'),
    (2200.00, 120.75, 100.25, 300.50, 220.75, '3 weeks'),
    (1800.00, 130.50, 110.75, 220.25, 240.00, '1 month'),
    (2400.00, 140.25, 90.50, 280.75, 190.25, '2 weeks'),
    (2100.00, 110.00, 130.25, 270.50, 210.75, '3 weeks'),
    (2300.00, 160.75, 80.25, 250.00, 230.50, '2 months'),
    (1900.00, 90.50, 140.75, 230.25, 200.75, '1 month'),
    (2500.00, 170.25, 70.00, 260.75, 250.25, '1 month'),
    (2000.00, 100.75, 160.25, 240.50, 220.00, '2 weeks');


INSERT INTO Trainers (FirstName, LastName, Qualification, WorkingDays, WorkingHours, Gender, Capacity, ContactPhone)
VALUES 
    ('Ararat', 'Hovhannisyan', 'Certified Personal Trainer', 'Monday, Wednesday, Friday', '9 AM - 5 PM', 'Male', 10, '091234561'),
    ('Anush', 'Movsisyan', 'Fitness Instructor', 'Tuesday, Thursday, Saturday', '10 AM - 6 PM', 'Female', 8, '094567892'),
    ('Tigran', 'Petrosyan', 'Strength and Conditioning Coach', 'Monday - Friday', '8 AM - 4 PM', 'Male', 12, '098765433'),
    ('Marine', 'Mkrtchyan', 'Yoga Instructor', 'Monday - Saturday', '6 AM - 12 PM', 'Female', 6, '093210988'),
    ('Gevorg', 'Martirosyan', 'CrossFit Trainer', 'Tuesday, Thursday, Saturday', '4 PM - 10 PM', 'Male', 8, '096543211'),
    ('Narine', 'Grigoryan', 'Pilates Instructor', 'Monday - Friday', '7 AM - 3 PM', 'Female', 6, '093890124'),
    ('Areg', 'Sahakyan', 'Nutritionist', 'Monday - Saturday', '9 AM - 5 PM', 'Male', 10, '093345679'),
    ('Lusine', 'Hakobyan', 'Personal Trainer', 'Monday - Friday', '10 AM - 6 PM', 'Female', 8, '091234560'),
    ('Gagik', 'Avetisyan', 'Zumba Instructor', 'Tuesday, Thursday, Saturday', '5 PM - 11 PM', 'Male', 8, '094567891'),
    ('Anna', 'Ghazaryan', 'Group Fitness Instructor', 'Monday, Wednesday, Friday', '2 PM - 8 PM', 'Female', 10, '098765432'),
    ('Varduhi', 'Poghosyan', 'Cardio Trainer', 'Monday - Saturday', '8 AM - 4 PM', 'Female', 8, '096543213'),
    ('Aramayis', 'Harutyunyan', 'Kickboxing Instructor', 'Monday, Wednesday, Friday', '6 AM - 12 PM', 'Male', 6, '091234562'),
    ('Tatev', 'Sargsyan', 'Senior Fitness Coach', 'Monday - Friday', '9 AM - 5 PM', 'Female', 12, '094567893'),
    ('Hayk', 'Grigoryan', 'Dance Instructor', 'Tuesday, Thursday, Saturday', '10 AM - 6 PM', 'Male', 8, '096543214'),
    ('Mariam', 'Avagyan', 'Weightlifting Coach', 'Monday - Saturday', '7 AM - 3 PM', 'Female', 10, '091234563');


INSERT INTO Users (FirstName, LastName, Dob, FitnessLevel, ContactPhone, Gender, TrainerID, City, DietID)
VALUES 
    ('Garik', 'Sargsyan', '1985-03-15', 'Advanced', '091234567', 'Male', 1, 'Yerevan', 1),
    ('Ani', 'Abrahamyan', '1990-07-25', 'Beginner', '094567890', 'Female', NULL, 'Gyumri', 2),
    ('Hayk', 'Melikyan', '1978-11-03', 'Intermediate', '098765432', 'Male', 3, 'Vanadzor', 3),
    ('Lilit', 'Karapetyan', '1983-05-22', 'Intermediate', '093210987', 'Female', 4, 'Abovyan', 4),
    ('Samvel', 'Harutyunyan', '1995-09-10', 'Advanced', '096543210', 'Male', 5, 'Kapan', 5),
    ('Armen', 'Margaryan', '1988-02-18', 'Advanced', '097890123', 'Male', 6, 'Hrazdan', 6),
    ('Nane', 'Sargsyan', '1980-08-30', 'Beginner', '091234567', 'Female', NULL, 'Armavir', 7),
    ('Vardan', 'Davtyan', '1992-04-05', 'Intermediate', '094567890', 'Male', 8, 'Artashat', 8),
    ('Lilit', 'Harutyunyan', '1986-12-12', 'Intermediate', '098765432', 'Female', 9, 'Gavar', 9),
    ('Gor', 'Khachatryan', '1975-06-20', 'Advanced', '093210987', 'Male', 10, 'Hrazdan', 10),
    ('Aram', 'Avetisyan', '1987-01-14', 'Intermediate', '094567890', 'Male', 11, 'Kapan', 1),
    ('Anahit', 'Grigoryan', '1984-09-08', 'Advanced', '096543210', 'Female', NULL, 'Gyumri', 2),
    ('Levon', 'Hakobyan', '1993-03-03', 'Beginner', '097890123', 'Male', 13, 'Vanadzor', 3),
    ('Sona', 'Petrosyan', '1981-07-17', 'Intermediate', '091234567', 'Female', 14, 'Artashat', 4),
    ('Ashot', 'Manukyan', '1979-11-28', 'Advanced', '094567890', 'Male', 15, 'Kapan', 5),
    ('Gayane', 'Poghosyan', '1989-05-06', 'Beginner', '098765432', 'Female', 1, 'Abovyan', 6),
    ('Vahan', 'Sahakyan', '2002-10-23', 'Intermediate', '093210987', 'Male', 2, 'Armavir', 7),
    ('Narine', 'Sargsyan', '2004-08-02', 'Advanced', '091234567', 'Female', 3, 'Artashat', 8),
    ('Artur', 'Vardanyan', '2001-04-19', 'Beginner', '094567890', 'Male', NULL, 'Kapan', 9),
    ('Marina', 'Gasparyan', '2000-12-25', 'Intermediate', '096543210', 'Female', 5, 'Gyumri', 10),
    ('Arevik', 'Grigoryan', '2003-06-14', 'Intermediate', '098765432', 'Female', 6, 'Vanadzor', 1),
    ('Karen', 'Avagyan', '2005-09-30', 'Advanced', '093210987', 'Male', 7, 'Hrazdan', 2),
    ('Ani', 'Hovhannisyan', '2002-03-11', 'Beginner', '091234567', 'Female', 8, 'Armavir', 3),
    ('Areg', 'Petrosyan', '1997-08-10', 'Advanced', '094567890', 'Male', 9, 'Artashat', 4),
    ('Anush', 'Sahakyan', '1996-02-23', 'Beginner', '096543210', 'Female', 10, 'Gavar', 5),
    ('Tigran', 'Martirosyan', '1998-11-05', 'Intermediate', '098765432', 'Male', 11, 'Hrazdan', 6),
    ('Anna', 'Mkrtchyan', '1999-06-17', 'Advanced', '091234567', 'Female', 12, 'Kapan', 7),
    ('Gagik', 'Galstyan', '1994-04-30', 'Beginner', '093210987', 'Male', 12, 'Yerevan', 8);
    
INSERT INTO TrainingProgram (MuscleGroup, Cardio, Stretching, DificultyLevel)
VALUES 
    ('Legs', 'Yes', 'PostWorkout', 'Beginner'),
    ('Back', 'Yes', 'PreWorkout', 'Intermediate'),
    ('Chest', 'No', 'No', 'Advanced'),
    ('Arms', 'Yes', 'PostWorkout', 'Beginner'),
    ('Shoulders', 'Yes', 'PreWorkout', 'Intermediate'),
    ('Core', 'No', 'No', 'Advanced'),
    ('Full Body', 'Yes', 'PostWorkout', 'Beginner'),
    ('Calisthenics', 'Yes', 'PreWorkout', 'Intermediate'),
    ('HIIT', 'Yes', 'PostWorkout', 'Intermediate'),
    ('Yoga', 'No', 'PostWorkout', 'Beginner');

INSERT INTO GymCenter (Name, City, Street, Building, WorkingDays, WorkingHour, Contact, Branch)
VALUES 
    ('FitLand', 'Yerevan', 'Northern Avenue', '15', 'Monday - Saturday', '8:00 AM - 10:00 PM', '091234567', 'Main Branch'),
    ('PowerGym', 'Gyumri', 'Shahumyan Street', '25', 'Monday - Friday', '7:00 AM - 9:00 PM', '094567890', 'Central Branch'),
    ('BodyZone', 'Vanadzor', 'Tigran Mets Avenue', '10', 'Monday - Saturday', '6:00 AM - 10:00 PM', '098765432', 'Downtown Branch'),
    ('MuscleFactory', 'Hrazdan', 'Isahakyan Street', '8', 'Monday - Friday', '9:00 AM - 8:00 PM', '096543210', 'City Center Branch'),
    ('FlexFit', 'Abovyan', 'Mashtots Avenue', '18', 'Monday - Saturday', '7:00 AM - 11:00 PM', '093210987', 'Park Branch'),
    ('IronWorks', 'Sevan', 'Geghama Street', '3', 'Monday - Friday', '6:00 AM - 9:00 PM', '097890123', 'Lakefront Branch'),
    ('BodyCraft', 'Kapan', 'Vardanants Street', '12', 'Monday - Saturday', '8:00 AM - 10:00 PM', '092345678', 'Downtown Branch'),
    ('FitZone', 'Hrazdan', 'Hakobyan Street', '5', 'Monday - Friday', '7:00 AM - 9:00 PM', '091234560', 'City Center Branch'),
    ('FitPlus', 'Goris', 'Vardan Mamikonyan Street', '20', 'Monday - Saturday', '6:00 AM - 10:00 PM', '094567891', 'Main Branch'),
    ('BodyTech', 'Vanadzor', 'Alek Manukyan Street', '7', 'Monday - Friday', '9:00 AM - 8:00 PM', '098765433', 'Downtown Branch');

INSERT INTO Measurements (UserID, Date, Height, Weight, WaistSize, HipSize, ChestSize, FatPercentage, MuscleMass)
VALUES 
    (1, '2024-05-01', 175.50, 80.00, 85.00, 100.00, 95.00, 20.00, 65.00),
    (2, '2024-05-02', 162.75, 65.50, 70.00, 90.00, 80.00, 25.00, 55.00),
    (3, '2024-05-03', 180.00, 90.25, 95.00, 105.00, 100.00, 18.00, 70.00),
    (4, '2024-05-04', 168.25, 70.75, 75.00, 95.00, 85.00, 22.00, 60.00),
    (5, '2024-05-05', 172.00, 75.50, 80.00, 100.00, 90.00, 21.00, 63.00),
    (6, '2024-05-06', 178.75, 85.25, 90.00, 110.00, 105.00, 19.00, 68.00),
    (7, '2024-05-07', 165.50, 70.00, 75.00, 95.00, 85.00, 23.00, 57.00),
    (8, '2024-05-08', 170.25, 75.75, 80.00, 100.00, 90.00, 20.00, 60.00),
    (9, '2024-05-09', 176.00, 85.50, 90.00, 110.00, 100.00, 18.50, 65.00),
    (10, '2024-05-10', 163.75, 70.25, 75.00, 95.00, 85.00, 22.50, 58.00),
	(11, '2024-05-11', 170.00, 72.50, 78.00, 98.00, 88.00, 21.50, 59.00),
    (12, '2024-05-12', 175.75, 82.25, 88.00, 108.00, 98.00, 19.50, 64.00),
    (13, '2024-05-13', 166.50, 69.00, 73.00, 93.00, 83.00, 24.00, 56.00),
    (14, '2024-05-14', 172.25, 76.75, 83.00, 103.00, 93.00, 20.50, 61.00),
    (15, '2024-05-15', 177.00, 86.50, 93.00, 113.00, 103.00, 18.75, 66.00),
    (16, '2024-05-16', 164.75, 71.25, 77.00, 97.00, 87.00, 22.25, 58.00),
    (17, '2024-05-17', 169.50, 77.00, 83.00, 103.00, 93.00, 21.00, 62.00),
    (18, '2024-05-18', 174.25, 84.75, 93.00, 113.00, 103.00, 19.25, 67.00),
    (19, '2024-05-19', 165.00, 73.50, 79.00, 99.00, 89.00, 23.00, 59.00),
    (20, '2024-05-20', 170.75, 78.25, 88.00, 108.00, 98.00, 20.75, 63.00),
    (21, '2024-05-21', 175.50, 80.00, 85.00, 100.00, 95.00, 20.00, 65.00),
    (22, '2024-05-22', 162.75, 65.50, 70.00, 90.00, 80.00, 25.00, 55.00),
    (23, '2024-05-23', 180.00, 90.25, 95.00, 105.00, 100.00, 18.00, 70.00),
    (24, '2024-05-24', 168.25, 70.75, 75.00, 95.00, 85.00, 22.00, 60.00),
    (25, '2024-05-25', 172.00, 75.50, 80.00, 100.00, 90.00, 21.00, 63.00),
    (26, '2024-05-26', 178.75, 85.25, 90.00, 110.00, 105.00, 19.00, 68.00),
    (27, '2024-05-27', 165.50, 70.00, 75.00, 95.00, 85.00, 23.00, 57.00),
    (28, '2024-05-28', 170.25, 75.75, 80.00, 100.00, 90.00, 20.00, 60.00);

INSERT INTO Goals (UserID, Date, HealthCondition, TargetWeight, TargetWaistSize, TargetHipSize, TargetChestSize, TargetFatPercentage, TargetMuscleMass, Timeline)
VALUES 
    (1, '2024-05-01', 'Reduce body fat', 75.00, 80.00, 95.00, 90.00, 15.00, 70.00, '3 months'),
    (2, '2024-05-02', 'Increase muscle mass', 70.00, 75.00, 95.00, 85.00, 20.00, 60.00, '6 months'),
    (3, '2024-05-03', 'Improve cardiovascular health', 85.00, 90.00, 110.00, 100.00, 18.00, 75.00, '1 year'),
    (4, '2024-05-04', 'Tone and sculpt body', 70.00, 75.00, 95.00, 85.00, 22.00, 65.00, '6 months'),
    (5, '2024-05-05', 'Gain strength and endurance', 80.00, 85.00, 100.00, 95.00, 17.00, 65.00, '9 months'),
    (6, '2024-05-06', 'Achieve balanced physique', 85.00, 90.00, 110.00, 100.00, 18.00, 70.00, '1 year'),
    (7, '2024-05-07', 'Lose weight and reduce body fat', 75.00, 80.00, 95.00, 90.00, 15.00, 65.00, '3 months'),
    (8, '2024-05-08', 'Increase muscle definition', 70.00, 75.00, 95.00, 85.00, 20.00, 62.00, '6 months'),
    (9, '2024-05-09', 'Improve overall fitness', 80.00, 85.00, 100.00, 95.00, 17.00, 70.00, '9 months'),
    (10, '2024-05-10', 'Enhance athletic performance', 85.00, 90.00, 110.00, 100.00, 18.00, 75.00, '1 year'),
    (11, '2024-05-11', 'Improve flexibility', 70.00, 75.00, 95.00, 85.00, 20.00, 60.00, '6 months'),
    (12, '2024-05-12', 'Enhance cardiovascular endurance', 85.00, 90.00, 110.00, 100.00, 18.00, 70.00, '1 year'),
    (13, '2024-05-13', 'Gain lean muscle mass', 80.00, 85.00, 100.00, 95.00, 17.00, 65.00, '9 months'),
    (14, '2024-05-14', 'Improve posture and core strength', 75.00, 80.00, 95.00, 90.00, 15.00, 70.00, '3 months'),
    (15, '2024-05-15', 'Increase energy levels and vitality', 70.00, 75.00, 95.00, 85.00, 20.00, 62.00, '6 months'),
    (16, '2024-05-16', 'Reduce stress and improve mental health', 85.00, 90.00, 110.00, 100.00, 18.00, 68.00, '1 year'),
    (17, '2024-05-17', 'Enhance body symmetry and proportion', 75.00, 80.00, 95.00, 90.00, 15.00, 65.00, '3 months'),
    (18, '2024-05-18', 'Improve agility and coordination', 70.00, 75.00, 95.00, 85.00, 20.00, 64.00, '6 months'),
    (19, '2024-05-19', 'Build overall muscle strength', 80.00, 85.00, 100.00, 95.00, 17.00, 70.00, '9 months'),
    (20, '2024-05-20', 'Increase bone density and prevent osteoporosis', 85.00, 90.00, 110.00, 100.00, 18.00, 75.00, '1 year'),
    (21, '2024-05-21', 'Enhance sports performance and agility', 70.00, 75.00, 95.00, 85.00, 20.00, 60.00, '6 months'),
    (22, '2024-05-22', 'Achieve a balanced and healthy lifestyle', 85.00, 90.00, 110.00, 100.00, 18.00, 70.00, '1 year'),
    (23, '2024-05-23', 'Improve cardiovascular health and endurance', 80.00, 85.00, 100.00, 95.00, 17.00, 65.00, '9 months'),
    (24, '2024-05-24', 'Reduce body fat percentage and increase lean muscle mass', 75.00, 80.00, 95.00, 90.00, 15.00, 70.00, '3 months'),
    (25, '2024-05-25', 'Increase muscle definition and tone', 70.00, 75.00, 95.00, 85.00, 20.00, 62.00, '6 months'),
    (26, '2024-05-26', 'Improve overall strength and fitness', 85.00, 90.00, 110.00, 100.00, 18.00, 68.00, '1 year'),
    (27, '2024-05-27', 'Achieve weight loss and improve body composition', 75.00, 80.00, 95.00, 90.00, 15.00, 65.00, '3 months'),
    (28, '2024-05-28', 'Increase muscle mass and strength', 80.00, 85.00, 100.00, 95.00, 17.00, 70.00, '9 months');
    

INSERT INTO UserHealthCondition (UserID, HealthCondition, Alergies, Limitations, Medication)
VALUES 
    (1, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (2, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (3, 'Diabetes', 'None', 'Avoid high-impact exercises', 'Insulin'),
    (4, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (5, 'Allergies', 'Shellfish', 'Strict diet', 'Ibuprofen'),
    (6, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (7, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (8, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (9, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (10, 'Celiac Disease', 'Gluten', 'Strict diet', 'None'),
    (11, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (12, 'Osteoporosis', 'None', 'Regular weight-bearing exercises', 'Calcium supplements'),
    (13, 'High Cholesterol', 'Eggs', 'Strict diet', 'Statins'),
    (14, 'Allergies', 'None', 'Strict diet', NULL),
    (15, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (16, 'Chronic Pain', 'Dairy', 'Avoid high-impact exercises', 'Probiotics'),
    (17, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (18, 'Allergies', 'Dust mites',  'Strict diet', 'Nasal corticosteroids'),
    (19, 'Gout', 'Pollen', 'Regular weight-bearing exercises', 'Topical steroids'),
    (20, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (21, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (22, 'Gout', 'Shellfish', 'Regular weight-bearing exercises', 'Colchicine'),
    (23, 'Chronic Pain', 'None',  'Avoid high-impact exercises', 'NSAIDs'),
    (24, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL),
    (25, 'Chronic Pain', 'Dairy','Avoid high-impact exercises', 'Topical retinoids'),
    (26, 'Diabetes', 'None', 'Avoid high-impact exercises', NULL),
    (27, 'Chronic Pain', 'Dairy', 'Avoid high-impact exercises', 'Probiotics'),
    (28, 'Healthy', 'None', 'Maintain regular exercise routine and balanced diet', NULL);

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(1, 4, '2024-05-05', '2024-05-06'),
(1, 7, '2024-05-06', '2024-05-07'),
(1, 8, '2024-05-07', '2024-05-08'),
(1, 2, '2024-05-08', '2024-05-09'),
(1, 10, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(2, 5, '2024-05-05', '2024-05-06'),
(2, 8, '2024-05-06', '2024-05-07'),
(2, 3, '2024-05-07', '2024-05-08'),
(2, 9, '2024-05-08', '2024-05-09'),
(2, 6, '2024-05-09', '2024-05-10');


INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(3, 3, '2024-05-05', '2024-05-06'),
(3, 9, '2024-05-06', '2024-05-07'),
(3, 7, '2024-05-07', '2024-05-08'),
(3, 1, '2024-05-08', '2024-05-09'),
(3, 10, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(4, 6, '2024-05-05', '2024-05-06'),
(4, 2, '2024-05-06', '2024-05-07'),
(4, 5, '2024-05-07', '2024-05-08'),
(4, 4, '2024-05-08', '2024-05-09'),
(4, 8, '2024-05-09', '2024-05-10');


INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(5, 8, '2024-05-05', '2024-05-06'),
(5, 4, '2024-05-06', '2024-05-07'),
(5, 6, '2024-05-07', '2024-05-08'),
(5, 3, '2024-05-08', '2024-05-09'),
(5, 1, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(6, 9, '2024-05-05', '2024-05-06'),
(6, 1, '2024-05-06', '2024-05-07'),
(6, 7, '2024-05-07', '2024-05-08'),
(6, 5, '2024-05-08', '2024-05-09'),
(6, 2, '2024-05-09', '2024-05-10');


INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(7, 2, '2024-05-05', '2024-05-06'),
(7, 3, '2024-05-06', '2024-05-07'),
(7, 10, '2024-05-07', '2024-05-08'),
(7, 6, '2024-05-08', '2024-05-09'),
(7, 9, '2024-05-09', '2024-05-10');


INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(8, 1, '2024-05-05', '2024-05-06'),
(8, 10, '2024-05-06', '2024-05-07'),
(8, 6, '2024-05-07', '2024-05-08'),
(8, 8, '2024-05-08', '2024-05-09'),
(8, 3, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(9, 5, '2024-05-05', '2024-05-06'),
(9, 9, '2024-05-06', '2024-05-07'),
(9, 2, '2024-05-07', '2024-05-08'),
(9, 1, '2024-05-08', '2024-05-09'),
(9, 7, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(10, 7, '2024-05-05', '2024-05-06'),
(10, 5, '2024-05-06', '2024-05-07'),
(10, 1, '2024-05-07', '2024-05-08'),
(10, 3, '2024-05-08', '2024-05-09'),
(10, 8, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(11, 3, '2024-05-05', '2024-05-06'),
(11, 9, '2024-05-06', '2024-05-07'),
(11, 7, '2024-05-07', '2024-05-08'),
(11, 2, '2024-05-08', '2024-05-09'),
(11, 5, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(12, 8, '2024-05-05', '2024-05-06'),
(12, 1, '2024-05-06', '2024-05-07'),
(12, 5, '2024-05-07', '2024-05-08'),
(12, 4, '2024-05-08', '2024-05-09'),
(12, 10, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(13, 4, '2024-05-05', '2024-05-06'),
(13, 6, '2024-05-06', '2024-05-07'),
(13, 2, '2024-05-07', '2024-05-08'),
(13, 8, '2024-05-08', '2024-05-09'),
(13, 3, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(14, 2, '2024-05-05', '2024-05-06'),
(14, 7, '2024-05-06', '2024-05-07'),
(14, 9, '2024-05-07', '2024-05-08'),
(14, 1, '2024-05-08', '2024-05-09'),
(14, 6, '2024-05-09', '2024-05-10');


INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(15, 10, '2024-05-05', '2024-05-06'),
(15, 3, '2024-05-06', '2024-05-07'),
(15, 6, '2024-05-07', '2024-05-08'),
(15, 7, '2024-05-08', '2024-05-09'),
(15, 4, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(16, 5, '2024-05-05', '2024-05-06'),
(16, 2, '2024-05-06', '2024-05-07'),
(16, 8, '2024-05-07', '2024-05-08'),
(16, 10, '2024-05-08', '2024-05-09'),
(16, 1, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(17, 9, '2024-05-05', '2024-05-06'),
(17, 4, '2024-05-06', '2024-05-07'),
(17, 1, '2024-05-07', '2024-05-08'),
(17, 6, '2024-05-08', '2024-05-09'),
(17, 5, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(18, 3, '2024-05-05', '2024-05-06'),
(18, 5, '2024-05-06', '2024-05-07'),
(18, 10, '2024-05-07', '2024-05-08'),
(18, 9, '2024-05-08', '2024-05-09'),
(18, 8, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(19, 1, '2024-05-05', '2024-05-06'),
(19, 6, '2024-05-06', '2024-05-07'),
(19, 7, '2024-05-07', '2024-05-08'),
(19, 8, '2024-05-08', '2024-05-09'),
(19, 3, '2024-05-09', '2024-05-10');


INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(20, 9, '2024-05-05', '2024-05-06'),
(20, 2, '2024-05-06', '2024-05-07'),
(20, 4, '2024-05-07', '2024-05-08'),
(20, 5, '2024-05-08', '2024-05-09'),
(20, 10, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(21, 2, '2024-05-05', '2024-05-06'),
(21, 5, '2024-05-06', '2024-05-07'),
(21, 1, '2024-05-07', '2024-05-08'),
(21, 8, '2024-05-08', '2024-05-09'),
(21, 9, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(22, 4, '2024-05-05', '2024-05-06'),
(22, 9, '2024-05-06', '2024-05-07'),
(22, 6, '2024-05-07', '2024-05-08'),
(22, 3, '2024-05-08', '2024-05-09'),
(22, 7, '2024-05-09', '2024-05-10');


INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(23, 6, '2024-05-05', '2024-05-06'),
(23, 10, '2024-05-06', '2024-05-07'),
(23, 2, '2024-05-07', '2024-05-08'),
(23, 7, '2024-05-08', '2024-05-09'),
(23, 5, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(24, 8, '2024-05-05', '2024-05-06'),
(24, 3, '2024-05-06', '2024-05-07'),
(24, 1, '2024-05-07', '2024-05-08'),
(24, 4, '2024-05-08', '2024-05-09'),
(24, 9, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(25, 7, '2024-05-05', '2024-05-06'),
(25, 4, '2024-05-06', '2024-05-07'),
(25, 6, '2024-05-07', '2024-05-08'),
(25, 8, '2024-05-08', '2024-05-09'),
(25, 2, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(26, 1, '2024-05-05', '2024-05-06'),
(26, 2, '2024-05-06', '2024-05-07'),
(26, 9, '2024-05-07', '2024-05-08'),
(26, 10, '2024-05-08', '2024-05-09'),
(26, 3, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(27, 5, '2024-05-05', '2024-05-06'),
(27, 9, '2024-05-06', '2024-05-07'),
(27, 1, '2024-05-07', '2024-05-08'),
(27, 7, '2024-05-08', '2024-05-09'),
(27, 10, '2024-05-09', '2024-05-10');

INSERT INTO UserTrainingProgram (UserID, ProgramID, StartDate, EndDate) VALUES
(28, 2, '2024-05-05', '2024-05-06'),
(28, 7, '2024-05-06', '2024-05-07'),
(28, 4, '2024-05-07', '2024-05-08'),
(28, 5, '2024-05-08', '2024-05-09'),
(28, 6, '2024-05-09', '2024-05-10');

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (1, 2, 'Monthly', '2024-05-01', '2024-05-31', 10);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (2, 3, 'Premium', '2024-01-01', '2024-12-31', 200),
    (2, 4, 'Monthly', '2024-03-01', '2024-03-31', 15);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (3, 1, 'Monthly', '2024-02-01', '2024-02-29', 20),
    (3, 2, 'Annual', '2024-04-01', '2024-04-30', 150);
    
INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (4, 3, 'Monthly', '2024-01-15', '2024-02-14', 12);


INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (5, 1, 'Annual', '2024-02-01', '2024-01-31', 150),
    (5, 5, 'Monthly', '2024-04-01', '2024-04-30', 8);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (6, 2, 'Monthly', '2024-01-15', '2024-02-14', 15),
    (6, 6, 'Annual', '2024-03-01', '2024-02-29', 200);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (7, 7, 'Premium', '2024-04-01', '2024-04-30', 120);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (8, 4, 'Annual', '2024-01-15', '2024-02-14', 160),
    (8, 8, 'Monthly', '2024-03-01', '2024-02-29', 6);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (9, 9, 'Annual', '2024-04-01', '2024-04-30', 100);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (10, 6, 'Annual', '2024-01-15', '2024-02-14', 190),
    (10, 10, 'Monthly', '2024-03-01', '2024-02-29', 5);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (11, 7, 'Monthly', '2024-02-01', '2024-01-31', 18),
    (11, 1, 'Annual', '2024-04-01', '2024-04-30', 145);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (12, 8, 'Annual', '2024-01-15', '2024-02-14', 130),
    (12, 2, 'Monthly', '2024-03-01', '2024-02-29', 12);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (13, 9, 'Monthly', '2024-02-01', '2024-01-31', 15);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (14, 4, 'Monthly', '2024-03-01', '2024-02-29', 9);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (15, 1, 'Monthly', '2024-02-01', '2024-01-31', 25),
    (15, 5, 'Annual', '2024-04-01', '2024-04-30', 175);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (16, 2, 'Premium', '2024-01-15', '2024-02-14', 140);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (17, 7, 'Annual', '2024-04-01', '2024-04-30', 135);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (18, 4, 'Annual', '2024-01-15', '2024-02-14', 120),
    (18, 8, 'Monthly', '2024-03-01', '2024-02-29', 7);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (19, 5, 'Monthly', '2024-02-01', '2024-01-31', 22);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (20, 6, 'Annual', '2024-01-15', '2024-02-14', 160),
    (20, 10, 'Monthly', '2024-03-01', '2024-02-29', 6);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (21, 7, 'Monthly', '2024-02-01', '2024-01-31', 16),
    (21, 1, 'Annual', '2024-04-01', '2024-04-30', 130);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (22, 8, 'Annual', '2024-01-15', '2024-02-14', 140),
    (22, 2, 'Monthly', '2024-03-01', '2024-02-29', 10);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (23, 9, 'Monthly', '2024-02-01', '2024-01-31', 17);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (24, 4, 'Premium', '2024-03-01', '2024-02-29', 8);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (25, 1, 'Monthly', '2024-02-01', '2024-01-31', 20);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (26, 2, 'Premium', '2024-01-15', '2024-02-14', 150);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (27, 3, 'Monthly', '2024-02-01', '2024-01-31', 18);

INSERT INTO UserGym (UserID, GymID, MembershipType, StartDate, EndDate, VisitsLeft)
VALUES 
    (28, 4, 'Annual', '2024-01-15', '2024-02-14', 140);

INSERT INTO TrainerGym (TrainerID, GymID, TrainingType) VALUES
(1, 1, 'Individual'),
(1, 2, 'Group'),
(2, 7, 'Individual'),
(3, 1, 'Individual'),
(3, 8, 'Group'),
(4, 3, 'Individual'),
(4, 5, 'Group'),
(4, 9, 'Group'),
(5, 1, 'Individual'),
(5, 10, 'Group'),
(6, 2, 'Individual'),
(6, 7, 'Group'),
(6, 6, 'Group'),
(7, 2, 'Individual'),
(7, 8, 'Group'),
(8, 8, 'Individual'),
(8, 9, 'Group'),
(9, 9, 'Individual'),
(9, 4, 'Group'),
(10, 10, 'Individual'),
(10, 1, 'Group'),
(11, 2, 'Group'),
(12, 2, 'Individual'),
(12, 3, 'Group'),
(13, 9, 'Individual'),
(14, 4, 'Individual'),
(14, 5, 'Group'),
(15, 1, 'Individual'),
(15, 6, 'Individual'),
(15, 5, 'Individual');

