# Hospital Management Data Analysis

End-to-end analysis of hospital operations and billing data (50 patients, 10 doctors, 200 appointments) using MySQL and Excel.

**Workflow:** MySQL (validation & analysis) → Excel (PivotTables) → Excel (dashboard)

## Dataset
Public hospital management dataset with five related tables: Patients, Doctors, Appointments, Treatments and Billing, covering 2023.

## Tools
- **MySQL:** data-quality checks, JOINs, aggregation, subqueries, date functions
- **Excel:** PivotTables, PivotCharts, KPI cards, slicers, dashboard

## Methodology
1. **Validate (SQL):** NULL values, duplicate IDs, negative amounts, unmatched foreign keys.
2. **Analyze (SQL):** doctor workload, appointment status, billing by treatment, payment methods, monthly trends.
3. **Summarize (Excel):** PivotTables and PivotCharts for each business question.
4. **Present (Excel):** KPI cards, slicers and an interactive dashboard.

## Key Findings

| Metric | Result |
|---|---|
| Total billed amount | 551,249.85 |
| Busiest doctor | D005 (Sarah Taylor), 29 appointments |
| Largest appointment status | No-show, 52 of 200 (26%) |
| Highest billed treatment | Chemotherapy, 128,855.68 |
| Highest average treatment cost | MRI, 3,224.95 |
| Top payment method | Credit Card, 201,382.43 |
| Peak billing month | April, 64,271.54 |

- Only 64 of 200 bills are marked Paid, so billed amount should not be treated as revenue received.

