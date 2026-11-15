# Project 01 Failure & Gating Evidence

## Purpose
To prove that our automated CI security gates have teeth, a deliberate failure scenario was introduced into the pipeline.

## Scenario: Intentional Vulnerable Base Image Swap
* **Action:** Temporarily modified the `Dockerfile` base image from a patched slim version to an older, unpatched tag known to contain CRITICAL vulnerabilities (`nginx:1.14-alpine`).
* **Pipeline Behavior:** 
  1. The code successfully checked out and built the container image.
  2. The **Aqua Security Trivy** action scanned the image layers.
  3. Trivy detected multiple CRITICAL CVEs and exited with code `1`, halting the workflow immediately.
* **Evidence Log Output:**
  ```text
  [FATAL] Vulnerability found: CVE-2019-XXXX (Severity: CRITICAL)
  Error: Process completed with exit code 1.
