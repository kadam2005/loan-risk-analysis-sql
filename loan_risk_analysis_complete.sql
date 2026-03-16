-- ============================================================
-- LOAN RISK ANALYSIS PROJECT
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS loan_risk_db;
USE loan_risk_db;


-- ============================================================
-- SECTION 2: CREATE TABLES
-- ============================================================

CREATE TABLE IF NOT EXISTS borrowers (
    borrower_id     INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100) NOT NULL,
    age             INT,
    employment_type VARCHAR(20) CHECK (employment_type IN ('Salaried','Self-Employed','Unemployed','Retired')),
    annual_income   DECIMAL(12, 2),
    credit_score    INT CHECK (credit_score BETWEEN 300 AND 900),
    state           VARCHAR(50),
    created_at      DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE IF NOT EXISTS loans (
    loan_id           INT PRIMARY KEY AUTO_INCREMENT,
    borrower_id       INT NOT NULL,
    loan_amount       DECIMAL(12, 2) NOT NULL,
    loan_purpose      VARCHAR(20) CHECK (loan_purpose IN ('Home','Auto','Education','Business','Personal')),
    interest_rate     DECIMAL(5, 2),
    loan_term_months  INT,
    disbursement_date DATE,
    status            VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active','Closed','Defaulted','Delinquent','Under Review')),
    FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id)
);

CREATE TABLE IF NOT EXISTS repayments (
    repayment_id    INT PRIMARY KEY AUTO_INCREMENT,
    loan_id         INT NOT NULL,
    due_date        DATE NOT NULL,
    paid_date       DATE,
    amount_due      DECIMAL(12, 2) NOT NULL,
    amount_paid     DECIMAL(12, 2) DEFAULT 0.00,
    days_overdue    INT DEFAULT 0,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);


-- ============================================================
-- SECTION 3: INSERT BORROWERS
-- ============================================================

INSERT INTO borrowers
(name, age, employment_type, annual_income, credit_score, state)
VALUES
('Rajesh Kumar',    45, 'Salaried',      720000.00,  742, 'Maharashtra'),
('Priya Sharma',    32, 'Salaried',      550000.00,  768, 'Delhi'),
('Anil Patel',      52, 'Self-Employed', 1350000.00, 695, 'Gujarat'),
('Sunita Devi',     38, 'Salaried',      390000.00,  621, 'Bihar'),
('Mohammed Irfan',  41, 'Self-Employed', 980000.00,  710, 'Telangana'),
('Kavya Nair',      27, 'Salaried',      460000.00,  784, 'Kerala'),
('Deepak Verma',    60, 'Retired',       310000.00,  598, 'Uttar Pradesh'),
('Ananya Iyer',     35, 'Salaried',      810000.00,  801, 'Tamil Nadu'),
('Ramesh Yadav',    48, 'Self-Employed', 1750000.00, 667, 'Rajasthan'),
('Fatima Sheikh',   29, 'Salaried',      520000.00,  733, 'Maharashtra'),
('Vikram Singh',    55, 'Retired',       280000.00,  612, 'Punjab'),
('Neha Joshi',      33, 'Salaried',      670000.00,  755, 'Gujarat'),
('Suresh Babu',     44, 'Self-Employed', 2100000.00, 648, 'Andhra Pradesh'),
('Pooja Mehta',     31, 'Salaried',      490000.00,  719, 'Madhya Pradesh'),
('Arjun Reddy',     39, 'Salaried',      920000.00,  778, 'Telangana'),
('Lalita Kumari',   23, 'Unemployed',    85000.00,   524, 'West Bengal'),
('Santosh Mishra',  50, 'Self-Employed', 830000.00,  634, 'Uttar Pradesh'),
('Divya Krishnan',  36, 'Salaried',      580000.00,  747, 'Karnataka'),
('Manoj Tiwari',    43, 'Salaried',      750000.00,  763, 'Delhi'),
('Rekha Pillai',    58, 'Retired',       340000.00,  581, 'Kerala');


-- ============================================================
-- SECTION 4: INSERT LOANS
-- ============================================================

