# 🚀 Traefik — Zero to Hero Guide

<div align="center">

**A complete, offline-first, example-driven learning curriculum to master Traefik v2 & v3**

[![GitHub Repository](https://img.shields.io/badge/GitHub-markdown--manager-blue?style=for-the-badge&logo=github)](https://github.com/meibraransari/markdown-manager.git)

</div>

![Traefik Architecture](./images/traefik_architecture_overview.jpg)

---

## 📋 Course Curriculum & Chapter Index

Each chapter below contains dedicated offline documentation, architectural diagrams, and ready-to-run example stacks:

| # | Chapter | Topic & Highlights | Chapter Guide & Offline Examples |
|---|---------|-------------------|----------------------------------|
| **00** | 💡 **What is Traefik?** | Architecture, 4 core building blocks, Static vs Dynamic config, Traefik vs Nginx | [📖 Read Chapter 00](./examples/00-what-is-traefik/README.md) |
| **01** | 🐳 **Routing to Docker Containers** | Service discovery, custom bridge network, Docker container labels | [📖 Read Chapter 01](./examples/01-docker-routing/README.md) |
| **02** | 🖥️ **Routing to Local IP Addresses** | Dynamic file provider, loadBalancer, LAN servers & VMs (`10.0.19.5:80`) | [📖 Read Chapter 02](./examples/02-local-ip-routing/README.md) |
| **03** | 🔑 **Middlewares (BasicAuth)** | Password hashing, authentication middleware, middleware chaining | [📖 Read Chapter 03](./examples/03-middlewares-basicauth/README.md) |
| **04** | 🔒 **Let's Encrypt — HTTP Challenge** | Automated SSL via ACME HTTP-01 on port 80, switching to `websecure` | [📖 Read Chapter 04](./examples/04-letsencrypt-http-challenge/README.md) |
| **05** | 🌐 **Let's Encrypt — DNS Challenge** | Wildcard SSL (`*.domain.com`) via Cloudflare API without exposing port 80 | [📖 Read Chapter 05](./examples/05-letsencrypt-dns-challenge-cloudflare/README.md) |
| **06** | 🔀 **Redirect HTTP to HTTPS** | Global port 80 to 443 redirection with `redirectscheme` middleware | [📖 Read Chapter 06](./examples/06-http-to-https-redirect/README.md) |
| **07** | 📊 **Production-Ready Stack & Dashboard** | Securing internal dashboard with BasicAuth + HTTPS, unified apps stack | [📖 Read Chapter 07](./examples/07-production-ready-stack/README.md) |
| **08** | ⚙️ **Advanced Configuration** | TLS 1.2/1.3 ciphers, HSTS/XSS security headers, rate limiting, health checks | [📖 Read Chapter 08](./examples/08-advanced-configuration/README.md) |
| **09** | 🩺 **Troubleshooting & Diagnostics** | Debug logging, error filtering, `acme.json` inspector, route testing tools | [📖 Read Chapter 09](./examples/09-troubleshooting-and-diagnostics/README.md) |
| **10** | ⚡ **Quick Reference & Master Cheat Sheet** | Label cheat sheet, rule syntax, production templates, middleware library | [📖 Read Chapter 10](./examples/10-quick-reference-and-cheat-sheet/README.md) |
| **11** | 🔌 **TCP & UDP Routing (Non-HTTP)** | Routing databases (Postgres/Redis), game servers, SNI & TLS passthrough | [📖 Read Chapter 11](./examples/11-tcp-udp-routing/README.md) |
| **12** | 📈 **Observability: Metrics, Tracing & Logs** | Native Prometheus metrics, OpenTelemetry/Jaeger tracing, JSON access logs | [📖 Read Chapter 12](./examples/12-observability-metrics-tracing/README.md) |
| **13** | 🔐 **SSO & ForwardAuth (Authelia)** | Centralized 2FA/MFA Single Sign-On portal protecting all subdomains | [📖 Read Chapter 13](./examples/13-sso-forwardauth-authelia/README.md) |
| **14** | 🛡️ **Custom SSL & Mutual TLS (mTLS)** | Commercial/Self-signed custom certificates, client certificate authentication | [📖 Read Chapter 14](./examples/14-custom-ssl-and-mtls/README.md) |
| **15** | 🛑 **Plugins & Security (CrowdSec)** | Traefik plugin ecosystem, CrowdSec WAF bouncer & real-time IP banning | [📖 Read Chapter 15](./examples/15-plugins-and-crowdsec/README.md) |
| **16** | ⚡ **HTTP/3 (QUIC) & Brotli** | Traefik v3 native HTTP/3 QUIC over UDP and advanced Brotli compression | [📖 Read Chapter 16](./examples/16-http3-quic-and-brotli/README.md) |
| **17** | ⚖️ **Canary & Traffic Mirroring** | Weighted Round Robin (Canary Deployments) and Traffic Shadowing | [📖 Read Chapter 17](./examples/17-canary-and-mirroring/README.md) |
| **18** | 🦖 **Tailscale Zero-Trust Integration** | Traefik v3 Tailscale certificates for secure, private VPN mesh routing | [📖 Read Chapter 18](./examples/18-tailscale-integration/README.md) |
| **19** | ☸️ **Kubernetes (K3s) & CRDs** | Translating Docker labels to Kubernetes `IngressRoute` and `Middleware` | [📖 Read Chapter 19](./examples/19-kubernetes-ingressroute/README.md) |

---

## ⚡ Prerequisites

Before starting, ensure you have:

- 🐳 **Docker & Docker Compose** installed and operational
- 🌍 A registered **domain name** (e.g. `example.com`)
- ☁️ **Cloudflare** (or your DNS provider) managing your domain records
- 🔓 **Ports 80 & 443** (TCP & UDP) forwarded/open in your firewall / router

---

## 🤝 Contributing

Contributions are welcome! Please see the detailed guidelines in [CONTRIBUTING.md](CONTRIBUTING.md).

For a quick summary:
1. Fork the repository
2. Create a feature branch: `git checkout -b feat/my-feature`
3. Commit your changes following [Conventional Commits](https://www.conventionalcommits.org/)
4. Push to the branch and open a Pull Request

---

## 📄 License

MIT License — see [LICENSE.md](LICENSE.md) for details.

---

<div align="center">

Made with ❤️ for the self-hosting community

**[What is Traefik?](./examples/00-what-is-traefik/README.md) · [Docker Routing](./examples/01-docker-routing/README.md) · [Production Stack](./examples/07-production-ready-stack/README.md) · [Cheat Sheet](./examples/10-quick-reference-and-cheat-sheet/README.md)**

</div>
