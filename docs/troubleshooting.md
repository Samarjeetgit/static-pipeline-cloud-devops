# Project 01 Troubleshooting Log

## Issue 1: Nginx Permission Denied on Startup
* **Symptom:** When switching the Dockerfile user to non-root (`appuser`), the container exited immediately with code `1` and permission errors regarding `/var/cache/nginx` and `/var/run/nginx.pid`.
* **Root Cause:** Unprivileged users cannot write to default system directories owned by root.
* **Fix:** Updated the `Dockerfile` to explicitly create the user, create `/var/run/nginx.pid`, and adjust file ownership recursively using `chown` for the cache, log, and HTML directories prior to switching the user context.

## Issue 2: Health Check Port Mismatch
* **Symptom:** Docker Compose health check failed with `Connection refused`.
* **Root Cause:** The default Nginx configuration (`default.conf`) was listening on port 80, but our Dockerfile and compose file mapped port 8080.
* **Fix:** Configured `nginx/default.conf` to listen explicitly on `8080` and established a dedicated `/healthz` location block returning HTTP 200.
