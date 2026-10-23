
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
