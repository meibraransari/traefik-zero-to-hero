# ☸️ Chapter 19 — Kubernetes (K3s) & CRDs (IngressRoute)

While this guide focuses heavily on Docker Compose, Traefik is the default Ingress Controller for **K3s** and heavily utilized in enterprise **Kubernetes**. In Kubernetes, Traefik uses Custom Resource Definitions (CRDs) like `IngressRoute` instead of Docker labels.


---

## 👶 Beginner's Explanation (ELI5)
> *Instead of managing one office building (Docker Compose), you are managing an **entire city of skyscrapers (Kubernetes)**. Traefik scales up to manage the traffic for the entire city using specialized `IngressRoute` blueprints.*

## 💡 Why do we need this?
> When you outgrow a single server and need an enterprise-grade cluster with zero downtime and automatic horizontal scaling.

---

---

## 🏗️ Kubernetes Routing Flow

```
[ Inbound Request ]
        │
┌───────▼───────┐
│ Traefik (Pod) │ ─── Reads Kubernetes API (IngressRoute CRDs)
└───────┬───────┘
        │
┌───────▼───────┐
│  K8s Service  │
└───────┬───────┘
        │
┌───────▼───────┐
│ App Pod (1/3) │ ─── Load balanced natively across pods
└───────────────┘
```

---

## ⚙️ Configuration Setup

### Example `IngressRoute` YAML
Instead of putting labels on containers, you define an `IngressRoute` object that links to a Kubernetes `Service`:

```yaml
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: whoami-ingressroute
  namespace: default
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`k8s.example.com`)
      kind: Rule
      services:
        - name: whoami-service
          port: 80
  tls:
    certResolver: lets-encr
```

---

## 🚀 Demo Time: Step-by-Step Practical

**1. Apply the Manifests (Requires a K8s/K3s cluster)**
```bash
kubectl apply -f 01-deployment.yaml
kubectl apply -f 02-ingressroute.yaml
kubectl apply -f 03-middleware.yaml
```

**2. Test the IngressRoute**
Traefik is monitoring the Kubernetes API. The moment you apply `02-ingressroute.yaml`, Traefik dynamically builds the route.
```bash
curl -H Host:k8s.example.com http://<your-cluster-ip>
```
You will hit your Kubernetes service smoothly, fully load-balanced across your pods!

**3. Teardown**
```bash
kubectl delete -f 01-deployment.yaml
kubectl delete -f 02-ingressroute.yaml
kubectl delete -f 03-middleware.yaml
```

---

## 📁 Included Offline Example Stacks

- 📄 [`01-deployment.yaml`](./01-deployment.yaml) — Kubernetes App Deployment & Service
- 📄 [`02-ingressroute.yaml`](./02-ingressroute.yaml) — Traefik IngressRoute definition
- 📄 [`03-middleware.yaml`](./03-middleware.yaml) — Kubernetes Traefik Middleware (BasicAuth)

---

[⬅️ Chapter 18 — Tailscale](../18-tailscale-integration/README.md) | [🏠 Master Index](../../README.md)
