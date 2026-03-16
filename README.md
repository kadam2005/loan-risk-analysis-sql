# 🏦 Loan Risk Analysis — SQL Project

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Domain](https://img.shields.io/badge/Domain-Banking%20%26%20Finance-orange)
![Tables](https://img.shields.io/badge/Tables-3-yellow)
![Queries](https://img.shields.io/badge/Queries-6-purple)
![Views](https://img.shields.io/badge/Views-3-red)
![Procedures](https://img.shields.io/badge/Stored%20Procedures-3-green)

## 📌 Project Overview

An end-to-end loan portfolio risk analysis system built
using MySQL — simulating how Indian banks like SBI, HDFC
and ICICI assess borrower risk, classify NPAs and segment
their loan portfolio for risk reporting.

---

## 🗄️ Database Schema
```
borrowers ──── loans ──── repayments
(20 rows)     (20 rows)   (30 rows)
```

| Table       | Columns | Description                     |
|-------------|---------|----------------------------------|
| borrowers   | 8       | Borrower profiles with income    |
| loans       | 9       | Loans across 5 purposes          |
| repayments  | 7       | Monthly EMI records with NPA     |

---

## 📊 Analysis Queries

| # | Query | Description |
|---|-------|-------------|
| 1 | Borrower Overview | Full joined view sorted by credit score |
| 2 | High Risk Identification | Flags score < 700 or stressed loans |
| 3 | Portfolio Segmentation | Exposure and stress by loan purpose |
| 4 | Repayment Behavior | RBI NPA classification per borrower |
| 5 | CIBIL Band Segmentation | 6-band credit score grouping |
| 6 | Composite Risk Score | 200-point scoring model with GREEN/AMBER/RED decision |

---

## 🔁 Views

| View | Purpose |
|------|---------|
| vw_borrower_risk_summary | Reusable joined view with credit band |
| vw_npa_accounts | Live NPA monitoring with RBI category |
| vw_portfolio_health | Executive summary by loan purpose |

---

## ⚙️ Stored Procedures

| Procedure | Parameter | Purpose |
|-----------|-----------|---------|
| sp_borrower_risk_profile | borrower_id INT | Full risk profile for 1 borrower |
| sp_loans_by_risk | risk_level VARCHAR | Filter by CRITICAL/HIGH/MEDIUM/LOW |
| sp_update_loan_status | loan_id, new_status | Update status with change log |

---

## 💡 Key Insights

- 25% of loans are stressed — Defaulted, Delinquent or Under Review
- Retired borrowers show highest default rate despite smallest loans
- Personal loans carry highest stress % despite lowest total exposure
- Home loans are the safest segment — zero defaults
- Borrowers below credit score 600 show 100% stress rate
- Self-employed borrowers carry higher rates AND higher risk

---

## 🚀 How to Run
```sql
-- Option 1: Run complete project in one go
SOURCE loan_risk_analysis_complete.sql;

-- Option 2: Run step by step
SOURCE schema/01_create_tables.sql;
SOURCE data/02_insert_data.sql;
SOURCE queries/08_query6_composite_risk_score.sql;
```

---

## 📁 Project Structure
```
loan-risk-analysis-sql/
│
├── README.md
├── loan_risk_analysis_complete.sql
│
├── schema/
│   └── 01_create_tables.sql
│
├── data/
│   └── 02_insert_data.sql
│
├── queries/
│   ├── 03_query1_borrower_overview.sql
│   ├── 04_query2_high_risk.sql
│   ├── 05_query3_portfolio_segmentation.sql
│   ├── 06_query4_repayment_behavior.sql
│   ├── 07_query5_credit_bands.sql
│   └── 08_query6_composite_risk_score.sql
│
└── views_procedures/
    ├── 09_views.sql
    └── 10_stored_procedures.sql
```

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| MySQL 8.0 | Database engine |
| MySQL Workbench | Query writing and testing |
| GitHub | Version control and portfolio |

---

## 👤 Author

**Your Name**
📧 ritikakadam186@gmail.com
🔗 www.linkedin.com/in/rutika-kadam-122927251
