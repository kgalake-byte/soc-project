# Attack Execution Details

## Manual Attack Commands

### Connect via WinRM
evil-winrm -i 192.168.1.5 -u Administrator -p P@ssw0rd123

text

### Commands Executed
| Command | Purpose | Detection |
|---------|---------|-----------|
| whoami | User enumeration | Event 4688 |
| hostname | System enumeration | Event 4688 |
| net user backdoor ... | Create backdoor | Event 4720 |
| net localgroup ... | Add to admins | Event 4732 |
| net user backdoor | Verify | Event 4688 |
| net user backdoor /delete | Cleanup | Event 4726 |

### Splunk Event IDs
| Event | Description |
|-------|-------------|
| 4624 | Successful Logon (WinRM) |
| 4688 | Process Creation |
| 4720 | User Account Created |
| 4732 | Member Added to Group |
| 4726 | User Account Deleted |
