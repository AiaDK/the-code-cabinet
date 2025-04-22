# 🐘 PostgreSQL Cheatsheet with Explanations

Your all-in-one reference for PostgreSQL basics, now with explanations next to every code snippet for maximum clarity.

---

## 🔌 Connecting and Basic `psql` Commands

```bash
psql -U username -d dbname           -- Connect to a PostgreSQL database using your username and database name
```

```sql
\l                                   -- List all available databases
\c dbname                            -- Connect to a specific database
\dt                                  -- List all tables in the current schema
\d tablename                         -- Show the structure (columns, types, indexes) of a table
\q                                   -- Quit the psql terminal
```

---

## 🔤 Common PostgreSQL Data Types

```sql
INTEGER, BIGINT                     -- Whole numbers of varying sizes
SERIAL, BIGSERIAL                   -- Auto-incrementing integer (commonly used for primary keys)
NUMERIC(precision, scale)          -- Exact decimal values (e.g. for financial data)
REAL, DOUBLE PRECISION             -- Floating-point numbers (approximate values)
VARCHAR(n), CHAR(n)                -- Strings with variable/fixed length
TEXT                               -- Unlimited-length string
BOOLEAN                            -- Logical values: TRUE, FALSE, NULL
DATE, TIME, TIMESTAMP              -- Calendar dates and times
UUID                               -- Universally unique identifier
BYTEA                              -- Binary data (e.g. for file storage)
```

---

## 🏗️ DDL (CREATE, ALTER, DROP)

```sql
CREATE TABLE users (                -- Create a new table called 'users'
  id SERIAL PRIMARY KEY,           -- Auto-incrementing primary key
  name VARCHAR(100) NOT NULL,      -- Non-nullable name with max 100 characters
  email VARCHAR(150) UNIQUE,       -- Unique email address
  age INTEGER CHECK (age >= 0),    -- Integer age, must be non-negative
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp defaulting to now
);
```

```sql
ALTER TABLE users ADD COLUMN status TEXT;       -- Add a new column 'status' of type TEXT
ALTER TABLE users RENAME COLUMN status TO user_status; -- Rename 'status' to 'user_status'
ALTER TABLE users DROP COLUMN user_status;      -- Remove the column 'user_status'
```

```sql
DROP TABLE IF EXISTS users;        -- Drop the 'users' table if it exists
```

---

## ✏️ DML (INSERT, SELECT, UPDATE, DELETE)

```sql
INSERT INTO users (name, email, age)
VALUES ('Alice', 'alice@mail.com', 25); -- Insert a new user record
```

```sql
SELECT id, name FROM users;        -- Retrieve 'id' and 'name' from all users
```

```sql
UPDATE users
SET age = 30
WHERE name = 'Alice';              -- Update age to 30 where name is 'Alice'
```

```sql
DELETE FROM users
WHERE id = 5;                      -- Delete user with id 5
```

---

## 🔍 Filtering, Ordering, and Limiting

```sql
SELECT * FROM users
WHERE age > 18 AND email IS NOT NULL; -- Filter users older than 18 with non-null email
```

```sql
SELECT * FROM users
ORDER BY age DESC, name ASC;       -- Sort users by age descending, then name ascending
```

```sql
SELECT * FROM users
ORDER BY id
LIMIT 10 OFFSET 20;                -- Skip first 20 rows, then return next 10 rows
```

---

## 🔗 Joins (INNER, LEFT, RIGHT, FULL)

```sql
SELECT * FROM users u
INNER JOIN orders o ON u.id = o.user_id; -- Return only matching rows from both tables
```

```sql
SELECT * FROM users u
LEFT JOIN orders o ON u.id = o.user_id;  -- Return all users and matching orders (NULL if no match)
```

```sql
SELECT * FROM users u
RIGHT JOIN orders o ON u.id = o.user_id; -- Return all orders and matching users (NULL if no match)
```

```sql
SELECT * FROM users u
FULL OUTER JOIN orders o ON u.id = o.user_id; -- Return all users and all orders, matched where possible
```

---

## 🧮 Aggregations and Grouping

```sql
SELECT COUNT(*) FROM users;        -- Count total number of rows in users
SELECT AVG(age) FROM users;        -- Calculate average age of users
```

```sql
SELECT age, COUNT(*)
FROM users
GROUP BY age;                      -- Count users for each unique age value
```

```sql
SELECT age, COUNT(*)
FROM users
GROUP BY age
HAVING COUNT(*) > 2;               -- Only return age groups with more than 2 users
```

---

## ⚡ Indexes

```sql
CREATE INDEX idx_users_email
ON users(email);                   -- Create a non-unique index on the email column
```

```sql
CREATE UNIQUE INDEX idx_unique_email
ON users(email);                   -- Create a unique index to prevent duplicates
```

```sql
DROP INDEX IF EXISTS idx_users_email; -- Remove the index if it exists
```

---

## 🔐 Constraints

