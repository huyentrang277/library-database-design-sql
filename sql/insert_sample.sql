
USE library_db;

-- 1. Publishers: 10 records
INSERT INTO publishers (publisher_name, address, phone) VALUES
('Penguin Random House', 'New York, USA', '1000000001'),
('HarperCollins', 'New York, USA', '1000000002'),
('Simon & Schuster', 'New York, USA', '1000000003'),
('Macmillan Publishers', 'London, UK', '1000000004'),
('Hachette Livre', 'Paris, France', '1000000005'),
('Oxford University Press', 'Oxford, UK', '1000000006'),
('Cambridge University Press', 'Cambridge, UK', '1000000007'),
('Pearson Education', 'London, UK', '1000000008'),
('Wiley', 'Hoboken, USA', '1000000009'),
('Scholastic', 'New York, USA', '1000000010');

-- 2. Categories: 10 records
INSERT INTO categories (category_name, description) VALUES
('Literature', 'Novels, short stories, and literary works'),
('Science', 'Natural and applied sciences'),
('Technology', 'Computers and modern technology'),
('History', 'Historical events and biographies'),
('Business', 'Management, finance, and entrepreneurship'),
('Education', 'Teaching and learning resources'),
('Mathematics', 'Mathematics and statistics'),
('Psychology', 'Human behavior and mental processes'),
('Philosophy', 'Philosophical ideas and ethics'),
('Children', 'Books for children and young readers');

-- 3. Authors: 10 records
INSERT INTO authors (author_name, birth_date, nationality) VALUES
('George Orwell', '1903-06-25', 'British'),
('Jane Austen', '1775-12-16', 'British'),
('Yuval Noah Harari', '1976-02-24', 'Israeli'),
('Robert C. Martin', '1952-12-05', 'American'),
('J. K. Rowling', '1965-07-31', 'British'),
('Paulo Coelho', '1947-08-24', 'Brazilian'),
('Stephen Hawking', '1942-01-08', 'British'),
('Agatha Christie', '1890-09-15', 'British'),
('Daniel Kahneman', '1934-03-05', 'Israeli-American'),
('Antoine de Saint-Exupery', '1900-06-29', 'French');



-- 4. Books: 10 records
INSERT INTO books
    (isbn, title, publisher_id, category_id, publication_year, total_copies)
VALUES
('9780451524935', '1984', 1, 1, 1949, 5),
('9780141439518', 'Pride and Prejudice', 2, 1, 1813, 4),
('9780062316097', 'Sapiens', 3, 4, 2011, 6),
('9780132350884', 'Clean Code', 8, 3, 2008, 5),
('9780545010221', 'Harry Potter and the Deathly Hallows', 10, 10, 2007, 7),
('9780062315007', 'The Alchemist', 5, 1, 1988, 4),
('9780553380163', 'A Brief History of Time', 9, 2, 1988, 3),
('9780062073488', 'Murder on the Orient Express', 2, 1, 1934, 4),
('9780374533557', 'Thinking, Fast and Slow', 3, 8, 2011, 3),
('9780156012195', 'The Little Prince', 4, 10, 1943, 5);

-- 5. Book authors: link each book to its author
INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


-- 6. Members

INSERT INTO members
    (full_name, email, phone, joined_date, status)
VALUES
('Nguyen Minh Anh', 'minhanh01@example.com', '0901000001', '2026-01-05', 'active'),
('Tran Quoc Bao', 'quocbao02@example.com', '0901000002', '2026-01-10', 'active'),
('Le Thu Ha', 'thuha03@example.com', '0901000003', '2026-01-15', 'active'),
('Pham Duc Huy', 'duchuy04@example.com', '0901000004', '2026-02-01', 'active'),
('Hoang Ngoc Linh', 'ngoclinh05@example.com', '0901000005', '2026-02-08', 'active'),
('Do Thanh Nam', 'thanhnam06@example.com', '0901000006', '2026-02-15', 'active'),
('Bui Phuong Thao', 'phuongthao07@example.com', '0901000007', '2026-03-01', 'active'),
('Vu Tuan Kiet', 'tuankiet08@example.com', '0901000008', '2026-03-10', 'active'),
('Dang Mai Chi', 'maichi09@example.com', '0901000009', '2026-03-20', 'inactive'),
('Ngo Hoang Long', 'hoanglong10@example.com', '0901000010', '2026-04-01', 'active');

-- 7. Borrowing records
INSERT INTO borrowings
    (member_id, borrowing_date, due_date, borrowing_status)
VALUES
(1, '2026-09-01', '2026-09-15', 'returned'),
(2, '2026-09-05', '2026-09-19', 'returned'),
(3, '2026-09-10', '2026-09-24', 'returned'),
(4, '2026-09-15', '2026-09-29', 'returned'),
(5, '2026-09-20', '2026-10-04', 'returned'),
(6, '2026-10-01', '2026-10-15', 'overdue'),
(7, '2026-10-05', '2026-10-19', 'overdue'),
(8, '2026-10-10', '2026-10-24', 'borrowing'),
(1, '2026-10-15', '2026-10-29', 'borrowing'),
(2, '2026-10-20', '2026-11-03', 'borrowing');

-- 8. Borrowing record details
INSERT INTO borrowing_details
    (borrowing_id, book_id, return_date, condition_note, fine_amount)
VALUES
(1, 1, '2026-09-10', 'Returned in good condition', 0),
(2, 2, '2026-09-18', 'Returned in good condition', 0),
(3, 3, '2026-09-22', 'Returned in good condition', 0),
(4, 4, '2026-09-28', 'Returned in good condition', 0),
(5, 5, '2026-10-02', 'Returned in good condition', 0),
(6, 6, NULL, 'Not yet returned', 0),
(7, 7, NULL, 'Not yet returned', 0),
(8, 8, NULL, 'Currently borrowing', 0),
(9, 9, NULL, 'Currently borrowing', 0),
(10, 10, NULL, 'Currently borrowing', 0);
