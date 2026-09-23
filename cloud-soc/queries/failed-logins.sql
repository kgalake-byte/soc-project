-- Failed Login Detection (Brute Force)
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  metadata->'payload'->>'message' AS full_message
FROM logs 
WHERE service = 'Windows DC Logs'
  AND metadata->'payload'->>'event_id' = '4625'
ORDER BY time DESC;
