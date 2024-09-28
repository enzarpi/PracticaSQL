SELECT
  calls_ivr_id,
  calls_phone_number,
  calls_start_date,
  
  -- Flag para indicar si hubo una llamada en las 24 horas anteriores
  CASE 
    WHEN LAG(calls_start_date, 1) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date) IS NOT NULL 
         AND TIMESTAMP_DIFF(calls_start_date, LAG(calls_start_date, 1) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date), HOUR) <= 24 
    THEN 1 ELSE 0 
  END AS repeated_phone_24H,
  
  -- Flag para indicar si hubo una llamada en las 24 horas siguientes
  CASE 
    WHEN LEAD(calls_start_date, 1) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date) IS NOT NULL 
         AND TIMESTAMP_DIFF(LEAD(calls_start_date, 1) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date), calls_start_date, HOUR) <= 24 
    THEN 1 ELSE 0 
  END AS cause_recall_phone_24H
  
FROM
  `keepcoding.ivr_detail`;
