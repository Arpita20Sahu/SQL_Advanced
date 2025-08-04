--Creating customer table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    city VARCHAR(50),
    state VARCHAR(50),
    join_date DATE
);

INSERT INTO customers VALUES
(101, 'Amit Sharma', '1985-06-12', 'Male', 'Mumbai', 'Maharashtra', '2020-01-15'),
(102, 'Neha Verma', '1990-02-25', 'Female', 'Delhi', 'Delhi', '2019-08-10'),
(103, 'John Paul', '1983-12-30', 'Male', 'Bangalore', 'Karnataka', '2021-03-22'),
(104, 'Ritika Singh', '1975-04-10', 'Female', 'Chennai', 'Tamil Nadu', '2018-11-05'),
(105, 'Arjun Mehta', '1992-09-17', 'Male', 'Pune', 'Maharashtra', '2022-01-01');


-- Creating policies table
CREATE TABLE policies (
    policy_id INT PRIMARY KEY,
    customer_id INT,
    policy_type VARCHAR(50),
    premium_amount DECIMAL(10,2),
    sum_assured DECIMAL(12,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO policies VALUES
(201, 101, 'Health', 15000, 500000, '2020-01-15', '2025-01-14', 'Active'),
(202, 102, 'Life', 25000, 1000000, '2019-08-10', '2039-08-09', 'Active'),
(203, 103, 'Vehicle', 8000, 300000, '2021-03-22', '2022-03-21', 'Expired'),
(204, 104, 'Health', 12000, 400000, '2018-11-05', '2023-11-04', 'Expired'),
(205, 105, 'Life', 18000, 700000, '2022-01-01', '2042-12-31', 'Active');


-- Creating claims Table
CREATE TABLE claims (
    claim_id INT PRIMARY KEY,
    policy_id INT,
    claim_date DATE,
    claim_amount DECIMAL(10,2),
    claim_status VARCHAR(20),
    settlement_date DATE,
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

INSERT INTO claims VALUES
(301, 201, '2021-03-20', 100000, 'Approved', '2021-04-05'),
(302, 202, '2022-12-15', 250000, 'Pending', NULL),
(303, 203, '2022-02-10', 50000, 'Rejected', NULL),
(304, 204, '2020-06-18', 75000, 'Approved', '2020-07-01');


-- Creating agents Table
CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    city VARCHAR(50),
    contact_no VARCHAR(15)
);

INSERT INTO agents VALUES
(1, 'Ravi Malhotra', 'Mumbai', '9876543210'),
(2, 'Swati Deshmukh', 'Delhi', '9123456780'),
(3, 'Anil Kumar', 'Bangalore', '9988776655');

