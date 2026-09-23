# Cloud SOC — Attack Evidence

## Full Command Chain Captured

```sql
-- Query to extract all commands
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  SUBSTRING(metadata->'payload'->>'message' FROM 'Process Command Line:\s+([^\r\n]+)') AS command
FROM logs 
WHERE service = 'Windows DC Logs'
  AND metadata->'payload'->>'event_id' = '4688'
  AND metadata->'payload'->>'message' LIKE '%Process Command Line%'
ORDER BY time DESC;
Results
Time	Command
15:45:37.081	net.exe user attack_evidence P@ssw0rd123! /add
15:45:35.638	net.exe localgroup Administrators attack_evidence /add
15:45:34.824	whoami.exe /priv
15:45:33.802	net.exe user
15:45:33.063	ipconfig.exe /all
15:45:32.784	NETSTAT.EXE -an
15:45:32.532	net.exe user attack_evidence /delete
