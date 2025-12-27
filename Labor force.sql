use mydatabase 
 select* from [working sheet labour force.xlsx - working sheet]

    SELECT TOP 5
    Month,
    year,
    Participation_rate,
    Unemployment_Rate
FROM [working sheet labour force.xlsx - working sheet];

ALTER TABLE [working sheet labour force.xlsx - working sheet]
ALTER COLUMN Participation_rate DECIMAL(5, 1);

ALTER TABLE [working sheet labour force.xlsx - working sheet]
ALTER COLUMN Unemployment_Rate DECIMAL(5, 1);


 --london particpation rate 
 select
w.Month,
w.year,
concat(w.Region,'-',w.country_province) region_province,
w.Participation_rate,
avg(w.Participation_rate) over(partition by w.year ) Yearly_avgParticipationRate
from [working sheet labour force.xlsx - working sheet] as w
where concat(region,'-',country_province) = 'london-ontario'

--or
-- top 10 london particpation rate over year
SELECT top 10
    year,
    AVG(participation_rate) AS yearly_avg_participation_rate
FROM [working sheet labour force.xlsx - working sheet]
GROUP BY year
ORDER BY AVG(participation_rate) desc

--Has London’s participation rate improved or declined post-2020?
select
YEAR,
region,
avg(Participation_rate) avg_participation_rate,
case
    when avg(Participation_rate)> (SELECT AVG(Participation_rate) FROM [working sheet labour force.xlsx - working sheet] WHERE YEAR = 2020)
    then 'improved'
    else 'declined'
end Post2020_flag
from [working sheet labour force.xlsx - working sheet]
group by YEAR,Region
having YEAR in (2020,2021,2022)
order by region,YEAR

-- london Resilient periods
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