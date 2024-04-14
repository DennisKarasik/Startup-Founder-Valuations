-- Startup Founder Valuations (Kaggle) Dataset:
-- https://www.kaggle.com/datasets/firmai/startup-founder-valuations-dataset

-- Art-Related:

WITH CTE AS (
  SELECT
    CASE
      WHEN sfc.Standardized_Major IN (
        'Architecture',
        'Design',
        'Desgin',
        'Film',
        'Media',
        'Music'
      ) THEN 'Arts-Related'
      WHEN sfc.Standardized_Major IN (
        'Biology',
        'Chemistry',
        'Computer Science',
        'Mathematics',
        'Physics',
        'Electrical Engineering',
        'Engineering',
        'Mechanical Engineering',
        'Cognitive Science',
        'Operations Research',
        'Opreations Research',
        'Geology'
      ) THEN 'STEM-Related'
      WHEN sfc.Standardized_Major IN ('Business', 'Economics') THEN 'Business-Related'
      WHEN sfc.Standardized_Major IN (
        'English',
        'History',
        'International Relations',
        'Philosophy',
        'Political Science',
        'Psychology',
        'Sociology',
        'Language',
        'Public Policy',
        'Interdisciplinary Degree'
      ) THEN 'Humanities-Related'
    END AS Major_Type,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
  WHERE
    sv.Seed_Valuation IS NOT NULL
)
SELECT
  Seed_Valuation
FROM
  CTE
WHERE
  Major_Type = 'Arts-Related'

-- Business-Related:

WITH CTE AS (
  SELECT
    CASE
      WHEN sfc.Standardized_Major IN (
        'Architecture',
        'Design',
        'Desgin',
        'Film',
        'Media',
        'Music'
      ) THEN 'Arts-Related'
      WHEN sfc.Standardized_Major IN (
        'Biology',
        'Chemistry',
        'Computer Science',
        'Mathematics',
        'Physics',
        'Electrical Engineering',
        'Engineering',
        'Mechanical Engineering',
        'Cognitive Science',
        'Operations Research',
        'Opreations Research',
        'Geology'
      ) THEN 'STEM-Related'
      WHEN sfc.Standardized_Major IN ('Business', 'Economics') THEN 'Business-Related'
      WHEN sfc.Standardized_Major IN (
        'English',
        'History',
        'International Relations',
        'Philosophy',
        'Political Science',
        'Psychology',
        'Sociology',
        'Language',
        'Public Policy',
        'Interdisciplinary Degree'
      ) THEN 'Humanities-Related'
    END AS Major_Type,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
  WHERE
    sv.Seed_Valuation IS NOT NULL
)
SELECT
  Seed_Valuation
FROM
  CTE
WHERE
  Major_Type = 'Business-Related'

-- Humanities-Related:

WITH CTE AS (
  SELECT
    CASE
      WHEN sfc.Standardized_Major IN (
        'Architecture',
        'Design',
        'Desgin',
        'Film',
        'Media',
        'Music'
      ) THEN 'Arts-Related'
      WHEN sfc.Standardized_Major IN (
        'Biology',
        'Chemistry',
        'Computer Science',
        'Mathematics',
        'Physics',
        'Electrical Engineering',
        'Engineering',
        'Mechanical Engineering',
        'Cognitive Science',
        'Operations Research',
        'Opreations Research',
        'Geology'
      ) THEN 'STEM-Related'
      WHEN sfc.Standardized_Major IN ('Business', 'Economics') THEN 'Business-Related'
      WHEN sfc.Standardized_Major IN (
        'English',
        'History',
        'International Relations',
        'Philosophy',
        'Political Science',
        'Psychology',
        'Sociology',
        'Language',
        'Public Policy',
        'Interdisciplinary Degree'
      ) THEN 'Humanities-Related'
    END AS Major_Type,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
  WHERE
    sv.Seed_Valuation IS NOT NULL
)
SELECT
  Seed_Valuation
FROM
  CTE
WHERE
  Major_Type = 'Humanities-Related'

-- Previous Startup Experience of Founders (Before Founding Primary Company):
  
