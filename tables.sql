Drop database GymTrackingDatabase;
CREATE DATABASE  IF NOT EXISTS GymTrackingDatabase;
USE GymTrackingDatabase;

CREATE TABLE IF NOT EXISTS Trainers (
    ID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Qualification VARCHAR(50) NOT NULL,
    WorkingDays VARCHAR(50) NOT NULL,
    WorkingHours VARCHAR(50) NOT NULL,
    ContactPhone VARCHAR(9) NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    Capacity INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Diet (
    DietID INT NOT NULL AUTO_INCREMENT,
    Water DECIMAL(10 , 2 ) NOT NULL,
    Carbs DECIMAL(10 , 2 ) NOT NULL,
    Protein DECIMAL(10 , 2 ) NOT NULL,
    Vegies DECIMAL(10 , 2 ) NOT NULL,
    Fruits DECIMAL(10 , 2 ) NOT NULL,
    Duration VARCHAR(50) NOT NULL,
    PRIMARY KEY (DietID)
);

CREATE TABLE IF NOT EXISTS Users (
    ID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Dob DATE NOT NULL,
    FitnessLevel ENUM('Beginner', 'Intermediate', 'Advanced') NOT NULL,
    City VARCHAR(50) NOT NULL,
    ContactPhone VARCHAR(9) NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    DietID INT,
    TrainerID INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (DietID) REFERENCES Diet(DietID),
    FOREIGN KEY (TrainerID) references Trainers(ID)
);


CREATE TABLE IF NOT EXISTS TrainingProgram (
    ProgramID INT NOT NULL AUTO_INCREMENT,
    MuscleGroup VARCHAR(50) NOT NULL,
    Cardio ENUM('Yes', 'No') NOT NULL,
    Stretching ENUM('PreWorkout', 'PostWorkout', 'No') NOT NULL,
  DificultyLevel ENUM('Beginner', 'Intermediate', 'Advanced') NOT NULL,
    PRIMARY KEY (ProgramID)
);

CREATE TABLE IF NOT EXISTS GymCenter (
    GymID INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Street VARCHAR(50) NOT NULL,
    Building VARCHAR(50) NOT NULL,
    WorkingDays VARCHAR(50) NOT NULL, 
    WorkingHour VARCHAR(50) NOT NULL, 
    Contact int(9) NOT NULL,
    Branch VARCHAR(50) NOT NULL,
    PRIMARY KEY (GymID)
);


CREATE TABLE IF NOT EXISTS Measurements (
    UserID INT NOT NULL,
    Date DATE NOT NULL,
    Height DECIMAL(5,2) NOT NULL,
    Weight DECIMAL(5,2) NOT NULL,
    WaistSize DECIMAL(5,2) NOT NULL,
    HipSize DECIMAL(5,2) NOT NULL,
    ChestSize DECIMAL(5,2) NOT NULL,
    FatPercentage DECIMAL(5,2),
    MuscleMass DECIMAL(5,2),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    PRIMARY KEY (UserID, Date)
);

CREATE TABLE IF NOT EXISTS Goals (
    UserID INT NOT NULL,
    Date DATE NOT NULL,
    HealthCondition VARCHAR(255) NOT NULL,
    TargetWeight DECIMAL(5,2) NOT NULL,
    TargetWaistSize DECIMAL(5,2) NOT NULL,
    TargetHipSize DECIMAL(5,2) NOT NULL,
    TargetChestSize DECIMAL(5,2) NOT NULL,
    TargetFatPercentage DECIMAL(5,2),
    TargetMuscleMass DECIMAL(5,2),
    Timeline varchar(50)NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    PRIMARY KEY (UserID, Date)
);

CREATE TABLE IF NOT EXISTS UserHealthCondition (
    UserID INT NOT NULL,
    HealthCondition VARCHAR(150) NOT NULL,
    Alergies VARCHAR(150) NOT NULL,
    Limitations VARCHAR(150) NOT NULL,
    Medication VARCHAR(150),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    PRIMARY KEY (UserID, HealthCondition)
);

CREATE TABLE IF NOT EXISTS UserTrainingProgram (
    UserID INT NOT NULL,
    ProgramID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (ProgramID) REFERENCES TrainingProgram(ProgramID),
    PRIMARY KEY (UserID, ProgramID)
);

CREATE TABLE IF NOT EXISTS UserGym (
    UserID INT NOT NULL,
    GymID INT NOT NULL,
    MembershipType ENUM('Monthly', 'Annual', 'Premium') NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    VisitsLeft INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (GymID) REFERENCES GymCenter(GymID),
    PRIMARY KEY (UserID, GymID)
);

CREATE TABLE IF NOT EXISTS TrainerGym (
    TrainerID INT NOT NULL,
    GymID INT NOT NULL,
    TrainingType ENUM("Individual", "Group", "both"),
    PRIMARY KEY (TrainerID, GymID),
    FOREIGN KEY (TrainerID) REFERENCES Trainers(ID),
    FOREIGN KEY (GymID) REFERENCES GymCenter(GymID)
);