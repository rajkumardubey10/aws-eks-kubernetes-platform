FROM node:16 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

## stage 2 
FROM  node:16-alpine

## creating non-root  user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app /

RUN chown -R appuser:appgroup /app /node_modules

USER appuser

EXPOSE 3000

CMD [ "npm", "start" ]
