
# ---- Etapa 1: build / dependències ----
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

# ---- Etapa 2: runtime mínim ----
FROM node:18-alpine AS runtime
WORKDIR /app
ENV NODE_ENV=production

# Usuari no-root per seguretat
RUN addgroup -S app && adduser -S app -G app

COPY --from=builder /app/node_modules ./node_modules
COPY --chown=app:app . .

USER app

EXPOSE 5000

HEALTHCHECK --interval=15s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:5000/health || exit 1

CMD ["node", "server.js"]
