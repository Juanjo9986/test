FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:22-alpine
WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY --from=builder /app ./

EXPOSE 4321
CMD ["npm", "run", "preview"]
