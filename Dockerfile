# Stage 1: Build the application
FROM node:10-alpine AS node
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json /app/
RUN npm install

# Copy the entire application
COPY ./ /app/

# Set build target (e.g., production or deployment)
ARG TARGET=ng-deploy
RUN npm run ${TARGET}

# Stage 2: Serve the application with Nginx
FROM nginx:1.13
COPY --from=node /app/dist/ /usr/share/nginx/html

# Copy custom Nginx configuration
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for HTTP traffic
EXPOSE 80
