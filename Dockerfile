# ---- Etapa 1: Build ----
FROM node:22-alpine AS builder

WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm ci

# Copiar el resto del proyecto
COPY . .

# Construir el proyecto (genera dist/)
RUN npm run build


# ---- Etapa 2: Runtime ----
FROM node:22-alpine

WORKDIR /app

# Solo copiar dist/ (debe existir ya)
COPY --from=builder /app/dist ./dist

# Los archivos package... se copian antes
COPY package*.json ./

# Instalar dependencias necesarias para preview
RUN npm install --only=production

EXPOSE 4321

CMD ["npm", "run", "preview"]
