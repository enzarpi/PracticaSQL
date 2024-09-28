SELECT
  calls_ivr_id,
  step_result,
  MAX(CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK' THEN 1 ELSE 0 END) AS info_by_dni_lg,
  MAX(document_identification) AS document_identification  
FROM
  `keepcoding.ivr_detail`
WHERE
  step_name = 'CUSTOMERINFOBYDNI.TX'  -- Filtra solo las filas con el step específico
GROUP BY
  calls_ivr_id, step_result;