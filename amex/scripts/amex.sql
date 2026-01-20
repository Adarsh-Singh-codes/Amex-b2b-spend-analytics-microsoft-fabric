-- ============================================
-- CORE BUSINESS KPIs
-- ============================================

-- Total Corporate Spend
SELECT 
    SUM(amount) AS total_spend
FROM gold.gold_fact_spend;


-- Total Transactions
SELECT 
    COUNT(*) AS total_transactions
FROM gold.gold_fact_spend;


-- Contract Spend
SELECT 
    SUM(amount) AS contract_spend
FROM gold.gold_fact_spend
WHERE is_contract = 1;


-- High Risk Spend
SELECT 
    SUM(amount) AS high_risk_spend
FROM gold.gold_fact_spend
WHERE is_high_risk = 1;


-- ============================================
-- SPEND ANALYSIS
-- ============================================

-- Spend by Industry
SELECT 
    company_industry,
    SUM(amount) AS total_spend
FROM gold.gold_fact_spend
GROUP BY company_industry
ORDER BY total_spend DESC;


-- Monthly Spend Trend
SELECT 
    year_month,
    SUM(amount) AS monthly_spend
FROM gold.gold_fact_spend
GROUP BY year_month
ORDER BY year_month;


-- Top 10 Suppliers by Spend
SELECT 
    supplier_name,
    SUM(amount) AS total_spend
FROM gold.gold_fact_spend
GROUP BY supplier_name
ORDER BY total_spend DESC
LIMIT 10;


-- Contract Coverage Percentage
SELECT 
    ROUND(
        SUM(CASE WHEN is_contract = 1 THEN amount ELSE 0 END) 
        * 100.0 / SUM(amount), 
        2
    ) AS contract_coverage_pct
FROM gold.gold_fact_spend;


-- High Risk Exposure Percentage
SELECT 
    ROUND(
        SUM(CASE WHEN is_high_risk = 1 THEN amount ELSE 0 END) 
        * 100.0 / SUM(amount), 
        2
    ) AS high_risk_exposure_pct
FROM gold.gold_fact_spend;


-- Payment Type Distribution
SELECT 
    payment_type,
    SUM(amount) AS total_spend
FROM gold.gold_fact_spend
GROUP BY payment_type
ORDER BY total_spend DESC;
