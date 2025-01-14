-- Creating Common Table Expression (CTE) to combine data from two years
WITH cte AS (
    -- Select data from the first year's bike share data
    SELECT * FROM bike_share_yr_0
    UNION ALL
    -- Select data from the second year's bike share data
    SELECT * FROM bike_share_yr_1
)

-- Main query to calculate revenue and profit from the CTE
SELECT 
    dteday,          -- Date of the record
    season,          -- Season (Spring, Summer, Fall, Winter)
    bike_data.yr AS year,    -- Year (2021 or 2022) for clarity
    weekday,         -- Day of the week
    hr,              -- Hour of the day
    rider_type,      -- Type of rider (Registered or Casual)
    riders,          -- Number of riders
    price,           -- Price per ride
    COGS,            -- Cost of Goods Sold
    riders * price AS revenue,  -- Calculating revenue: riders * price
    riders * price - COGS AS profit -- Calculating profit: revenue - COGS
FROM cte bike_data  -- Renaming cte to bike_data for better clarity
-- Left join with the cost_table to get cost data for each year
LEFT JOIN cost_table cost_data  -- Renaming cost_table to cost_data for better clarity
    ON bike_data.yr = cost_data.yr
