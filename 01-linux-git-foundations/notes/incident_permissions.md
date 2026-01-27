# Incident: Permission denied when deleting/writing artifacts

## Symptom
- Deleting `artifacts/incident_log.txt` failed with: Permission denied
- Root cause was missing write permission on the directory

## What happened
The directory `01-linux-git-foundations/artifacts` lost owner write permission.
Directory permissions control create/delete/rename operations for files inside it.

## Diagnosis
- `ls -ld <dir>` showed the directory was not writable (example: dr-xr-xr-x)
- `namei -l <path>` helped verify permissions along the full path

## Fix
Restored owner write permission:
- `chmod u+w 01-linux-git-foundations/artifacts`

## Verification
- `rm -f artifacts/incident_log.txt` succeeded
- `scripts/write_log.sh` successfully recreated the log file