SELECT
  Previous_startups_,
  COUNT(DISTINCT Full_Name) AS number_of_founders
FROM
  startup_valuations.startup_founder_chars_cleaned
GROUP BY
  1
ORDER BY
  2 DESC

-- Previous Consulting Experience of Founders (Before Founding Primary Company):
  
SELECT
  CASE
    WHEN Consulting_before_start_up = 1 THEN 'Previous_Consulting_Experience'
    WHEN Consulting_before_start_up = 0 THEN 'No_Previous_Consulting_Experience'
  END AS Consulting_before_start_up,
  COUNT(DISTINCT Full_Name) AS number_of_founders
FROM
  startup_valuations.startup_founder_chars_cleaned
GROUP BY
  1
ORDER BY
  2 DESC

-- Number of Founders By (Undergraduate) University:
  
SELECT
  Standardized_University,
  COUNT(DISTINCT Full_Name) AS number_of_founders
FROM
  startup_valuations.startup_founder_chars_cleaned
WHERE
  Standardized_University != 'Unknown'
GROUP BY
  1
ORDER BY
  2 DESC

-- Experience of Founders Who Dropped Out of (Undergraduate) University:
  
SELECT
  Full_Name AS founders_who_dropped_out,
  Previous_startups_,
  CASE
    WHEN Consulting_before_start_up = 1 THEN 'Previous_Consulting_Experience'
    WHEN Consulting_before_start_up = 0 THEN 'No_Previous_Consulting_Experience'
  END AS Consulting_before_start_up,
  CASE
    WHEN Worked_in_Sales_ = 1 THEN 'Previous_Sales_Experience'
    WHEN Worked_in_Sales_ = 0 THEN 'No_Previous_Sales_Experience'
  END AS Sales_before_start_up,
  Standardized_University
FROM
  startup_valuations.startup_founder_chars_cleaned
WHERE
  Degree_Type = "Drop"
GROUP BY
  1,
  2,
  3,
  4,
  5

-- Percent of Founders Who Dropped Out of (Undergraduate) University:
  
SELECT
  (
    (
      (
        SELECT
          COUNT(DISTINCT Full_Name)
        FROM
          startup_valuations.startup_founder_chars_cleaned
        WHERE
          Degree_Type = "Drop"
      ) / COUNT(DISTINCT Full_Name)
    ) * 100
  ) AS pct_of_founders_who_dropped_out_of_uni
FROM
  startup_valuations.startup_founder_chars_cleaned
WHERE
  Degree_Type != "Drop"
  AND Degree_Type != 'Unknown'

-- Number of Founders By (Undergraduate) University Major and Type:
  
SELECT
  Standardized_Major,
  CASE
    WHEN Standardized_Major IN (
      'Architecture',
      'Design',
      'Film',
      'Media',
      'Music'
    ) THEN 'Arts-Related'
    WHEN Standardized_Major IN (
      'Biology',
      'Chemistry',
      'Computer Science',
      'Mathematics',
      'Physics',
      'Electrical Engineering',
      'Engineering',
      'Mechanical Engineering',
      'Cognitive Science',
      'Operations Research',
      'Geology'
    ) THEN 'STEM-Related'
    WHEN Standardized_Major IN ('Business', 'Economics') THEN 'Business-Related'
    WHEN Standardized_Major IN (
      'English',
      'History',
      'International Relations',
      'Philosophy',
      'Political Science',
      'Psychology',
      'Sociology',
      'Language',
      'Public Policy',
      'Interdisciplinary Degree'
    ) THEN 'Humanities-Related'
  END AS Major_Type,
  COUNT(DISTINCT Full_Name) AS number_of_founders
FROM
  startup_valuations.startup_founder_chars_cleaned
WHERE
  Standardized_Major != 'Unknown'
GROUP BY
  1,
  2
ORDER BY
  3 DESC

-- Founders By Graduate Institution:
  
SELECT
  Standardized_Graduate_Institution,
  COUNT(DISTINCT Full_Name) AS number_of_founders
FROM
  startup_valuations.startup_founder_chars_cleaned
