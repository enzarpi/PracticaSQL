CREATE TABLE `keepcoding.ivr_summary` AS
WITH analytic_data AS (
  SELECT
    calls_ivr_id,
    calls_phone_number,
    calls_ivr_result,
    calls_vdn_label,
    calls_start_date,
    calls_end_date,
    calls_total_duration,
    calls_customer_segment,
    calls_ivr_language,
    calls_steps_module,
    calls_module_aggregation,
    document_type,
    document_identification,
    customer_phone,
    billing_account_id,
    module_name,

    -- Flag para masiva_lg
    CASE WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0 END AS masiva_lg,

    -- Flag para info_by_phone_lg
    CASE WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK' THEN 1 ELSE 0 END AS info_by_phone_lg,

    -- Flag para info_by_dni_lg
    CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK' THEN 1 ELSE 0 END AS info_by_dni_lg,

    -- Flag para repeated_phone_24H
    CASE 
      WHEN LAG(calls_start_date, 1) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date) IS NOT NULL 
           AND TIMESTAMP_DIFF(calls_start_date, LAG(calls_start_date, 1) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date), HOUR) <= 24 
      THEN 1 ELSE 0 
    END AS repeated_phone_24H,

    -- Flag para cause_recall_phone_24H
    CASE 
      WHEN LEAD(calls_start_date, 1) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date) IS NOT NULL 
           AND TIMESTAMP_DIFF(LEAD(calls_start_date, 1) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date), calls_start_date, HOUR) <= 24 
      THEN 1 ELSE 0 
    END AS cause_recall_phone_24H

  FROM
    `keepcoding.ivr_detail`
)

SELECT
  -- Identificadores principales
  calls_ivr_id AS ivr_id,
  calls_phone_number AS phone_number,
  calls_ivr_result AS ivr_result,
  
  -- Agregación de VDN
  CASE
    WHEN calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
    WHEN calls_vdn_label LIKE 'TECH%' THEN 'TECH'
    WHEN calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
    ELSE 'RESTO'
  END AS vdn_aggregation,

  -- Información temporal y duración
  calls_start_date AS start_date,
  calls_end_date AS end_date,
  calls_total_duration AS total_duration,

  -- Segmento e idioma del cliente
  calls_customer_segment AS customer_segment,
  calls_ivr_language AS ivr_language,

  -- Módulos
  calls_steps_module AS steps_module,
  calls_module_aggregation AS module_aggregation,

  -- Documentación del cliente
  document_type,
  document_identification,

  -- Información adicional del cliente
  customer_phone,
  billing_account_id,

  -- Indicadores de masiva y flags
  MAX(masiva_lg) AS masiva_lg,
  MAX(info_by_phone_lg) AS info_by_phone_lg,
  MAX(info_by_dni_lg) AS info_by_dni_lg,
  MAX(repeated_phone_24H) AS repeated_phone_24H,
  MAX(cause_recall_phone_24H) AS cause_recall_phone_24H

FROM
  analytic_data

GROUP BY
  calls_ivr_id,
  calls_phone_number,
  calls_ivr_result,
  calls_vdn_label,
  calls_start_date,
  calls_end_date,
  calls_total_duration,
  calls_customer_segment,
  calls_ivr_language,
  calls_steps_module,
  calls_module_aggregation,
  document_type,
  document_identification,
  customer_phone,
  billing_account_id;

