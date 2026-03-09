# --------------------------- stage 1 : building stage ------------------------
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

# Build artifacts
RUN npm run build

## ------------------------ stage 2 : runtime stage -------------------------------------------
FROM  nginx:alpine

## creating non-root  user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/build  /usr/share/nginx/html

# Changing the OWner
RUN chown -R appuser:appgroup /usr/share/nginx/html

# switching the user
USER appuser

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;"]
