import os
import logging
from flask import Flask, jsonify

app = Flask(__name__)

logging.basicConfig(level=os.getenv("LOG_LEVEL", "INFO"))
log = logging.getLogger("sample-app")

# Config that will affect readiness
REQUIRED_TOKEN = os.getenv("REQUIRED_TOKEN", "")

@app.get("/")
def home():
    log.info("home endpoint hit")
    return jsonify(service="sample-app", status="ok")

@app.get("/healthz")
def healthz():
    return jsonify(status="healthy")

@app.get("/readyz")
def readyz():
    if not REQUIRED_TOKEN:
        log.error("readiness failed: REQUIRED_TOKEN is missing")
        return jsonify(status="not-ready", reason="missing REQUIRED_TOKEN"), 503
    return jsonify(status="ready")

if __name__ == "__main__":
    port = int(os.getenv("PORT", "8080"))
    log.info("starting server on port %s", port)
    app.run(host="0.0.0.0", port=port)
