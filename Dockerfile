# lightweight Node image with curl for HEALTHCHECK
FROM node:18-alpine
WORKDIR /app

# copy package.json first (layering) and app code
COPY package.json ./
COPY app ./app

# install curl for healthcheck (no node modules to install for this simple app)
RUN apk add --no-cache curl

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

CMD ["node", "app/index.js"]
