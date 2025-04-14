```
# 🐘 PostgreSQL Cheatsheet

Your quick reference for PostgreSQL basics, including commands, data types, DDL/DML, joins, aggregations, indexes, constraints, transactions, and useful admin commands.

---

## 🔌 Connecting and Basic `psql` Commands

- Connect to a database:
```bash
psql -U username -d dbname
```

- List databases:
```sql
\l
```

- Connect to another database:
```sql
\c dbname
```

- List tables:
```sql
\dt
```

- Describe a table:
```sql
\d tablename
```

- Quit `psql`:
```sql
\q
```

---

## 🔤 Common PostgreSQL Data Types

- `INTEGER`, `BIGINT` – Whole numbers
- `SERIAL`, `BIGSERIAL` – Auto-incrementing integers
- `NUMERIC(precision, scale)` – Exact decimal values
- `REAL`, `DOUBLE PRECISION` – Floating-point numbers
- `VARCHAR(n)`, `CHAR(n)` – Variable/fixed-length strings
- `TEXT` – Unlimited-length string
- `BOOLEAN` – `TRUE`, `FALSE`, `NULL`
- `DATE`, `TIME`, `TIMESTAMP` – Date and time types
- `UUID` – Universally unique identifier
- `BYTEA` – Binary data

---

## 🏗️ DDL (CREATE, ALTER, DROP)

### Create table:
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE,
  age INTEGER CHECK (age >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Alter table (add/rename/drop column):
```sql
ALTER TABLE users ADD COLUMN status TEXT;
ALTER TABLE users RENAME COLUMN status TO user_status;
ALTER TABLE users DROP COLUMN user_status;
```

### Drop table:
```sql
DROP TABLE IF EXISTS users;
```

---

## ✏️ DML (INSERT, SELECT, UPDATE, DELETE)

### Insert rows:
```sql
INSERT INTO users (name, email, age) VALUES ('Alice', 'alice@mail.com', 25);
```

### Select rows:
```sql
SELECT id, name FROM users;
```

### Update rows:
```sql
UPDATE users SET age = 30 WHERE name = 'Alice';
```

### Delete rows:
```sql
DELETE FROM users WHERE id = 5;
```

---

## 🔍 Filtering, Ordering, and Limiting

### WHERE clause:
```sql
SELECT * FROM users WHERE age > 18 AND email IS NOT NULL;
```

### ORDER BY:
```sql
SELECT * FROM users ORDER BY age DESC, name ASC;
```

### LIMIT and OFFSET:
```sql
SELECT * FROM users ORDER BY id LIMIT 10 OFFSET 20;
```

---

## 🔗 Joins (INNER, LEFT, RIGHT, FULL)

Assume: `orders(user_id INT)` and `users(id INT)`

### INNER JOIN – Only matching rows:
```sql
SELECT * FROM users u INNER JOIN orders o ON u.id = o.user_id;
```

### LEFT JOIN – All from left + matched right:
```sql
SELECT * FROM users u LEFT JOIN orders o ON u.id = o.user_id;
```

### RIGHT JOIN – All from right + matched left:
```sql
SELECT * FROM users u RIGHT JOIN orders o ON u.id = o.user_id;
```

### FULL OUTER JOIN – All records:
```sql
SELECT * FROM users u FULL OUTER JOIN orders o ON u.id = o.user_id;
```

---

## 🧮 Aggregations and Grouping

### COUNT, SUM, AVG, MIN, MAX:
```sql
SELECT COUNT(*) FROM users;
SELECT AVG(age) FROM users;
```

### GROUP BY:
```sql
SELECT age, COUNT(*) FROM users GROUP BY age;
```

### HAVING – Filter grouped results:
```sql
SELECT age, COUNT(*) FROM users GROUP BY age HAVING COUNT(*) > 2;
```

---

## ⚡ Indexes

### Create an index:
```sql
CREATE INDEX idx_users_email ON users(email);
```

### Unique index:
```sql
CREATE UNIQUE INDEX idx_unique_email ON users(email);
```

### Drop index:
```sql
DROP INDEX IF EXISTS idx_users_email;
```

Indexes speed up reads but may slow writes. Use them on frequently filtered/joined columns.

---

## 🔐 Constraints

### PRIMARY KEY:
```sql
id SERIAL PRIMARY KEY
```

### UNIQUE:
```sql
email VARCHAR(100) UNIQUE
```

### NOT NULL:
```sql
name TEXT NOT NULL
```

### CHECK:
```sql
age INTEGER CHECK (age >= 0)
```

### FOREIGN KEY:
```sql
user_id INT REFERENCES users(id)
```

---

## 🔁 Transactions

Transactions group multiple statements atomically.

```sql
BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

