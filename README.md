# Explorador de Catalunya

Aplicación web dockerizada que muestra información turística de las cuatro provincias de Catalunya.

## Arquitectura

| Servicio | Tecnología | Puerto |
|----------|-----------|--------|
| db | PostgreSQL 15 | 5432 |
| backend | Node.js + Express | 5000 |
| frontend | Nginx + HTML/JS | 8080 |

## Arrancar

    docker-compose up --build -d

Abrir: http://localhost:8080

## Comandos útiles

- Ver logs: `docker-compose logs -f`
- Consumo: `docker stats`
- Parar: `docker-compose down`
- Rebuild sin cache: `docker-compose build --no-cache`
