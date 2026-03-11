# Inception

A fully Dockerized WordPress stack built from scratch — no pre-made images. Every service runs in its own Alpine-based container, built from a dedicated `Dockerfile` and configured through a companion shell script.

---

## Project Overview

This project deploys a production-style WordPress website over HTTPS, with object caching, FTP access, a database admin UI, a static web app, and real-time server monitoring — all orchestrated through a single `docker-compose.yml`.

All images are based on **Alpine Linux 3.21** and are built locally; no images are pulled from Docker Hub.

---

## Architecture

```
                        ┌─────────────────────────────────────────────┐
                        │                   nginx                     │
                        │   (TLS termination · reverse proxy · :443)  │
                        └─────┬──────────┬──────────┬─────────┬───────┘
                              │          │          │         │
                         /    │   /adminer   /calculator  /netdata/
                              │          │          │         │
                        ┌─────▼──┐  ┌───▼────┐ ┌──▼────┐ ┌──▼──────┐
                        │  WP    │  │adminer │ │ httpd │ │netdata  │
                        │php-fpm │  │php-fpm │ │apache │ │dashboard│
                        └─────┬──┘  └────────┘ └───────┘ └─────────┘
                              │
                     ┌────────┴────────┐
                     │                 │
               ┌─────▼──┐       ┌──────▼──┐
               │ mariadb │       │  redis  │
               │  (DB)   │       │ (cache) │
               └─────────┘       └─────────┘

                        ┌──────────────────┐
                        │    proftpd :21   │
                        │  (FTP → WP root) │
                        └──────────────────┘
```

### Services

| Service | Base image | Role |
|---|---|---|
| `nginx` | Alpine 3.21 | HTTPS reverse proxy (TLSv1.3, self-signed cert). Routes `/` → WordPress, `/adminer` → Adminer, `/calculator` → Apache, `/netdata/` → Netdata |
| `wordpress` | Alpine 3.21 | PHP-FPM 8.4 + WP-CLI. Configured and installed automatically via `startup.sh` on first boot |
| `mariadb` | Alpine 3.21 | Database server. Database, users, and root password are bootstrapped on first boot via `startup.sh` |
| `redis` | Alpine 3.21 | Redis object cache for WordPress (WP Redis plugin enabled automatically) |
| `proftpd` | Alpine 3.21 | FTP server on port 21 providing access to the WordPress web root |
| `adminer` | Alpine 3.21 | Lightweight database admin UI (PHP-FPM 8.4), served at `/adminer` |
| `httpd` | Alpine 3.21 | Apache serving a static calculator app at `/calculator` |
| `netdata` | Alpine 3.21 | Real-time system monitoring dashboard, proxied at `/netdata/` |

All services share a single internal bridge network (`webnet`). Only ports `443` (HTTPS) and `21` (FTP) are exposed to the host.

### Secrets

Sensitive credentials are passed to containers via Docker secrets (files mounted at `/run/secrets/` inside the container), never through plain environment variables:

| Secret file | Used by |
|---|---|
| `secrets/db_pass` | `wordpress`, `mariadb` |
| `secrets/db_root_pass` | `mariadb` |
| `secrets/wp_admin_pass` | `wordpress` |
| `secrets/wp_user_pass` | `wordpress` |
| `secrets/ftp_pass` | `proftpd` |

---

## Prerequisites

- Docker Engine
- Docker Compose v2
- `make`

---

## Setup

### 1. Clone the repository

```bash
git clone <repo-url>
cd Inception
```

### 2. Create the environment file

```bash
cp srcs/.env.example srcs/.env
```

Open `srcs/.env` and fill in every value:

```dotenv
DB_NAME=            # MariaDB database name
DB_USER=            # MariaDB user
WP_HOST=            # WordPress host (e.g. localhost or your domain)
WP_SITEURL=         # Full site URL (e.g. https://localhost)
DB_DATABASE=        # Same as DB_NAME (used by WP config)
INTRA=              # Your 42 intra login (used for FTP user and volume paths)
WP_USER=            # WordPress author username
DB_PORT=3306
WP_ADMIN_USER=      # WordPress admin username
WP_ADMIN_EMAIL=     # WordPress admin email
REDIS_PORT=6379
```

### 3. Create the secrets files

```bash
cp -r secrets_example secrets
```

Open each file under `secrets/` and replace the placeholder with the actual password:

| File | Variable inside | Description |
|---|---|---|
| `secrets/db_pass` | `DB_PASSWORD=` | MariaDB application user password |
| `secrets/db_root_pass` | `DB_ROOT_PASSWORD=` | MariaDB root password |
| `secrets/wp_admin_pass` | `WP_ADMIN_PASS=` | WordPress admin account password |
| `secrets/wp_user_pass` | `WP_USER_PASS=` | WordPress author account password |
| `secrets/ftp_pass` | `FTP_PASS=` | ProFTPD user password |

Each file must contain a single `KEY=value` line. The startup scripts source them with `. /run/secrets/<filename>`.

### 4. Build and start

```bash
make build
```

This builds all images and starts every service in detached mode. On first boot, MariaDB is initialized and WordPress is automatically installed via WP-CLI.

---

## Usage

| Command | Description |
|---|---|
| `make build` | Build images and start all services |
| `make up` | Start already-built services |
| `make down` | Stop and remove containers |
| `make clean` | Stop containers and remove named volumes |
| `make fclean` | Full clean (same as `clean` + host volume dirs when uncommented) |
| `make re` | Full rebuild from scratch |
| `make ps` | List running containers |

Once running, the stack is accessible at:

- **WordPress site** — `https://localhost/` (or your configured domain)
- **Adminer** — `https://localhost/adminer`
- **Calculator** — `https://localhost/calculator`
- **Netdata** — `https://localhost/netdata/`
- **FTP** — `ftp://localhost:21` (login with your `INTRA` username and the `ftp_pass` secret)

> The TLS certificate is self-signed, so your browser will show a security warning. Accept it to proceed.

---

## Notes

### Volume persistence

Volume bind-mount options are **commented out** in both `srcs/docker-compose.yml` and the `Makefile` to simplify initial deployment (Docker-managed volumes are used by default). To persist data to specific host directories, uncomment the relevant blocks in both files and set the correct paths under `/home/<INTRA>/data/volumes/`.

**`srcs/docker-compose.yml`** — uncomment under each named volume:
```yaml
volumes:
  mariadb_data:
    driver: local
    driver_opts:
      type: none
      device: /home/${INTRA}/data/volumes/mariadb
      o: bind
```

**`Makefile`** — uncomment the `mkdir` lines in `build` and the `rm` line in `fclean`:
```makefile
build:
	mkdir -p /home/$(INTRA)/data/volumes/wordpress
	mkdir -p /home/$(INTRA)/data/volumes/mariadb
	mkdir -p /home/$(INTRA)/data/volumes/adminer
```

### TLS

Nginx generates a self-signed RSA-2048 certificate at image build time (`openssl req -x509 …`). For a real domain, replace the certificate generation step with a valid certificate.

### First boot

On first startup, `wordpress/startup.sh` waits for MariaDB to become available before running `wp core install`. Two WordPress accounts are created automatically: the admin (from `WP_ADMIN_USER`) and an author (from `WP_USER`). The Redis object cache plugin is installed and activated automatically.
