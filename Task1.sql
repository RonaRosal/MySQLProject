use unitoverview;

CREATE TABLE Unit (
	unitCode varchar(255) NOT NULL UNIQUE,
    name varchar(255) NOT NULL UNIQUE,
    description varchar(255),
    PRIMARY KEY (unitCode, name)
    );
    
    CREATE TABLE Tutor (
	staffID INT auto_increment NOT NULL UNIQUE,
    staffName VARCHAR(255) NOT NULL,
    PRIMARY KEY(staffID)
    );
    
    CREATE TABLE Student(
    studentID INT auto_increment NOT NULL UNIQUE,
    Name VARCHAR (255) NOT NULL,
    phone INT,
    gender VARCHAR(255) CHECK ( gender IN ('female', 'male', 'other')),
    PRIMARY KEY (studentID)
    );
    
    CREATE TABLE TaughtBy(
    staffID INT auto_increment NOT NULL UNIQUE,
    code VARCHAR(255) NOT NULL UNIQUE,
    semester VARCHAR(255) CHECK (semester IN ('1','2','summer')),
    PRIMARY KEY (staffID, code, semester),
	FOREIGN KEY (code) REFERENCES Unit (code)
    );
    
    CREATE TABLE TuteGroup (
    tuteCode VARCHAR(255) NOT NULL UNIQUE,
    staffID INT auto_increment ,
    date varchar(255),
    room int check (room in ('1')),
    PRIMARY KEY (tuteCode)
    );
    
    CREATE TABLE TuteEnrollment (
	studentID INT auto_increment NOT NULL UNIQUE,
    unitCode varchar(255) NOT NULL UNIQUE,
    tuteCode varchar(255) NOT NULL UNIQUE,
    PRIMARY KEY (studentID, unitCode)
    );
    
    