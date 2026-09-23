-- Account Creation Detection (Backdoor)
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  SUBSTRING(metadata->'payload'->>'message' FROM 'New Account:\s*\r?\n\s*Security ID:\s+\S+\r?\n\s*Account Name:\s+(\S+)') AS new_account,
  SUBSTRING(metadata->'payload'->>'message' FROM 'Account Name:\s+(\S+)') AS created_by
FROM logs 
WHERE service = 'Windows DC Logs'
  AND metadata->'payload'->>'event_id' = '4720'
ORDER BY time DESC;
