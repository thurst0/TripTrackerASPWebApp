CREATE DATABASE TripTrackerApp
USE TripTrackerApp;
DROP TABLE Students
CREATE TABLE Students
(
Rp UNIQUEIDENTIFIER, ID INT, FirstName VARCHAR (30)
,LastName VARCHAR(30), Teacher VARCHAR (60)
,School VARCHAR(40)
)
ALTER TABLE Students ADD Distance Decimal(25,13)
DROP TABLE Teachers
CREATE TABLE Teachers
( 
Rp UNIQUEIDENTIFIER, FullName VARCHAR (60), School VARCHAR(200)
)
DROP TABLE Trips
CREATE TABLE Trips
(
Rp UNIQUEIDENTIFIER, TripType INT NOT NULL, EntryType INT NOT NULL
, EntryDate DATETIME, Trips DECIMAL (2,2), ID INT
)

CREATE TABLE Periods
(
	Period INT, MaxTrips INT
)