SELECT
  calls_ivr_id,
  MAX(CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' THEN document_type ELSE NULL END) AS document_type,
  MAX(CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' THEN document_identification ELSE NULL END) AS document_identification
FROM
  `keepcoding.ivr_detail`
WHERE
  step_name = 'CUSTOMERINFOBYDNI.TX'  -- Filtramos solo los pasos que capturan el documento
GROUP BY
  calls_ivr_id;