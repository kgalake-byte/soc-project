# Splunk Receiver Setup

## On Kali (Splunk Server)

### 1. Add TCP Input on Port 9997
sudo -u splunk /opt/splunk/bin/splunk add tcp 9997 -sourcetype WinEventLog -auth admin:Splunk@123

text

### 2. Create Windows Index
sudo -u splunk /opt/splunk/bin/splunk add index windows -auth admin:Splunk@123

text

### 3. Verify Listening
sudo netstat -tlnp | grep 9997

text

### 4. Verify Index
sudo -u splunk /opt/splunk/bin/splunk list index -auth admin:Splunk@123 | grep windows

text
