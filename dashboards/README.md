# Splunk Dashboard Setup

## Dashboard Name
Windows DC Attack Monitoring

## Panels

### Panel 1: Failed Logins
index=windows EventCode=4625
| stats count by Source_Network_Address, Target_User_Name
| sort - count
| head 10


### Panel 2: Privilege Escalation
index=windows EventCode=4672
| stats count by User_Name
| sort - count


### Panel 3: Attack Timeline
index=windows (EventCode=4625 OR EventCode=4672 OR EventCode=4720)
| timechart count by EventCode


### Panel 4: Top Attack Sources
index=windows EventCode=4625
| stats count by Source_Network_Address
| sort - count
| head 10


### Panel 5: Account Changes
index=windows EventCode=4720 OR EventCode=4726 OR EventCode=4728
| stats count by EventCode, Target_User_Name
| sort - count