WHERE
  Standardized_Graduate_Institution != 'Unknown'
GROUP BY
  1
ORDER BY
  2 DESC

-- Number of Founders By (Graduate) Institution Major:
  
SELECT
  Standardized_Graduate_Studies,
  COUNT(DISTINCT Full_Name) AS number_of_founders
FROM
  startup_valuations.startup_founder_chars_cleaned
WHERE
  Standardized_Graduate_Studies != 'Unknown'
GROUP BY
  1
ORDER BY
  2 DESC

-- Number of Founders By Years of Employment:
  
SELECT
  ROUND(Years_of_Employment, 0) AS Years_of_Employment,
  COUNT(DISTINCT Full_Name) AS number_of_founders
FROM
  startup_valuations.startup_founder_chars_cleaned
GROUP BY
  1
ORDER BY
  2 DESC

-- Years of Employment By Percentile:
  
WITH subquery AS (
  SELECT
    Years_of_Employment
  FROM
    startup_valuations.startup_founder_chars_cleaned
)
SELECT
  percentiles [offset(10)] AS p10_years_of_employment,
  percentiles [offset(25)] AS p25_years_of_employment,
  percentiles [offset(50)] AS p50_years_of_employment,
  percentiles [offset(75)] AS p75_years_of_employment,
  percentiles [offset(90)] AS p90_years_of_employment
FROM
  (
    SELECT
      approx_quantiles(Years_of_Employment, 100) percentiles
    FROM
      subquery
  )

-- Average Years of Employment Before Founding Primary Company:
  
SELECT
  AVG(Years_of_Employment) AS average_years_of_employment
FROM
  startup_valuations.startup_founder_chars_cleaned

-- Average Previous Startup Experience (Number of Startups Experienced Before Founding Primary Company):
  
SELECT
  AVG(Previous_startups_) AS average_previous_startups,
  AVG(
    CASE
      WHEN Previous_startups_ > 0 THEN Previous_startups_
      ELSE NULL
    END
  ) AS average_previous_startups_excluding_zero
FROM
  Startup_valuations.startup_founder_chars_cleaned

-- Previous Sales Experience of Founders (Before Founding Primary Company):
  
WITH subquery AS (
  SELECT
    CASE
      WHEN Worked_in_Sales_ = 1 THEN 'Previous_Sales_Experience'
      WHEN Worked_in_Sales_ = 0 THEN 'No_Previous_Sales_Experience'
    END AS Sales_before_start_up,
    COUNT(DISTINCT Full_Name) AS number_of_founders
  FROM
    startup_valuations.startup_founder_chars_cleaned
  GROUP BY
    1
)
SELECT
  Sales_before_start_up,
  number_of_founders
FROM
  subquery
ORDER BY
  number_of_founders DESC

-- 
  
SELECT
  CASE
    WHEN Ivy_League = 1 THEN 'Ivy_League'
    WHEN Ivy_League = 0 THEN 'Not_Ivy_League'
  END AS Ivy_League_Status,
  COUNT(DISTINCT Full_Name) AS number_of_founders
FROM
  startup_valuations.startup_founder_chars_cleaned
GROUP BY
  1
ORDER BY
  2 DESC
###
SELECT
  CASE
    WHEN Ivy_League = 1 THEN 'Ivy_League'
    WHEN Ivy_League = 0 THEN 'Not_Ivy_League'
  END AS Ivy_League_Status,
  AVG(Years_of_Employment) AS average_years_of_employment
FROM
  startup_valuations.startup_founder_chars_cleaned
GROUP BY
  1
###
SELECT
  *
FROM
  startup_valuations.startup_valuations_cleaned
###
SELECT
  Primary_Company,
  B_Valuation,
  LAG(B_Valuation, 1) OVER (
    ORDER BY
      B_Valuation DESC
  ) AS B_Valuation_Lag,
  (
    (
      (
        LAG(B_Valuation, 1) OVER (
          ORDER BY
            B_Valuation DESC
        ) / B_Valuation
      ) -1
    ) * 100
  ) AS Pct_Diff_vs_Predecessor,
  ROW_NUMBER() OVER (
    ORDER BY
      B_Valuation DESC
  ) AS row_number,
  LAG(Primary_Company, 1) OVER (
    ORDER BY
      B_Valuation DESC
  ) AS Primary_Company_Lag
