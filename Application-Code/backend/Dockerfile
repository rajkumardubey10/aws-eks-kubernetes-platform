## Stage 1 
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

## Stage 2 

FROM node:18-alpine

## Creating the non-root user 
RUN addgroup -S appgroup && adduser -S appuser -G appgroup 

WORKDIR /app

## copy only the required artifacts from builder stage 
COPY --from=builder /app /app/

## change ownership 
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 3500

CMD ["node", "index.js"]