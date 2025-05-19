--6.	Daily Average Vaccinations Over Time for Top 5 Countries
WITH top_countries AS (SELECT DISTINCT country, SUM(total_vaccinations) AS total_vaccinations FROM  covid_19_vacc
    GROUP BY country
    ORDER BY total_vaccinations DESC LIMIT 5
),
daily_averages AS (SELECT  country,
        AVG(daily_vaccinations) AS avg_daily_vaccinations FROM covid_19_vacc
    WHERE country IN (SELECT country FROM top_countries)
        AND daily_vaccinations IS NOT NULL
    GROUP BY country
)
SELECT d.country, d.avg_daily_vaccinations,
    t.total_vaccinations AS country_total_vaccinations FROM  daily_averages d
JOIN top_countries t ON d.country = t.country
ORDER BY d.avg_daily_vaccinations DESC;