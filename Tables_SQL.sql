--CREATE DATABASE
CREATE DATABASE netflix;
USE netflix;
**************************************

--Create original tables
CREATE TABLE categories(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
categories VARCHAR(30) NOT NULL UNIQUE);

CREATE TABLE device(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
device VARCHAR(10) NOT NULL UNIQUE);

CREATE TABLE languages(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
langauges VARCHAR(10) NOT NULL UNIQUE);

CREATE TABLE payments(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
payment VARCHAR(15) NOT NULL UNIQUE);

CREATE TABLE plans(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
subs VARCHAR(5) NOT NULL,
price DECIMAL(5,2) NOT NULL UNIQUE);

CREATE TABLE production(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
produc VARCHAR(10) NOT NULL,
mode VARCHAR(10) NOT NULL);

CREATE TABLE programs(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
ddate_id BIGINT NOT NULL,
lang_id BIGINT NOT NULL,
catg_id BIGINT NOT NULL,
produc_id BIGINT NOT NULL,
FOREIGN KEY (ddate_id) REFERENCES calendar(idx),
FOREIGN KEY (lang_id) REFERENCES languages(idx),
FOREIGN KEY (catg_id) REFERENCES categories(idx),
FOREIGN KEY (produc_id) REFERENCES production(idx));

CREATE TABLE ratings(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
ratings VARCHAR(15) NOT NULL UNIQUE);

CREATE TABLE states(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
state_code VARCHAR(5) NOT NULL,
states VARCHAR(20) NOT NULL,
region VARCHAR(10) NOT NULL);

CREATE TABLE users(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
state_id BIGINT NOT NULL,
created_on BIGINT NOT NULL,
sub_id BIGINT NOT NULL,
dev_id BIGINT NOT NULL,
pay_id BIGINT NOT NULL,
FOREIGN KEY (state_id) REFERENCES states(idx),
FOREIGN KEY (created_on) REFERENCES calendar(idx),
FOREIGN KEY (sub_id) REFERENCES plans(idx),
FOREIGN KEY (dev_id) REFERENCES device(idx),
FOREIGN KEY (pay_id) REFERENCES payments(idx));

CREATE TABLE viewx(
idx BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
users_id BIGINT NOT NULL,
view_on BIGINT NOT NULL,
prg_id BIGINT NOT NULL,
rate_id BIGINT NOT NULL,
dev_id BIGINT NOT NULL,
FOREIGN KEY (users_id) REFERENCES users(idx),
FOREIGN KEY (view_on) REFERENCES calendar(idx),
FOREIGN KEY (prg_id) REFERENCES programs(idx),
FOREIGN KEY (rate_id) REFERENCES ratings(idx),
FOREIGN KEY (dev_id) REFERENCES device(idx));

******************************************
-- Procedure to copy from fake table to original tables
CREATE PROCEDURE realuser AS
INSERT INTO users (state_id,created_on,acct_status,
plan_id,device_id,pay_id)
SELECT 
state_id,created_on,acct_status,plan_id,
device_id,pay_id
FROM fakeusers
GO;

CREATE PROCEDURE realprograms AS
INSERT INTO programs(ddate_id,idiom_id,category_id,
class_id,produc_id,run_id)
SELECT 
ddate_id,idiom_id,category_id,class_id,produc_id,runs
FROM fakeprograms
GO;

CREATE PROCEDURE realviews AS
INSERT INTO tviews(played_on,users_id,program_id,rate_id)
SELECT 
played_on,users_id,program_id,rate_id
FROM fakeviews
GO;

CREATE PROCEDURE inc_user_prg AS
DELETE v
FROM viewx AS v
INNER JOIN users AS u
ON v.users_id=u.idx
INNER JOIN programs AS p
ON v.prg_id=p.idx
WHERE
v.users_id=u.idx AND v.view_on<u.created_on OR
v.prg_id=p.idx AND v.view_on<p.ddate_id
GO;

*********************************
-- Indexs
CREATE INDEX usersx
ON users(state_id,created_on,
sub_id,dev_id,pay_id);

CREATE INDEX viewsx
ON viewx(users_id,view_on,prg_id,rate_id,dev_id);

CREATE INDEX programx
ON programs(ddate_id,lang_id,catg_id,produc_id);

CREATE INDEX datex
ON calendar (ddate,years,months,months_name,day_num,
day_name,y_weeks,y_quarter);

*************************
-- Bulk inserts
BULK INSERT --table
FROM ---file path
WITH (
	FIRSTROW=2,
	FIELDTERMINATOR=','
	);

*******************************
--Create fake tables to help with bulk insert
CREATE TABLE fakeprograms(
ddate_id VARCHAR(50),
idiom_id VARCHAR(50),
category_id VARCHAR(50),
class_id VARCHAR(50),
produc_id VARCHAR(50),
runs VARCHAR(50));

CREATE TABLE fakeusers(
state_id VARCHAR(50),
created_on VARCHAR(50),
acct_status VARCHAR(50),
plan_id VARCHAR(50),
device_id VARCHAR(50),
pay_id VARCHAR(50));

CREATE TABLE fakeviews(
played_on VARCHAR(50),
users_id VARCHAR(50),
program_id VARCHAR(50),
rate_id VARCHAR(50));