FROM
  startup_valuations.startup_valuations_cleaned
ORDER BY
  B_Valuation DESC
###
WITH subquery AS (
  SELECT
    Seed_Valuation
  FROM
    startup_valuations.startup_valuations_cleaned
)
SELECT
  percentiles [offset(10)] AS p10_seed_valuation,
  percentiles [offset(25)] AS p25_seed_valuation,
  percentiles [offset(50)] AS p50_seed_valuation,
  percentiles [offset(75)] AS p75_seed_valuation,
  percentiles [offset(90)] AS p90_seed_valuation
FROM
  (
    SELECT
      approx_quantiles(Seed_Valuation, 100) percentiles
    FROM
      subquery
  )
###
WITH subquery AS (
  SELECT
    A_Valuation
  FROM
    startup_valuations.startup_valuations_cleaned
)
SELECT
  percentiles [offset(10)] AS p10_A_Valuation,
  percentiles [offset(25)] AS p25_A_Valuation,
  percentiles [offset(50)] AS p50_A_Valuation,
  percentiles [offset(75)] AS p75_A_Valuation,
  percentiles [offset(90)] AS p90_A_Valuation
FROM
  (
    SELECT
      approx_quantiles(A_Valuation, 100) percentiles
    FROM
      subquery
  )
###
WITH subquery AS (
  SELECT
    B_Valuation
  FROM
    startup_valuations.startup_valuations_cleaned
)
SELECT
  percentiles [offset(10)] AS p10_B_Valuation,
  percentiles [offset(25)] AS p25_B_Valuation,
  percentiles [offset(50)] AS p50_B_Valuation,
  percentiles [offset(75)] AS p75_B_Valuation,
  percentiles [offset(90)] AS p90_B_Valuation
FROM
  (
    SELECT
      approx_quantiles(B_Valuation, 100) percentiles
    FROM
      subquery
  )
###
SELECT
  AVG(Seed_Valuation) AS Avg_Seed_Valuation,
  AVG(A_Valuation) AS Avg_A_Valuation,
  AVG(B_Valuation) AS Avg_B_Valuation
FROM
  startup_valuations.startup_valuations_cleaned
###
WITH CTE AS (
  SELECT
    sfc.Ivy_League,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
)
SELECT
  CASE
    WHEN Ivy_League = 1 THEN 'Ivy_League'
    WHEN Ivy_League = 0 THEN 'Not_Ivy_League'
  END AS Ivy_League_Status,
  AVG(Seed_Valuation) AS avg_seed_valuation
FROM
  CTE
GROUP BY
  1
ORDER BY
  2 DESC
###
WITH CTE AS (
  SELECT
    sfc.Standardized_Major,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
  WHERE
    sfc.Standardized_Major != 'Unknown'
)
SELECT
  CASE
    WHEN Standardized_Major IN (
      'Architecture',
      'Design',
      'Desgin',
      'Film',
      'Media',
      'Music'
    ) THEN 'Arts-Related'
    WHEN Standardized_Major IN (
      'Biology',
      'Chemistry',
      'Computer Science',
      'Mathematics',
      'Physics',
      'Electrical Engineering',
      'Engineering',
      'Mechanical Engineering',
      'Cognitive Science',
      'Operations Research',
      'Opreations Research',
      'Geology'
    ) THEN 'STEM-Related'
    WHEN Standardized_Major IN ('Business', 'Economics') THEN 'Business-Related'
    WHEN Standardized_Major IN (
      'English',
      'History',
      'International Relations',
      'Philosophy',
      'Political Science',
      'Psychology',
      'Sociology',
      'Language',
      'Public Policy',
      'Interdisciplinary Degree'
    ) THEN 'Humanities-Related'
  END AS Major_Type,
  AVG(Seed_Valuation) AS avg_seed_valuation
FROM
  CTE
GROUP BY
  1
