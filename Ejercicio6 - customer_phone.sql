SELECT
  calls_ivr_id,
  MAX(CASE WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' THEN customer_phone ELSE NULL END) AS customer_phone
FROM
  `keepcoding.ivr_detail`
WHERE
  step_name = 'CUSTOMERINFOBYPHONE.TX'  -- Filtramos solo los pasos donde se identifica el número de teléfono
GROUP BY
  calls_ivr_id;