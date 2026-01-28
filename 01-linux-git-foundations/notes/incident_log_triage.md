# Incident: Fake service intermittent failures

## Symptom
Service fails intermittently with exit code 1.

## Logs Evidence
- Errors: database connection failures
- Warnings: high memory usage

## Diagnosis
- ERROR indicates dependency (database) not reachable
- WARN suggests resource pressure but not fatal

## Immediate Actions
- Check database availability
- Verify network connectivity
- Monitor memory usage

## Commands Used
- tail
- grep
- grep -c
