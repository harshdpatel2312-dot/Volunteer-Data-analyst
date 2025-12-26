# Labour Force Trend Analysis – London Economic Region  
**Volunteer Data Analyst Project**

---

## Executive Summary
This volunteer project provides stakeholders with a **clear, long-term view of labour force trends for the London Economic Region** using data from **2006–2025**.

Stakeholders did not define a specific problem or request recommendations. Their primary need was **trend visibility and historical context**. Using **Excel for data validation**, **SQL for analysis**, and **Tableau for dashboards and story views**, this project guides **subject matter experts (SMEs)** by highlighting historically comparable periods and framing **analytical questions** to support interpretation and recall.

---

## Stakeholder Requirement
- View long-term labour force trends for the London Economic Region  
- Compare recent movements to historical periods  
- Use visuals to support discussion and interpretation  

---

## Dataset (2006–2025)
- labour force (x1000 persons)
- Employment (x1000 persons)
- Unemployed (x1000 persons)
- Metrics:
  - Participation Rate    
  - Unemployment Rate  
- Geography: London Economic Region, Elgin, Oxford, Middlesex 

---

## Tools & Workflow

### Excel (Data Validation)
- Corrected dataset structure (using transpose), formatting (using TRIM and adjusting decimal fields), and missing values
- Verified that month, year, and rate columns were consistent using lookup functions
- Created a single 'Date' column by concatenating Month and Year (using CONCAT function)

### SQL (Analysis)
SQL queries included in the repository demonstrate:
- Monthly and yearly aggregation  
- Historical and yearly average comparisons  
- Window functions for trend identification  
- Conditional logic to flag notable deviations
  
-- Sample London Resilient periods
with london_flags as (select
w.Region,
w.date,
Participation_rate,
Unemployment_Rate,
case 
    when Unemployment_Rate > avg(Unemployment_Rate) over (partition by w.region,year(w.date)) then 'spike'
    else 'no spike'
    end unemployment_spike_flag,
case 
    when Participation_rate< avg(Participation_rate) over (partition by w.region,year(w.date)) then 'drop' 
    else 'no drop'
    end participation_drop_flag
from [working sheet labour force.xlsx - working sheet] as w
where w.Region in ('london')
)
select *
from london_flags
where unemployment_spike_flag='spike' and participation_drop_flag='no drop'
order by date


📂 See: `/sql/`

### Tableau (Visualization & Storytelling)
Dashboards and story views were created to:
- Show trends across years clearly  
- Compare months year-over-year  
- Annotate visuals with guiding analytical questions  
- Focus on SME interpretation and recall  

📂 See:
- `/tableau/dashboard_images/`  
- `/tableau/story_images/`
  

---

## Key Observations (Question-Driven)
- Which past recovery periods show patterns similar to recent years?  
- Why did participation peak in certain post-pandemic months for the first time since earlier recovery phases?  
- Are recent movements part of a long-term cycle or temporary deviations?  

These observations are framed as **questions for SME guidance**, not conclusions.

---

**Impact & Value:**
- Created dashboards showing long-term trends and monthly comparisons  
- Framed analytical questions to help SMEs understand and recall past periods  
- Delivered SQL queries that summarize trends and flag deviations  
- Focused entirely on **stakeholder viewing needs**, not prescriptive recommendations

---

## Limitations
- Descriptive analysis only; no causality inferred  
- External variables (economic, policy, demographic) not included  
- Focus limited to one economic region 
---

## About
**Harsh**  
Volunteer Data Analyst  
Experienced in SQL, Tableau, and Excel for **stakeholder-driven exploratory analysis**.

