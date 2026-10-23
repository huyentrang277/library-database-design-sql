# Library Management System — Database Design & SQL

## 1. Project Overview

This project designs and implements a relational database for a Library Management System using MySQL.

The database supports book management, author and publisher information, book categories, library members, and borrowing transactions.

## 2. Objectives

- Design a relational database using an Entity-Relationship Diagram (ERD).
- Apply database normalization up to Third Normal Form (3NF).
- Implement primary keys, foreign keys, and data constraints.
- Insert sample data for testing.
- Write SQL queries to retrieve and analyze library data.
- Implement indexes, a view, a stored procedure, and a trigger.

## 3. Technologies

- MySQL
- MySQL Workbench
- SQL
- Git and GitHub

## 4. Database Structure

The database contains eight tables:

1. `authors` — stores author information.
2. `book_authors` — connects books and authors.
3. `books` — stores book information.
4. `borrowing_details` — stores the books included in borrowing records.
5. `borrowings` — stores borrowing transactions.
6. `categories` — stores book categories.
7. `members` — stores library member information.
8. `publishers` — stores publisher information.

## 5. Project Structure

```text
library-database-design-sql/
├── erd/
│   ├── library_erd.png
│   └── library_erd.dbml
├── sql/
│   ├── create_database.sql
│   ├── insert_sample_data.sql
│   ├── indexes_views.sql
│   └── procedure_trigger.sql
├── queries/
│   └── queries.sql
├── docs/
│   └── screenshots/
└── README.md
```

## 6. Implementation

The project includes:

- Database and table creation scripts.
- Sample data for all eight tables.
- Indexes for frequently queried columns.
- A view summarizing book borrowing information.
- A stored procedure for retrieving a member's borrowing history.
- A trigger that validates book return dates.
- Ten SQL queries demonstrating filtering, sorting, joins, aggregate functions, subqueries, `CASE WHEN`, window functions, pagination, and CTEs.

## 7. How to Run

1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench and connect to your MySQL Server.
3. Run `sql/01_create_database.sql`.
4. Run `sql/02_insert_sample_data.sql`.
5. Run `sql/03_indexes_views.sql`.
6. Run `sql/04_procedure_trigger.sql`.
7. Open `queries/queries.sql` and execute the queries individually.

**Important:** Run the sample data script only once on a newly created database to avoid duplicate-key errors. If the database already contains the sample data, do not rerun the insert statements.

## 8. Testing

The SQL queries were executed in MySQL Workbench. Screenshots of query results are included in `docs/screenshots/`.

The tests demonstrate how the database retrieves, joins, filters, and summarizes library information.

## 9. Limitations

This project focuses on relational database design and SQL implementation. It does not include a complete application interface.

## 10. Author

Tran Thi Huyen Trang — Database Design & SQL assignment.
