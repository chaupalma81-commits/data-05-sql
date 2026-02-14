-- sql/duckdb/case_civic_event_query_attendance_count.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Answer a simple structural question:
-- "How many attendees do we have in our civic event system?"
--
-- This query does NOT involve the sale table.
-- It operates only on the independent/parent table.
--
-- WHY:
-- - Establishes the size of the system
-- - Provides context for other KPIs
-- - Helps answer questions like:
--   "Are we growing by adding events, or just increasing attendance at existing events?"
--
SELECT
  COUNT(*) AS total_attendees
FROM attendance;
