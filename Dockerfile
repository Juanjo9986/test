# ---- Etapa 1: Build ----
FROM node:22-alpine AS builder

WORKDIR /app

# Copiar solo archivos necesarios para instalar dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del proyecto
COPY . .

# Compilar el proyecto
RUN npm run build


# ---- Etapa 2: Runtime ----
FROM node:22-alpine

WORKDIR /app

# Copiar solo la carpeta dist (salida del build)
COPY --from=builder /app/dist ./dist

# Instalar dependencias de producción
COPY package*.json ./
RUN npm install --only=production

EXPOSE 4321

# Ejecutar la app
CMD ["npm", "run", "preview"]
