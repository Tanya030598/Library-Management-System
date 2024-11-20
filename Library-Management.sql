-- schema.sql --

create database library;
use library;

-- Create the 'Authors' Table --
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE
);

-- Create the 'Books' Table --
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    publication_year INT,
    author_id INT,
    available_copies INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Create the 'Customers' Table --
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    membership_date DATE
);

-- Create the 'Loans' Table --
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    book_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Add data --
-- data.sql --

-- Insert data in Authors Table --
INSERT INTO Authors
(author_id, first_name, last_name, birth_date)
VALUES
(1, 'J.K.', 'Rowling', '1965-07-31'),
(2, 'George', 'Orwell', '1903-06-25'),
(3, 'J.R.R.', 'Tolkien', '1892-01-03'),
(4, 'Agatha', 'Christie', '1890-09-15'),
(5, 'F. Scott', 'Fitzgerald', '1896-09-24'),
(6, 'Harper', 'Lee', '1926-04-28'),
(7, 'Mark', 'Twain', '1835-11-30'),
(8, 'Jane', 'Austen', '1775-12-16'),
(9, 'Leo', 'Tolstoy', '1828-09-09'),
(10, 'William', 'Shakespeare', '1564-04-23');

-- Insert data in books table --
INSERT INTO Books
(book_id, title, genre, publication_year, author_id, available_copies)
VALUES
(1, 'Harry Potter and the Sorcerer\'s Stone', 'Fantasy', 1997, 1, 5),
(2, '1984', 'Dystopian', 1949, 2, 3),
(3, 'The Hobbit', 'Fantasy', 1937, 3, 4),
(4, 'Murder on the Orient Express', 'Mystery', 1934, 4, 6),
(5, 'The Great Gatsby', 'Fiction', 1925, 5, 2),
(6, 'To Kill a Mockingbird', 'Fiction', 1960, 6, 3),
(7, 'The Adventures of Tom Sawyer', 'Adventure', 1876, 7, 5),
(8, 'Pride and Prejudice', 'Romance', 1813, 8, 4),
(9, 'War and Peace', 'Historical Fiction', 1869, 9, 2),
(10, 'Hamlet', 'Tragedy', 1600, 10, 7);

-- Insert Data in Customers Table --
INSERT INTO Customers
(customer_id, first_name, last_name, email, membership_date)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '2023-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2023-02-20'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '2023-03-05'),
(4, 'Bob', 'Williams', 'bob.williams@example.com', '2023-04-12'),
(5, 'Charlie', 'Brown', 'charlie.brown@example.com', '2023-05-10'),
(6, 'David', 'Davis', 'david.davis@example.com', '2023-06-18'),
(7, 'Emma', 'Wilson', 'emma.wilson@example.com', '2023-07-25'),
(8, 'Olivia', 'Moore', 'olivia.moore@example.com', '2023-08-01'),
(9, 'Sophia', 'Taylor', 'sophia.taylor@example.com', '2023-09-05'),
(10, 'Liam', 'Miller', 'liam.miller@example.com', '2023-10-15');

-- Insert data in loans table --
INSERT INTO Loans 
(customer_id, book_id, loan_date, return_date)
VALUES
(1, 1, '2023-05-01', '2023-05-15'),
(2, 2, '2023-05-10', '2023-05-20'),
(3, 3, '2023-06-01', '2023-06-10'),
(4, 4, '2023-07-01', '2023-07-15'),
(5, 5, '2023-07-05', '2023-07-20'),
(6, 6, '2023-07-10', '2023-07-25'),
(7, 7, '2023-08-01', '2023-08-15'),
(8, 8, '2023-08-10', '2023-08-24'),
(9, 9, '2023-09-01', '2023-09-10'),
(10, 10, '2023-09-05', '2023-09-20');

-- Sql Queries --
-- Basic Queries --
Query 1: List all books
Ans-- SELECT * FROM Books;

Query 2: Find all books by a specific author (e.g., 'J.K. Rowling')
Ans-- SELECT b.title, b.genre, b.publication_year
      FROM Books b
      JOIN Authors a ON b.author_id = a.author_id
      WHERE a.first_name = 'J.K.' AND a.last_name = 'Rowling';

Query 3: Find all customers who borrowed a specific book (e.g., '1984')
Ans-- SELECT c.first_name, c.last_name, l.loan_date, l.return_date
      FROM Loans l
      JOIN Customers c ON l.customer_id = c.customer_id
      JOIN Books b ON l.book_id = b.book_id
      WHERE b.title = '1984';

Query 4: List all authors
Ans-- SELECT * FROM Authors;

Query 5: Find all available books (books with > 0 copies)
Ans-- SELECT * FROM Books WHERE available_copies > 0;

-- Intermediate Queries --
  
Query 1: Find the number of books borrowed by each customer
Ans-- SELECT c.first_name, c.last_name, COUNT(l.loan_id) AS books_borrowed
      FROM Customers c
      JOIN Loans l ON c.customer_id = l.customer_id
      GROUP BY c.customer_id;

Query 2: Find the most popular book (book with the highest number of loans)
Ans-- SELECT b.title, COUNT(l.loan_id) AS loan_count
      FROM Books b
      JOIN Loans l ON b.book_id = l.book_id
      GROUP BY b.book_id
      ORDER BY loan_count DESC
      LIMIT 1;

Query 3: Find all books that were borrowed more than once
Ans-- SELECT b.title, COUNT(l.loan_id) AS borrow_count
      FROM Books b
      JOIN Loans l ON b.book_id = l.book_id
      GROUP BY b.book_id
      HAVING borrow_count > 1;

Query 4: Find all books by a specific genre (e.g., 'Fantasy')
Ans-- SELECT b.title, b.author_id, b.publication_year
      FROM Books b
      WHERE b.genre = 'Fantasy';

Query 5: Find the customer who borrowed the most books
Ans-- SELECT c.first_name, c.last_name, COUNT(l.loan_id) AS borrow_count
      FROM Customers c
      JOIN Loans l ON c.customer_id = l.customer_id
      GROUP BY c.customer_id
      ORDER BY borrow_count DESC
      LIMIT 1;

-- Advanced Queries --
Query 1: Find the average number of books borrowed per customer
Ans-- SELECT AVG(books_borrowed) AS avg_books_borrowed
      FROM (SELECT COUNT(l.loan_id) AS books_borrowed
      FROM Loans l
      GROUP BY l.customer_id) AS borrow_count;

Query 2: Find books that have never been borrowed
Ans-- SELECT b.title
      FROM Books b
      LEFT JOIN Loans l ON b.book_id = l.book_id
      WHERE l.loan_id IS NULL;

Query 3: Find the total number of books borrowed in the last month
Ans-- SELECT COUNT(l.loan_id) AS total_books_borrowed
      FROM Loans l
      WHERE l.loan_date BETWEEN '2023-09-01' AND '2023-09-30';

Query 4: Find the most common genre borrowed by customers
Ans-- SELECT b.genre, COUNT(l.loan_id) AS borrow_count
      FROM Books b
      JOIN Loans l ON b.book_id = l.book_id
      GROUP BY b.genre
      ORDER BY borrow_count DESC
      LIMIT 1;

Query 5: Find customers who borrowed a book by a specific author (e.g., 'Agatha Christie')
Ans-- SELECT c.first_name, c.last_name, b.title
      FROM Customers c
      JOIN Loans l ON c.customer_id = l.customer_id
      JOIN Books b ON l.book_id = b.book_id
      JOIN Authors a ON b.author_id = a.author_id
      WHERE a.first_name = 'Agatha' AND a.last_name = 'Christie';


  
