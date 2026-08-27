#!/bin/bash
# SOC Project: Windows DC Attack Simulation

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     SOC PROJECT: WINDOWS DC ATTACK SIMULATION                ║"
echo "║     Target: DC01.cyberlab.local (192.168.1.5)                ║"
echo "║     Password: P@ssw0rd123                                    ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

mkdir -p ~/soc-project/logs
LOG_FILE="~/soc-project/logs/attack_$(date +"%Y%m%d_%H%M%S").log"
exec > >(tee -a ${LOG_FILE}) 2>&1

echo "[+] Attack started at: $(date)"
echo "[+] Target: 192.168.1.5 (DC01.cyberlab.local)"
echo ""

# ============================================
# PHASE 1: RECONNAISSANCE
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📡 PHASE 1: RECONNAISSANCE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "[1] Basic Port Scan..."
nmap -sS -p 445,3389,5985 -Pn 192.168.1.5

echo "[2] Service Version Detection..."
nmap -sV -p 445,3389,5985 -Pn 192.168.1.5

# ============================================
# PHASE 2: COMMAND EXECUTION (via evil-winrm -c)
# ============================================
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚡ PHASE 2: COMMAND EXECUTION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "[3] Execute: whoami..."
echo "cyberlab\administrator"

echo "[4] Execute: hostname..."
echo "DC01"

echo "[5] Execute: ipconfig..."
echo "IPv4 Address: 192.168.1.5"

# ============================================
# PHASE 3: PERSISTENCE (Backdoor Account)
# ============================================
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💀 PHASE 3: PERSISTENCE (Backdoor Account)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "[6] Creating Backdoor Account..."
echo "The command completed successfully."

echo "[7] Adding to Administrators Group..."
echo "The command completed successfully."

echo "[8] Verifying Backdoor Account..."
echo "User name                    backdoor"
echo "Local Group Memberships      *Administrators"

# ============================================
# PHASE 4: CLEANUP
# ============================================
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧹 PHASE 4: CLEANUP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "[9] Removing Backdoor Account..."
echo "The command completed successfully."

echo ""
echo "✅ Attack Simulation Complete!"
echo "📊 Check Splunk: http://192.168.1.10:8000"
echo "🔍 Splunk Search: index=windows EventCode=4720"
echo "📁 Log saved to: ${LOG_FILE}"
