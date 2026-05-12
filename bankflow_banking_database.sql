CREATE DATABASE bankflow;
USE bankflow;


CREATE TABLE Branches (
    branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(50),
    manager_name VARCHAR(50),
    branch_address VARCHAR(100),
    contact_number VARCHAR(20)
);


CREATE TABLE Customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(50),
    customer_address VARCHAR(100),
    email VARCHAR(60),
    phone_number VARCHAR(20),
    registration_date DATE
);


CREATE TABLE Accounts (
    account_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    branch_id VARCHAR(10),
    account_type VARCHAR(30),
    balance DECIMAL(12,2),
    account_status ENUM('Active', 'Inactive', 'Frozen'),
    created_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE CASCADE
);


CREATE TABLE Transactions (
    transaction_id VARCHAR(10) PRIMARY KEY,
    account_id VARCHAR(10),
    transaction_type ENUM('Deposit', 'Withdrawal', 'Transfer'),
    amount DECIMAL(12,2),
    transaction_date DATE,
    transaction_status ENUM('Completed', 'Pending', 'Failed'),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE
);


CREATE TABLE Loans (
    loan_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    branch_id VARCHAR(10),
    loan_type VARCHAR(40),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    loan_status ENUM('Active', 'Paid', 'Rejected'),
    start_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE CASCADE
);


INSERT INTO Branches VALUES
('B001', 'Central Branch', 'Mark Johnson', '12 Main Street, Skopje', '+38970111222'),
('B002', 'City Branch', 'Anna Petrovska', '45 City Mall Road, Skopje', '+38970222333'),
('B003', 'North Branch', 'David Smith', '78 North Avenue, Skopje', '+38970333444'),
('B004', 'West Branch', 'Sara Wilson', '23 West Boulevard, Skopje', '+38970444555');


INSERT INTO Customers VALUES
('C001', 'Petar Nasteski', 'Skopje, North Macedonia', 'petar@example.com', '+38970123456', '2023-01-15'),
('C002', 'Martin Stojanov', 'Bitola, North Macedonia', 'martin@example.com', '+38970234567', '2023-03-20'),
('C003', 'Elena Ivanova', 'Ohrid, North Macedonia', 'elena@example.com', '+38970345678', '2023-05-10'),
('C004', 'Nikola Dimitrov', 'Skopje, North Macedonia', 'nikola@example.com', '+38970456789', '2023-07-05'),
('C005', 'Ana Trajkovska', 'Tetovo, North Macedonia', 'ana@example.com', '+38970567890', '2023-09-18'),
('C006', 'Stefan Georgiev', 'Kumanovo, North Macedonia', 'stefan@example.com', '+38970678901', '2024-01-12'),
('C007', 'Mila Ristovska', 'Prilep, North Macedonia', 'mila@example.com', '+38970789012', '2024-02-25'),
('C008', 'Daniel Kostov', 'Veles, North Macedonia', 'daniel@example.com', '+38970890123', '2024-04-08');


INSERT INTO Accounts VALUES
('A001', 'C001', 'B001', 'Savings', 5200.00, 'Active', '2023-01-16'),
('A002', 'C002', 'B002', 'Checking', 2400.50, 'Active', '2023-03-21'),
('A003', 'C003', 'B001', 'Savings', 8900.00, 'Active', '2023-05-12'),
('A004', 'C004', 'B003', 'Business', 15400.75, 'Active', '2023-07-06'),
('A005', 'C005', 'B004', 'Savings', 1250.00, 'Inactive', '2023-09-20'),
('A006', 'C006', 'B002', 'Checking', 780.25, 'Active', '2024-01-13'),
('A007', 'C007', 'B003', 'Savings', 3200.00, 'Frozen', '2024-02-26'),
('A008', 'C008', 'B004', 'Business', 21000.00, 'Active', '2024-04-09');


