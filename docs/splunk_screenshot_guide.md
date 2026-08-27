# Splunk Dashboard Screenshot Guide

## 1. Login to Splunk
URL: http://192.168.1.10:8000
Username: admin
Password: Splunk@123

## 2. Capture These Screenshots

### Screenshot 1: Account Creation (Event 4720)
Search: index=windows EventCode=4720
Filter: latest (backdoor account creation)

### Screenshot 2: WinRM Login (Event 4624)
Search: index=windows EventCode=4624 Logon_Type=10

### Screenshot 3: Process Creation (Event 4688)
Search: index=windows EventCode=4688 Process_CommandLine="*net*"

### Screenshot 4: Dashboard View
Go to Dashboards → Windows DC Attack Monitoring
Take a full screenshot of the dashboard

### Screenshot 5: Attack Timeline
Search: index=windows EventCode=4625 OR EventCode=4720 OR EventCode=4688
Time range: Last hour
Chart type: Timeline
