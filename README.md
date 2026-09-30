# 📚 Library Database Analysis using MySQL

## 📌 Project Overview

The **Library Database Analysis** project is a relational database project developed using **MySQL**.

The project focuses on creating, managing, and analyzing a library database that connects books, authors, publishers, library branches, borrowers, book copies, and book loans.

SQL queries are used to answer practical library-management questions related to:

- Book availability
- Library branch inventory
- Borrower activity
- Book loans
- Due dates
- Branch-wise loan activity
- Borrowers with multiple books checked out
- Author-specific book inventory

---

## 🎯 Project Objectives

The main objectives of this project are:

- Determine the number of copies of a specific book available at a library branch.
- Compare book-copy availability across different branches.
- Identify borrowers who do not have any books checked out.
- Retrieve loan details based on branch and due date.
- Calculate the total number of books loaned from each branch.
- Identify borrowers who have more than five books checked out.
- Analyze books written by **Stephen King** and their copies at the Central branch.

---

## 🛠️ Technology Stack

### MySQL

Used as the relational database management system for:

- Creating the database and tables
- Defining primary and foreign keys
- Importing and managing data
- Executing SQL queries
- Performing data analysis

### SQL

SQL concepts used in this project include:

- `CREATE DATABASE`
- `CREATE TABLE`
- Primary Keys
- Foreign Keys
- `JOIN`
- `LEFT JOIN`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `COUNT()`
- `SUM()`
- Subqueries
- Filtering and aggregation

---

## 🗂️ Database Structure

The project contains the following seven tables:

1. `tbl_publisher`
2. `tbl_book`
3. `tbl_book_authors`
4. `tbl_library_branch`
5. `tbl_book_copies`
6. `tbl_borrower`
7. `tbl_book_loans`

### Table Relationships

The database uses primary and foreign keys to establish relationships between the tables.

- `tbl_book` is connected to `tbl_publisher`
- `tbl_book_authors` is connected to `tbl_book`
- `tbl_book_copies` is connected to `tbl_book`
- `tbl_book_copies` is connected to `tbl_library_branch`
- `tbl_book_loans` is connected to `tbl_book`
- `tbl_book_loans` is connected to `tbl_library_branch`
- `tbl_book_loans` is connected to `tbl_borrower`

These relationships allow information from multiple tables to be combined using SQL joins.

---

## 🧩 Database Tables

### 1. `tbl_publisher`

Stores publisher information.

| Column | Description |
|---|---|
| `publisher_PublisherName` | Publisher name |
| `publisher_PublisherAddress` | Publisher address |
| `publisher_PublisherPhone` | Publisher phone number |

### 2. `tbl_book`

Stores information about books.

| Column | Description |
|---|---|
| `book_BookID` | Unique book ID |
| `book_Title` | Book title |
| `book_PublisherName` | Publisher of the book |

### 3. `tbl_book_authors`

Stores author information for books.

| Column | Description |
|---|---|
| `book_authors_AuthorID` | Unique author record ID |
| `book_authors_BookID` | Related book ID |
| `book_authors_AuthorName` | Author name |

### 4. `tbl_library_branch`

Stores library branch information.

| Column | Description |
|---|---|
| `library_branch_BranchID` | Unique branch ID |
| `library_branch_BranchName` | Library branch name |
| `library_branch_BranchAddress` | Branch address |

### 5. `tbl_book_copies`

Stores information about book copies available at each branch.

| Column | Description |
|---|---|
| `book_copies_CopiesID` | Unique copy record ID |
| `book_copies_BookID` | Related book ID |
| `book_copies_BranchID` | Related branch ID |
| `book_copies_No_Of_Copies` | Number of copies |

### 6. `tbl_borrower`

Stores borrower information.

| Column | Description |
|---|---|
| `borrower_CardNo` | Borrower card number |
| `borrower_BorrowerName` | Borrower name |
| `borrower_BorrowerAddress` | Borrower address |
| `borrower_BorrowerPhone` | Borrower phone number |

### 7. `tbl_book_loans`

Stores information about books borrowed from library branches.

| Column | Description |
|---|---|
| `book_loans_LoansID` | Unique loan ID |
| `book_loans_BookID` | Related book ID |
| `book_loans_BranchID` | Related branch ID |
| `book_loans_CardNo` | Borrower's card number |
| `book_loans_DateOut` | Date the book was borrowed |
| `book_loans_DueDate` | Due date of the book |

---

# 🔍 SQL Analysis

The project contains seven SQL analysis questions.

## 1. The Lost Tribe at Sharpstown

### Question

How many copies of the book **"The Lost Tribe"** are owned by the library branch **"Sharpstown"**?

### SQL Concepts

- `JOIN`
- `WHERE`
- Multiple-table relationships

### Result

