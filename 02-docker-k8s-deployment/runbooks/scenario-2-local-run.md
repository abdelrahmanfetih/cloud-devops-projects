# Scenario 2: Local run + health/readiness validation

## Goal
Validate liveness vs readiness behavior before containerizing.

## Prereqs
- Python 3 installed
- venv available (Ubuntu: python3.10-venv)

## Steps

### 1) Create and activate venv
python3 -m venv .venv
source .venv/bin/activate

### 2) Install deps
pip install -r requirements.txt

### 3) Run without REQUIRED_TOKEN (expect readiness failure)
python app.py

### 4) Validate endpoints
curl -i http://127.0.0.1:8080/healthz   # expect 200
curl -i http://127.0.0.1:8080/readyz    # expect 503

### 5) Run with REQUIRED_TOKEN (expect readiness success)
REQUIRED_TOKEN=dev python app.py
curl -i http://127.0.0.1:8080/readyz    # expect 200

## Troubleshooting

### Symptom: curl shows "Connection refused"
- Ensure the server is running in another terminal.
- Avoid typos; prefer 127.0.0.1 over localhost.
