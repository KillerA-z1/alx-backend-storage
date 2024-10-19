-- This SQL script lists all bands with Glam rock as their main style.
-- The bands are ranked by their longevity, calculated as the difference between the year they split (or 2020 if they haven't split) and the year they formed.
-- Columns:
--   - band_name: The name of the band.
--   - lifespan: The calculated longevity of the band.
-- The results are ordered by lifespan in descending order.
SELECT band_name, IFNULL(split, 2020) - formed AS lifespan
FROM metal_bands
WHERE FIND_IN_SET("Glam rock", style)
ORDER BY lifespan DESC;
