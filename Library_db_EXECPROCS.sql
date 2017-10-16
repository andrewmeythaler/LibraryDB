USE Library;

EXEC [dbo].[Books_At_Branch] @Book = NULL, @Author = NULL, @Branch = NULL;
/* This PROC retrieves records that displays how many copies of books each branch has
If no parameters, or NULL parameters, are passed in, it will retrieve all records
Displays as Book title | Author Name | Number of Copies at Branch
@Book is an NVARCHAR(50), allowing you to limit record results by book title
@Author is an NVARCHAR(50), allowing you to limit record results by author name
@Branch is an NVARCHAR(50), allowing you to limit record results by the name of the library branch

This PROC was designed to meet the requirements: 1, 2, and 7 in the drill.
1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
To meet this requirement pass in 'The Lost Tribe' for @Book, and 'Sharpstown' for @Branch.
2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?
To meet this requirement pass in 'The Lost Tribe' for @Book.
7. For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
To meet this requirement pass in 'Stephen King' for @Author, and 'Central' for @Branch*/

EXEC [dbo].[Books_due] @Branch = NULL, @Title = NULL, @Date = NULL, @Name = NULL;
/* This PROC retrieves records that displays what books are due or overdue, and who checked them out
If no parameters, or NULL parameters, are passed in, it will retrieve all records and show all checked out books
Displays as Branch | Book Title | Due Date | Borrower name | Address
@Branch is an NVARCHAR(50), allowing you to limit record results by the branch it is checked out from
@Title is an NVARCHAR(50), allowing you to limit record results by book title
@Date is a date, allowing you to limit record results by the day they are due (will display any books with due dates before the provided date
@Name is an NVARCHAR(50), allowing you to limit record results by the name of the person checking them out

This PROC was designed to meet requirement 4 in the drill.
4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.
To meet this requirement pass in 'Sharpstown' for @Branch, and GETDATE() for @Date*/

EXEC [dbo].[Books_Out] @Branch = NULL;
/* This PROC retrieves records that displays the total number of books checked out at a library branch
If no parameters, or NULL parameters, are passed in, it will retrieve all records and show the number of books checked out at all branches
Displays as Branch name | Total Books Checked Out
@Branch is an NVARCHAR(50), allowing you to limit the record results by branch name

This PROC was designed to meet requirement 5 in the drill.
5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
To meet this requiement, simply run the PROC without passing in parameters, or pass in NULL for @Branch*/

EXEC [dbo].[Books_Out_Borrower] @Name = NULL, @Books = NULL;
/* This PROC retrieves records that displays all the total number of books a person has checked out
If no parameters, or NULL parameters, are passed in, it will retrieve all records and show the count of books checked out by each person
Displays as Name | Address | Phone Number | Total Books Checked Out
@Name is an NVARCHAR(50), allows you to limit the record results by borrower name
@Books is an INT, allows you to limit record results by total books checked out (will display anyone with more than the provided number)

This PROC Was designed to meet requirement 6 in the drill.
6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
To meet this requirement pass in 5 for @Books*/

EXEC [dbo].[No_Book];
/* This PROC retrieves records for each borrower that does not currently have any books checked out
Displays only the name
Has no parameters

This PROC was designed to meet requirement 3 in the drill.
3. Retrieve the names of all borrowers who do not have any books checked out.
To meet this requirement, simply execute the PROC.*/