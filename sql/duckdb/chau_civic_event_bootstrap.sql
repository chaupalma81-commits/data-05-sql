-- ============================================================
-- PURPOSE
-- ============================================================
-- Creates civic_event tables and loads data from CSV files (DuckDB).
--
-- ASSUMPTION:
-- We always run all commands from the project root directory.
--
-- EXPECTED PROJECT PATHS (relative to repo root):
--   SQL:  sql/duckdb/case_civic_event_bootstrap.sql
--   CSV:  data/civic_event/civic_event.csv
--   CSV:  data/civic_event/attendance.csv
--   DB:   artifacts/duckdb/civic_event.duckdb
--
-- ============================================================
-- TOPIC DOMAINS + 1:M RELATIONSHIPS
-- ============================================================
-- OUR DOMAIN: CIVIC EVENT
-- - civic_event (1): independent/parent table
-- - attendance  (M): dependent/child table
--
-- REQ: Tables must be created in order to satisfy foreign key constraints.
-- REQ: Data must be loaded in order to satisfy foreign key constraints.
--
-- ============================================================
-- EXECUTION: ATOMIC BOOTSTRAP (ALL OR NOTHING)
-- ============================================================
BEGIN TRANSACTION;

-- ============================================================
-- STEP 1: CREATE TABLES (PARENT FIRST, THEN CHILD)
-- ============================================================
CREATE TABLE IF NOT EXISTS civic_event (
  civic_event_id TEXT PRIMARY KEY,
  event_name TEXT NOT NULL,
  location TEXT NOT NULL,
  organizer TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS attendance (
  attendance_id TEXT PRIMARY KEY,
  civic_event_id TEXT NOT NULL,
  attendee_type TEXT NOT NULL,
  checked_in INTEGER NOT NULL,
  contribution DOUBLE NOT NULL,
  attend_date TEXT NOT NULL
);

-- ============================================================
-- STEP 2: LOAD DATA (PARENT FIRST, THEN CHILD)
-- ============================================================
COPY civic_event
FROM 'data/civic_event/civic_event.csv'
(HEADER, DELIMITER ',', QUOTE '"', ESCAPE '"');

COPY attendance
FROM 'data/civic_event/attendance.csv'
(HEADER, DELIMITER ',', QUOTE '"', ESCAPE '"');

COMMIT;
