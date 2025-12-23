--understand the tables
SELECT * FROM customer_data LIMIT 5;
SELECT * FROM payment_data LIMIT 5;

--Check Class imbalance
SELECT
    label,
    COUNT(*) AS customer_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM customer_data
GROUP BY label;

--Aggregate payment behavior(Feature engineering)
CREATE TABLE payment_agg AS
SELECT
    id,
    SUM("OVD_t1") AS total_ovd_t1,
    SUM("OVD_t2") AS total_ovd_t2,
    SUM("OVD_t3") AS total_ovd_t3,
    SUM("OVD_sum") AS total_overdue_days,
    SUM("pay_normal") AS total_normal_payments,
    MAX("prod_limit") AS max_credit_limit,
    AVG("new_balance") AS avg_balance,
    MAX("highest_balance") AS max_balance
FROM payment_data
GROUP BY id;

--checking
SELECT * FROM payment_agg LIMIT 5;

--joining customer and payment table
CREATE TABLE credit_risk_master AS
SELECT
    c.*,
    p.total_ovd_t1,
    p.total_ovd_t2,
    p.total_ovd_t3,
    p.total_overdue_days,
    p.total_normal_payments,
    p.max_credit_limit,
    p.avg_balance,
    p.max_balance,
    ROUND(
        (p.avg_balance / NULLIF(p.max_credit_limit, 0))::NUMERIC,
        2
    ) AS credit_utilization
FROM customer_data c
LEFT JOIN payment_agg p
ON c.id = p.id;



--Risky vs non risky behavior analysis
SELECT
    label,
    ROUND(AVG(total_overdue_days), 2) AS avg_overdue_days,
    ROUND(AVG(credit_utilization), 2) AS avg_utilization
FROM credit_risk_master
GROUP BY label;

--Payment discipline
SELECT
    label,
    ROUND(AVG(total_normal_payments), 2) AS avg_normal_payments
FROM credit_risk_master
GROUP BY label;

--Top risk indicators
SELECT
    label,
    ROUND(AVG(total_ovd_t1), 2) AS ovd_t1,
    ROUND(AVG(total_ovd_t2), 2) AS ovd_t2,
    ROUND(AVG(total_ovd_t3), 2) AS ovd_t3
FROM credit_risk_master
GROUP BY label;

--to create powerbi ready view
CREATE OR REPLACE VIEW credit_risk_dashboard AS
SELECT
    id,
    label,
    fea_1, fea_3, fea_5, fea_6, fea_7, fea_9,
    total_overdue_days,
    total_normal_payments,
    credit_utilization,
    max_credit_limit,
    avg_balance
FROM credit_risk_master;

--Business KPI Dashboard tiles
-- % Risky Customers
SELECT ROUND(100.0 * COUNT(*) FILTER (WHERE label = 1) / COUNT(*), 2)
AS risky_customer_percentage
FROM credit_risk_master;

-- Avg Utilization of Risky Customers
SELECT ROUND(AVG(credit_utilization), 2)
FROM credit_risk_master
WHERE label = 1;




