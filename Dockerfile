FROM node:16 AS dependencies

WORKDIR /app

COPY package*.json ./

RUN npm ci

FROM dependencies AS security-scan

RUN npm audit --audit-level=high

FROM dependencies AS app

COPY . .

EXPOSE 8080

CMD ["npm", "start"]
