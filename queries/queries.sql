USE library_db;

-- =====================================================
-- Query 1: Lastest published books
/* Mục đích: Hiển thị 5 cuốn sách có năm xuất bản gần đây nhất.
Giải thích: ORDER BY sắp xếp năm xuất bản giảm dần,
    LIMIT 5 giới hạn kết quả chỉ còn 5 dòng.*/
SELECT
    book_id,
    title,
    isbn,
    publication_year,
    total_copies
FROM books
ORDER BY publication_year DESC
LIMIT 5;

-- =====================================================
-- Query 2: Filter active members
/* Mục đích: Hiển thị danh sách thành viên có trạng thái active.
Giải thích: WHERE lọc những thành viên đang hoạt động,
    ORDER BY sắp xếp tên thành viên theo thứ tự alphabet.*/
SELECT
    member_id,
    full_name,
    email,
    phone
FROM members
WHERE status = 'active'
ORDER BY full_name ASC;

-- =====================================================
-- Query 3: Filter category
/* Mục đích: Hiển thị tên sách và tên thể loại tương ứng.
Giải thích: INNER JOIN kết hợp bảng books với categories
    thông qua category_id. Kết quả gồm các sách có thể loại
    khớp với dữ liệu trong bảng categories.*/
SELECT
    b.book_id,
    b.title,
    c.category_name
FROM books b
INNER JOIN categories c
    ON b.category_id = c.category_id
ORDER BY c.category_name, b.title;

-- =====================================================
-- Query 4: Books and their authors
/* Mục đích: Liệt kê tên sách và tác giả tương ứng.
    Giải thích: LEFT JOIN giữ lại tất cả sách ở bảng books,
    kể cả khi chưa có tác giả được liên kết.*/
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

-- =====================================================
-- Query 5: Count borrowings by status
/* Mục đích: Đếm số phiếu mượn thuộc từng trạng thái.
Giải thích: COUNT(*) đếm số bản ghi; GROUP BY gom
    các phiếu mượn có cùng borrowing_status thành từng nhóm.
    ORDER BY sắp xếp nhóm theo số lượng giảm dần.*/
SELECT
    borrowing_status,
    COUNT(*) AS total_borrowings
FROM borrowings
GROUP BY borrowing_status
ORDER BY total_borrowings DESC;

-- =====================================================
-- Query 6: Members who have borrowed books
/* -- Mục đích: Liệt kê các thành viên có phiếu mượn.
Giải thích: Truy vấn con lấy danh sách member_id từ bảng
    borrowings. IN chọn những thành viên có ID nằm trong
    danh sách đó.*/
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

-- =====================================================
-- Query 7: Classify borrowing status
/* Mục đích: Hiển thị thêm nhãn mô tả cho từng phiếu mượn.
Giải thích: CASE WHEN kiểm tra trạng thái và hạn trả để
    phân loại phiếu mượn thành các nhóm dễ hiểu.*/
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

-- =====================================================
-- Query 8: Rank books by borrowing count
/* Mục đích: Xếp hạng sách dựa trên số bản ghi mượn sách.
Giải thích: RANK() là hàm cửa sổ dùng để xếp hạng các
    sách theo total_borrow_records giảm dần.*/
SELECT
    book_id,
    title,
    total_borrow_records,
    RANK() OVER (
        ORDER BY total_borrow_records DESC
    ) AS borrowing_rank
FROM v_book_borrowing_summary
ORDER BY borrowing_rank, title;

-- =====================================================
-- Query 9: Pagination - page 2
/* Mục đích: Hiển thị trang thứ hai với 5 cuốn sách.
Giải thích: LIMIT 5 lấy tối đa 5 dòng, OFFSET 5 bỏ qua
    5 dòng đầu tiên. ORDER BY book_id đảm bảo thứ tự ổn định.*/
SELECT
    book_id,
    title,
    isbn,
    publication_year
FROM books
ORDER BY book_id
LIMIT 5 OFFSET 5;

-- =====================================================
-- Query 10: Members borrowing above average
/* Mục đích: Tìm những thành viên có số phiếu mượn lớn hơn
    số phiếu mượn trung bình của tất cả thành viên.
Giải thích: CTE member_borrowing_counts tính số phiếu
    mượn của từng thành viên. Truy vấn con tính trung bình,
    sau đó truy vấn chính lọc các thành viên vượt mức trung bình. */
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