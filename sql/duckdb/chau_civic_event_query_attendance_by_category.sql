-- sql/duckdb/chau_civic_event_query_attendance_by_category.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Break overall attendance performance down by event category.
--
-- This query answers:
-- "How many attendees and how much total attendance do we have by category?"
--
-- WHY:
-- - Overall totals hide important differences.
-- - Grouping lets us compare parts of the system.
-- - This often reveals where action is needed:
--   * Which categories drive attendance?
--   * Which categories underperform?
--
-- IMPORTANT:
-- This query uses GROUP BY but does NOT join tables yet.
-- We are still working only with the dependent/child table (attendance).

SELECT
  civic_event_id,
  COUNT(*) AS attendance_count,
  ROUND(SUM(contribution), 2) AS total_attendance,
  ROUND(AVG(contribution), 2) AS avg_attendance_amount
FROM attendance
GROUP BY civic_event_id
ORDER BY total_attendance DESC;
