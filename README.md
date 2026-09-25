# 🛡️ SOC Project: Windows DC Attack Detection (Local + Cloud)

## 📋 Project Overview
A comprehensive Security Operations Center (SOC) project simulating real-world attacks against a Windows Domain Controller with detection using both a **local Splunk SIEM** and a **cloud LogTide SIEM on AWS**.

## 🏗️ Architectures

### Local SOC
[Kali Attacker] → [FreeBSD Firewall] → [Windows DC]
↓ ↓ ↓
[Suricata] [Syslog] [Windows Event Logs]
↓ ↓ ↓
└──────────→ [Splunk SIEM] ←───────┘

text

### Cloud SOC
[Windows DC] ──webhook──▶ [LogTide on AWS EC2]
192.168.1.5 51.20.18.162
│
├── Frontend (3000)
├── Backend (8080)
├── Worker
└── PostgreSQL (TimescaleDB)

text

## 🛠️ Technologies Used

| Layer | Local | Cloud |
|-------|-------|-------|
| **SIEM** | Splunk Enterprise | LogTide (AWS EC2) |
| **IDS/IPS** | Suricata | — |
| **OS** | FreeBSD, Windows Server | Ubuntu 24.04 (AWS) |
| **Log Transport** | Syslog / Forwarder | HTTPS Webhook |
| **Database** | Splunk Indexer | PostgreSQL + TimescaleDB |

## 📁 Repository Structure
soc-project/
├── README.md
├── cloud-soc/ ← Cloud SOC (LogTide on AWS)
│ ├── README.md
│ ├── incident-report.md
│ ├── attack-evidence.md
│ ├── queries/
│ └── reports/
├── cloud-attack-logs/ ← Cloud attack logs
├── docs/ ← Setup guides
├── scripts/ ← Attack simulation scripts
├── screenshots/ ← Detection screenshots
├── dashboards/ ← Splunk dashboards
├── logs/ ← Sample logs
└── archive/ ← Old documentation

text

## 🚀 Attack Simulation

### Attack Chain (Captured in Cloud SIEM)
1. **Reconnaissance** — Nmap scanning
2. **Initial Access** — WinRM login (Event 4624)
3. **Brute Force** — Failed logins (Event 4625)
4. **Persistence** — Backdoor account creation (Event 4720)
5. **Privilege Escalation** — Added to Administrators (Event 4732)
6. **Reconnaissance** — whoami, net user, ipconfig, netstat
7. **Cleanup** — Account deletion (Event 4726)

## 📊 Detection Evidence

### Events Captured in Cloud SIEM
| Event ID | Count | Description |
|----------|-------|-------------|
| 4624 | 105+ | Successful logons |
| 4625 | 6+ | Failed logins |
| 4672 | 105+ | Privilege use |
| 4688 | 100+ | Process creation |
| 4720 | 3+ | Account creation |
| 4726 | 3+ | Account deletion |
| 4732 | 3+ | Admin group additions |

### Full Attack Commands Extracted
net.exe user attack_evidence P@ssw0rd123! /add
net.exe localgroup Administrators attack_evidence /add
whoami.exe /priv
net.exe user
ipconfig.exe /all
NETSTAT.EXE -an
net.exe user attack_evidence /delete

text

## 🎯 MITRE ATT&CK Coverage

| Tactic | Technique | Detection |
|--------|-----------|-----------|
| Credential Access | T1110 - Brute Force | Event 4625 |
| Persistence | T1136 - Create Account | Event 4720 |
| Privilege Escalation | T1098 - Account Manipulation | Event 4732 |
| Discovery | T1033 - System Owner Discovery | Event 4688 |
| Discovery | T1087 - Account Discovery | Event 4688 |
| Discovery | T1016 - Network Config Discovery | Event 4688 |
| Defense Evasion | T1070 - Indicator Removal | Event 4726 |

## 📚 Documentation
- [Cloud SOC Guide](cloud-soc/README.md)
- [Incident Report](cloud-soc/incident-report.md)
- [Attack Evidence](cloud-soc/attack-evidence.md)
- [Setup Guide](docs/setup-guide.md)

## 🎓 Key Skills Demonstrated
- SIEM deployment (Splunk, LogTide)
- Cloud infrastructure (AWS EC2, Security Groups)
- Log ingestion pipelines (syslog, webhook)
- Threat detection and analysis
- Incident response and documentation
- MITRE ATT&CK framework application
- Sigma detection rules
- Database querying (PostgreSQL, SQL)

## 📄 License
MIT License

## 👤 Author
Kgalake Mabotja

## 📄 CV

The latest CV is available in the [`cv/`](cv/) directory:
- [HTML version](cv/Kgalake-Mabotja-SOC-CV.html) (editable)
- [PDF version](cv/Kgalake-Mabotja-SOC-CV.pdf) (for applications)
