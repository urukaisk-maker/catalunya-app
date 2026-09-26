# 🌍 Explorador de Catalunya 🏔️

[![CI](https://github.com/urukaisk-maker/catalunya-app/actions/workflows/ci.yml/badge.svg)](https://github.com/urukaisk-maker/catalunya-app/actions/workflows/ci.yml)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?logo=docker&logoColor=white)
![Node.js](https://img.shields.io/badge/node.js-18-green)
![Next.js](https://img.shields.io/badge/Next.js-14-black)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)

Plataforma web dockerizada per explorar la riquesa cultural, geogràfica i gastronòmica de les províncies, comarques i municipis de Catalunya. Dissenyada amb una arquitectura de microserveis, aquesta aplicació separa la capa de dades, la lògica del servidor i la interfície d'usuari en entorns aïllats i escalables.

## 🚀 Arquitectura del Projecte

| Component | Tecnologia | Rol |
|-----------|-----------|-----|
| **Frontend** | Next.js 14 + Nginx (proxy invers) | Interfície web responsiva amb rutes dinàmiques |
| **Backend** | Node.js 18 + Express | API RESTful per a consultes i enrutament de dades |
| **Base de Dades** | PostgreSQL 15 | Volums persistents per a patrimoni i geografia |
| **Orquestació** | Docker Compose | Xarxa interna `catalunya_net` + desplegament sincronitzat |

## 🛠️ Instal·lació i Desplegament Local

**1. Clonar el repositori:**

```bash
git clone https://github.com/urukaisk-maker/catalunya-app.git
cd catalunya-app
```

**2. Configurar variables d'entorn:**

```bash
cp .env.example .env
```

**3. Construir i aixecar la infraestructura:**

```bash
docker-compose up --build -d
```

**4. Accés a la plataforma:**

Obre el navegador a 👉 **http://localhost:8000**

> 🔌 El backend opera internament al port `5000`, la base de dades al `5432` i el frontend Next.js al `3000`. Tots tres accessibles internament per la xarxa `catalunya_net`. El proxy invers exposa tot a través del port `8000`.

## 🔌 Endpoints de l'API

| Mètode | Ruta | Descripció |
|--------|------|-----------|
| GET | `/health` | Estat del backend + BD |
| GET | `/api/provincies` | Llista de províncies |
| GET | `/api/provincies/:id/comarques` | Comarques d'una província |
| GET | `/api/provincies/:id/monuments` | Monuments d'una província |
| GET | `/api/comarques/:id/municipis` | Municipis d'una comarca |
| GET | `/api/monuments?tipus=Romà` | Monuments (filtre opcional) |
| GET | `/api/plats` | Plats tradicionals |
| GET | `/api/festes` | Festes i tradicions |
| GET | `/api/cerca?q=dalí` | Cercador global |

## ⚠️ Resolució de Problemes Freqüents

**Sobrecàrrega del Sistema (CPU al 98%):** Si al construir les imatges de Node.js notes que el sistema es ralentitza, atura el procés immediatament i neteja la caché:

```bash
docker builder prune -af
docker image prune -af
docker-compose up --build -d
```

**Errors de connexió al navegador:** Comprova l'estat amb `docker ps`. Si el frontend no respon, reinicia'l de forma aïllada:

```bash
docker-compose restart frontend
```

**Pèrdua de dades:** Si la informació desapareix al reiniciar, comprova que el volum `catalunya_data` estigui definit correctament al `docker-compose.yml` i que `./db/init.sql` estigui muntat com a `/docker-entrypoint-initdb.d/init.sql`.

## 📜 Llicència

MIT — veure [LICENSE](LICENSE)
