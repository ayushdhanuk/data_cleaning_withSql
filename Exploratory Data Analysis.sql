select *
from layoffs_staging2;

select max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off desc
;

select company, sum(total_laid_off) as layoffs
from layoffs_staging2
group by company
order by 2 desc
;

select industry, sum(total_laid_off) as layoffs
from layoffs_staging2
group by industry
order by 2 desc
;

select country, sum(total_laid_off) as layoffs
from layoffs_staging2
group by country
order by 2 desc
;

select min(`date`), max(`date`)
from layoffs_staging2;

select year(`date`) as `year`, sum(total_laid_off) as layoffs
from layoffs_staging2
group by year(`date`)
order by 1 desc
;

select *
from layoffs_staging2;

select substr(`date`,1,7) as `month`, sum(total_laid_off) as layoffs
from layoffs_staging2
where substr(`date`,1,7) is not null
group by `month`
order by 1 asc
;

with Rolling_total as 
(
select substr(`date`,1,7) as `month`, sum(total_laid_off) as layoffs
from layoffs_staging2
where substr(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`,layoffs,sum(layoffs) over(order by `month`) as rolling_total
from Rolling_total;

select company, year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 3 desc;

with  Company_Year(company,years,layoffs) as
(
select company, year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
), Company_Year_Rank as 
(select *,
dense_rank() over(partition by years order by layoffs desc) as Ranking
from Company_Year
where years is not null
)
select *
from Company_Year_Rank
Where Ranking<=5
;