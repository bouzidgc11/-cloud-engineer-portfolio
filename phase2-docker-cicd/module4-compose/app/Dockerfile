# ===== STAGE 1 : builder =====
FROM node:20-alpine AS builder

WORKDIR /build

COPY package.json ./
RUN npm install --only=production

COPY . .

# ===== STAGE 2 : production =====
FROM node:20-alpine AS production

WORKDIR /app

# Crée un utilisateur non-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copie depuis le builder
COPY --from=builder /build/node_modules ./node_modules
COPY --from=builder /build/app.js ./
COPY --from=builder /build/package.json ./

# Crée le dossier de logs et donne les droits à appuser
RUN mkdir -p /app/logs && chown appuser:appgroup /app/logs

USER appuser

EXPOSE 3000

CMD ["node", "app.js"]