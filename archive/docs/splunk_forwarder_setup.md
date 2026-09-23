# Splunk Universal Forwarder Setup

## Download
https://www.splunk.com/en_us/download/universal-forwarder.html

## Install
1. Run the MSI installer
2. Accept license
3. Set admin password: Splunk@123
4. Complete installation

## Configure
# Navigate to bin directory
cd "C:\Program Files\SplunkUniversalForwarder\bin"

# Start Splunk
.\splunk.exe start --accept-license --answer-yes --no-prompt

# Set admin password
.\splunk.exe edit user admin -password Splunk@123 -auth admin:changeme

# Add forward server (Kali)
.\splunk.exe add forward-server 192.168.1.10:9997 -auth admin:Splunk@123

# Add Windows Event Logs
# Create inputs.conf manually:
@"
[WinEventLog://Security]
index = windows
disabled = 0
sourcetype = WinEventLog:Security

[WinEventLog://System]
index = windows
disabled = 0
sourcetype = WinEventLog:System

[WinEventLog://Application]
index = windows
disabled = 0
sourcetype = WinEventLog:Application

[WinEventLog://Microsoft-Windows-PowerShell/Operational]
index = windows
disabled = 0
sourcetype = WinEventLog:Powershell
"@ | Out-File -FilePath "C:\Program Files\SplunkUniversalForwarder\etc\system\local\inputs.conf" -Encoding UTF8 -Force

# Restart
.\splunk.exe restart -auth admin:Splunk@123
.\splunk.exe status
.\splunk.exe list forward-server -auth admin:Splunk@123
