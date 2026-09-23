# Cloud SOC Incident Report

## Incident Overview
- **Incident ID:** IR-CLOUD-2026-001
- **Date:** 2026-09-23
- **Time:** 14:23:53 - 14:24:51 SAST
- **Duration:** 58 seconds
- **Severity:** HIGH
- **Status:** CONTAINED
- **Analyst:** Kgalake Mabotja

## Environment
- **SIEM:** LogTide (AWS EC2, eu-north-1)
- **Log Source:** DC01.cyberlab.local (Windows Domain Controller)
- **Attacker:** Kali Linux (192.168.1.10)
- **Target IP:** 192.168.1.5

## Attack Timeline

### Phase 1: Brute Force (14:23:53 - 14:23:55)
| Time | Event ID | Description |
|------|----------|-------------|
| 14:23:53.153 | 4625 | Failed login attempt #1 |
| 14:23:53.625 | 4625 | Failed login attempt #2 |
| 14:23:54.153 | 4625 | Failed login attempt #3 |
| 14:23:54.685 | 4625 | Failed login attempt #4 |
| 14:23:55.177 | 4625 | Failed login attempt #5 |
| 14:23:55.681 | 4625 | Failed login attempt #6 |

**Pattern:** 6 failed logins in 2.5 seconds = automated brute force tool

### Phase 2: Persistence (14:24:47 - 14:24:48)
| Time | Event ID | Account Created | Created By |
|------|----------|----------------|------------|
| 14:24:47.662 | 4720 | soc_backdoor2 | Administrator |
| 14:24:48.137 | 4720 | soc_backdoor | Administrator |
| 14:24:48.645 | 4720 | backdoor_test | Administrator |

**Finding:** Attacker used `Administrator` account (already compromised) to create multiple backdoors

### Phase 3: Privilege Escalation (14:24:50 - 14:24:51)
| Time | Event ID | Action |
|------|----------|--------|
| 14:24:50.657 | 4732 | Added account to Administrators group |
| 14:24:51.116 | 4732 | Added account to Administrators group |
| 14:24:51.589 | 4732 | Added account to Administrators group |

### Phase 4: Cleanup (14:24:49 - 14:24:50)
| Time | Event ID | Action |
|------|----------|--------|
| 14:24:49.112 | 4726 | Account deleted |
| 14:24:49.621 | 4726 | Account deleted |
| 14:24:50.168 | 4726 | Account deleted |

**Note:** Attacker tried to cover tracks but the SIEM captured everything

## MITRE ATT&CK Mapping

| Tactic | Technique | ID | Evidence |
|--------|-----------|-----|----------|
| **Credential Access** | Brute Force | T1110 | 6x Event 4625 |
| **Persistence** | Create Account | T1136 | 3x Event 4720 |
| **Privilege Escalation** | Account Manipulation | T1098 | 3x Event 4732 |
| **Defense Evasion** | Indicator Removal | T1070 | 3x Event 4726 |
| **Initial Access** | Valid Accounts | T1078 | Event 4624 (Administrator) |

## Indicators of Compromise (IOCs)

| Type | Value |
|------|-------|
| **Attacker IP** | 192.168.1.10 |
| **Target IP** | 192.168.1.5 |
| **Target Host** | DC01.cyberlab.local |
| **Backdoor Accounts** | soc_backdoor, soc_backdoor2, backdoor_test |
| **Compromised Account** | Administrator |
| **Tools** | Evil-WinRM, net.exe, Nmap |
| **Attack Duration** | 58 seconds |

## Detection Evidence

### Total Events Captured
| Event ID | Count | Description |
|----------|-------|-------------|
| 4625 | 6 | Failed logins |
| 4720 | 3 | Account creations |
| 4726 | 3 | Account deletions |
| 4732 | 3 | Admin group additions |
| 4624 | 105 | Successful logons |
| 4672 | 105 | Privilege use |
| 4688 | 100 | Process execution |
### Evidence Location
LogTide Database: logtide
Table: logs
Service: "Windows DC Logs"
Field: metadata.payload

text

## Response Actions

### Immediate
- ✅ Attack detected via SIEM
- ✅ Backdoor accounts identified
- ✅ Privilege escalation confirmed
- ✅ Attack timeline documented

### Containment
- ✅ Backdoor accounts removed
- ⏳ Attacker IP blocked (pending)
- ⏳ Administrator password reset (recommended)

### Recovery
- ✅ System verified clean
- ✅ Monitoring enhanced
- ✅ Detection rules updated

## Recommendations

### Short-term
1. **Reset Administrator password** immediately
2. **Enable MFA** for privileged accounts
3. **Block attacker IP** on firewall
4. **Review Windows Security logs** for other activity

### Medium-term
1. **Deploy Sigma rules** for automated detection
2. **Configure LogTide alerts** for Event 4720/4732
3. **Enable Windows Defender** real-time protection
4. **Regular vulnerability scans**

### Long-term
1. **Implement Zero Trust** architecture
2. **Deploy EDR** solution
3. **Regular penetration testing**
4. **Security awareness training**

## Lessons Learned

1. **Brute force is loud** — 6 events in 2.5 seconds = clear detection
2. **SIEM captured everything** — Even with cleanup attempts
3. **Backdoor accounts are a common persistence method**
4. **Cloud SIEM is effective** — LogTide on AWS detected all events
5. **Field mapping matters** — Need to configure for easier search

## Conclusion

A coordinated attack was detected and contained within 58 seconds.
The attacker used brute force, backdoor accounts, and privilege
escalation techniques. All events were captured by the LogTide SIEM
with no data loss, demonstrating effective cloud-based security monitoring.

## Sign-off
**Analyst:** Kgalake Mabotja
**Date:** 2026-09-23
**Status:** COMPLETE
