FROM node:18-alpine

WORKDIR /app

# instalar dependencias (producción)
COPY package*.json ./
RUN npm install --production

# copiar el código
COPY . .

ENV NODE_ENV=production
EXPOSE 5000
CMD ["node", "server.js"]