INSERT INTO loans
(borrower_id, loan_amount, loan_purpose, interest_rate, loan_term_months, disbursement_date, status)
VALUES
(1,  2500000.00, 'Home',      8.40,  240, '2020-06-15', 'Active'),
(2,  800000.00,  'Personal',  11.50, 60,  '2022-03-10', 'Active'),
(3,  5000000.00, 'Business',  12.00, 180, '2019-11-01', 'Active'),
(4,  300000.00,  'Personal',  15.50, 36,  '2021-08-20', 'Delinquent'),
(5,  1500000.00, 'Business',  13.00, 120, '2020-04-05', 'Active'),
(6,  600000.00,  'Education', 9.50,  84,  '2021-07-01', 'Active'),
(7,  150000.00,  'Personal',  16.00, 24,  '2022-01-15', 'Defaulted'),
(8,  4500000.00, 'Home',      7.90,  300, '2019-03-22', 'Active'),
(9,  3000000.00, 'Business',  13.75, 120, '2021-02-10', 'Delinquent'),
(10, 700000.00,  'Auto',      9.25,  60,  '2022-09-01', 'Active'),
(11, 200000.00,  'Personal',  15.00, 36,  '2021-05-18', 'Defaulted'),
(12, 3500000.00, 'Home',      8.25,  240, '2020-10-30', 'Active'),
(13, 7500000.00, 'Business',  12.50, 180, '2018-06-01', 'Active'),
(14, 500000.00,  'Personal',  12.75, 48,  '2022-06-15', 'Active'),
(15, 6000000.00, 'Home',      7.85,  300, '2019-08-12', 'Active'),
(16, 50000.00,   'Personal',  18.00, 12,  '2023-01-10', 'Under Review'),
(17, 1200000.00, 'Business',  14.00, 84,  '2021-09-25', 'Delinquent'),
(18, 2000000.00, 'Home',      8.60,  180, '2020-07-14', 'Active'),
(19, 4000000.00, 'Home',      8.15,  240, '2019-12-01', 'Active'),
(20, 180000.00,  'Personal',  16.50, 24,  '2022-11-20', 'Delinquent');


-- ============================================================
-- SECTION 5: INSERT REPAYMENTS
-- ============================================================

INSERT INTO repayments
(loan_id, due_date, paid_date, amount_due, amount_paid, days_overdue)
VALUES
(1,  '2024-01-15', '2024-01-15', 21500.00, 21500.00, 0),
(1,  '2024-02-15', '2024-02-15', 21500.00, 21500.00, 0),
(1,  '2024-03-15', '2024-03-18', 21500.00, 21500.00, 3),
(2,  '2024-01-10', '2024-01-10', 17500.00, 17500.00, 0),
(2,  '2024-02-10', '2024-02-14', 17500.00, 17500.00, 4),
(3,  '2024-01-01', '2024-01-01', 60000.00, 60000.00, 0),
(4,  '2024-01-20', '2024-02-10', 10800.00, 10800.00, 21),
(4,  '2024-02-20', NULL,         10800.00, 0.00,     45),
(5,  '2024-01-05', '2024-01-05', 22500.00, 22500.00, 0),
(5,  '2024-02-05', '2024-02-05', 22500.00, 22500.00, 0),
(6,  '2024-01-01', '2024-01-01', 9800.00,  9800.00,  0),
(7,  '2023-02-15', NULL,         7500.00,  0.00,     365),
(7,  '2023-03-15', NULL,         7500.00,  0.00,     335),
(8,  '2024-01-22', '2024-01-22', 35200.00, 35200.00, 0),
(8,  '2024-02-22', '2024-02-22', 35200.00, 35200.00, 0),
(9,  '2024-01-10', '2024-02-01', 38500.00, 38500.00, 22),
(9,  '2024-02-10', NULL,         38500.00, 19000.00, 30),
(10, '2024-01-01', '2024-01-01', 14600.00, 14600.00, 0),
(10, '2024-02-01', '2024-02-01', 14600.00, 14600.00, 0),
(11, '2022-06-18', NULL,         6900.00,  0.00,     600),
(12, '2024-01-30', '2024-01-30', 30100.00, 30100.00, 0),
(13, '2024-01-01', '2024-01-01', 92000.00, 92000.00, 0),
(14, '2024-01-15', '2024-01-15', 13400.00, 13400.00, 0),
(15, '2024-01-12', '2024-01-12', 46800.00, 46800.00, 0),
(16, '2023-02-10', NULL,         4500.00,  0.00,     60),
(17, '2024-01-25', '2024-02-20', 21800.00, 21800.00, 26),
(17, '2024-02-25', NULL,         21800.00, 10000.00, 20),
(18, '2024-01-14', '2024-01-14', 19800.00, 19800.00, 0),
(19, '2024-01-01', '2024-01-01', 34200.00, 34200.00, 0),
(20, '2023-12-20', NULL,         9100.00,  0.00,     75);


