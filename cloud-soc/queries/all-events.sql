-- All Windows DC Events in LogTide
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  metadata->'payload'->>'event_id' AS event_id,
  metadata->'payload'->>'source' AS source,
  LEFT(metadata->'payload'->>'message', 200) AS message_preview
FROM logs 
WHERE service = 'Windows DC Logs'
ORDER BY time DESC
LIMIT 100;
