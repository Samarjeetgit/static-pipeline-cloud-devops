# Project 01 Architecture & Trade-Offs

## Flow Diagram
```text
Developer Push (main) 
    │
    ▼
GitHub Actions CI
    ├── 1. Lint HTML & Dockerfile
    ├── 2. Build Immutable Image (Tag: site:${{ github.sha }})
    ├── 3. Trivy Security Gate (Fail on CRITICAL CVEs)
    └── 4. Container Smoke Test (curl /healthz -> 200 OK)
