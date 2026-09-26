<div align="center">

# 🌍 Explorador de Catalunya 🏔️

### Plataforma web dockeritzada per explorar la riquesa cultural, geogràfica i gastronòmica de Catalunya

[![CI](https://github.com/urukaisk-maker/catalunya-app/actions/workflows/ci.yml/badge.svg)](https://github.com/urukaisk-maker/catalunya-app/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![Next.js](https://img.shields.io/badge/Next.js-14-black?style=flat&logo=next.js)](https://nextjs.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18-green?style=flat&logo=node.js)](https://nodejs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?style=flat&logo=postgresql)](https://www.postgresql.org/)

[Arquitectura](#-arquitectura) · [Instal·lació](#-instal·lació-ràpida) · [API](#-api-rest) · [Captures](#-captures) · [Roadmap](#-roadmap)

</div>

---

## 📖 Sobre el projecte

**Explorador de Catalunya** és una aplicació full-stack dockeritzada que mostra informació turística, cultural i gastronòmica de les quatre províncies catalanes. El projecte demostra una arquitectura de microserveis amb separació estricta de responsabilitats:

- 🎨 **Frontend** (Next.js 14) — Interfície amb rutes dinàmiques, cerca global i mapa interactiu
- ⚙️ **Backend** (Node.js + Express) — API RESTful amb autenticació Basic Auth per a l'àrea d'administració
- 🗄️ **Base de dades** (PostgreSQL 15) — 9 taules relacionals amb 200+ registres reals
- 🚪 **Proxy invers** (Nginx) — Punt d'entrada únic, capçaleres de seguretat i balanceig

## 🏗️ Arquitectura

```
                    ┌──────────────────────────────────┐
                    │      🌐 Navegador (usuari)       │
                    └────────────────┬─────────────────┘
                                     │ HTTP :8000
                                     ▼
                    ┌──────────────────────────────────┐
                    │   🚪 Proxy invers (Nginx)        │
                    │   Port 8000 → 80                 │
                    │   • Capçaleres de seguretat      │
                    │   • Proxy /api/* → backend       │
                    └───────┬──────────────────┬───────┘
                            │                  │
                 /api/*     │                  │  /*
                            ▼                  ▼
              ┌─────────────────────┐  ┌──────────────────────┐
              │  ⚙️  Backend         │  │  🎨 Frontend         │
              │  Node.js + Express  │  │  Next.js 14          │
              │  Port 5000          │  │  Port 3000           │
              │  • 12 endpoints     │  │  • App Router        │
              │  • Basic Auth admin │  │  • Server Components │
              └──────────┬──────────┘  │  • Leaflet (mapa)    │
                         │             └──────────────────────┘
                         │ SQL
                         ▼
              ┌─────────────────────┐
              │  🗄️  PostgreSQL 15   │
              │  Port 5432          │
              │  • 9 taules         │
              │  • Volum persistent │
              └─────────────────────┘

        Tots els serveis connectats a la xarxa interna catalunya_net
```

### Decisions tècniques

| Decisió | Motiu |
|---------|-------|
| **Docker Compose** amb 4 serveis | Aïllament de responsabilitats, desplegament reproduïble |
| **Proxy invers Nginx** | Punt d'entrada únic, fàcil afegir HTTPS a la Fase 4 |
| **Multi-stage builds** | Imatges finals ~150MB en lloc de ~400MB |
| **Usuari no-root** als contenidors | Bona pràctica de seguretat |
| **Healthchecks reals** | `depends_on: condition: service_healthy` evita errors d'arrencada |
| **`unaccent` a PostgreSQL** | Cerca sense accents ("dali" troba "Dalí") |
| **Basic Auth** per a l'admin | Simple, sense estat, ideal per a un sol administrador |

## 📊 Contingut de la base de dades

| Taula | Registres | Descripció |
|-------|-----------|------------|
| `provincies` | 4 | Barcelona, Girona, Lleida, Tarragona |
| `comarques` | 42 | Totes les comarques oficials amb capital i descripció |
| `municipis` | 42 | Municipis amb població i coordenades |
| `monuments` | 32 | Patrimoni de la UNESCO, modernisme, romànic, castells |
| `plats_tradicionals` | 22 | Calçotada, pa amb tomàquet, crema catalana... |
| `festes_tradicions` | 18 | Castellers, Sant Jordi, Patum de Berga, correfocs |
| `geografia` | 14 | Muntanyes, rius, parcs naturals, valls |
| `cultura_general` | 12 | Símbols, himnes, tradicions |
| `dites` | 7 | Refranys catalans amb significat |
| `estadistiques` | 10 | Dades generals de Catalunya |
| **TOTAL** | **~203** | |

## 🚀 Instal·lació ràpida

### Requisits previs

- [Docker](https://docs.docker.com/get-docker/) (v20+)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2+)
- `git`

### Passos

```bash
# 1. Clonar el repositori
git clone https://github.com/urukaisk-maker/catalunya-app.git
cd catalunya-app

# 2. Configurar variables d'entorn
cp .env.example .env
# Edita .env si vols canviar ports o credencials

# 3. Construir i aixecar tota la infraestructura
docker-compose up --build -d

# 4. Comprovar l'estat
docker ps

# 5. Obrir al navegador
#    http://localhost:8000
```

### Verificació

```bash
# Comprovar que el backend respon
curl http://localhost:8000/health
# → {"status":"ok"}

# Comprovar l'API
curl http://localhost:8000/api/provincies
# → [{...4 provincies...}]

# Provar el cercador
curl "http://localhost:8000/api/cerca?q=dalí"
# → [{"tipus":"monument","nom":"Teatre-Museu Dalí",...}]
```

## 🔌 API REST

### Públiques (sense autenticació)

| Mètode | Ruta | Descripció |
|--------|------|------------|
| `GET` | `/health` | Estat del backend i la BD |
| `GET` | `/api/provincies` | Llista de les 4 províncies |
| `GET` | `/api/provincies/:id/comarques` | Comarques d'una província |
| `GET` | `/api/provincies/:id/monuments` | Monuments d'una província |
| `GET` | `/api/comarques` | Totes les comarques |
| `GET` | `/api/comarques/:id` | Detall d'una comarca |
| `GET` | `/api/comarques/:id/municipis` | Municipis d'una comarca |
| `GET` | `/api/municipis` | Tots els municipis |
| `GET` | `/api/monuments` | Tots els monuments (`?tipus=Romà`) |
| `GET` | `/api/monuments/:id` | Detall d'un monument |
| `GET` | `/api/plats` | Plats tradicionals |
| `GET` | `/api/festes` | Festes i tradicions |
| `GET` | `/api/geografia` | Muntanyes, rius, parcs |
| `GET` | `/api/cultura` | Símbols i cultura general |
| `GET` | `/api/dites` | Refranys catalans |
| `GET` | `/api/estadistiques` | Dades generals |
| `GET` | `/api/cerca?q=text` | **Cercador global** (9 taules) |

### Protegides (Basic Auth)

| Mètode | Ruta | Descripció |
|--------|------|------------|
| `GET` | `/api/admin/check` | Validar credencials |
| `POST` | `/api/monuments` | Crear monument |
| `PUT` | `/api/monuments/:id` | Editar monument |
| `DELETE` | `/api/monuments/:id` | Esborrar monument |

### Exemple amb autenticació

```bash
curl -X POST http://localhost:8000/api/monuments \
  -u admin:canvia_aixo_2026 \
  -H "Content-Type: application/json" \
  -d '{
    "nom": "Catedral de Barcelona",
    "municipi_id": 1,
    "tipus": "Religiós",
    "descripcio": "Catedral gòtica al Barri Gòtic",
    "latitud": 41.3839,
    "longitud": 2.1762
  }'
```

## 📸 Captures de pantalla

### 🏠 Pàgina d'inici
Interfície principal amb el cercador global i les targetes de les quatre províncies, amb paleta de colors inspirada en la Senyera (granate, ocre, cobalt).

![Pàgina d'inici](./docs/screenshots/home.png)

### 🔍 Cercador global
Cerca en temps real sobre 9 taules: monuments, comarques, municipis, plats, festes, geografia, cultura i dites.

![Cercador](./docs/screenshots/cerca.png)

### 🗺️ Mapa interactiu
Mapa Leaflet amb tots els monuments geolocalitzats i popups amb informació detallada.

![Mapa](./docs/screenshots/mapa.png)

### 📚 Sobre Catalunya
Pàgina amb estadístiques, geografia, símbols culturals i dites catalanes.

![Sobre](./docs/screenshots/sobre.png)

### 🔐 Panell d'administració
CRUD complet de monuments protegit amb Basic Auth.

![Admin](./docs/screenshots/admin.png)

---

## 🎬 Demo en vídeo

> ⬇️ *(Opcional)* Afegeix aquí un GIF animat o vídeo de 30-60 segons mostrant la navegació.

![Demo](./docs/screenshots/demo.gif)
### Home
![Home](./docs/screenshots/home.png)

### Mapa interactiu
![Mapa](./docs/screenshots/mapa.png)

### Panell d'administració
![Admin](./docs/screenshots/admin.png)

## 🛠️ Comandes útils

```bash
# Veure logs en temps real
docker-compose logs -f

# Només del backend
docker-compose logs --tail=50 backend

# Consum de recursos (CPU, RAM)
docker stats

# Reiniciar un servei
docker-compose restart frontend

# Rebuild net (sense caché)
docker-compose build --no-cache

# Aturar i netejar
docker-compose down

# Esborrar també els volums (perd dades)
docker-compose down -v

# Entrar al backend
docker exec -it catalunya_backend sh

# Consola SQL
docker exec -it catalunya_db psql -U catalunya_user -d catalunya_db

# Backup de la BD
docker exec -t catalunya_db pg_dumpall -c -U catalunya_user > backup.sql

# Inspeccionar la xarxa interna
docker network inspect catalunya-app_catalunya_net
```

## 📁 Estructura del projecte

```
catalunya-app/
├── .env                      # Variables d'entorn (NO al repo)
├── .env.example              # Plantilla de variables
├── docker-compose.yml        # Orquestació dels 4 serveis
├── docker-compose.override.yml # Config de desenvolupament
├── LICENSE                   # MIT
├── README.md                 # Aquest fitxer
├── .github/
│   └── workflows/
│       └── ci.yml            # CI automàtic a cada push
├── db/
│   ├── init.sql              # Esquema inicial + dades base
│   ├── 02_ampliacion_datos.sql
│   ├── 03_fix_municipis_monuments.sql
│   └── 04_contingut_final.sql
├── backend/
│   ├── Dockerfile            # Multi-stage
│   ├── package.json
│   ├── server.js             # API Express
│   └── middleware/
│       └── auth.js           # Basic Auth
├── frontend/
│   ├── Dockerfile            # Multi-stage (Next.js standalone)
│   ├── package.json
│   ├── next.config.js
│   ├── app/
│   │   ├── layout.jsx        # Layout global (header, nav, footer)
│   │   ├── page.jsx          # Home
│   │   ├── comarques/        # /comarques
│   │   ├── monuments/        # /monuments
│   │   ├── gastronomia/      # /gastronomia
│   │   ├── cultura/          # /cultura
│   │   ├── cerca/            # /cerca?q=...
│   │   ├── sobre/            # /sobre
│   │   ├── mapa/             # /mapa (Leaflet)
│   │   └── admin/            # /admin (CRUD)
│   ├── components/
│   │   └── SearchBar.jsx
│   └── lib/
│       └── api.js
└── proxy/
    ├── Dockerfile
    └── nginx.conf            # Config del reverse proxy
```

## 🎯 Funcionalitats destacades

### 🔍 Cercador global
Consulta **9 taules simultàniament** amb suport per a accents (`unaccent` de PostgreSQL). Escriu "dali" i troba "Teatre-Museu Dalí".

### 🗺️ Mapa interactiu
Leaflet + OpenStreetMap amb tots els monuments geolocalitzats. Popups amb nom, tipus i municipi.

### 🔐 Panell d'administració
CRUD complet de monuments amb Basic Auth. Interfície web a `/admin` per afegir, editar i esborrar sense tocar la BD.

### 📱 Responsive
Funciona a mòbil, tauleta i escriptori. Menú adaptatiu, targetes en grid.

## 🚧 Roadmap

- [x] **Fase 1** — Infraestructura Docker (4 serveis, xarxa interna, healthchecks)
- [x] **Fase 2** — Migració a Next.js 14 amb App Router
- [x] **Fase 3A** — Contingut massiu (200+ registres)
- [x] **Fase 3B** — CRUD + Basic Auth + pàgina `/admin`
- [x] **Fase 3C** — Cercador global (9 taules)
- [x] **Fase 3D** — Frontend final (cercador UI, mapa, /sobre)
- [ ] **Fase 3E** — Modularització del backend (routes, controllers)
- [ ] **Fase 3F** — Pujada d'imatges amb volum persistent
- [ ] **Fase 4** — HTTPS amb Certbot + desplegament a VPS
- [ ] **Fase 5** — Desplegament al núvol (Render/Fly.io) amb enllaç en viu

## 🤝 Contribuir

Les contribucions són benvingudes! Si vols afegir contingut:

1. Fork el projecte
2. Crea una branca (`git checkout -b feature/nova-funcionalitat`)
3. Commit els canvis (`git commit -m 'feat: nova funcionalitat'`)
4. Push (`git push origin feature/nova-funcionalitat`)
5. Obre una Pull Request

## 📜 Llicència

Aquest projecte està sota la llicència **MIT** — veure [LICENSE](LICENSE).

## 🙏 Agraïments

- [OpenStreetMap](https://www.openstreetmap.org/) — mapes lliures
- [Leaflet](https://leafletjs.com/) — biblioteca de mapes
- [Next.js](https://nextjs.org/) — framework React
- [PostgreSQL](https://www.postgresql.org/) — base de dades
- Tota la comunitat de codi obert

---

<div align="center">

**Fet amb ❤️ per [@urukaisk-maker](https://github.com/urukaisk-maker)**

⭐ Si t'agrada el projecte, deixa una estrella!

</div>
