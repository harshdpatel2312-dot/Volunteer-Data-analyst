# Labour Force Trend Analysis – London Economic Region  

---

## Executive Summary
This volunteer project provides stakeholders with a **clear, long-term view of labour force trends for the London Economic Region** using data from **2006–2025**.

Stakeholders did not define a specific problem or request recommendations. Their primary need was **trend visibility and historical context**. Using **Excel for data validation**, **SQL for analysis**, and **Tableau for dashboards and story views**, this project supports subject matter experts by highlighting comparable historical periods and guiding interpretation through analytical questions.

---

## Stakeholder Requirement
- View long-term labour force trends for the London Economic Region  
- Compare recent movements to historical periods  
- Use visuals to support discussion and interpretation  

---

## Dataset (2006–2025)
- Labour force, Employment, Unemployed  (x1000 persons)
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

📂 See: [Before (Raw Data)](Labour%20force%20raw%20dataset.xlsx) → [After (Cleaned Data)](Cleaned%20labour%20force%20dataset.xlsx.csv)


### SQL (Analysis)
SQL queries included in the repository demonstrate:
- Monthly and yearly aggregation  
- Historical and yearly average comparisons  
- Window functions for trend identification  
- Conditional logic to flag notable deviations

## Sample London Resilient periods
```sql
WITH london_flags AS (
    SELECT 
        w.Region, 
        w.date, 
        Participation_rate, 
        Unemployment_Rate, 
        CASE 
            WHEN Unemployment_Rate > AVG(Unemployment_Rate) OVER (PARTITION BY w.region, YEAR(w.date)) 
            THEN 'spike' 
            ELSE 'no spike' 
        END AS unemployment_spike_flag, 
        CASE 
            WHEN Participation_rate < AVG(Participation_rate) OVER (PARTITION BY w.region, YEAR(w.date)) 
            THEN 'drop' 
            ELSE 'no drop' 
        END AS participation_drop_flag 
    FROM [working sheet labour force.xlsx - working sheet] AS w 
    WHERE w.Region IN ('london')
)
SELECT * 
FROM london_flags 
WHERE unemployment_spike_flag = 'spike' 
    AND participation_drop_flag = 'no drop' 
ORDER BY date;
```

📂 See: [Full SQL file](Labour%20force.sql)


---

### Tableau (Visualization & Storytelling)

**Regional Employment Analytics Dashboard**:

![Regional Employment Analytics Dashboard](Tableau%20image/Dashboard-image.png)

## Sample Story 

**Unemployment peaked twice**

![story-1](Tableau%20image/Story%20point-1.png)

📂 See: [Full Tableau file](Tableau%20image)


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

