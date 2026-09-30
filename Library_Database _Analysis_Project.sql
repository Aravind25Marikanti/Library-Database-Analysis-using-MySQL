create database if not exists Library_Database_Proc;
use Library_Database_Proc;

-- Table: tbl_publisher
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);

-- Table: tbl_borrower
CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);

-- Table: tbl_library_branch
CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress TEXT
);

-- Table: tbl_book
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);

-- Table: tbl_book_authors
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
	FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);

-- Table: tbl_book_copies
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
);

-- Table: tbl_book_loans
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);

-- INSERTED CSV FILES DATA IN TABLES  using 'Table data import wizard'

-- checking the tables
show tables;
select * from tbl_publisher;
select * from tbl_borrower;
select * from tbl_library_branch;
select * from tbl_book;
select * from tbl_book_authors;
select * from tbl_book_copies;
select * from tbl_book_loans;

-- BELOW USED TO DELETE ONLY RECORDS AND STARTING INCREMENT FROM 1
-- DELETE FROM tbl_book_authors;
-- ALTER TABLE tbl_book_authors AUTO_INCREMENT=1;

-- DELETE FROM tbl_book_copies;
-- ALTER TABLE tbl_book_copies AUTO_INCREMENT=1;

-- DELETE FROM tbl_book_loans;
-- ALTER TABLE tbl_book_loans AUTO_INCREMENT=1;

-- ----------------------
-- Task Questions
-- ----------------------
-- 1.	How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
select bc.book_copies_no_of_copies,b.book_Title,lb.library_branch_BranchName from tbl_book_copies bc 
join tbl_book b on bc.book_copies_BookID=b.book_BookID
join tbl_library_branch lb on bc.book_copies_BranchID=lb.library_branch_BranchID
where b.book_Title='The Lost Tribe' and lb.library_branch_BranchName='Sharpstown';


-- 2.	How many copies of the book titled "The Lost Tribe" are owned by each library branch?
select lb.library_branch_BranchName,sum(bc.book_copies_No_Of_Copies) as Total_Copies from tbl_book_copies bc 
join tbl_book b on bc.book_copies_BookID=b.book_BookID
join tbl_library_branch lb on bc.book_copies_BranchID=lb.library_branch_BranchID
where b.book_Title='The Lost Tribe' group by lb.library_branch_BranchName;


-- 3.	Retrieve the names of all borrowers who do not have any books checked out.
select b.borrower_BorrowerName, bl.book_loans_CardNo,bl.book_loans_DateOut
from tbl_borrower b
left join tbl_book_loans bl on b.borrower_CardNo = bl.book_loans_CardNo
where bl.book_loans_CardNo is null;


-- 4.	For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 
select lb.library_branch_BranchName,bl.book_loans_DueDate,b.book_Title, bor.borrower_BorrowerName, bor.borrower_BorrowerAddress from tbl_book_loans bl
join tbl_book b on bl.book_loans_BookID = b.book_BookID
join tbl_borrower bor on bl.book_loans_CardNo = bor.borrower_CardNo
join tbl_library_branch lb on bl.book_loans_BranchID = lb.library_branch_BranchID
where lb.library_branch_BranchName = 'Sharpstown'
and (bl.book_loans_DueDate = '2018-03-02');


-- 5.	For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
select lb.library_branch_BranchName,count(bl.book_loans_LoansID) as Each_branch_books_loaned_out from tbl_library_branch lb
join tbl_book_loans bl on lb.library_branch_BranchID=bl.book_loans_BranchID
group by library_branch_BranchName;


-- 6.	Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
select b.borrower_BorrowerName, b.borrower_BorrowerAddress, COUNT(bl.book_loans_LoansID) AS Books_Checked_Out
from tbl_borrower b
join tbl_book_loans bl on b.borrower_CardNo = bl.book_loans_CardNo
group by b.borrower_CardNo, b.borrower_BorrowerName, b.borrower_BorrowerAddress
having COUNT(bl.book_loans_LoansID) > 5;


-- 7.	For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
select b.book_Title,(bc.book_copies_No_Of_Copies) from tbl_book b 
join tbl_book_copies bc on b.book_BookID=bc.book_copies_BookID
join tbl_library_branch lb on bc.book_copies_BranchID=lb.library_branch_BranchID
where lb.library_branch_BranchName='Central' and b.book_BookID in (select book_authors_BookID from tbl_book_authors where book_authors_AuthorName='Stephen King');
