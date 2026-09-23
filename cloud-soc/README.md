cat > ~/soc-project/cloud-soc/README.md << 'EOF'
# Cloud SOC — LogTide on AWS

## Overview
A cloud-native SOC using LogTide deployed on AWS EC2, ingesting real Windows Event Logs from a Domain Controller via webhook.

## Architecture
[Windows DC] ──webhook──▶ [LogTide on AWS EC2]
192.168.1.5 51.20.18.162
│
├── Frontend (3000)
├── Backend (8080)
├── Worker
└── PostgreSQL (TimescaleDB)

text

## Components
| Component | Technology | Purpose |
|-----------|-----------|---------|
| **SIEM** | LogTide | Log ingestion, storage, search |
| **Database** | PostgreSQL + TimescaleDB | Time-series log storage |
| **Instance** | AWS EC2 t3.micro | Compute |
| **Log Source** | Windows DC | Event log forwarding |
| **Transport** | Webhook | HTTPS from DC to EC2 |

## Setup Steps

### 1. Deploy EC2 Instance
```bash
# Launch Ubuntu 24.04 instance
# Security Group: 22, 3000, 8080 (from authorized IPs)
aws ec2 run-instances \
  --image-id ami-xxxxx \
  --instance-type t3.micro \
  --key-name wazuh-key
2. Install Docker & Deploy LogTide
bash
# On EC2
sudo apt update && sudo apt install docker.io docker-compose-v2 -y
sudo usermod -aG docker ubuntu

# Clone LogTide configuration
mkdir ~/logtide && cd ~/logtide
curl -O https://raw.githubusercontent.com/logtide-dev/logtide/main/docker/docker-compose.simple.yml
curl -O https://raw.githubusercontent.com/logtide-dev/logtide/main/docker/.env.example
mv .env.example .env

# Start LogTide
docker compose -f docker-compose.simple.yml up -d
3. Configure Webhook Receiver
Log in to LogTide dashboard

Create project: SOC-Lab

Create Webhook Receiver: Windows DC Logs

Type: Generic JSON

Copy webhook URL

4. Configure Windows DC Log Forwarding
PowerShell script sends Security events to LogTide webhook:

4624 - Successful logon

4625 - Failed logon

4672 - Special privileges

4688 - Process creation

4720 - Account created

4726 - Account deleted

4732 - Added to group

5. SSH Tunnel for Dashboard Access
bash
ssh -i ~/wazuh-key.pem \
    -L 3000:localhost:3000 \
    -L 8080:localhost:8080 \
    ubuntu@51.20.18.162
Detection Queries
All DC Events
sql
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  metadata->'payload'->>'event_id' AS event_id,
  metadata->'payload'->>'source' AS source
FROM logs 
WHERE service = 'Windows DC Logs'
ORDER BY time DESC
LIMIT 100;
Failed Logins (Brute Force)
sql
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  metadata->'payload'->>'message'
FROM logs 
WHERE service = 'Windows DC Logs'
  AND metadata->'payload'->>'event_id' = '4625'
ORDER BY time DESC;
Process Executions with Commands
sql
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  SUBSTRING(metadata->'payload'->>'message' FROM 'Process Command Line:\s+([^\r\n]+)') AS command
FROM logs 
WHERE service = 'Windows DC Logs'
  AND metadata->'payload'->>'event_id' = '4688'
  AND metadata->'payload'->>'message' LIKE '%Process Command Line%'
ORDER BY time DESC;
Account Creations
sql
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  SUBSTRING(metadata->'payload'->>'message' FROM 'New Account:\s*\r?\n\s*Security ID:\s+\S+\r?\n\s*Account Name:\s+(\S+)') AS new_account
FROM logs 
WHERE service = 'Windows DC Logs'
  AND metadata->'payload'->>'event_id' = '4720'
ORDER BY time DESC;
Attack Simulation Result
Full Attack Chain Captured
Time (SAST)	Event ID	Command
15:45:37	4688	net.exe user attack_evidence P@ssw0rd123! /add
15:45:36	4688	net1 user attack_evidence P@ssw0rd123! /add
15:45:35	4688	net.exe localgroup Administrators attack_evidence /add
15:45:34	4688	whoami.exe /priv
15:45:33	4688	net.exe user
15:45:33	4688	ipconfig.exe /all
15:45:32	4688	NETSTAT.EXE -an
15:45:32	4688	net.exe user attack_evidence /delete
Total events captured: 325+
Attack detection time: < 1 second
Evidence quality: Full command lines with timestamps

Detection Rules
Sigma Rule: Backdoor Account Creation
yaml
title: Backdoor Account Creation
id: 9a1b2c3d-4e5f-6789-0abc-def123456789
status: experimental
description: Detects creation of new local user accounts
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4720
  condition: selection
level: high
tags:
  - attack.persistence
  - attack.t1136.001
Sigma Rule: Privilege Escalation
yaml
title: Account Added to Administrators Group
id: 9a1b2c3d-4e5f-6789-0abc-def123456790
status: experimental
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4732
  condition: selection
level: critical
tags:
  - attack.privilege_escalation
  - attack.t1098
Cost Management
Estimated AWS Costs
Resource	Monthly Cost
EC2 t3.micro	~$8 (or free tier)
EBS 20GB	~$2
Data transfer	~$1
Total	~$11/month
Cost Saving
Stop instance when not in use

Use ec2-control.sh script to start/stop

Only pay for running hours

Repository Structure
text
cloud-soc/
├── README.md
├── queries/
│   ├── all-events.sql
│   ├── failed-logins.sql
│   ├── process-executions.sql
│   └── account-creations.sql
├── reports/
│   └── incident-report.md
└── screenshots/
    ├── logtide-dashboard.png
    └── attack-evidence.png

## 📸 Screenshots

All screenshots are available in the [`screenshots/`](screenshots/) directory.

| Screenshot | Description |
|-----------|-------------|
| [LogTide Dashboard](screenshots/logtide-dashboard.png) | 350+ logs ingested |
| [Brute Force](screenshots/logtide-brute-force.png) | Event 4625 - Failed logins |
| [Backdoor](screenshots/logtide-backdoor.png) | Event 4720 - Account creation |
| [Attack Timeline](screenshots/attack-timeline.png) | Chronological attack sequence |
| [Attack Commands](screenshots/attack-command.png) | Exact attacker commands |
| [Event Summary](screenshots/event-summary.png) | Event breakdown |
