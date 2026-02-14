-- sql/duckdb/case_civic_event_kpi_query_attendance.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Calculate a Key Performance Indicator (KPI) for the civic_event domain using DuckDB SQL.
--
-- KPI DRIVES THE WORK:
-- In analytics, we do not start with "write a query."
-- We start with a KPI that supports an actionable decision.
--
-- ACTIONABLE OUTCOME (EXAMPLE):
-- We want to identify which events are generating the most attendance so we can:
-- - allocate staffing during high-performing periods,
-- - increase inventory for top categories,
-- - investigate why low-performing events are underperforming,
-- - target promotions where they will have the biggest impact.
--
-- In this example, our KPI is event attendance (total number of attendees) by event.
--
-- ANALYST RESPONSIBILITY:
-- Analysts are responsible for determining HOW to get the information
-- that informs the KPI and supports action.
-- That means:
-- - identifying the needed tables,
-- - joining them correctly,
-- - selecting the right measures,
-- - aggregating at the correct level (event),
-- - and presenting results in a way that supports decision-making.
--
-- ASSUMPTION:
-- We always run all commands from the project root directory.
--
-- EXPECTED PROJECT PATHS (relative to repo root):
--   SQL:  sql/duckdb/case_civic_event_kpi_query_attendance.sql
--   DB:   artifacts/duckdb/civic_event.duckdb
--
--
-- ============================================================
-- TOPIC DOMAINS + 1:M RELATIONSHIPS
-- ============================================================
-- OUR DOMAIN: CIVIC EVENT
-- Two tables in a 1-to-many relationship (1:M):
-- - civic_event (1): independent/parent table
-- - attendance  (M): dependent/child table
--
-- HOW THIS RELATES TO OUR KPI:
-- - The civic_event table tells us "which event" (civic_event_id, event_name, city, region).
-- - The attendance table contains the measurable activity (attendee_name, attendee_email).
-- - To compute attendance by event, we must:
--   1) connect each attendance record to its event (JOIN on civic_event_id),
--   2) count attendees at each event level (GROUP BY civic_event_id).
--
--
-- ============================================================
-- KPI DEFINITION
-- ============================================================
-- KPI NAME: Total Attendance by Event
--
-- KPI QUESTION:
-- "How many attendees attended each event?"
--
-- MEASURE:
-- - attendance = COUNT(attendance.attendee_name)
--
-- GRAIN (LEVEL OF DETAIL):
-- - one row per event
--
-- OUTPUT (WHAT DECISION-MAKERS NEED):
-- - event identifier and name
-- - total attendance
-- - optionally: number of sales and average sale amount
--
--
-- ============================================================
-- EXECUTION: GET THE INFORMATION THAT INFORMS THE KPI
-- ============================================================
-- Strategy:
-- - JOIN civic_event (1) to attendance (M)
-- - GROUP BY civic_event_id
-- - COUNT attendees to compute attendance
-- - ORDER results so we can quickly see top events
--
SELECT
  e.civic_event_id,
  e.event_name,
  e.location,
  e.organizer,
  COUNT(a.attend_date) AS total_attendance
FROM civic_event AS e
JOIN attendance AS a
  ON a.civic_event_id = e.civic_event_id
GROUP BY
  e.civic_event_id,
  e.event_name,
  e.location,
  e.organizer
ORDER BY total_attendance DESC;
