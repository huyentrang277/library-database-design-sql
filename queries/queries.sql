USE library_db;
-- Query 1: Lastest published books
SELECT
    book_id,
    title,
    isbn,
    publication_year,
    total_copies
FROM books
ORDER BY publication_year DESC
LIMIT 5;

-- Query 2: Filter active members
SELECT
    member_id,
    full_name,
    email,
    phone
FROM members
WHERE status = 'active'
ORDER BY full_name ASC;

-- Query 3: Filter category
SELECT
    b.book_id,
    b.title,
    c.category_name
FROM books b
INNER JOIN categories c
    ON b.category_id = c.category_id
ORDER BY c.category_name, b.title;

-- Query 4: Books and their authors
SELECT
    b.book_id,
    b.title,
    a.author_name
FROM books b
LEFT JOIN book_authors ba
    ON b.book_id = ba.book_id
LEFT JOIN authors a
    ON ba.author_id = a.author_id
ORDER BY b.title;

-- Query 5: Count borrowings by status
SELECT
    borrowing_status,
    COUNT(*) AS total_borrowings
FROM borrowings
GROUP BY borrowing_status
ORDER BY total_borrowings DESC;

-- Query 6: Members who have borrowed books
SELECT
    member_id,
    full_name,
    email
FROM members
WHERE member_id IN (
    SELECT member_id
    FROM borrowings
)
ORDER BY full_name;

-- Query 7: Classify borrowing status
SELECT
    borrowing_id,
    member_id,
    due_date,
    borrowing_status,
    CASE
        WHEN borrowing_status = 'returned' THEN 'Completed'
        WHEN borrowing_status = 'overdue' THEN 'Overdue'
        WHEN borrowing_status = 'borrowing'
             AND due_date < CURDATE() THEN 'Past Due'
        WHEN borrowing_status = 'borrowing' THEN 'In Progress'
        ELSE 'Other'
    END AS status_description
FROM borrowings
ORDER BY due_date;

-- Query 8: Rank books by borrowing count
SELECT
    book_id,
    title,
    total_borrow_records,
    RANK() OVER (
        ORDER BY total_borrow_records DESC
    ) AS borrowing_rank
FROM v_book_borrowing_summary
ORDER BY borrowing_rank, title;

-- Query 9: Pagination - page 2
SELECT
    book_id,
    title,
    isbn,
    publication_year
FROM books
ORDER BY book_id
LIMIT 5 OFFSET 5;

-- Query 10: Members borrowing above average
WITH member_borrowing_counts AS (
    SELECT
        m.member_id,
        m.full_name,
        COUNT(b.borrowing_id) AS total_borrowings
    FROM members m
    LEFT JOIN borrowings b
        ON m.member_id = b.member_id
    GROUP BY
        m.member_id,
        m.full_name
)
SELECT
    member_id,
    full_name,
    total_borrowings
FROM member_borrowing_counts
WHERE total_borrowings > (
    SELECT AVG(total_borrowings)
    FROM member_borrowing_counts
)
ORDER BY total_borrowings DESC;