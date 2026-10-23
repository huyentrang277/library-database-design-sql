
USE library_db;

-- =========================================
-- 1. STORED PROCEDURE
-- Show borrowing history of a member
-- =========================================

DROP PROCEDURE IF EXISTS sp_member_borrowing_history;

DELIMITER //

CREATE PROCEDURE sp_member_borrowing_history(
    IN p_member_id INT
)
BEGIN
    SELECT
        m.member_id,
        m.full_name,
        b.borrowing_id,
        b.borrowing_date,
        b.due_date,
        b.borrowing_status,
        bk.title,
        bd.return_date,
        bd.fine_amount
    FROM members m
    JOIN borrowings b
        ON m.member_id = b.member_id
    JOIN borrowing_details bd
        ON b.borrowing_id = bd.borrowing_id
    JOIN books bk
        ON bd.book_id = bk.book_id
    WHERE m.member_id = p_member_id
    ORDER BY b.borrowing_date DESC, b.borrowing_id;
END //

DELIMITER ;


-- =========================================
-- 2. TRIGGER
-- Validate return date before inserting
-- =========================================

DROP TRIGGER IF EXISTS trg_validate_return_date;

DELIMITER //

CREATE TRIGGER trg_validate_return_date
BEFORE INSERT ON borrowing_details
FOR EACH ROW
BEGIN
    DECLARE v_borrowing_date DATE;

    SELECT borrowing_date
    INTO v_borrowing_date
    FROM borrowings
    WHERE borrowing_id = NEW.borrowing_id;

    IF NEW.return_date IS NOT NULL
       AND NEW.return_date < v_borrowing_date THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
                'Return date cannot be earlier than borrowing date';
    END IF;
END //

DELIMITER ;


-- =========================================
-- 3. VERIFY
-- =========================================

SHOW PROCEDURE STATUS
WHERE Db = 'library_db'
  AND Name = 'sp_member_borrowing_history';

SHOW TRIGGERS
FROM library_db;
