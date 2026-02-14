-- sql/duckdb/case_civic_event_query_civic_event_count.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Answer a basic activity question:
-- "How many civic events have occurred?"
--
-- This query operates on the independent/parent table.
--
-- WHY:
-- - Volume and revenue are different signals
-- - A store may have many small sales or few large ones
-- - Analysts often start by understanding event counts
--   before analyzing monetary impact

SELECT
  COUNT(*) AS event_count
FROM civic_event;
