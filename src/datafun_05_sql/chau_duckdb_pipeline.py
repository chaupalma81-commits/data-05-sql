import pathlib

import duckdb

# Get project root (go up two levels from this script)
project_root = pathlib.Path(__file__).resolve().parents[2]

# Build path to CSV
csv_path = (project_root / "data" / "civic_event" / "attendance.csv").as_posix()

# Connect to DuckDB
conn = duckdb.connect("civic_events.duckdb")

# Create table from CSV
conn.execute(f"""
    CREATE TABLE attendance AS
    SELECT *
    FROM read_csv_auto('{csv_path}');
""")

print("Table created successfully!")

conn.close()