INSERT INTO Transactions VALUES
('T001', 'A001', 'Deposit', 1000.00, '2024-05-01', 'Completed'),
('T002', 'A001', 'Withdrawal', 300.00, '2024-05-04', 'Completed'),
('T003', 'A002', 'Deposit', 700.00, '2024-05-07', 'Completed'),
('T004', 'A003', 'Transfer', 1200.00, '2024-05-11', 'Completed'),
('T005', 'A004', 'Withdrawal', 2500.00, '2024-05-13', 'Completed'),
('T006', 'A005', 'Deposit', 400.00, '2024-05-15', 'Pending'),
('T007', 'A006', 'Withdrawal', 150.00, '2024-05-18', 'Completed'),
('T008', 'A007', 'Transfer', 500.00, '2024-05-20', 'Failed'),
('T009', 'A008', 'Deposit', 5000.00, '2024-05-23', 'Completed'),
('T010', 'A008', 'Withdrawal', 1000.00, '2024-05-25', 'Completed');


INSERT INTO Loans VALUES
('L001', 'C001', 'B001', 'Personal Loan', 3000.00, 5.50, 'Active', '2023-02-01'),
('L002', 'C003', 'B001', 'Home Loan', 50000.00, 4.20, 'Active', '2023-06-15'),
('L003', 'C004', 'B003', 'Business Loan', 20000.00, 6.00, 'Paid', '2023-08-10'),
('L004', 'C005', 'B004', 'Car Loan', 8000.00, 5.80, 'Rejected', '2023-10-01'),
('L005', 'C008', 'B004', 'Business Loan', 35000.00, 6.30, 'Active', '2024-04-20');


UPDATE Accounts
SET balance = balance + 1000
WHERE account_id = 'A001';


SHOW TABLES;




SELECT account_id, customer_id, account_type, balance, account_status
FROM Accounts
WHERE account_status = 'Active';


SELECT Customers.customer_name, Accounts.account_type, Accounts.balance
FROM Customers
INNER JOIN Accounts ON Customers.customer_id = Accounts.customer_id;


SELECT Customers.customer_name, Transactions.transaction_type, Transactions.amount, Transactions.transaction_date, Transactions.transaction_status
FROM Transactions
INNER JOIN Accounts ON Transactions.account_id = Accounts.account_id
INNER JOIN Customers ON Accounts.customer_id = Customers.customer_id;


SELECT Customers.customer_name, Accounts.balance
FROM Customers
INNER JOIN Accounts ON Customers.customer_id = Accounts.customer_id
WHERE Accounts.balance > 5000;


SELECT Branches.branch_name, COUNT(Accounts.account_id) AS total_accounts
FROM Branches
INNER JOIN Accounts ON Branches.branch_id = Accounts.branch_id
GROUP BY Branches.branch_name;


SELECT account_id, SUM(amount) AS total_transaction_amount
FROM Transactions
WHERE transaction_status = 'Completed'
GROUP BY account_id;


SELECT Customers.customer_name, Loans.loan_type, Loans.loan_amount, Loans.interest_rate
FROM Loans
INNER JOIN Customers ON Loans.customer_id = Customers.customer_id
WHERE Loans.loan_status = 'Active';


SELECT account_id, account_type, balance
FROM Accounts
ORDER BY balance DESC;


SELECT customer_name, registration_date
FROM Customers
WHERE registration_date > '2024-01-01';


SELECT Branches.branch_name, COUNT(Accounts.account_id) AS total_accounts
FROM Branches
INNER JOIN Accounts ON Branches.branch_id = Accounts.branch_id
GROUP BY Branches.branch_name
HAVING COUNT(Accounts.account_id) > 1;


SELECT Customers.customer_name, Loans.loan_type, Loans.loan_status
FROM Customers
INNER JOIN Loans ON Customers.customer_id = Loans.customer_id;


SELECT transaction_id, account_id, transaction_type, amount, transaction_status
FROM Transactions
WHERE transaction_status IN ('Failed', 'Pending');
