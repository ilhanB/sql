
/*  ------   ASSİGNMENT-1  -------- */

/* 1. Write a query that displays InvoiceId, CustomerId and total dollar amount for each 
invoice, sorted first by CustomerId (in ascending order), and then by total dollar 
amount  (in descending order). */

	SELECT InvoiceId, CustomerId, total
	FROM invoices
	WHERE CustomerId
	ORDER BY CustomerId ASC, total DESC;
	
/* 2. Write a query that displays InvoiceId, CustomerId and total dollar amount for each invoice,
 but this time sorted first by total dollar amount (in descending order), and then by CustomerId 
 (in ascending order).*/
	
	SELECT InvoiceId, total, CustomerId
	FROM invoices
	WHERE total
	ORDER BY total DESC, CustomerId ASC;
	
/* 3. Compare the results of these two queries above. How are the results different when you switch 
the column you sort on first? (Explain it in your own words.)*/	

	-- in the first query CustomerId sorted by ascending and then each CustomerId's total amount is sorted by descending mode.
	-- in the second query total amount sorted by descending mode and then in each price CustomerId's sorted by ascending mode.
	
	/* 4. Write a query to pull the first 10 rows and all columns from the invoices table that 
	have a dollar amount of total greater than or equal to 10. */
	
	SELECT *
	FROM invoices 
	WHERE total >=10
	LIMIT 10	;
	
	/* 5. Write a query to pull the first 5 rows and all columns from the invoices table that have a dollar amount
	of total less than 10.*/
	
	SELECT *
	FROM invoices 
	WHERE total <10
	LIMIT 5;
	
	/* 6. Find all track names that start with 'B' and end with 's'.*/
	
	SELECT *
	FROM tracks
	WHERE name like 'B%' AND name like '%s';
	
	/* 7. Use the invoices table to find all information regarding invoices whose billing address 
	is USA or Germany or Norway or Canada and invoice date is at any point in 2010, sorted 
	from newest to oldest.*/
	
	
	SELECT *
	FROM invoices
	WHERE BillingCountry  IN('USA', 'Norway', 'Germany', 'Canada') and InvoiceDate like '2010-%'
	ORDER BY InvoiceDate ASC;
	
	
	/*  ------   ASSİGNMENT-2  -------- */
	
	/* 1. How many tracks does each album have? Your solution should include Album id and
	its number of tracks sorted from highest to lowest. */
	
	SELECT DISTINCT AlbumId, count(AlbumId) as num_of_tracks
	FROM tracks
	GROUP BY AlbumId
	ORDER BY AlbumId DESC;

	SELECT DISTINCT AlbumId, count(AlbumId) as num_of_tracks
	FROM tracks
	GROUP BY AlbumId
	ORDER BY num_of_tracks DESC;
	
	/* 2. Find the album title of the tracks. Your solution should
	include track name and its album title. */
	
	SELECT a.AlbumId, a.Title, t.Name
	FROM albums a
	JOIN tracks t
	ON	a.AlbumId = t.AlbumId;
	
	/* 3. Find the minimum duration of the track in each album. Your solution should include album id, 
	album title and duration of the track sorted from highest to lowest. */
	
	SELECT a.AlbumId, a.Title, t.Name, min(t.Milliseconds)
	FROM albums a
	JOIN tracks t
	ON	a.AlbumId = t.AlbumId
	GROUP BY t.AlbumId
	ORDER BY Milliseconds DESC;
	
	
	/* 4. Find the total duration of each album. Your solution should include album id, 
	album title and its total duration sorted from highest to lowest. */

	SELECT a.AlbumId, a.Title, sum(t.Milliseconds)
	FROM albums a
	JOIN tracks t
	ON	a.AlbumId = t.AlbumId
	GROUP BY t.AlbumId
	ORDER BY Milliseconds DESC;
	
	
	/* 5. Based on the previous question, find the albums whose total duration is higher than 70 minutes. 
	Your solution should include album title and total duration.*/
	
	SELECT a.AlbumId, a.Title, sum(t.Milliseconds)
	FROM albums a
	JOIN tracks t
	ON	a.AlbumId = t.AlbumId
	WHERE Milliseconds > 700000
	GROUP BY t.AlbumId
	ORDER BY Milliseconds DESC;
	
	
		/*  ------   ASSİGNMENT-3  -------- */
	
	/* Single-Row Subqueries: */

