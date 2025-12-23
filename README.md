# 📊 Customer Credit Risk Analysis

## Domain
Banking & Finance

## Objective
Analyze factors contributing to customer credit risk and differentiate credit-worthy vs credit-risky customers based on payment behavior.

## Dataset Overview
- **Customer Demographics:** Encoded features + risk label  
- **Payment Transactions:** Overdue history, balances, credit limits  
- **Labels:** 0 → Credit Worthy, 1 → Credit Risky  

## Key Analysis Steps
1. Aggregated payment behavior at customer level  
2. Analyzed overdue behavior and payment discipline  
3. Calculated credit utilization and risk KPIs  
4. Compared credit-worthy vs credit-risky customers  

## Key Insights
- Risky customers have **2× overdue days** and exceed credit limits  
- High credit utilization and severe overdue events strongly indicate risk  
- Credit-worthy customers maintain regular payments and controlled credit usage  

## Business Impact
- Supports **credit approval rules** and **early warning systems**  
- Enables **risk-based customer segmentation**  

## Tools & Technologies
- Python (pandas, numpy, matplotlib, seaborn)  
- SQL (PostgreSQL/MySQL)  
- Power BI for dashboard visualization  

## How to Run
1. Load datasets into Python environment  
2. Perform data cleaning and aggregation  
3. Run analysis scripts to generate KPIs and visualizations  
4. Use findings to build dashboards and reports  

## Conclusion
Customer payment behavior is the **primary driver of credit risk**. Key predictors include **high credit utilization**, **long overdue durations**, and **irregular payment patterns**. Insights can directly inform banking risk management strategies.