COMMIT;
-- or
ROLLBACK;
```

---

## 🧰 Useful `psql` Meta-Commands

- List all tables/views:
```sql
\dt
```

- List all columns of a table:
```sql
\d+ tablename
```

- Show current connection:
```sql
\conninfo
```

- Execute SQL from a file:
```sql
\i filename.sql
```

- Set output format (e.g., aligned, csv, html):
```sql
\pset format aligned
\pset format csv
```

---

## 🛠️ Admin and Maintenance

### Rename table or column:
```sql
ALTER TABLE old_name RENAME TO new_name;
ALTER TABLE users RENAME COLUMN email TO contact_email;
```

### Change column type:
```sql
ALTER TABLE users ALTER COLUMN age TYPE BIGINT;
```

### Add default value:
```sql
ALTER TABLE users ALTER COLUMN created_at SET DEFAULT NOW();
```

### Remove default:
```sql
ALTER TABLE users ALTER COLUMN created_at DROP DEFAULT;
```

### Drop or add constraints:
```sql
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users DROP CONSTRAINT unique_email;
```

---
Continuing with advanced or additional admin features and tips.

---

## 🧹 Table Maintenance

### VACUUM – Reclaim storage:
```sql
VACUUM;
VACUUM FULL; -- more aggressive, locks the table
```

### ANALYZE – Update statistics:
```sql
ANALYZE;
```

### REINDEX – Rebuild index:
```sql
REINDEX INDEX index_name;
REINDEX TABLE table_name;
```

---

## 🧾 Views and Materialized Views

### Create a view:
```sql
CREATE VIEW active_users AS
SELECT id, name FROM users WHERE active = TRUE;
```

### Query a view:
```sql
SELECT * FROM active_users;
```

### Drop view:
```sql
DROP VIEW IF EXISTS active_users;
```

### Create a materialized view:
```sql
CREATE MATERIALIZED VIEW user_stats AS
SELECT age, COUNT(*) FROM users GROUP BY age;
```

### Refresh materialized view:
```sql
REFRESH MATERIALIZED VIEW user_stats;
```

---

## 🛑 User and Role Management

### Create user:
```sql
CREATE USER username WITH PASSWORD 'securepass';
```

### Create role:
```sql
CREATE ROLE readonly;
```

### Grant privileges:
```sql
GRANT SELECT ON users TO readonly;
GRANT readonly TO username;
```

### Grant all privileges:
```sql
GRANT ALL PRIVILEGES ON DATABASE dbname TO username;
```

### Revoke privileges:
```sql
REVOKE SELECT ON users FROM readonly;
```

---

## 🗄️ Backups and Restores (using command line tools)

### Dump database:
```bash
pg_dump -U username -F c -d dbname -f db_backup.dump
```

### Restore database:
```bash
pg_restore -U username -d dbname db_backup.dump
```

---

## 📦 JSON and Array Operations

### Query JSON:
```sql
SELECT data->'name' FROM users_json;
SELECT data->>'name' FROM users_json; -- text
```

### Query arrays:
```sql
SELECT * FROM products WHERE 'tag1' = ANY(tags);
```

### Unnest arrays:
```sql
SELECT unnest(tags) FROM products;
```

---

## ⏱️ Date and Time Functions

```sql
SELECT NOW(); -- current timestamp
SELECT CURRENT_DATE;
SELECT AGE(timestamp_column); -- time since timestamp
```

### Extract part of date:
```sql
SELECT EXTRACT(YEAR FROM created_at) FROM users;
```

---

## 🧪 Conditional Expressions

### CASE expression:
```sql
SELECT name,
  CASE
    WHEN age < 18 THEN 'minor'
    WHEN age < 65 THEN 'adult'
    ELSE 'senior'
  END AS category
FROM users;
```

---

## 🔧 Miscellaneous Tips

- NULL-safe equality:
```sql
SELECT * FROM users WHERE email IS DISTINCT FROM 'test@mail.com';
```

- COALESCE – Return first non-null:
```sql
SELECT COALESCE(email, 'no email') FROM users;
```

- Generate series:
```sql
SELECT generate_series(1, 10);
```

- String functions:
```sql
SELECT LENGTH(name), UPPER(name), LOWER(name), CONCAT(name, '!', ' 🎉') FROM users;
```

- Safe divide (avoid division by zero):
```sql
SELECT amount / NULLIF(count, 0) FROM sales;
```

---

## 📚 Resources

- PostgreSQL Docs: https://www.postgresql.org/docs/
- `psql` Help:
```sql
\?         -- command help
\h         -- SQL syntax help
\h SELECT  -- help for specific SQL command
```

---
