# 🌍 Explorador de Catalunya

[![CI](https://github.com/urukaisk-maker/catalunya-app/actions/workflows/ci.yml/badge.svg)](https://github.com/urukaisk-maker/catalunya-app/actions/workflows/ci.yml)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?logo=docker&logoColor=white)
![Node.js](https://img.shields.io/badge/node.js-18-green)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)

Aplicació web dockeritzada amb arquitectura de microserveis que mostra informació turística i cultural de Catalunya: províncies, comarques, municipis i monuments amb coordenades.

## 🏗️ Arquitectura

| Servei | Tecnologia | Port intern | Port exposat |
|--------|-----------|-------------|--------------|
| `db` | PostgreSQL 15 | 5432 | (opcional 5432 via override) |
| `backend` | Node.js 18 + Express | 5000 | (opcional 5001 via override) |
| `frontend` | Nginx (HTML/JS estàtic) | 80 | (opcional 8080 via override) |
| `proxy` | Nginx reverse proxy | 80 | **8000 (únic punt d'entrada)** |

Tots els serveis comparteixen la xarxa interna `catalunya_net`.

## 🚀 Arrencar

```bash
cp .env.example .env    # edita els valors si vols
docker-compose up --build -d
