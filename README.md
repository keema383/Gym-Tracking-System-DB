# Gym Tracking System

This is a **Database Management System (DBMS)** project designed for a gym tracking system. It was developed as part of the *Databases and Distributed Systems* course. The system allows managing gyms, trainers, users, diets, health conditions, measurements, and training programs.

## Project Structure

- `tables.sql` – Contains SQL scripts to create the database schema (tables and relationships).
- `data.sql` – Inserts sample data into the database, including users, trainers, gyms, diets, and measurements.
- `queries.sql` – Includes advanced SQL queries, stored procedures, and functions to retrieve and manipulate data.
- `ERD.pdf` – The Entity-Relationship Diagram visualizing the database design.

## Features

- **User Management:** Track gym members, their fitness levels, health conditions, and goals.
- **Trainer Scheduling:** Assign trainers to gyms and users with capacity limits.
- **Diet & Program Plans:** Manage diet plans and training programs for users.
- **Health Monitoring:** Record user measurements and calculate BMI.
- **Advanced Queries:**  
  - Users needing to renew memberships.  
  - Trainers' availability and assigned users.  
  - Find gyms close to users based on location.  
  - Calculate user progress towards fitness goals.  

## Setup Instructions

1. Import the database schema:
    ```sql
    source tables.sql;
    ```
2. Populate with sample data:
    ```sql
    source data.sql;
    ```
3. Run queries and procedures:
    ```sql
    source queries.sql;
    ```

> **Note:** Make sure you are connected to a MySQL server before running these scripts.

## ERD Preview

The database design includes entities like Users, Trainers, GymCenters, Diets, and relationships such as UserTrainingProgram and TrainerGym.

## Authors

This project was developed collaboratively as part of the *Databases and Distributed Systems* course by 

- Kima Badalyan
- Ruben Galoyan
- Sofi Khachatryan