ORDER BY
  2 DESC
###
WITH CTE AS (
  SELECT
    sfc.Standardized_University,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
  WHERE
    sfc.Standardized_University != 'Unknown'
)
SELECT
  Standardized_University,
  AVG(Seed_Valuation) AS avg_seed_valuation
FROM
  CTE
WHERE
  Standardized_University IN (
    'Stanford University',
    'Harvard University',
    'University of Pennsylvania',
    'University of California Berkeley',
    'Massachusetts Institute of Technology',
    'Princeton University',
    'Brigham Young University',
    'Dartmouth College',
    'Cornell University',
    'University of Texas Austin',
    'University of Michigan',
    'Columbia University',
    'Yale University',
    'Carnegie Mellon University',
    'University of Illinois Urbana-Champaign',
    'Brown University',
    'University of California Los Angeles',
    'New York University',
    'University of Washington',
    'Tel Aviv University'
  )
GROUP BY
  1
ORDER BY
  2 DESC
###
WITH CTE AS (
  SELECT
    CASE
      WHEN sfc.Ivy_League = 1 THEN 'Ivy_League'
      WHEN sfc.Ivy_League = 0 THEN 'Not_Ivy_League'
    END AS Ivy_League_Status,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
  WHERE
    sv.Seed_Valuation IS NOT NULL
)
SELECT
  Seed_Valuation
FROM
  CTE
WHERE
  Ivy_League_Status = 'Ivy_League'
###
WITH CTE AS (
  SELECT
    CASE
      WHEN sfc.Ivy_League = 1 THEN 'Ivy_League'
      WHEN sfc.Ivy_League = 0 THEN 'Not_Ivy_League'
    END AS Ivy_League_Status,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
  WHERE
    sv.Seed_Valuation IS NOT NULL
)
SELECT
  Seed_Valuation
FROM
  CTE
WHERE
  Ivy_League_Status = 'Not_Ivy_League'
###
SELECT
  *
FROM
  startup_valuations.startup_founder_chars
###
SELECT
  CAST(Full_Name AS STRING) AS Full_Name,
  CAST(Primary_Company AS STRING) AS Primary_Company,
  CAST(Previous_startups_ AS INT) AS Previous_startups_,
  CAST(Consulting_before_start_up AS INT) AS Consulting_before_start_up,
  CAST(Standardized_University AS STRING) AS Standardized_University,
  CAST(Standardized_Major AS STRING) AS Standardized_Major,
  CAST(Degree_Type AS STRING) AS Degree_Type,
  CAST(Standardized_Graduate_Institution AS STRING) AS Standardized_Graduate_Institution,
  CAST(Standardized_Graduate_Studies AS STRING) AS Standardized_Graduate_Studies,
  CAST(Graduate_Diploma AS STRING) AS Graduate_Diploma,
  CAST(
    Ever_served_as_TA_Teacher_Professor_Mentor_ AS INT
  ) AS Ever_served_as_TA_Teacher_Professor_Mentor_,
  CAST(Years_of_Employment AS INT) AS Years_of_Employment,
  CAST(
    Worked_as_product_manager_director_head_VP_ AS INT
  ) AS Worked_as_product_manager_director_head_VP_,
  CAST(Worked_at_Google_ AS INT) AS Worked_at_Google_,
  CAST(Worked_at_Microsoft_ AS INT) AS Worked_at_Microsoft_,
  CAST(Worked_in_Sales_ AS INT) AS Worked_in_Sales_,
  CAST(Stanford_or_Berkeley AS INT) AS Stanford_or_Berkeley,
  CAST(Ivy_League AS INT) AS Ivy_League
