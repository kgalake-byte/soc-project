# 🛡️ SOC Project: Windows Domain Controller Attack Detection

## 📋 Project Overview
A comprehensive Security Operations Center (SOC) project simulating real-world attacks against a Windows Domain Controller with detection using Suricata IDS/IPS and monitoring using Splunk SIEM.

## 🏗️ Architecture
[Kali Attacker] → [FreeBSD Firewall] → [Windows DC]
↓ ↓ ↓
[Suricata] [Syslog] [Windows Event Logs]
↓ ↓ ↓
└──────────→ [Splunk SIEM] ←───────┘
↓
[Splunk Dashboard]


## 🛠️ Technologies Used
- **SIEM:** Splunk Enterprise
- **IDS/IPS:** Suricata
- **OS:** FreeBSD (Firewall), Windows Server (DC), Kali (Attacker)
- **Log Forwarding:** Splunk Universal Forwarder

## 📁 Repository Structure
soc-project/
├── README.md
├── scripts/
│ └── attack_simulation.sh
├── attack-logs/
├── dashboards/
├── configs/
└── reports/


## 🚀 Attack Simulation Steps
1. Reconnaissance (Nmap scanning)
2. SMB Brute Force (Hydra)
3. Privilege Escalation (WMI)
4. Persistence (Backdoor account)
5. Lateral Movement (WMI)
6. Data Exfiltration

## 📊 Detection Sources
- **Suricata:** Network-based detection
- **Windows Event Logs:** Host-based detection
- **Splunk:** Centralized monitoring

## 📝 Documentation
- [Attack Simulation Logs](attack-logs/)
- [Splunk Dashboard](dashboards/)
- [Incident Reports](reports/)

## 🎯 Key Learnings
- ✅ IDS/IPS Implementation with Suricata
- ✅ Windows Event Logging Configuration
- ✅ Splunk SIEM Integration
- ✅ Attack Simulation and Detection
- ✅ Incident Response


---

**Author:** Kgalake Mabotja
**Date:** $(date)