-- ============================================================
-- SECTION 6: CREATE VIEWS
-- ============================================================

CREATE OR REPLACE VIEW vw_borrower_risk_summary AS
SELECT
    b.borrower_id,
    b.name,
    b.age,
    b.employment_type,
    b.annual_income,
    b.credit_score,
    b.state,
    l.loan_id,
    l.loan_amount,
    l.loan_purpose,
    l.interest_rate,
    l.status                                        AS loan_status,
    ROUND(l.loan_amount / b.annual_income, 2)       AS loan_to_income_ratio,
    CASE
        WHEN b.credit_score >= 800 THEN 'Excellent'
        WHEN b.credit_score >= 750 THEN 'Very Good'
        WHEN b.credit_score >= 700 THEN 'Good'
        WHEN b.credit_score >= 650 THEN 'Fair'
        WHEN b.credit_score >= 600 THEN 'Poor'
        ELSE                            'Critical'
    END                                             AS credit_band,
    CASE
        WHEN l.status IN ('Defaulted','Delinquent','Under Review')
        THEN 'At Risk'
        ELSE 'Healthy'
    END                                             AS portfolio_health
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id;


CREATE OR REPLACE VIEW vw_npa_accounts AS
SELECT
    b.name,
    b.credit_score,
    b.employment_type,
    b.state,
    l.loan_id,
    l.loan_amount,
    l.loan_purpose,
    l.status,
    MAX(r.days_overdue)                             AS max_days_overdue,
    SUM(r.amount_due) - SUM(r.amount_paid)          AS total_outstanding,
    CASE
        WHEN MAX(r.days_overdue) >= 180 THEN 'Loss Asset'
        WHEN MAX(r.days_overdue) >= 90  THEN 'Substandard'
        WHEN MAX(r.days_overdue) >= 30  THEN 'Special Mention'
        ELSE                                 'Watch List'
    END                                             AS npa_category
FROM borrowers b
JOIN loans l       ON b.borrower_id = l.borrower_id
JOIN repayments r  ON l.loan_id     = r.loan_id
WHERE l.status IN ('Defaulted','Delinquent','Under Review')
GROUP BY
    b.name, b.credit_score, b.employment_type, b.state,
    l.loan_id, l.loan_amount, l.loan_purpose, l.status;


CREATE OR REPLACE VIEW vw_portfolio_health AS
SELECT
    l.loan_purpose,
    COUNT(l.loan_id)                                AS total_loans,
    SUM(l.loan_amount)                              AS total_exposure,
    ROUND(AVG(b.credit_score), 1)                   AS avg_credit_score,
    ROUND(AVG(l.interest_rate), 2)                  AS avg_interest_rate,
    SUM(CASE WHEN l.status = 'Active'
        THEN 1 ELSE 0 END)                          AS active_count,
    SUM(CASE WHEN l.status = 'Defaulted'
        THEN 1 ELSE 0 END)                          AS default_count,
    SUM(CASE WHEN l.status = 'Delinquent'
        THEN 1 ELSE 0 END)                          AS delinquent_count,
    ROUND(
        SUM(CASE WHEN l.status IN
            ('Defaulted','Delinquent','Under Review')
            THEN l.loan_amount ELSE 0 END)
        / SUM(l.loan_amount) * 100
    , 2)                                            AS stress_pct
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id
GROUP BY l.loan_purpose;


-- ============================================================
-- SECTION 7: CREATE STORED PROCEDURES
-- ============================================================

