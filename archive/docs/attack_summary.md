# Attack Simulation Summary

## Attack Details
- **Date:** 2026-08-27
- **Target:** DC01.cyberlab.local (192.168.1.5)
- **Attacker:** Kali (192.168.1.10)
- **Method:** WinRM (Port 5985)

## Attack Timeline
| Time | Event | Detection |
|------|-------|-----------|
| 11:14:24 | Account Creation (backdoor) | Event 4720 |
| 11:14:25 | Added to Administrators | Event 4732 |
| 11:14:26 | Account Verified | Event 4688 |
| 11:14:27 | Account Deleted | Event 4726 |

## Detection Summary
| Event ID | Description | Count |
|----------|-------------|-------|
| 4624 | Successful Login (WinRM) | 1 |
| 4688 | Process Creation | 4 |
| 4720 | Account Creation | 1 |
| 4732 | Group Membership Change | 1 |
| 4726 | Account Deletion | 1 |

## IOCs
| IOC | Value |
|-----|-------|
| Attacker IP | 192.168.1.10 |
| Target | 192.168.1.5 |
| Backdoor Account | backdoor |
| Tools | Nmap, Evil-WinRM, net.exe |

## MITRE ATT&CK Mapping
| Tactic | Technique | ID |
|--------|-----------|-----|
| Reconnaissance | Network Service Scanning | T1046 |
| Initial Access | Valid Accounts | T1078 |
| Privilege Escalation | Valid Accounts | T1078 |
| Persistence | Create Account | T1136 |
| Discovery | Account Discovery | T1087 |

## Incident Response Actions
1. ✅ Detected account creation in Splunk
2. ✅ Investigated the source (WinRM login)
3. ✅ Verified backdoor account
4. ✅ Removed backdoor account
5. ✅ Documented the incident
6. ✅ Implemented monitoring for future incidents
