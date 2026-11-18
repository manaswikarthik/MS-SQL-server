# Set 3 – Retail Returns and Refunds

## Business Scenario
A retail business wants to analyze product returns, refund transactions, customer feedback, store performance, and employee information using SQL and MongoDB.

## Tasks

### Task 1 – SQL Reports
Write SQL queries to analyze returns, refunds, customers, products, stores, employees, and customer feedback.

### Task 2 – IN, NOT IN, NULL, and NOT EXISTS
Demonstrate the usage of `IN`, `NOT IN`, handle NULL-related issues, and use `NOT EXISTS` as an alternative.

### Task 3 – ANY and ALL
Compare refund values across stores and regions using `ANY` and `ALL`.

### Task 4 – Nested Subqueries
Implement queries using nested subqueries to retrieve specific business insights.

### Task 5 – MongoDB Aggregation
Use `$lookup` to join collections and generate reports.

- Returns, Customers, and Products
- Returns, Refunds, and Products
- Returns, Customers, and Feedback

## Technologies Used

- SQL Server
- MongoDB
- MongoDB Compass

## Files

- `advanced_reports.sql` – SQL queries and database operations
- `reports.js` – MongoDB aggregation pipelines using `$lookup`

## Database

**Database Name:** `Retail_Returns_Refunds`

### SQL Tables / MongoDB Collections

- Customers
- Products
- Stores
- Employees
- Sales
- Returns
- Refunds
- Return_Feedback

## Concepts Covered

- Joins
- Subqueries
- Nested Subqueries
- IN and NOT IN
- NULL handling
- NOT EXISTS
- ANY and ALL
- MongoDB Aggregation
- `$lookup`
- `$unwind`
- `$project`