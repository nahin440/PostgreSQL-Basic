# PostgreSQL Basics: Key Concepts and Usage

This document covers fundamental PostgreSQL concepts in a clear and structured format, suitable for beginners and intermediate learners.

---

## 1. What is PostgreSQL?

**PostgreSQL** is a powerful, open-source object-relational database management system (RDBMS). It is used for storing, managing, and retrieving structured data. It supports both **SQL** and **JSON** data types, making it highly versatile.

**Key Features:**
- ACID compliance ensures data reliability.
- Extensible through custom functions and data types.
- Robust support for concurrency and large datasets.
- Ideal for both small-scale applications and enterprise-grade systems.

---

## 2. What is the purpose of a database schema in PostgreSQL?

A **database schema** defines the structure or blueprint of a database. It includes tables, columns, data types, constraints, and the relationships between tables.

**Benefits of using schemas:**
- Logical organization of data.
- Separation of concerns among different teams or applications.
- Supports multiple users working on the same database without conflict.
- Enhances security and access control.

---

## 3. Explain the **Primary Key** and **Foreign Key** concepts in PostgreSQL.

### Primary Key:
A column (or set of columns) that uniquely identifies each row in a table.
- Must be unique and not null.
- Each table can have only one primary key.

**Example:**
In the `rangers` table, `ranger_id` is the primary key.

### Foreign Key:
A column in one table that refers to the primary key of another table.
- Used to establish relationships between tables.
- Maintains referential integrity.

**Example:**
In the `sightings` table, `ranger_id` is a foreign key referencing `rangers.ranger_id`.

---

## 4. What is the difference between the `VARCHAR` and `CHAR` data types?

### CHAR:
- Fixed-length string.
- Always reserves the specified number of characters.
- Padding is done with spaces if the input is shorter.

**Example:** `CHAR(10)` reserves exactly 10 characters.

### VARCHAR:
- Variable-length string.
- Stores only the characters used (up to the specified limit).

**Example:** `VARCHAR(10)` can store up to 10 characters but uses space only as needed.

---

## 5. Explain the purpose of the `WHERE` clause in a `SELECT` statement.

The `WHERE` clause is used to **filter** records based on a specific condition.

**Example:**
```sql
SELECT * FROM rangers WHERE region = 'Northern Hills';