DROP PROCEDURE IF EXISTS sp_borrower_risk_profile;
DROP PROCEDURE IF EXISTS sp_loans_by_risk;
DROP PROCEDURE IF EXISTS sp_update_loan_status;

DELIMITER $$

CREATE PROCEDURE sp_borrower_risk_profile(IN p_borrower_id INT)
BEGIN
    SELECT
        b.name,
        b.credit_score,
        b.employment_type,
        b.annual_income,
        l.loan_amount,
        l.loan_purpose,
        l.status,
        ROUND(l.loan_amount / b.annual_income, 2)       AS lti_ratio,
        COALESCE(MAX(r.days_overdue), 0)                AS max_days_overdue,
        COALESCE(
            SUM(r.amount_due) - SUM(r.amount_paid)
        , 0)                                            AS total_shortfall
    FROM borrowers b
    JOIN loans l           ON b.borrower_id = l.borrower_id
    LEFT JOIN repayments r ON l.loan_id     = r.loan_id
    WHERE b.borrower_id = p_borrower_id
    GROUP BY
        b.name, b.credit_score, b.employment_type,
        b.annual_income, l.loan_amount,
        l.loan_purpose, l.status;
END$$


CREATE PROCEDURE sp_loans_by_risk(IN p_risk_level VARCHAR(10))
BEGIN
    SELECT
        b.name,
        b.credit_score,
        b.employment_type,
        b.annual_income,
        l.loan_amount,
        l.loan_purpose,
        l.status,
        CASE
            WHEN b.credit_score < 600               THEN 'CRITICAL'
            WHEN b.credit_score BETWEEN 600 AND 649 THEN 'HIGH'
            WHEN b.credit_score BETWEEN 650 AND 699 THEN 'MEDIUM'
            ELSE                                         'LOW'
        END                                         AS risk_level
    FROM borrowers b
    JOIN loans l ON b.borrower_id = l.borrower_id
    HAVING risk_level = p_risk_level
    ORDER BY b.credit_score ASC;
END$$


CREATE PROCEDURE sp_update_loan_status(
    IN p_loan_id    INT,
    IN p_new_status VARCHAR(20)
)
BEGIN
    DECLARE v_current_status VARCHAR(20);

    SELECT status INTO v_current_status
    FROM loans
    WHERE loan_id = p_loan_id;

    UPDATE loans
    SET status = p_new_status
    WHERE loan_id = p_loan_id;

    SELECT
        p_loan_id           AS loan_id,
        v_current_status    AS old_status,
        p_new_status        AS new_status,
        NOW()               AS updated_at;
END$$

DELIMITER ;


-- ============================================================
-- SECTION 8: RUN ALL QUERIES
-- ============================================================

-- Query 1: Borrower + Loan Overview
SELECT
    b.borrower_id,
    b.name,
    b.age,
    b.employment_type,
    b.annual_income,
    b.credit_score,
    b.state,
    l.loan_id,
    l.loan_amount,
    l.loan_purpose,
    l.interest_rate,
    l.status
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id
ORDER BY b.credit_score DESC;


-- Query 2: High Risk Borrowers
SELECT
    b.name,
    b.credit_score,
    b.employment_type,
    b.annual_income,
    l.loan_amount,
    l.loan_purpose,
    l.status,
    ROUND(l.loan_amount / b.annual_income, 2)           AS loan_to_income_ratio,
    CASE
        WHEN b.credit_score < 600               THEN 'CRITICAL'
        WHEN b.credit_score BETWEEN 600 AND 649 THEN 'HIGH'
        WHEN b.credit_score BETWEEN 650 AND 699 THEN 'MEDIUM'
        ELSE                                         'LOW'
    END                                                 AS risk_level
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id
WHERE b.credit_score < 700
   OR l.status IN ('Defaulted','Delinquent','Under Review')
ORDER BY b.credit_score ASC, l.loan_amount DESC;


