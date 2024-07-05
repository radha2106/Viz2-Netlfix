-- Create a recursive CTE to generate dates
-- Set the date range for dates to be added
DECLARE @Startdate DATE = 'year-month-day';
DECLARE @Enddate DATE = 'year-month-day';

WITH DateRange AS (
    SELECT 
        CAST('@startdate' AS DATE) AS CalendarDate  -- Start date
    UNION ALL
    SELECT 
        DATEADD(DAY, 1, CalendarDate)  -- Increment date by 1 day
    FROM 
        DateRange
    WHERE 
        CalendarDate < 'Enddate'  -- End date
)
-- Insert into a physical calendar table
SELECT
    ROW_NUMBER() OVER (ORDER BY CalendarDate) AS idx,
    CalendarDate AS ddate,
    YEAR(CalendarDate) AS years,
    MONTH(CalendarDate) AS months,
    FORMAT(CalendarDate, 'MMM') AS months_name,
    DAY(CalendarDate) AS day_number,
    DATENAME(DW, CalendarDate) AS day_name,
    DATEPART(WEEK, CalendarDate) AS weeks
INTO calendar
FROM 
    DateRange
OPTION (MAXRECURSION 0);

-- Set the date range for new dates to be added
DECLARE @Startdate DATE = 'year-month-day';
DECLARE @Enddate DATE = 'year-month-day';

-- Create a recursive CTE to generate new dates
WITH DateRange AS (
    SELECT 
        @StartDate AS CalendarDate  -- Start date for new range
    UNION ALL
    SELECT 
        DATEADD(DAY, 1, CalendarDate)  -- Increment date by 1 day
    FROM 
        DateRange
    WHERE 
        CalendarDate < @EndDate  -- End date for new range
)
-- Insert new dates into the calendar table
INSERT INTO calendar (ddate, years, months, months_name, day_number, day_name, weeks)
SELECT
	ROW_NUMBER() OVER (ORDER BY CalendarDate) AS idx,
    CalendarDate,
    YEAR(CalendarDate),
    MONTH(CalendarDate),
    FORMAT(CalendarDate, 'MMM'),
    DAY(CalendarDate),
    DATENAME(DW, CalendarDate),
    DATEPART(WEEK, CalendarDate)
FROM 
    DateRange
WHERE
    CalendarDate NOT IN (SELECT ddate FROM calendar);  -- Avoid duplicates

-- Optional: Update index column (if necessary)
UPDATE calendar
SET idx = ROW_NUMBER() OVER (ORDER BY ddate);

-- Optional: Rebuild primary key constraint (if necessary)
ALTER TABLE calendar
DROP CONSTRAINT PK_calendar;
ALTER TABLE calendar
ADD CONSTRAINT PK_calendar PRIMARY KEY (idx);
