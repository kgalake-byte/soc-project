# Splunk Searches for Attack Detection

## 1. Failed Logins (Brute Force)
index=windows EventCode=4625
| stats count by Source_Network_Address, Target_User_Name
| sort - count

text

## 2. Successful WinRM Login
index=windows EventCode=4624 Logon_Type=10
| stats count by User_Name, Source_Network_Address

text

## 3. Account Creation (Backdoor)
index=windows EventCode=4720
| stats count by Target_User_Name, User_Name
| sort - count

text

## 4. Account Deletion
index=windows EventCode=4726
| stats count by Target_User_Name, User_Name
| sort - count

text

## 5. Process Execution (net.exe)
index=windows EventCode=4688 Process_CommandLine="net"
| stats count by Process_CommandLine, User_Name
| sort - count

text

## 6. PowerShell Logging
index=windows sourcetype=WinEventLog:Powershell
| stats count by User_Name, CommandLine
| sort - count

text

## 7. Full Attack Timeline
index=windows EventCode=4625 OR EventCode=4720 OR EventCode=4688 OR EventCode=4624
| timechart count by EventCode

text

## 8. Backdoor Account Detection
index=windows EventCode=4720 Target_User_Name="backdoor"
| stats count by User_Name, Target_User_Name

text
