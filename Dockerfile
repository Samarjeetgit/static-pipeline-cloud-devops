# Stage 1: Build / Validate Assets
FROM nginx:alpine-slim AS builder
WORKDIR /app
COPY site/ /usr/share/nginx/html/

# Stage 2: Runtime Production Image
FROM nginx:alpine-slim

# Create a non-root system user and group for security hardening
RUN addgroup -g 10001 appgroup && \
    adduser -u 10001 -G appgroup -s /bin/sh -D appuser

# Copy custom Nginx configuration and static website assets
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html

# Adjust file ownership for non-root execution
RUN chown -R appuser:appgroup /usr/share/nginx/html && \
    chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R appuser:appgroup /var/run/nginx.pid

# Switch to unprivileged user
USER appuser

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
