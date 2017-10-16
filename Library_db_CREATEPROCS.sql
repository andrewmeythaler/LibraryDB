CREATE Database Library;
USE Library;

CREATE PROC BUILD_TABLES
AS
	CREATE TABLE PUBLISHER (
		PUBLISHER_Name NVARCHAR(50) PRIMARY KEY NOT NULL,
		PUBLISHER_Address VARCHAR(100) NOT NULL,
		PUBLISHER_Phone VARCHAR(50) NOT NULL,
	);
	CREATE TABLE BOOK (
		BOOK_Bookid INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		BOOK_Title NVARCHAR(50) NOT NULL,
		BOOK_PublisherName NVARCHAR(50) CONSTRAINT fk_PublisherName FOREIGN KEY REFERENCES PUBLISHER(PUBLISHER_Name) ON UPDATE CASCADE ON DELETE CASCADE 
	);
	CREATE TABLE BOOK_AUTHORS (
		BOOK_AUTHORS_Bookid INT NOT NULL CONSTRAINT fk_bookid_authors FOREIGN KEY REFERENCES BOOK(BOOK_bookid) ON UPDATE CASCADE ON DELETE CASCADE,
		BOOK_AUTHORS_AuthorName NVARCHAR(50) NOT NULL
	);
	CREATE TABLE LIBRARY_BRANCH (
		LIBRARY_BRANCH_Branchid INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		LIBRARY_BRANCH_BranchName NVARCHAR(50) NOT NULL,
		LIBRARY_BRANCH_Address VARCHAR(50)
	);
	CREATE TABLE BORROWER (
		BORROWER_CardNo INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		BORROWER_Name NVARCHAR(50) NOT NULL,
		BORROWER_Address VARCHAR(50),
		BORROWER_Phone VARCHAR(50)
	);
	CREATE TABLE BOOK_LOANS (
		BOOK_LOANS_Bookid INT NOT NULL CONSTRAINT fk_bookid_loans FOREIGN KEY REFERENCES BOOK(BOOK_Bookid) ON UPDATE CASCADE ON DELETE CASCADE,
		BOOK_LOANS_Branchid INT NOT NULL CONSTRAINT fk_branchid_loans FOREIGN KEY REFERENCES LIBRARY_BRANCH(LIBRARY_BRANCH_Branchid) ON UPDATE CASCADE ON DELETE CASCADE,
		BOOK_LOANS_CardNo INT NOT NULL CONSTRAINT fk_cardno_loans FOREIGN KEY REFERENCES BORROWER(BORROWER_CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
		BOOK_LOANS_DateOut DATE,
		BOOK_LOANS_DueDate DATE
	);
	CREATE TABLE BOOK_COPIES (
		BOOK_COPIES_Bookid INT NOT NULL CONSTRAINT fk_bookid_copies FOREIGN KEY REFERENCES BOOK(BOOK_Bookid) ON UPDATE CASCADE ON DELETE CASCADE,
		BOOK_COPIES_Branchid INT NOT NULL CONSTRAINT fk_branchid_copies FOREIGN KEY REFERENCES LIBRARY_BRANCH(LIBRARY_BRANCH_Branchid) ON UPDATE CASCADE ON DELETE CASCADE,
		BOOK_COPIES_No_Of_Copies INT NOT NULL
	);
GO

CREATE PROC POPULATE
AS
	INSERT INTO PUBLISHER
		(PUBLISHER_Name, PUBLISHER_Address, PUBLISHER_Phone)
		VALUES
		('Picador', '12345 NW Tribal Dr., City-town, Statesylvania', '555-123-9876'),
		('Doubleday', '1313 Literary St., San Francisco, CA', '513-138-1313'),
		('Ace', '0000 Nort Harkonen Circle, Arakeen, Arakis', '245-673-5167'),
		('Gollancz', '5716 East Umbria, Placeville, West State', '643-615-5772'),
		('Gnome Press', '6427 Garden Lane, Yard City, Gnomeland', '864-365-3672'),
		('Weird Tales', '00000 Non-euclid St., Dagon City, Atlantic Ocean', '364-367-2563'),
		('Secker & Warburg', '1253 Party St., Proletown, Pacifica', '543-111-1984'),
		('Chatto & Windus', '1932 Ford St., Civilization-ville, New World', '356-153-5333'),
		('Charles Scribner''s Sons', '1922 Green Light Dr., Boston, MA', '543-254-4626'),
		('Titan Books', '4564 South Colonel Rd., NeoTokyo, Japan', '026-025-2020'),
		('Galaxy Publishing Corp', '10101001 AM, Allied Master Computer, Earth', '101-001-1101'),
		('Burton''s Gentleman''s Magazine', '1894 Raven Rd., Boston, MA', '543-365-3683'),
		('Tor Books', '192.221.5475.2121', '653-365-7356'),
		('Pan Macmillan', '2156 G''day St., Melbourne, ''stralia', '465-357-6512')
	;
	INSERT INTO BOOK
		(BOOK_Title, BOOK_PublisherName)
		VALUES
		('The Lost Tribe', 'Picador'), --Mark Lee 1
		('The Shining', 'Doubleday'), --Stephen King 2
		('Dune', 'Ace'), --Frank Herbert 3
		('Neuromancer', 'Ace'), --William Gibson 4
		('Do Androids Dream of Electric Sheep?', 'Doubleday'), --Phillip K. Dick 5
		('The Witcher Blood of Elves', 'Gollancz'), --Andrzej Sapkowski 6
		('I, Robot', 'Gnome Press'), --Isaac Asimov 7
		('The Call of Cthulu', 'Weird Tales'), --H.P. Lovecraft 8
		('1984', 'Secker & Warburg'), --George Orwell 9
		('Brave New World', 'Chatto & Windus'), --Aldous Huxley 10
		('The Great Gatsby', 'Charles Scribner''s Sons'), --F. Scott Fitzgerald 11
		('Akira', 'Titan Books'), --Katsuhiro Otomo 12
		('I Have No Mouth and I Must Scream', 'Galaxy Publishing Corp'), --Harlan Ellison 13
		('The Fall of the House of Usher', 'Burton''s Gentleman''s Magazine'), --Edgar Allan Poe 14
		('Ender''s Game', 'Tor books'), --Orson Scott Card 15
		('Count Zero', 'Gollancz'), --William Gibson 16
		('Foundation', 'Gnome Press'), --Isaac Asimov 17
		('Mona Lisa Overdrive', 'Gollancz'), --William Gibson 18
		('Dune Messiah', 'Ace'), --Frank Herbert 19
		('The Messenger', 'Pan Macmillan') --Markus Zusak 20
	;
	INSERT INTO BOOK_AUTHORS
		(BOOK_AUTHORS_Bookid, BOOK_AUTHORS_AuthorName)
		VALUES
		(1, 'Mark Lee'),
		(2, 'Stephen King'),
		(3, 'Frank Herbert'),
		(4, 'William Gibson'),
		(5, 'Phillip K. Dick'),
		(6, 'Andrzej Sapkowski'),
		(7, 'Isaac Asimov'),
		(8, 'H.P. Lovecraft'),
		(9, 'George Orwell'),
		(10, 'Aldous Huxley'),
		(11, 'F. Scott Fitzgerald'),
		(12, 'Katsuhiro Otomo'),
		(13, 'Harlan Ellison'),
		(14, 'Edgar Allan Poe'),
		(15, 'Orson Scott Card'),
		(16, 'William Gibson'),
		(17, 'Isaac Asimov'),
		(18, 'William Gibson'),
		(19, 'Frank Herbert'),
		(20, 'Markus Zusak')
	;
	INSERT INTO LIBRARY_BRANCH
		(LIBRARY_BRANCH_BranchName, LIBRARY_BRANCH_Address)
		VALUES
		('Sharpstown', '12345 Pointy St., Sharpstown, West Bladedelphia'), --1
		('Central', '12345 Core Circle, Central, Heartland'), --2
		('Moon', '12345 Lunar Dr., Moon, Orbit'), --3
		('Mars', '12345 Red Rock Rd., Olympus, Mars') --4
	;
	INSERT INTO BOOK_COPIES
		(BOOK_COPIES_Bookid, BOOK_COPIES_Branchid, BOOK_COPIES_No_Of_Copies)
		VALUES
		--Sharpstown
		(1, 1, 2), --Mark Lee, Lost Tribe
		(2, 1, 2), --Stephen King, The Shining
		(3, 1, 6), --Frank Herbert, Dune
		(4, 1, 4), --William Gibson, Neuromancer
		(5, 1, 4), --Phillip K. Dick, Do Androids Dream of Electric Sheep
		(6, 1, 3), --Andrzej Sapkowski, The Witcher Blood of Elves
		(7, 1, 6), --Isaac Asimov, I, Robot
		(9, 1, 8), --George Orwell, 1984
		(10, 1, 3), --Aldous Huxley, Brave New World
		(11, 1, 10), --F. Scott Fitzgerald, The Great Gatsby
		(12, 1, 6), --Katsuhiro Otomo, Akira
		(14, 1, 7), --Edgar Allan Poe, The Fall of the House of Usher
		(16, 1, 6), --William Gibson, Count Zero
		(20, 1, 3), --Markus Zusak, The Messenger
		--Central
		(1, 2, 5), --Mark Lee, Lost Tribe
		(2, 2, 2), --Stephen King, The Shining
		(3, 2, 7), --Frank Herbert, Dune
		(4, 2, 5), --William Gibson, Neuromancer
		(5, 2, 8), --Phillip K. Dick, Do Androids Dream of Electric Sheep
		(6, 2, 6), --Andrzej Sapkowski, The Witcher Blood of Elves
		(7, 2, 4), --Isaac Asimov, I, Robot
		(8, 2, 3), --H.P. Lovecraft, The Call of Cthulu
		(9, 2, 7), --George Orwell, 1984
		(10, 2, 4), --Aldous Huxley, Brave New World
		(11, 2, 11), --F. Scott Fitzgerald, The Great Gatsby
		(12, 2, 6), --Katsuhiro Otomo, Akira
		(13, 2, 5), --Harlan Ellison, I Have No Mouth and I Must Scream
		(14, 2, 6), --Edgar Allan Poe, The Fall of the House of Usher
		(15, 2, 4), --Orson Scott Card, Ender''s Game
		(16, 2, 5), --William Gibson, Count Zero
		(17, 2, 7), --Isaac Asimov, Foundation
		(18, 2, 4), --William Gibson, Mona Lisa Overdrive
		(19, 2, 5), --Frank Herbert, Dune Messiah
		(20, 2, 6), --Markus Zusak, The Messenger
		--Moon
		(2, 3, 2), --Stephen King, The Shining
		(3, 3, 3), --Frank Herbert, Dune
		(4, 3, 4), --William Gibson, Neuromancer
		(5, 3, 4), --Phillip K. Dick, Do Androids Dream of Electric Sheep
		(7, 3, 5), --Isaac Asimov, I, Robot
		(13, 3, 2), --Harlan Ellison, I Have No Mouth and I Must Scream
		(15, 3, 4), --Orson Scott Card, Ender''s Game
		(17, 3, 5), --Isaac Asimov, Foundation
		(18, 3, 2), --William Gibson, Mona Lisa Overdrive
		(19, 3, 2), --Frank Herbert, Dune Messiah
		--Mars
		(1, 4, 2), --Mark Lee, Lost Tribe
		(2, 4, 2), --Stephen King, The Shining
		(3, 4, 7), --Frank Herbert, Dune
		(4, 4, 5), --William Gibson, Neuromancer
		(5, 4, 6), --Phillip K. Dick, Do Androids Dream of Electric Sheep
		(6, 4, 3), --Andrzej Sapkowski, The Witcher Blood of Elves
		(7, 4, 5), --Isaac Asimov, I, Robot
		(8, 4, 2), --H.P. Lovecraft, The Call of Cthulu
		(9, 4, 5), --George Orwell, 1984
		(10, 4, 5), --Aldous Huxley, Brave New World
		(11, 4, 3), --F. Scott Fitzgerald, The Great Gatsby
		(12, 4, 6), --Katsuhiro Otomo, Akira
		(13, 4, 2), --Harlan Ellison, I Have No Mouth and I Must Scream
		(14, 4, 4), --Edgar Allan Poe, The Fall of the House of Usher
		(15, 4, 6), --Orson Scott Card, Ender''s Game
		(16, 4, 7), --William Gibson, Count Zero
		(17, 4, 4), --Isaac Asimov, Foundation
		(18, 4, 4), --William Gibson, Mona Lisa Overdrive
		(19, 4, 7), --Frank Herbert, Dune Messiah
		(20, 4, 2) --Markus Zusak, The Messenger
	;
	INSERT INTO BORROWER
		(BORROWER_Name, BORROWER_Address, BORROWER_Phone)
		VALUES
		('Jim Jameson', '12345 Place St., Town, State', '555-555-5555'),
		('Kevin Schmekels', '54321 CountDown Dr., City, Province', '123-456-7890'),
		('Liam Noseen', '6523 Taken place, LA, CA', '123-123-1234'),
		('Schmitty Warbermanjensen', '1111 Winners circle, Numberonesville', '111-111-1111'),
		('REAL NAME', ' 123 REAL ADDRESS rd., REAL, PLACE', '000-000-0000'),
		('Bob Jones', '1245 OCP st., Detroit, Michigan', '542-543-6835'),
		('Rick Lewis', '3653 Place rd., Town, Place', '465-535-5431'),
		('Running Outofnames', '1254 Running Out of plc., Sandnum, Berstoo', '500-354-3654')
	;
	INSERT INTO BOOK_LOANS
		(BOOK_LOANS_Bookid, BOOK_LOANS_Branchid, BOOK_LOANS_CardNo, BOOK_LOANS_DateOut, BOOK_LOANS_DueDate)
		VALUES
		(1, 1, 1, '10-12-17', '10-16-17'),
		(3, 1, 1, '10-10-17', '10-14-17'),
		(2, 1, 1, '10-09-17', GETDATE()),
		(4, 1, 1, '10-08-17', '10-12-17'),
		(5, 1, 1, '10-12-17', '10-17-17'),
		(6, 1, 1, '10-12-17', '10-17-17'),
		(1, 1, 2, '10-12-17', '10-16-17'),
		(3, 1, 2, '10-10-17', GETDATE()),
		(2, 1, 2, '10-09-17', '10-13-17'),
		(4, 1, 2, '10-08-17', '10-12-17'),
		(5, 1, 2, '10-12-17', '10-17-17'),
		(6, 1, 2, '10-12-17', '10-17-17'),
		(1, 2, 3, '10-12-17', '10-16-17'),
		(3, 2, 3, '10-10-17', '10-14-17'),
		(2, 2, 3, '10-09-17', GETDATE()),
		(6, 2, 3, '10-12-17', '10-17-17'),
		(2, 3, 4, '10-12-17', '10-16-17'),
		(3, 3, 4, '10-10-17', '10-14-17'),
		(7, 3, 4, '10-09-17', '10-13-17'),
		(13, 3, 4, '10-08-17', '10-12-17'),
		(2, 4, 6, '10-12-17', '10-16-17'),
		(3, 4, 6, '10-10-17', '10-14-17'),
		(7, 4, 6, '10-09-17', '10-13-17'),
		(13, 4, 6, '10-08-17', '10-12-17'),
		(2, 4, 7, '10-12-17', '10-16-17'),
		(3, 4, 7, '10-10-17', '10-14-17'),
		(7, 4, 7, '10-09-17', '10-13-17'),
		(13, 4, 7, '10-08-17', GETDATE())
	;
GO

CREATE PROC Book_At_Counter @Title NVARCHAR(50) = NULL, @Branch NVARCHAR(50) = NULL, @Author NVARCHAR(50) = NULL
AS
	SELECT a1.BOOK_Title AS 'Book Title',
	a2.LIBRARY_BRANCH_BranchName AS 'Branch Name',
	a3.BOOK_COPIES_No_Of_Copies AS 'Number of Copies'
	FROM BOOK_COPIES a3
	INNER JOIN LIBRARY_BRANCH a2
	ON a2.LIBRARY_BRANCH_Branchid = a3.BOOK_COPIES_Branchid
	INNER JOIN BOOK a1
	ON a1.BOOK_Bookid = a3.BOOK_COPIES_Bookid
	INNER JOIN BOOK_AUTHORS a6
	ON a6.BOOK_AUTHORS_Bookid = a1.BOOK_Bookid
	WHERE a1.BOOK_Title = ISNULL(@Title, a1.BOOK_Title)
	AND a2.LIBRARY_BRANCH_BranchName = ISNULL(@Branch, a2.LIBRARY_BRANCH_BranchName)
	AND a6.BOOK_AUTHORS_AuthorName = ISNULL(@Author, a6.BOOK_AUTHORS_AuthorName)
	ORDER BY a1.BOOK_Title ASC;
GO

CREATE PROC No_Book
AS
	SELECT a4.BORROWER_Name AS 'Name'
	FROM BORROWER a4
	LEFT JOIN BOOK_LOANS a5
	ON a5.BOOK_LOANS_CardNo = a4.BORROWER_CardNo
	WHERE a5.BOOK_LOANS_CardNo IS NULL;
GO

CREATE PROC Books_Out_Borrower @Name NVARCHAR(50) = NULL, @Books INT = NULL
AS
	SELECT a1.BORROWER_Name AS 'NAME',
	a1.BORROWER_Address AS 'Address',
	a1.BORROWER_Phone AS 'Phone Number',
	COUNT(a1.BORROWER_CardNo) AS 'Books Checked Out'
	FROM BORROWER a1
	INNER JOIN BOOK_LOANS a2
	ON a1.BORROWER_CardNo = a2.BOOK_LOANS_CardNo
	GROUP BY a1.BORROWER_CardNo, a1.BORROWER_Name, a1.BORROWER_Address, a1.BORROWER_Phone
	HAVING COUNT(*) >= ISNULL(@Books, 0)
	AND a1.BORROWER_Name LIKE ISNULL(@Name, a1.Borrower_Name);
GO

CREATE PROC Books_At_Branch @Book NVARCHAR(50) = NULL, @Author NVARCHAR(50) = NULL, @Branch NVARCHAR(50) = NULL
AS
	SELECT a1.BOOK_Title AS 'Title',
	a2.BOOK_AUTHORS_AuthorName AS 'Author',
	a3.LIBRARY_BRANCH_BranchName AS 'Branch',
	a4.BOOK_COPIES_No_Of_Copies AS 'Number of Copies'
	FROM BOOK a1
	INNER JOIN BOOK_AUTHORS a2 ON a2.BOOK_AUTHORS_Bookid = a1.BOOK_Bookid
	INNER JOIN BOOK_COPIES a4 ON a4.BOOK_COPIES_Bookid = a1.BOOK_Bookid
	INNER JOIN LIBRARY_BRANCH a3 ON a3.LIBRARY_BRANCH_Branchid = a4.BOOK_COPIES_Branchid
	WHERE a1.BOOK_Title = ISNULL(@Book, a1.BOOK_Title)
	AND a2.BOOK_AUTHORS_AuthorName = ISNULL(@Author, a2.BOOK_AUTHORS_AuthorName)
	AND a3.LIBRARY_BRANCH_BranchName = ISNULL(@Branch, a3.LIBRARY_BRANCH_BranchName)
	ORDER BY a3.LIBRARY_BRANCH_BranchName ASC, a1.BOOK_Title ASC, a2.BOOK_AUTHORS_AuthorName ASC;
GO

CREATE PROC Books_Out @Branch NVARCHAR(50) = NULL
AS
	SELECT a1.LIBRARY_BRANCH_BranchName AS 'Branch',
	COUNT(a2.BOOK_LOANS_Branchid) AS 'Total Books checked out'
	FROM LIBRARY_BRANCH a1
	INNER JOIN BOOK_LOANS a2 ON a2.BOOK_LOANS_Branchid = a1.LIBRARY_BRANCH_Branchid
	GROUP BY a1.LIBRARY_BRANCH_BranchName, a2.BOOK_LOANS_Branchid
	HAVING a1.LIBRARY_BRANCH_BranchName = ISNULL(@Branch, a1.LIBRARY_BRANCH_BranchName)
	ORDER BY a1.LIBRARY_BRANCH_BranchName ASC;
GO

CREATE PROC Books_due @Branch NVARCHAR(50) = NULL, @Title NVARCHAR(50) = NULL, @Date date = NULL, @Name NVARCHAR(50) = NULL
AS
	SELECT a1.LIBRARY_BRANCH_BranchName AS 'BRANCH',
	a2.BOOK_Title AS 'Book Title',
	a3.BOOK_LOANS_DueDate AS 'Due Date',
	a4.BORROWER_Name AS 'Borrower Name',
	a4.BORROWER_Address AS 'Address'
	FROM BOOK a2
	INNER JOIN BOOK_LOANS a3 ON a3.BOOK_LOANS_Bookid = a2.BOOK_Bookid
	INNER JOIN LIBRARY_BRANCH a1 ON a3.BOOK_LOANS_Branchid = a1.LIBRARY_BRANCH_Branchid
	INNER JOIN BORROWER a4 ON a4.BORROWER_CardNo = a3.BOOK_LOANS_CardNo
	WHERE a1.LIBRARY_BRANCH_BranchName = ISNULL(@Branch, a1.LIBRARY_BRANCH_BranchName)
	AND a2.BOOK_Title = ISNULL(@Title, a2.BOOK_Title)
	AND a3.BOOK_LOANS_DueDate >= ISNULL(@Date, a3.BOOK_LOANS_DueDate)
	AND a4.BORROWER_Name = ISNULL(@Name, a4.BORROWER_Name)
	ORDER BY a1.LIBRARY_BRANCH_BranchName ASC, a2.BOOK_Title ASC, a3.BOOK_LOANS_DueDate ASC, a4.BORROWER_Name ASC;
GO

EXECUTE BUILD_TABLES;
EXECUTE POPULATE;