-- Query 3: Portfolio Segmentation by Purpose
SELECT
    l.loan_purpose,
    COUNT(l.loan_id)                                    AS total_loans,
    COUNT(DISTINCT b.borrower_id)                       AS total_borrowers,
    SUM(l.loan_amount)                                  AS total_exposure,
    ROUND(AVG(l.loan_amount), 2)                        AS avg_loan_amount,
    ROUND(AVG(l.interest_rate), 2)                      AS avg_interest_rate,
    ROUND(AVG(b.credit_score), 1)                       AS avg_credit_score,
    SUM(CASE WHEN l.status = 'Defaulted'
        THEN 1 ELSE 0 END)                              AS total_defaults,
    SUM(CASE WHEN l.status = 'Delinquent'
        THEN 1 ELSE 0 END)                              AS total_delinquent,
    SUM(CASE WHEN l.status IN
        ('Defaulted','Delinquent','Under Review')
        THEN l.loan_amount ELSE 0 END)                  AS stressed_amount,
    ROUND(
        SUM(CASE WHEN l.status IN
            ('Defaulted','Delinquent','Under Review')
            THEN l.loan_amount ELSE 0 END)
        / SUM(l.loan_amount) * 100
    , 2)                                                AS stress_percentage
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id
GROUP BY l.loan_purpose
ORDER BY total_exposure DESC;


-- Query 4: Repayment Behavior — RBI Classification
SELECT
    b.name,
    b.credit_score,
    b.employment_type,
    l.loan_purpose,
    l.loan_amount,
    l.status                                            AS loan_status,
    COUNT(r.repayment_id)                               AS total_payments,
    SUM(r.amount_due)                                   AS total_amount_due,
    SUM(r.amount_paid)                                  AS total_amount_paid,
    SUM(r.amount_due) - SUM(r.amount_paid)              AS total_shortfall,
    MAX(r.days_overdue)                                 AS max_days_overdue,
    ROUND(AVG(r.days_overdue), 1)                       AS avg_days_overdue,
    SUM(CASE WHEN r.paid_date IS NULL
        THEN 1 ELSE 0 END)                              AS missed_payments,
    SUM(CASE WHEN r.days_overdue = 0
        THEN 1 ELSE 0 END)                              AS on_time_payments,
    CASE
        WHEN MAX(r.days_overdue) >= 180 THEN 'NPA - Write Off'
        WHEN MAX(r.days_overdue) >= 90  THEN 'NPA - Substandard'
        WHEN MAX(r.days_overdue) >= 30  THEN 'Special Mention'
        WHEN MAX(r.days_overdue) > 0    THEN 'Minor Delay'
        ELSE                                 'Regular'
    END                                                 AS rbi_classification
FROM borrowers b
JOIN loans l       ON b.borrower_id = l.borrower_id
JOIN repayments r  ON l.loan_id     = r.loan_id
GROUP BY
    b.name, b.credit_score, b.employment_type,
    l.loan_purpose, l.loan_amount, l.status
ORDER BY max_days_overdue DESC, total_shortfall DESC;


-- Query 5: CIBIL Credit Band Segmentation
SELECT
    CASE
        WHEN b.credit_score >= 800 THEN '800-900  | Excellent'
        WHEN b.credit_score >= 750 THEN '750-799  | Very Good'
        WHEN b.credit_score >= 700 THEN '700-749  | Good'
        WHEN b.credit_score >= 650 THEN '650-699  | Fair'
        WHEN b.credit_score >= 600 THEN '600-649  | Poor'
        ELSE                            'Below 600 | Very Poor'
    END                                                 AS credit_band,
    COUNT(DISTINCT b.borrower_id)                       AS total_borrowers,
    COUNT(l.loan_id)                                    AS total_loans,
    SUM(l.loan_amount)                                  AS total_loan_amount,
    ROUND(AVG(l.loan_amount), 2)                        AS avg_loan_amount,
    ROUND(AVG(b.annual_income), 2)                      AS avg_annual_income,
    ROUND(AVG(l.interest_rate), 2)                      AS avg_interest_rate,
    SUM(CASE WHEN l.status = 'Active'
        THEN 1 ELSE 0 END)                              AS active_loans,
    SUM(CASE WHEN l.status = 'Defaulted'
        THEN 1 ELSE 0 END)                              AS defaulted_loans,
    SUM(CASE WHEN l.status = 'Delinquent'
        THEN 1 ELSE 0 END)                              AS delinquent_loans,
    SUM(CASE WHEN l.status IN
        ('Defaulted','Delinquent','Under Review')
        THEN l.loan_amount ELSE 0 END)                  AS stressed_exposure,
    ROUND(
        SUM(CASE WHEN l.status IN
            ('Defaulted','Delinquent','Under Review')
            THEN l.loan_amount ELSE 0 END)
        / SUM(l.loan_amount) * 100
    , 2)                                                AS stress_rate_pct,
    ROUND(AVG(b.credit_score), 1)                       AS avg_credit_score
