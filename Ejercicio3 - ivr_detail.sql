CREATE OR REPLACE TABLE `keepcoding.ivr_detail` AS
SELECT
  -- Campos de ivr_calls
  calls.ivr_id AS calls_ivr_id,
  calls.phone_number AS calls_phone_number,
  calls.ivr_result AS calls_ivr_result,
  calls.vdn_label AS calls_vdn_label,
  calls.start_date AS calls_start_date,
  FORMAT_DATE('%Y%m%d', DATE(calls.start_date)) AS calls_start_date_id,  -- Formato yyyymmdd
  calls.end_date AS calls_end_date,
  FORMAT_DATE('%Y%m%d', DATE(calls.end_date)) AS calls_end_date_id,  -- Formato yyyymmdd
  calls.total_duration AS calls_total_duration,
  calls.customer_segment AS calls_customer_segment,
  calls.ivr_language AS calls_ivr_language,
  calls.steps_module AS calls_steps_module,
  calls.module_aggregation AS calls_module_aggregation,

  -- Campos de ivr_modules
  modules.module_sequece AS module_sequence,  
  modules.module_name AS module_name,
  modules.module_duration AS module_duration,
  modules.module_result AS module_result,

  -- Campos de ivr_steps
  steps.step_sequence AS step_sequence,
  steps.step_name AS step_name,
  steps.step_result AS step_result,
  steps.step_description_error AS step_description_error,
  steps.document_type AS document_type,
  steps.document_identification AS document_identification,
  steps.customer_phone AS customer_phone,
  steps.billing_account_id AS billing_account_id

FROM
  keepcoding.ivr_calls AS calls
  -- Join con ivr_modules basado en ivr_id
  LEFT JOIN keepcoding.ivr_modules AS modules
    ON calls.ivr_id = modules.ivr_id

  -- Join con ivr_steps basado en ivr_id y module_sequece
  LEFT JOIN keepcoding.ivr_steps AS steps
    ON modules.ivr_id = steps.ivr_id
    AND modules.module_sequece = steps.module_sequece;


