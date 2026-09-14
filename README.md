# SF Building Permits Analysis

## Overview
This project analyzes San Francisco's public building permits dataset using SQL to explore how permit activity and approval speed have changed over time, and where the biggest bottlenecks are.

## Project Question
How has San Francisco's building permit activity and approval speed changed over time, and where are the biggest bottlenecks?

This breaks down into a few sub-questions:
- How has permit volume changed year over year?
- How long does it take permits to go from filed to issued, and has that changed over time?
- Which permit types or neighborhoods have the slowest approval times?
- Has the mix of residential vs. commercial permits shifted?

## Data Source
[SF Building Permits](https://data.sf.gov/Housing-and-Buildings/Building-Permits/i98e-djp9) — San Francisco's Open Data Portal (DataSF)

## Data Quality Notes
While exploring the dataset, a few real-world data quality issues were identified and documented:

- **Date fields imported as text**: The "Filed Date," "Issued Date," and "Completed Date" columns were originally stored as text rather than proper date/timestamp values. New cleaned columns (`filed_date_clean`, `issued_date_clean`, `completed_date_clean`) were created to enable accurate date calculations.
- **Illogical date ordering in older records**: Approximately 1% of rows (2,292 out of ~200k) have an Issued Date earlier than the Filed Date. This issue is concentrated in older records (1980s-90s), likely reflecting inconsistencies from historical data entry or digitization. These rows are excluded from approval-time calculations to avoid skewing results.
- **Blank vs. null values**: Empty date fields were sometimes stored as empty strings rather than true NULL values, requiring explicit checks for both.
- **Excluded data**: Intentionally excluded sparse and inconsistent pre-1980 data as well as incomplete 2026 data in analysis.

## Findings

### 1. Permit Volume Over Time
Permit filings grew steadily from 1980 (259 permits) through a peak in 2019 (42,681 permits), reflecting several decades of increasing development activity in San Francisco. Filings dropped sharply in 2020 (24,925, a ~42% decline from 2019), likely reflecting COVID-19 disruptions to construction and permitting processes. Volume has remained in a lower, relatively stable range (~24,000-26,000/year) from 2020-2025, well below pre-pandemic levels.

*Note: Analysis excludes pre-1980 records (sparse and likely incomplete/unreliable) and 2026 (partial year, data as of September 10, 2026).*

![Permit volume by year](visuals/sf_permit_volume_by_year.png)

🔗 [View interactive version on Tableau Public](https://public.tableau.com/app/profile/leena.qureshi/viz/SFBuildingPermits_17894082363590/SFPermitVolumebyYear#1)

### 2. Permit Approval Time Over Time
Average approval time (days from filed to issued) has fluctuated significantly over the dataset's history, ranging from a low of ~18 days (2008) to a high of ~67 days (2020). Excluding the 1980 outlier (discussed below), approval times generally ran 50-60+ days through the late 1980s, dropped to their lowest point in the late 2000s/early 2010s, then climbed again from 2013 onward, peaking in 2020. Notably, this 2020 peak occurred even though permit *volume* dropped sharply that same year (see Finding 1), suggesting slower processing wasn't simply a matter of higher demand. Approval times have since declined, returning to ~24-25 days by 2024-2025.

*Note: Excludes rows where Issued Date is earlier than Filed Date (~1% of records, concentrated in older data — see Data Quality Notes). 1980 shows an unusually high average (401 days), likely due to the small number of permits filed that year (259, versus 2,000+ in surrounding years) — a few slow outliers have an outsized effect on the average when the sample is that small.*

![Permit approval time by year](visuals/sf_permit_approval_time.png)

🔗 [View interactive version on Tableau Public](https://public.tableau.com/app/profile/leena.qureshi/viz/SFBuildingPermitApprovalTime1980-2025/SFPermitApprovalTime#1)

## Tools
SQL (PostgreSQL), TablePlus, Tableau