FROM borrowers b
JOIN loans l ON b.borrower_id = l.borrower_id
GROUP BY credit_band
ORDER BY MIN(b.credit_score) DESC;


-- Query 6: Composite Risk Score + Bank Decision
SELECT
    b.borrower_id,
    b.name,
    b.age,
    b.employment_type,
    b.annual_income,
    b.credit_score,
    b.state,
    l.loan_id,
    l.loan_amount,
    l.loan_purpose,
    l.interest_rate,
    l.status                                            AS loan_status,
    ROUND(l.loan_amount / b.annual_income, 2)           AS loan_to_income_ratio,
    COALESCE(MAX(r.days_overdue), 0)                    AS max_days_overdue,
    COALESCE(SUM(CASE WHEN r.paid_date IS NULL
        THEN 1 ELSE 0 END), 0)                          AS missed_payments,
    COALESCE(SUM(r.amount_due)
        - SUM(r.amount_paid), 0)                        AS total_shortfall,
    CASE
        WHEN b.credit_score >= 800 THEN 'Excellent'
        WHEN b.credit_score >= 750 THEN 'Very Good'
        WHEN b.credit_score >= 700 THEN 'Good'
        WHEN b.credit_score >= 650 THEN 'Fair'
        WHEN b.credit_score >= 600 THEN 'Poor'
        ELSE                            'Critical'
    END                                                 AS credit_band,
    CASE
        WHEN b.employment_type = 'Salaried'      THEN 'Low'
        WHEN b.employment_type = 'Self-Employed' THEN 'Medium'
        WHEN b.employment_type = 'Retired'       THEN 'High'
        WHEN b.employment_type = 'Unemployed'    THEN 'Very High'
    END                                                 AS employment_risk,
    (
        CASE WHEN b.credit_score >= 800 THEN 5
             WHEN b.credit_score >= 750 THEN 10
             WHEN b.credit_score >= 700 THEN 20
             WHEN b.credit_score >= 650 THEN 35
             WHEN b.credit_score >= 600 THEN 50
             ELSE                            70 END
        + CASE WHEN l.loan_amount/b.annual_income < 1 THEN 5
               WHEN l.loan_amount/b.annual_income < 2 THEN 10
               WHEN l.loan_amount/b.annual_income < 4 THEN 20
               WHEN l.loan_amount/b.annual_income < 6 THEN 35
               ELSE                                        50 END
        + CASE WHEN b.employment_type = 'Salaried'      THEN 5
               WHEN b.employment_type = 'Self-Employed' THEN 15
               WHEN b.employment_type = 'Retired'       THEN 25
               WHEN b.employment_type = 'Unemployed'    THEN 40
               ELSE                                          20 END
        + CASE WHEN COALESCE(MAX(r.days_overdue),0) >= 180 THEN 40
               WHEN COALESCE(MAX(r.days_overdue),0) >= 90  THEN 30
               WHEN COALESCE(MAX(r.days_overdue),0) >= 30  THEN 20
               WHEN COALESCE(MAX(r.days_overdue),0) >  0   THEN 10
               ELSE                                              0 END
    )                                                   AS composite_risk_score,
    CASE
        WHEN (
            CASE WHEN b.credit_score >= 800 THEN 5
                 WHEN b.credit_score >= 750 THEN 10
                 WHEN b.credit_score >= 700 THEN 20
                 WHEN b.credit_score >= 650 THEN 35
                 WHEN b.credit_score >= 600 THEN 50
                 ELSE 70 END
            + CASE WHEN l.loan_amount/b.annual_income < 1 THEN 5
                   WHEN l.loan_amount/b.annual_income < 2 THEN 10
                   WHEN l.loan_amount/b.annual_income < 4 THEN 20
                   WHEN l.loan_amount/b.annual_income < 6 THEN 35
                   ELSE 50 END
            + CASE WHEN b.employment_type = 'Salaried'      THEN 5
                   WHEN b.employment_type = 'Self-Employed' THEN 15
                   WHEN b.employment_type = 'Retired'       THEN 25
                   WHEN b.employment_type = 'Unemployed'    THEN 40
                   ELSE 20 END
            + CASE WHEN COALESCE(MAX(r.days_overdue),0) >= 180 THEN 40
                   WHEN COALESCE(MAX(r.days_overdue),0) >= 90  THEN 30
                   WHEN COALESCE(MAX(r.days_overdue),0) >= 30  THEN 20
                   WHEN COALESCE(MAX(r.days_overdue),0) >  0   THEN 10
                   ELSE 0 END
        ) <= 30 THEN 'GREEN  - Approve'
        WHEN (
            CASE WHEN b.credit_score >= 800 THEN 5
                 WHEN b.credit_score >= 750 THEN 10
                 WHEN b.credit_score >= 700 THEN 20
                 WHEN b.credit_score >= 650 THEN 35
                 WHEN b.credit_score >= 600 THEN 50
                 ELSE 70 END
            + CASE WHEN l.loan_amount/b.annual_income < 1 THEN 5
                   WHEN l.loan_amount/b.annual_income < 2 THEN 10
                   WHEN l.loan_amount/b.annual_income < 4 THEN 20
                   WHEN l.loan_amount/b.annual_income < 6 THEN 35
                   ELSE 50 END
            + CASE WHEN b.employment_type = 'Salaried'      THEN 5
                   WHEN b.employment_type = 'Self-Employed' THEN 15
                   WHEN b.employment_type = 'Retired'       THEN 25
                   WHEN b.employment_type = 'Unemployed'    THEN 40
                   ELSE 20 END
            + CASE WHEN COALESCE(MAX(r.days_overdue),0) >= 180 THEN 40
                   WHEN COALESCE(MAX(r.days_overdue),0) >= 90  THEN 30
                   WHEN COALESCE(MAX(r.days_overdue),0) >= 30  THEN 20
                   WHEN COALESCE(MAX(r.days_overdue),0) >  0   THEN 10
                   ELSE 0 END
        ) <= 60 THEN 'AMBER  - Review'
        ELSE         'RED    - Reject'
    END                                                 AS bank_decision
