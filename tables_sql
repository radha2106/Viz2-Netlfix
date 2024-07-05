-- Create database and use it
CREATE DATABASE Netflix;
USE netflix;

-- Create original tables

-- State table
CREATE TABLE states(
idx INT IDENTITY(1,1) NOT NULL,
state_code VARCHAR(10) NOT NULL UNIQUE,
states VARCHAR(100) NOT NULL UNIQUE,
region VARCHAR(20) NOT NULL,
PRIMARY KEY(idx));

-- Language table
CREATE TABLE languages(
idx INT IDENTITY(1,1),
languages VARCHAR(20) NOT NULL UNIQUE,
PRIMARY KEY(idx));

-- Rating table
CREATE TABLE ratings(
idx INT IDENTITY(1,1) NOT NULL,
rating VARCHAR(10) NOT NULL UNIQUE,
PRIMARY KEY(idx));

-- Categories table
CREATE TABLE categories(
idx INT IDENTITY(1,1) NOT NULL,
categories VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY(idx));

-- Mode table
CREATE TABLE modes(
idx INT IDENTITY(1,1) NOT NULL
modes VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY(idx));

-- Programs table
CREATE TABLE programs(
idx INT IDENTITY(1,1) NOT NULL,
ddate INT NOT NULL,
idiom INT NOT NULL,
category INT NOT NULL,
rate INT NOT NULL,
class VARCHAR(10) NOT NULL,
production VARCHAR(20) NOT NULL,
duration INT NOT NULL,
PRIMARY KEY(idx),
FOREIGN KEY(idiom)
REFERENCES languages(idx),
FOREIGN KEY(category)
REFERENCES categories(idx),
FOREIGN KEY(rate)
REFERENCES ratings(idx),
FOREIGN KEY(duration)
REFERENCES modes(idx));

-- Users table
CREATE TABLE users(
idx INT IDENTITY(1,1) NOT NULL UNIQUE,
state_id VARCHAR(10) NOT NULL,
created_on BIGINT NOT NULL,
membership VARCHAR(10) NOT NULL,
acct_status VARCHAR(20) NOT NULL,
subscription VARCHAR(10) NOT NULL,
plan_acct DECIMAL(5,2) NOT NULL,
device VARCHAR(10) NOT NULL,
payment VARCHAR(20) NOT NULL,
PRIMARY KEY(idx),
FOREIGN KEY(created_on)
REFERENCES calendar(idx),
FOREIGN KEY(state_id)
REFERENCES states(state_code));

-- Procedure to copy from fake table to original tables
CREATE PROCEDURE --procedure name
AS
INSERT INTO --real table (column1, column2...)
SELECT --(same amount of column as real table)
FROM --faketable
GO;

-- Indexs
CREATE INDEX states_name
ON states(states);

CREATE INDEX languages_type
ON languages(languages);

CREATE INDEX rates
ON ratings(rating);

CREATE INDEX ddates
ON programs(ddate);

CREATE INDEX finduser
ON users(users)

-- Bulk inserts
BULK INSERT --table
FROM ---file path
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=','
	);

-- Create fake tables

-- Fake state
CREATE TABLE fakestate(
state_code VARCHAR(100),
states VARCHAR(100),
regions VARCHAR(100));

-- Fake rating
CREATE TABLE fakeratings(
ratings VARCHAR(100));

-- Fake modes
CREATE TABLE fakemode(
modes VARCHAR(100));

-- Fake language
CREATE TABLE fakelanguage(
languages VARCHAR(100));

-- Fake program
CREATE TABLE fakeprograms(
ddate VARCHAR(100),
languages VARCHAR(100),
category VARCHAR(100),
rating VARCHAR(100),
class VARCHAR(100),
production VARCHAR(100),
duration VARCHAR(100));

-- Fake category
CREATE TABLE fakecategories(
categories VARCHAR(100));

-- Fake user
CREATE TABLE fakeuser(
state_id VARCHAR(100),
created_on VARCHAR(100),
membership VARCHAR(100),
acct_status VARCHAR(100),
subscription VARCHAR(100),
payment_amount VARCHAR(100),
device VARCHAR(100),
payment_method VARCHAR(100));
