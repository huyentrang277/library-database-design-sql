
USE library_db;

-- =========================================
-- 1. INDEXES
-- =========================================

-- Index 1: Support searching books by title
CREATE INDEX idx_books_title
ON books(title);

-- Index 2: Support finding borrowing records
-- by member and borrowing date
CREATE INDEX idx_borrowings_member_date
ON borrowings(member_id, borrowing_date);

-- Index 3: Support finding borrowing details by book
CREATE INDEX idx_borrowing_details_book
ON borrowing_details(book_id);


-- =========================================
-- 2. VIEW: BOOK BORROWING SUMMARY
-- =========================================

CREATE OR REPLACE VIEW v_book_borrowing_summary AS
SELECT
    b.book_id,
    b.title,
    b.isbn,
    b.total_copies,
    COUNT(bd.borrowing_detail_id) AS total_borrow_records,
    SUM(
        CASE
            WHEN bd.borrowing_detail_id IS NOT NULL
                 AND bd.return_date IS NULL
            THEN 1
            ELSE 0
        END
    ) AS currently_borrowed
FROM books b
LEFT JOIN borrowing_details bd
    ON b.book_id = bd.book_id
GROUP BY
    b.book_id,
    b.title,
    b.isbn,
    b.total_copies;


-- =========================================
-- 3. VERIFY INDEXES AND VIEW
-- =========================================

SHOW INDEX FROM books;
SHOW INDEX FROM borrowings;
SHOW INDEX FROM borrowing_details;

SELECT *
FROM v_book_borrowing_summary
ORDER BY book_id;
