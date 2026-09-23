-- Process Execution with Command Lines
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  SUBSTRING(metadata->'payload'->>'message' FROM 'New Process Name:\s+([^\r\n]+)') AS process,
  SUBSTRING(metadata->'payload'->>'message' FROM 'Process Command Line:\s+([^\r\n]+)') AS command
FROM logs 
WHERE service = 'Windows DC Logs'
  AND metadata->'payload'->>'event_id' = '4688'
  AND metadata->'payload'->>'message' LIKE '%Process Command Line%'
ORDER BY time DESC
LIMIT 50;
