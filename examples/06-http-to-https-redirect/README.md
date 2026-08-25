# 🔀 Chapter 06 — Redirect HTTP to HTTPS

In production, you generally want to force all HTTP traffic (Port 80) to securely redirect to HTTPS (Port 443). Traefik makes this trivial by applying a global `redirectScheme` on the `web` entrypoint.


---

## 👶 Beginner's Explanation (ELI5)
> *Imagine a visitor accidentally walks up to the **insecure back door** (HTTP/Port 80). Traefik immediately hands them a map and says, "Please walk around to the heavily armored front door (HTTPS/Port 443)."*

## 💡 Why do we need this?
> You never want users accidentally sending unencrypted passwords because they forgot to type `https://` in their browser address bar.

---

## 🖼️ Architecture Diagram

![HTTP to HTTPS Redirect Architecture](../../images/traefik_http_https_redirect.jpg)
> **Diagram Explanation:** A high-level technical visualization of the concepts discussed in this chapter.

---

---

## 🏗️ HTTP to HTTPS Redirect Flow

```
[ Browser: http://app.example.com ]
            │
            ▼
┌────────────────────────┐
│ EntryPoint `web` (:80) │
└───────────┬────────────┘
            │
            ▼
┌────────────────────────┐
│      HTTP Router       │ ── (matches all Host rules on :80)
└───────────┬────────────┘
            │
            ▼
┌────────────────────────┐
│     redirectScheme     │ ──▶ 301 Moved Permanently
│       Middleware       │     Location: https://app.example.com
└────────────────────────┘
            │
            ▼
[ Browser Automatically Upgrades to HTTPS ]
```

---

## ⚙️ Configuration Setup

### Global Redirect via Static Config (`traefik.yml`)
The most reliable method is to globally redirect the entire `web` entrypoint to `websecure`:

```yaml
entryPoints:
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https
  websecure:
    address: ":443"
```

## 🚀 Demo Time: Step-by-Step Practical

**1. Start the Stack**
```bash
docker compose -f traefik-docker-compose.yml up -d
```

**2. Test the Redirect**
Run a verbose curl request to port 80:
```bash
curl -v http://127.0.0.1
```
**Output Expectation:** You should receive an `HTTP/1.1 301 Moved Permanently` response, with a `Location: https://127.0.0.1/` header, proving Traefik is actively forcing traffic to HTTPS globally.

**3. Teardown**
```bash
docker compose -f traefik-docker-compose.yml down
```

---

## 📁 Included Offline Example Stacks

- 📄 [`traefik.yml`](./traefik.yml) — Static config with global entrypoint redirection
- 🐳 [`traefik-docker-compose.yml`](./traefik-docker-compose.yml)
- 🔒 [`.env.example`](./.env.example)

---

[⬅️ Chapter 05 — Let's Encrypt DNS](../05-letsencrypt-dns-challenge-cloudflare/README.md) | [🏠 Master Index](../../README.md) | [➡️ Next: Chapter 07 — Production Stack](../07-production-ready-stack/README.md)