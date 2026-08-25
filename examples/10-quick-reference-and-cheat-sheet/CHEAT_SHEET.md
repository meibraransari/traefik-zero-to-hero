# ? Traefik Master Cheat Sheet & Quick Reference

A complete, offline reference for Docker labels, routing rules, static configs, dynamic middlewares, and CLI commands.

---

## 1. Docker Labels Quick Reference

### Core Activation
```yaml
- "traefik.enable=true"
- "traefik.docker.network=traefik_net"
```

### Routers
```yaml
# Entrypoints
- "traefik.http.routers.<NAME>.entrypoints=websecure"

# Rules
- "traefik.http.routers.<NAME>.rule=Host(`app.example.com`)"
- "traefik.http.routers.<NAME>.rule=Host(`app.example.com`) && PathPrefix(`/api`)"
- "traefik.http.routers.<NAME>.priority=1000"

# TLS & Certificates
- "traefik.http.routers.<NAME>.tls=true"
- "traefik.http.routers.<NAME>.tls.certresolver=lets-encr"
- "traefik.http.routers.<NAME>.tls.domains[0].main=*.example.com"
- "traefik.http.routers.<NAME>.tls.domains[0].sans=example.com"

# Attach Middlewares
- "traefik.http.routers.<NAME>.middlewares=auth-mw,rate-limit-mw,sec-headers-mw"

# Explicit Service Attachment
- "traefik.http.routers.<NAME>.service=<SERVICE_NAME>"
```

### Services (Load Balancers & Health Checks)
```yaml
# Custom Backend Port
- "traefik.http.services.<NAME>.loadbalancer.server.port=8080"
- "traefik.http.services.<NAME>.loadbalancer.server.scheme=http"

# Sticky Sessions
- "traefik.http.services.<NAME>.loadbalancer.sticky.cookie=true"
- "traefik.http.services.<NAME>.loadbalancer.sticky.cookie.name=lb_cookie"
- "traefik.http.services.<NAME>.loadbalancer.sticky.cookie.secure=true"
- "traefik.http.services.<NAME>.loadbalancer.sticky.cookie.httpOnly=true"

# Active Health Checks
- "traefik.http.services.<NAME>.loadbalancer.healthcheck.path=/healthz"
- "traefik.http.services.<NAME>.loadbalancer.healthcheck.interval=10s"
- "traefik.http.services.<NAME>.loadbalancer.healthcheck.timeout=3s"
- "traefik.http.services.<NAME>.loadbalancer.healthcheck.status=200"
```

---

## 2. Router Rule Syntax Reference

| Matcher | Syntax | Example |
|---------|--------|---------|
| **Host** | `Host(\`domain.com\`)` | `Host(\`api.example.com\`, \`api2.example.com\` )` |
| **HostRegexp** | `HostRegexp(\`{sub:[a-z]+}.example.com\`)` | Match dynamic subdomains |
| **Path** | `Path(\`/login\`)` | Exact path `/login` |
| **PathPrefix** | `PathPrefix(\`/api/v1\`)` | `/api/v1` and anything under it |
| **Method** | `Method(\`GET\`, \`POST\`)` | HTTP verbs |
| **Headers** | `Headers(\`X-Token\`, \`secret\`)` | Header matching |
| **HeadersRegexp** | `HeadersRegexp(\`User-Agent\`, \`.*Mobile.*\`)` | Header regex |
| **Query** | `Query(\`page\`, \`1\`)` | Query parameter matching |
| **ClientIP** | `ClientIP(\`192.168.1.0/24\`)` | Match client source IP |
| **Logical AND** | `&&` | `Host(\`app.com\`) && PathPrefix(\`/admin\`)` |
| **Logical OR** | `||` | `Host(\`a.com\`) || Host(\`b.com\`)` |
| **Logical NOT** | `!` | `!PathPrefix(\`/internal\`)` |

---

## 3. Essential Middleware Snippets

### Basic Authentication
```yaml
- "traefik.http.middlewares.auth.basicauth.users=admin:$apr1$ELgBQZx3$BFx7a9RIxh1Z0kiJG0juE/"
# Or file based:
- "traefik.http.middlewares.auth.basicauth.usersfile=/users_credentials"
```

### HTTP to HTTPS Redirect
```yaml
- "traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https"
- "traefik.http.middlewares.redirect-to-https.redirectscheme.permanent=true"
```

### Rate Limiting
```yaml
- "traefik.http.middlewares.ratelimit.ratelimit.average=50"
- "traefik.http.middlewares.ratelimit.ratelimit.burst=20"
- "traefik.http.middlewares.ratelimit.ratelimit.period=1s"
```

### Security Headers
```yaml
- "traefik.http.middlewares.sec-headers.headers.stsSeconds=31536000"
- "traefik.http.middlewares.sec-headers.headers.stsIncludeSubdomains=true"
- "traefik.http.middlewares.sec-headers.headers.stsPreload=true"
- "traefik.http.middlewares.sec-headers.headers.browserXssFilter=true"
- "traefik.http.middlewares.sec-headers.headers.contentTypeNosniff=true"
- "traefik.http.middlewares.sec-headers.headers.frameDeny=true"
```

### Strip Prefix
```yaml
- "traefik.http.middlewares.strip-api.stripprefix.prefixes=/api"
```

### IP Allowlist
```yaml
- "traefik.http.middlewares.whitelist.ipallowlist.sourcerange=192.168.1.0/24,10.0.0.0/8"
```

---

## 4. Useful CLI & Docker Commands

```bash
# Follow Traefik container logs
docker logs -f traefik

# Inspect labels attached to a container
docker inspect <CONTAINER_NAME> --format='{{json .Config.Labels}}' | python -m json.tool

# Inspect Traefik bridge network & connected IPs
docker network inspect traefik_net

# Test routing without DNS using curl
curl -v -H "Host: app.example.com" http://<TRAEFIK_SERVER_IP>:80
curl -vk --resolve "app.example.com:443:<TRAEFIK_SERVER_IP>" https://app.example.com:443

# Query Traefik API endpoints (if api is enabled on :8080)
curl -s http://<TRAEFIK_SERVER_IP>:8080/api/http/routers | python -m json.tool
curl -s http://<TRAEFIK_SERVER_IP>:8080/api/http/services | python -m json.tool
curl -s http://<TRAEFIK_SERVER_IP>:8080/api/http/middlewares | python -m json.tool
```