FROM
  (
    SELECT
      Full_Name,
      Primary_Company,
      Previous_startups_,
      Consulting_before_start_up,
      COALESCE(Standardized_University, "Unknown") AS Standardized_University,
      CASE
        WHEN Standardized_Major = 'Opreations Research' THEN 'Operations Research'
        WHEN Standardized_Major = 'Desgin' THEN 'Design'
        WHEN Standardized_Major IS NULL THEN 'Unknown'
        ELSE Standardized_Major
      END AS Standardized_Major,
      COALESCE(Degree_Type, "Unknown") AS Degree_Type,
      COALESCE(Standardized_Graduate_Institution, "Unknown") AS Standardized_Graduate_Institution,
      COALESCE(Standardized_Graduate_Studies, "Unknown") AS Standardized_Graduate_Studies,
      COALESCE(Graduate_Diploma, "Unknown") AS Graduate_Diploma,
      CASE
        WHEN Ever_served_as_TA_Teacher_Professor_Mentor_ IS NULL THEN 0
        ELSE Ever_served_as_TA_Teacher_Professor_Mentor_
      END AS Ever_served_as_TA_Teacher_Professor_Mentor_,
      Years_of_Employment,
      Worked_as_product_manager_director_head_VP_,
      Worked_at_Google_,
      CASE
        WHEN Worked_at_Microsoft_ IS NULL THEN 0
        ELSE Worked_at_Microsoft_
      END AS Worked_at_Microsoft_,
      CASE
        WHEN Worked_in_Sales_ IS NULL THEN 0
        ELSE Worked_in_Sales_
      END AS Worked_in_Sales_,
      Stanford_or_Berkeley,
      Ivy_League
    FROM
      `startup_valuations.startup_founder_chars`
  )
###
SELECT
  *
FROM
  startup_valuations.startup_valuations
###
SELECT
  Full_Name,
  Primary_Company,
  Seed_Valuation,
  A_Valuation,
  B_Valuation,
  ROUND(
    (
      ((A_Valuation / Seed_Valuation) - 1) * 100
    ),
    0
  ) AS Seed_to_A_Valuation_Percent_Increase,
  ROUND((((B_Valuation / A_Valuation) - 1) * 100), 0) AS A_Valuation_to_B_Valuation_Percent_Increase
FROM
  (
    SELECT
      CAST(Full_Name AS STRING) AS Full_Name,
      CAST(Primary_Company AS STRING) AS Primary_Company,
      CAST(
        REPLACE(
          SUBSTRING(Seed_Valuation, 2, LENGTH(Seed_Valuation) - 5),
          ",",
          ""
        ) AS INT
      ) AS Seed_Valuation,
      CAST(A_Valuation AS INT) AS A_Valuation,
      CAST(B_Valuation AS INT) AS B_Valuation,
    FROM
      startup_valuations.startup_valuations
    WHERE
      Seed_Valuation IS NOT NULL
      AND Seed_Valuation != '0'
      AND Seed_Valuation != 'Nan'
      AND A_Valuation != 0
      AND B_Valuation != 0
  )
###
WITH CTE AS (
  SELECT
    CASE
      WHEN sfc.Standardized_Major IN (
        'Architecture',
        'Design',
        'Desgin',
        'Film',
        'Media',
        'Music'
      ) THEN 'Arts-Related'
      WHEN sfc.Standardized_Major IN (
        'Biology',
        'Chemistry',
        'Computer Science',
        'Mathematics',
        'Physics',
        'Electrical Engineering',
        'Engineering',
        'Mechanical Engineering',
        'Cognitive Science',
        'Operations Research',
        'Opreations Research',
        'Geology'
      ) THEN 'STEM-Related'
      WHEN sfc.Standardized_Major IN ('Business', 'Economics') THEN 'Business-Related'
      WHEN sfc.Standardized_Major IN (
        'English',
        'History',
        'International Relations',
        'Philosophy',
        'Political Science',
        'Psychology',
        'Sociology',
        'Language',
        'Public Policy',
        'Interdisciplinary Degree'
      ) THEN 'Humanities-Related'
    END AS Major_Type,
    sv.Seed_Valuation
  FROM
    startup_valuations.startup_founder_chars_cleaned AS sfc
    LEFT JOIN startup_valuations.startup_valuations_cleaned AS sv ON sfc.Full_Name = sv.Full_Name
  WHERE
    sv.Seed_Valuation IS NOT NULL
)
SELECT
  Seed_Valuation
FROM
  CTE
WHERE
  Major_Type = 'STEM-Related'
###
