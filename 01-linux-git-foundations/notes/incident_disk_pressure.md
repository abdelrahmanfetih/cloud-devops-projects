# Incident: Disk pressure due to growing log files

## Symptom
System reported disk usage increasing.
Potential risk of service degradation if disk becomes full.

## Evidence
- `du -h artifacts | sort -h` showed `disk-logs` consuming ~200MB
- Log files growing without rotation or compression

## Root Cause
Uncontrolled log growth inside `artifacts/disk-logs`.

## Diagnosis Steps
1. Check overall disk usage:
   - `df -h`
2. Identify largest directories:
   - `du -h artifacts | sort -h`

## Resolution
- Compressed large log file using `gzip`
- Reduced log size from ~200MB to ~200KB

## Verification
- Re-ran `du -h artifacts | sort -h`
- Confirmed disk usage returned to normal levels

## Prevention
- Enable log rotation
- Periodically compress or delete old logs
- Monitor disk usage thresholds (80% warning, 90% critical)