**5 copies** of *The Lost Tribe* are owned by the Sharpstown branch.

---

## 2. The Lost Tribe Across All Branches

### Question

How many copies of the book **"The Lost Tribe"** are owned by each library branch?

### SQL Concepts

- `JOIN`
- `SUM()`
- `GROUP BY`
- `WHERE`

### Result

Each library branch has **5 copies** of *The Lost Tribe*.

---

## 3. Borrowers Without Checked-Out Books

### Question

Retrieve the names of all borrowers who do not have any books checked out.

### SQL Concepts

- `LEFT JOIN`
- `IS NULL`

### Result

**Jane Smith** is the only borrower who does not have any books checked out.

---

## 4. Sharpstown Loans Due on 2/3/18

### Question

For each book loaned out from the **Sharpstown** branch with a due date of **2/3/18**, retrieve:

- Book title
- Borrower's name
- Borrower's address

### SQL Concepts

- Multiple `JOIN`s
- `WHERE`
- Date filtering

### Result

The analysis returned **6 books** loaned from the Sharpstown branch with the specified due date.

---

## 5. Books Loaned by Each Branch

### Question

For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

### SQL Concepts

- `JOIN`
- `COUNT()`
- `GROUP BY`

### Result

| Library Branch | Books Loaned |
|---|---:|
| Sharpstown | 10 |
| Central | 11 |
| Saline | 10 |
| Ann Arbor | 20 |

---

## 6. Borrowers With More Than Five Books

### Question

Retrieve the names, addresses, and number of books checked out for borrowers who have more than five books checked out.

### SQL Concepts

- `JOIN`
- `COUNT()`
- `GROUP BY`
- `HAVING`

### Result

A total of **6 borrowers** were identified as having more than five books checked out.

---

## 7. Stephen King Books at Central Branch

### Question

For each book authored by **Stephen King**, retrieve the title and the number of copies owned by the **Central** library branch.

### SQL Concepts

- Multiple `JOIN`s
- Subquery
- `WHERE`
- Filtering based on author

### Result

The Stephen King books identified were:

- **It**
- **The Green Mile**

Each book has **5 copies** at the Central library branch.

---

# 📊 Key Insights

The SQL analysis produced the following key findings:

- **5 copies** of *The Lost Tribe* are available at the Sharpstown branch.
- Each library branch has **5 copies** of *The Lost Tribe*.
- **Jane Smith** is the only borrower without any checked-out books.
- **6 books** were identified for the specified Sharpstown due-date analysis.
- Branch-wise loan counts are:
  - Sharpstown – 10
  - Central – 11
  - Saline – 10
  - Ann Arbor – 20
- **6 borrowers** have more than five books checked out.
- Stephen King books identified in the analysis are *It* and *The Green Mile*.
- Each of these Stephen King books has **5 copies** at the Central branch.

---

# 🧠 SQL Concepts Demonstrated

This project helped demonstrate practical usage of several SQL concepts.

### 🔹 Primary Keys

Used to uniquely identify records in tables.

### 🔹 Foreign Keys

Used to establish relationships between related tables.

### 🔹 INNER JOIN

Used to combine related records from multiple tables.

### 🔹 LEFT JOIN

Used to identify borrowers who do not have corresponding loan records.

### 🔹 WHERE

Used to filter records based on specific conditions.

### 🔹 GROUP BY

Used to group records for aggregate analysis.

### 🔹 COUNT()

Used to count loan records and checked-out books.

### 🔹 SUM()

Used to calculate the total number of book copies.

### 🔹 HAVING

Used to filter grouped results, such as borrowers with more than five checked-out books.

### 🔹 Subquery

Used to identify books authored by Stephen King before filtering the Central branch inventory.

---

# ⚡ Challenges Faced

During the project, the major challenges included:

- Understanding relationships between multiple tables.
- Writing queries involving multiple `JOIN`s and conditions.
- Working with `GROUP BY` and aggregate functions.
- Understanding and implementing subqueries.
- Validating SQL query results to ensure the output was correct.

---

# 📚 Key Learnings

Through this project, I gained practical experience in:

- Designing and creating relational database tables.
- Understanding primary-key and foreign-key relationships.
- Writing SQL queries for real-world business questions.
- Combining information from multiple related tables.
- Using joins for relational data analysis.
- Performing aggregation using `COUNT()` and `SUM()`.
- Grouping data using `GROUP BY`.
- Filtering aggregated results using `HAVING`.
- Using subqueries for more advanced filtering.
- Validating SQL query outputs.

---

# 📁 Project Structure

```text
Library-Database-Analysis-MySQL/
│
├── Library_Database_Analysis_Project.sql
├── README.md
│
└── Project_Presentation/
    └── Library Database Analysis(using MySQL).pptx
