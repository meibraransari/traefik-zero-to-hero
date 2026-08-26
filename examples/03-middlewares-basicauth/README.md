# 🔑 Chapter 03 — Middlewares (BasicAuth)

Middlewares are pieces of logic that modify a request before it hits your service. The most common middleware is **BasicAuth**, which places a username/password prompt in front of an application.


---

## 👶 Beginner's Explanation (ELI5)
> *A middleware is like a **bouncer** standing at the door of a club. The receptionist (Router) gives you directions to the club, but the bouncer checks your ID (username/password) before letting you inside.*

## 💡 Why do we need this?
> Some apps (like internal dashboards or databases) do not have their own login screens! BasicAuth protects them from the public internet.

---

---

## 🖼️ BasicAuth Architecture

![BasicAuth Middleware](../../images/traefik_middleware_basicauth.jpg)
> **Diagram Explanation:** Shows the exact moment the middleware intercepts the traffic. Before the service receives the request, the Traefik middleware challenges the user for credentials against a `.htpasswd` file, effectively blocking unauthorized access at the perimeter.

---

## 🏗️ Middleware Execution Flow

```
[ Browser ] ────▶ ┌───────────────┐
                  │ Traefik Proxy │
                  └───────┬───────┘
                          │ (Route matches)
                          ▼
                  ┌───────────────┐
                  │  BasicAuth    │ ◀── (Rejects invalid password with 401 Unauthorized)
                  │  Middleware   │
                  └───────┬───────┘
                          │ (If authenticated)
                          ▼
                  ┌───────────────┐
                  │  Backend App  │
                  └───────────────┘
```

---

```
traefik.yml
    │
    ├── Docker provider
    │      └── Docker labels
    │             └── whoami router
    │                    └── auth-middleware
    │
    └── File provider
           └── dynamic_conf/
                  └── external-app.yml
                         └── external server

```

## ⚙️ Configuration Setup

### Step 1 — Generate a Password Hash
Traefik requires hashed passwords (`htpasswd`). Generate one:
create a new file - users_credentials containing username:passwords pairs, htpasswd style
```bash
apt install apache2-utils -y
htpasswd -Bbn admin 'MySecretPassword123' >> users_credentials # replace user name and password
```

### Step 2 — Define the Middleware
```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.whoami.entrypoints=web"
  - "traefik.http.routers.whoami.rule=Host(`whoami.$MY_DOMAIN`)"
    # 1. Define the middleware
  - "traefik.http.routers.whoami.middlewares=auth-middleware"
    # 2. Apply it to the router
  - "traefik.http.middlewares.auth-middleware.basicauth.usersfile=/users_credentials"
```

---

## 🚀 Demo Time: Step-by-Step Practical

**1. Start the Stack**
```bash
cp -a .env.example .env
docker compose -f traefik-docker-compose.yml up -d
# users_credentials already mounted in above compose file
docker compose -f whoami-docker-compose.yml up -d
# Middleware already configured in above compose file
```

**2. Test the Authentication**
Open your browser and navigate to `http://whoami.example.com` (Ensure your `/etc/hosts` file maps this to `127.0.0.1`). 
- A popup will appear asking for a Username and Password!
- Enter the credentials defined in the labels (or the `users_credentials` file).
- E.g., Username: `user`, Password: `password`

```
curl -i -H "Host: whoami.example.com" http://127.0.0.1
# You should get something like:
# HTTP/1.1 401 Unauthorized

# Change password with your passsword.
curl -i -u admin:YOUR_PASSWORD \
  -H "Host: whoami.example.com" \
  http://127.0.0.1
# You should then get the whoami response.
```

**3. Teardown**
```bash
docker compose -f whoami-docker-compose.yml down
docker compose -f traefik-docker-compose.yml down
```

---

## 📁 Included Offline Example Stacks

- 📄 [`users_credentials`](./users_credentials) — File containing hashed passwords
- 🐳 [`traefik-docker-compose.yml`](./traefik-docker-compose.yml) — Basic Traefik setup
- 🐳 [`whoami-docker-compose.yml`](./whoami-docker-compose.yml) — Test app protected by inline labels
- 🐳 [`nginx-docker-compose.yml`](./nginx-docker-compose.yml) — Test app protected by `users_credentials` file
- 🔒 [`.env.example`](./.env.example)

---

[⬅️ Chapter 02 — Local IP Routing](../02-local-ip-routing/README.md) | [🏠 Master Index](../../README.md) | [➡️ Next: Chapter 04 — Let's Encrypt HTTP](../04-letsencrypt-http-challenge/README.md)