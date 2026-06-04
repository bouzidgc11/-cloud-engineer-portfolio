# Stage 1 — builder
FROM node:20-alpine AS builder
WORKDIR /build
COPY package.json .
RUN npm install --only=production
COPY . .

# Stage 2 — production
FROM node:20-alpine AS production
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /build/node_modules ./node_modules
COPY --from=builder /build/app.js .
COPY --from=builder /build/package.json .

RUN mkdir -p /app/logs && chown appuser:appgroup /app/logs

USER appuser

EXPOSE 3000
CMD ["node", "app.js"]