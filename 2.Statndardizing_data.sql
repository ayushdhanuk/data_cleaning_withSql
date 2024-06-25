-- STANDARDIZING DATA
select *
from layoffs_staging2;

-- company colummn
select distinct company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

-- industry column
select distinct industry
from layoffs_staging2
where  industry like 'crypto%' ;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'crypto%';

-- country
select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1 ;

update layoffs_staging2
set country = trim(trailing '.' from country);

select distinct stage
from layoffs_staging2;

update layoffs_staging2
set stage = trim(trailing '.' from stage);

-- date column
select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date