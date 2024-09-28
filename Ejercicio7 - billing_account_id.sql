SELECT
  calls_ivr_id,
  MAX(CASE WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' THEN billing_account_id ELSE NULL END) AS billing_account_id
FROM
  `keepcoding.ivr_detail`
WHERE
  step_name = 'CUSTOMERINFOBYPHONE.TX'  -- Filtramos solo los pasos donde se identifica el billing account
GROUP BY
  calls_ivr_id;