FROM borrowers b
JOIN loans l           ON b.borrower_id = l.borrower_id
LEFT JOIN repayments r ON l.loan_id     = r.loan_id
GROUP BY
    b.borrower_id, b.name, b.age, b.employment_type,
    b.annual_income, b.credit_score, b.state,
    l.loan_id, l.loan_amount, l.loan_purpose,
    l.interest_rate, l.status
ORDER BY composite_risk_score DESC;


-- ============================================================
-- SECTION 9: TEST VIEWS
-- ============================================================

SELECT * FROM vw_borrower_risk_summary;
SELECT * FROM vw_npa_accounts         ORDER BY max_days_overdue DESC;
SELECT * FROM vw_portfolio_health     ORDER BY stress_pct DESC;


-- ============================================================
-- SECTION 10: TEST STORED PROCEDURES
-- ============================================================

CALL sp_borrower_risk_profile(1);    -- Rajesh Kumar
CALL sp_borrower_risk_profile(7);    -- Deepak Verma  (Defaulted)
CALL sp_borrower_risk_profile(16);   -- Lalita Kumari (Critical)

CALL sp_loans_by_risk('CRITICAL');
CALL sp_loans_by_risk('HIGH');
CALL sp_loans_by_risk('MEDIUM');
CALL sp_loans_by_risk('LOW');

CALL sp_update_loan_status(4,  'Defaulted');
CALL sp_update_loan_status(16, 'Defaulted');
CALL sp_update_loan_status(6,  'Closed');