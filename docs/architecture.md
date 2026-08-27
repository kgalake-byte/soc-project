# Architecture Diagram

## Network Layout
- **Kali Attacker:** 192.168.1.10
- **FreeBSD Firewall (Suricata):** 192.168.1.1
- **Windows DC:** 192.168.1.5
- **Splunk SIEM:** 192.168.1.10:8000

## Data Flow
1. Attacker generates traffic (Nmap, Hydra, etc.)
2. Suricata detects network-based attacks
3. Windows Event Logs capture host-based attacks
4. Splunk Universal Forwarder sends logs to Splunk
5. Splunk indexes and displays alerts in dashboard
