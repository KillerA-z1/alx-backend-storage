-- Task 2: 2. Best band ever! - ranks country origins of bands, based on their total number of fans
-- This query selects the distinct origins of metal bands and calculates the total number of fans for each origin.
-- The results are grouped by origin and ordered in descending order based on the total number of fans.
SELECT DISTINCT `origin`, SUM(`fans`) as `nb_fans` FROM `metal_bands`
GROUP BY `origin`
ORDER BY `nb_fans` DESC;
