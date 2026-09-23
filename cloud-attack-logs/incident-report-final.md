# Cloud SOC Incident Report — FINAL

## Incident Overview
- **Incident ID:** IR-CLOUD-2026-001
- **Date:** 2026-09-23
- **Time:** 15:45:32 - 15:45:38 SAST
- **Duration:** 6 seconds
- **Severity:** HIGH
- **Status:** CONTAINED
- **Analyst:** Kgalake Mabotja

## Environment
- **SIEM:** LogTide on AWS EC2 (eu-north-1)
- **Log Source:** DC01.cyberlab.local (Windows Domain Controller)
- **Attacker:** Kali Linux (192.168.1.10)
- **Target IP:** 192.168.1.5

## Complete Attack Chain — Extracted From Logs

### Backdoor Creation
15:45:36.821 net1 user attack_evidence P@ssw0rd123! /add
15:45:37.081 "C:\WINDOWS\system32\net.exe" user attack_evidence P@ssw0rd123! /add

text

### Privilege Escalation
15:45:35.357 net1 localgroup Administrators attack_evidence /add
15:45:35.638 "C:\WINDOWS\system32\net.exe" localgroup Administrators attack_evidence /add

text

### Privilege Enumeration
15:45:34.824 "C:\WINDOWS\system32\whoami.exe" /priv

text

### User Enumeration
15:45:33.507 net1 user
15:45:33.802 "C:\WINDOWS\system32\net.exe" user

text

### Network Reconnaissance
15:45:32.784 "C:\WINDOWS\system32\NETSTAT.EXE" -an
15:45:33.063 "C:\WINDOWS\system32\ipconfig.exe" /all

text

### Cleanup
15:45:32.272 net1 user attack_evidence /delete
15:45:32.532 "C:\WINDOWS\system32\net.exe" user attack_evidence /delete

text

## MITRE ATT&CK Mapping

| Tactic | Technique | Command Evidence |
|--------|-----------|------------------|
| **Persistence** | T1136.001 - Local Account | `net user attack_evidence /add` |
| **Privilege Escalation** | T1098 - Account Manipulation | `net localgroup Administrators /add` |
| **Discovery** | T1033 - System Owner Discovery | `whoami /priv` |
| **Discovery** | T1087 - Account Discovery | `net user` |
| **Discovery** | T1016 - System Network Config | `ipconfig /all` |
| **Discovery** | T1049 - System Network Connections | `netstat -an` |
| **Defense Evasion** | T1070 - Indicator Removal | `net user attack_evidence /delete` |

## Indicators of Compromise

| Type | Value |
|------|-------|
| Attacker IP | 192.168.1.10 |
| Target IP | 192.168.1.5 |
| Target Host | DC01.cyberlab.local |
| Backdoor Accounts | attack_evidence, soc_backdoor, soc_backdoor2, backdoor_test |
| Tools | net.exe, net1.exe, whoami.exe, ipconfig.exe, netstat.exe |
| Attack Pattern | Account creation → Privilege escalation → Recon → Cleanup |

## Detection Evidence

### LogTide Database Query
```sql
SELECT 
  time AT TIME ZONE 'Africa/Johannesburg' AS time_sast,
  SUBSTRING(metadata->'payload'->>'message' FROM 'Process Command Line:\s+([^\r\n]+)') AS command
FROM logs 
WHERE service = 'Windows DC Logs'
  AND metadata->'payload'->>'event_id' = '4688'
  AND metadata->'payload'->>'message' LIKE '%Process Command Line%'
ORDER BY time DESC;
Total Events Captured
Event ID	Count	Description
4688	100+	Process creation (with full command lines)
4625	6	Failed logins (brute force)
4720	3+	Account creations
4726	3+	Account deletions
4732	3+	Admin group additions
4624	105+	Successful logons
4672	105+	Privilege use
Response Actions
Immediate (Completed)
✅ Attack detected via SIEM

✅ Full attack chain reconstructed

✅ Backdoor accounts identified

✅ Command lines extracted

✅ IOCs documented

Containment (Recommended)
⏳ Reset Administrator password

⏳ Block attacker IP on firewall

⏳ Enable MFA for admin accounts

⏳ Review all privileged accounts

Detection Improvements
✅ Create Sigma rule for account creation

✅ Create Sigma rule for privilege escalation

✅ Create Sigma rule for suspicious process names

✅ Configure LogTide alerts

Recommendations
Sigma Rule 1: Backdoor Account Creation
yaml
title: Suspicious Account Creation
detection:
  selection:
    EventID: 4720
  condition: selection
Sigma Rule 2: Privilege Escalation
yaml
title: Account Added to Administrators
detection:
  selection:
    EventID: 4732
  condition: selection
Sigma Rule 3: Suspicious Process Execution
yaml
title: Suspicious net.exe Usage
detection:
  selection:
    EventID: 4688
    CommandLine|contains:
      - 'user /add'
      - 'localgroup Administrators'
  condition: selection
Lessons Learned
Command-line logging is critical — Process Command Line in Event 4688 gave us the exact attack commands

Cloud SIEM works — LogTide captured every step of the attack

Full message payloads matter — 500-char truncation would have missed the key evidence

Timing reveals intent — 6 seconds for the whole chain = automated attack

Cleanup attempts are detectable — Event 4726 revealed the attacker's cover-up

Conclusion
A complete SOC investigation was performed on a simulated attack against a Windows Domain Controller. The attack chain was fully reconstructed from SIEM logs, including:

Exact commands executed

Timestamps of each action

User account used

Attack technique mapping

This demonstrates the value of centralized logging, proper event auditing, and SIEM analysis in detecting and investigating security incidents.

Status: INCIDENT CLOSED

Sign-off
Analyst: Kgalake Mabotja
Date: 2026-09-23
SIEM: LogTide on AWS
