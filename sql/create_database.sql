
-- =====================================================
-- Project: Library Management System
-- File: 01_create_database.sql
-- Database: MySQL 8.0+
-- =====================================================

CREATE DATABASE IF NOT EXISTS library_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE library_db;

-- 1. Publishers
CREATE TABLE IF NOT EXISTS publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(150) NOT NULL UNIQUE,
    address VARCHAR(255),
    phone VARCHAR(20)
);

-- 2. Categories
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- 3. Authors
CREATE TABLE IF NOT EXISTS authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(150) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(100)
);

-- 4. Books
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    publisher_id INT NOT NULL,
    category_id INT NOT NULL,
    publication_year SMALLINT,
    total_copies INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_books_publishers
        FOREIGN KEY (publisher_id)
        REFERENCES publishers(publisher_id),

    CONSTRAINT fk_books_categories
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    CONSTRAINT chk_books_copies
        CHECK (total_copies >= 0),

    CONSTRAINT chk_books_year
        CHECK (
            publication_year IS NULL
            OR publication_year BETWEEN 1450 AND 2100
        )
);

-- 5. Book Authors: many-to-many relationship
CREATE TABLE IF NOT EXISTS book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,

    PRIMARY KEY (book_id, author_id),

    CONSTRAINT fk_book_authors_books
        FOREIGN KEY (book_id)
        REFERENCES books(book_id),

    CONSTRAINT fk_book_authors_authors
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
);

-- 6. Members
CREATE TABLE IF NOT EXISTS members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    joined_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    status VARCHAR(10) NOT NULL DEFAULT 'active',

    CONSTRAINT chk_members_status
        CHECK (status IN ('active', 'inactive'))
);

-- 7. Borrowings
CREATE TABLE IF NOT EXISTS borrowings (
    borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    borrowing_status VARCHAR(20) NOT NULL DEFAULT 'borrowing',

    CONSTRAINT fk_borrowings_members
        FOREIGN KEY (member_id) REFERENCES members(member_id),

    CONSTRAINT chk_borrowings_dates
        CHECK (due_date >= loan_date),

    CONSTRAINT chk_borrowings_status
        CHECK (
            borrowing_status IN (
                'borrowing',
                'returned',
                'overdue',
                'cancelled'
            )
        )
);

-- 8. Borrowing Details
CREATE TABLE IF NOT EXISTS borrowing_details (
    borrowing_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    borrowing_id INT NOT NULL,
    book_id INT NOT NULL,
    return_date DATE,
    condition_note VARCHAR(255),
    fine_amount DECIMAL(12, 2) NOT NULL DEFAULT 0,

    CONSTRAINT uq_borrowing_book
        UNIQUE (borrowing_id, book_id),

    CONSTRAINT fk_borrowing_details_borrowings
        FOREIGN KEY (borrowing_id) REFERENCES borrowings(borrowing_id),

    CONSTRAINT fk_borrowing_details_books
        FOREIGN KEY (book_id) REFERENCES books(book_id),

    CONSTRAINT chk_fine_amount
        CHECK (fine_amount >= 0),

    CONSTRAINT chk_return_date
        CHECK (return_date IS NULL OR return_date >= '1900-01-01')
);

-- Verify tables
SHOW TABLES;