```sql
id SERIAL PRIMARY KEY             -- Defines id as the unique primary identifier
email VARCHAR(100) UNIQUE         -- Ensures email values are unique
name TEXT NOT NULL                -- Name cannot be null
age INTEGER CHECK (age >= 0)      -- Age must be a non-negative integer
user_id INT REFERENCES users(id)  -- Sets up a foreign key linking to users table
```

---

## 🔁 Transactions

```sql
BEGIN;                            -- Start a transaction block

UPDATE accounts
SET balance = balance - 100
WHERE id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE id = 2;

COMMIT;                           -- Save all changes if no error occurred
-- or
ROLLBACK;                         -- Revert all changes if an error occurs
```

---

## 🧰 Useful `psql` Meta-Commands

```sql
\dt                                -- List all tables
\d+ tablename                      -- Show columns, indexes, and table details
\conninfo                          -- Show current connection info
\i filename.sql                    -- Run SQL script from file
\pset format aligned               -- Set output format to aligned (default)
\pset format csv                   -- Set output format to CSV
```

---

## 🛠️ Admin and Maintenance

```sql
ALTER TABLE old_name RENAME TO new_name;                -- Rename table
ALTER TABLE users RENAME COLUMN email TO contact_email; -- Rename column
ALTER TABLE users ALTER COLUMN age TYPE BIGINT;         -- Change column type
ALTER TABLE users ALTER COLUMN created_at SET DEFAULT NOW(); -- Set default value
ALTER TABLE users ALTER COLUMN created_at DROP DEFAULT; -- Remove default value
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email); -- Add unique constraint
ALTER TABLE users DROP CONSTRAINT unique_email;         -- Drop specific constraint
```

---

## 🧹 Table Maintenance

```sql
VACUUM;                           -- Reclaim space from dead tuples (safe and non-blocking)
VACUUM FULL;                      -- Rewrites table to reclaim space (locks table)
ANALYZE;                          -- Update planner statistics for better performance
REINDEX INDEX index_name;        -- Rebuild a specific index
REINDEX TABLE table_name;        -- Rebuild all indexes on a table
```

---

## 🧾 Views and Materialized Views

```sql
CREATE VIEW active_users AS
SELECT id, name FROM users WHERE active = TRUE; -- Create a virtual table (view)

SELECT * FROM active_users;                     -- Query the view

DROP VIEW IF EXISTS active_users;               -- Drop view if it exists

CREATE MATERIALIZED VIEW user_stats AS
SELECT age, COUNT(*) FROM users GROUP BY age;   -- Create a cached view for faster performance

REFRESH MATERIALIZED VIEW user_stats;           -- Update the data in the materialized view
```

---

## 🛑 User and Role Management

```sql
CREATE USER username WITH PASSWORD 'securepass';     -- Create a new database user
CREATE ROLE readonly;                                -- Create a new role
GRANT SELECT ON users TO readonly;                   -- Grant read access on users table
GRANT readonly TO username;                          -- Assign role to a user
GRANT ALL PRIVILEGES ON DATABASE dbname TO username; -- Grant full DB access
REVOKE SELECT ON users FROM readonly;                -- Remove read access
```

---

## 🗄️ Backup and Restore

```bash
pg_dump -U username -F c -d dbname -f db_backup.dump  -- Backup using custom format
pg_restore -U username -d dbname db_backup.dump       -- Restore backup to database
```

---

## 📦 JSON and Array Support

```sql
SELECT data->'name' FROM users_json;     -- Extract JSON field as JSON
SELECT data->>'name' FROM users_json;    -- Extract JSON field as text

SELECT * FROM products
WHERE 'tag1' = ANY(tags);                -- Check if array column contains 'tag1'

SELECT unnest(tags) FROM products;       -- Expand array into rows
```

---

## ⏱️ Date and Time Functions

```sql
SELECT NOW();                            -- Current timestamp
SELECT CURRENT_DATE;                     -- Current date
SELECT AGE(timestamp_column);            -- Time elapsed since timestamp
SELECT EXTRACT(YEAR FROM created_at);    -- Get year part of timestamp
```

---

## 🧪 Conditional Logic

```sql
SELECT name,
  CASE
    WHEN age < 18 THEN 'minor'
    WHEN age < 65 THEN 'adult'
    ELSE 'senior'
  END AS category
FROM users;                              -- Classify users based on age
```

---

## 🔧 Other Useful Tips

```sql
SELECT * FROM users
WHERE email IS DISTINCT FROM 'test@mail.com'; -- NULL-safe comparison

SELECT COALESCE(email, 'no email') FROM users; -- Replace NULL with fallback value

SELECT generate_series(1, 10);                 -- Generate a sequence from 1 to 10

SELECT LENGTH(name), UPPER(name), LOWER(name),
       CONCAT(name, '!', ' 🎉') FROM users;    -- String operations

SELECT amount / NULLIF(count, 0) FROM sales;   -- Avoid division by zero
```

---

## 📚 References

```sql
\?               -- psql help for backslash commands
\h               -- SQL command help
\h SELECT        -- Help for specific SQL command
```

PostgreSQL Documentation: https://www.postgresql.org/docs/
