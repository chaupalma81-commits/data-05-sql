-- sql/duckdb/chau_civic_event_query_attendance_by_event.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Summarize overall attendance activity across ALL events.
--
-- This query answers:
-- - "What is our total attendance?"
-- - "What is the average attendance amount?"
--
-- WHY:
-- - Establishes system-wide performance
-- - Provides a baseline before breaking results down by event
-- - Helps answer:
--   "Is overall performance up or down?"

SELECT
  COUNT(*) AS attendance_count,
  ROUND(SUM(contribution), 2) AS total_attendance,
  ROUND(AVG(contribution), 2) AS avg_attendance_amount
FROM attendance;