/* 1. Write a query to find the maximum duration among the tracks. Your query should include TrackId, Name, Milliseconds. */

	SELECT TrackId, Name, Milliseconds
	FROM tracks
	WHERE Milliseconds = (SELECT max(Milliseconds) FROM tracks);

/* 2. Write a query to find the minimum duration among the tracks. Your query should include TrackId, Name, Milliseconds. */

	SELECT TrackId, Name, Milliseconds
	FROM tracks
	WHERE Milliseconds = (SELECT min(Milliseconds) FROM tracks);

/* 3. Write a query to find the tracks whose bytes are higher than the average of the bytes of all tracks. Your query should 
include TrackId, Name, Bytes, general average and should be ordered by Bytes from highest to lowest. General average 
is the average of all tracks. General average should repeat in every row. (Hint: You need to use two subqueries) */

SELECT TrackId, Name,	Bytes 
FROM tracks
WHERE Bytes > (SELECT avg(Bytes) FROM tracks)
ORDER BY Bytes DESC;

/*	Multiple-Row Subqueries: */

/* 1. Write a query that returns the customers whose sales representatives are Jane Peacock and Margaret Park. 
Your query should include CustomerID, First Name and Last Name of the customers. */

SELECT CustomerId, FirstName, LastName
FROM customers
WHERE SupportRepId IN	(SELECT EmployeeId FROM employees WHERE LastName in ('Peacock', 'Park'));

/* 2. Rewrite the subquery above using the JOIN. */

SELECT c.CustomerId, c.FirstName, c.LastName
FROM customers c
JOIN employees e
ON c.SupportRepId = e.EmployeeId 
WHERE e.LastName IN ('Peacock', 'Park');

/* DDL (CREATE, ALTER, DELETE) and DML (SELECT, INSERT, UPDATE, DELETE) Statements */

/* 1. Create a table inside the chinook database. This table tracks the employees’ courses inside the organization. 
Your table should have the followings features:

               Name of the table: courses
               Columns:
                    CourseId (Primary Key)
                    CourseName (Cannot be null)
                    EmployeeId (Foreign Key - Refers to EmployeeId of employees table ) 
                    CoursePrice   */
					
		CREATE TABLE courses(
			CourseId INT PRIMARY KEY,
			CourseName TEXT NOT NULL,
			EmployeeId INT,
			coursePrice INT,
			FOREIGN KEY(EmployeeId) REFERENCES employees(EmployeeId)
);

      /* 2. Insert at least 5 rows into the courses table. Your EmployeeId should contain the values of the 
	  EmployeeId column on the employees table. You’re free to choose any values for 
	  other columns (CourseId, CourseName, CoursePrice) */

	  		INSERT INTO courses VALUES(1001,'DevOps',	1, 1100);
			INSERT INTO courses VALUES(1002,'DetaScience',	2, 800);
			INSERT INTO courses VALUES(1003,'FullStack',	3, 700);
			INSERT INTO courses VALUES(1004,'SiberSecurity',	4, 900);
			INSERT INTO courses VALUES(1005,'English',	5, 1000);
					
	  
	/* 3. Delete the last row of your courses table. */

	DELETE FROM courses
	WHERE CourseId=1005, CourseName='English', EmployeeId=5, coursePrice=1000;

	/* 4. Add a new column to your courses table named StartDate. The new column cannot be null. */
	
	ALTER TABLE courses
	ADD	COLUMN StartDate date '2021-12-20';


	/* 5. Delete the CoursePrice column. */
	
	ALTER TABLE courses
	DROP COLUMN coursePrice;

	
	/* 6. Delete the courses table. */
	
	DROP TABLE courses;
	
	
	
