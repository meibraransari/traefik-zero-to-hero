# 🦖 Chapter 18 — Tailscale Zero-Trust Integration

Traefik v3 introduces native support for **Tailscale**. This allows Traefik to automatically fetch SSL certificates from your Tailnet and route traffic securely over your private VPN mesh—without exposing any ports to the public internet!


---

## 👶 Beginner's Explanation (ELI5)
> *Taking your entire building off the public map. The only way to find it is to use a **secret underground tunnel system (Tailscale VPN)** that only your personal devices have the keys to.*

## 💡 Why do we need this?
> The ultimate security. Your apps literally do not exist on the public internet, yet you can access them with beautiful HTTPS URLs from anywhere in the world.

---

---

## 🏗️ Tailscale VPN Flow

```
[ Tailscale Client ]
  (Laptop/Mobile)
        │
   (WireGuard VPN)
        │
┌───────▼───────┐
│   Tailscale   │ ─── 1. Traefik fetches SSL from Tailscale daemon
└───────┬───────┘
        │
┌───────▼───────┐
│    Traefik    │ ─── 2. Serves `https://my-app.tailnet-name.ts.net`
└───────┬───────┘
        │
┌───────▼───────┐
│  Internal App │ ─── 3. Completely hidden from public internet
└───────────────┘
```

---

## ⚙️ Configuration Setup

### Step 1 — Enable Tailscale Certificate Resolver (`traefik.yml`)
```yaml
certificatesResolvers:
  my-tailscale:
    tailscale: {}
```

### Step 2 — Route to Tailscale DNS Name
Use your machine's MagicDNS name from Tailscale (e.g., `app.machine-name.ts.net`).

```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.internal-app.entrypoints=websecure"
  - "traefik.http.routers.internal-app.rule=Host(`internal-app.magic-name.ts.net`)"
  - "traefik.http.routers.internal-app.tls.certresolver=my-tailscale"
```

---

## 📁 Included Offline Example Stacks

- 📄 [`traefik.yml`](./traefik.yml) — Static config with Tailscale resolver
- 🐳 [`traefik-tailscale-docker-compose.yml`](./traefik-tailscale-docker-compose.yml) — Traefik container mapping the Tailscale socket
- 🔒 [`.env.example`](./.env.example)

---

[⬅️ Chapter 17 — Canary & Mirroring](../17-canary-and-mirroring/README.md) | [🏠 Master Index](../../README.md) | [➡️ Next: Chapter 19 — Kubernetes](../19-kubernetes-ingressroute/README.md)
