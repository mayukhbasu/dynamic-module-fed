# Dockerfile for building and running the Angular applications with Nginx
FROM nginx:alpine

# Remove the default configuration file (optional, but ensures no conflicts)
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx configuration file to the appropriate location
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the default server configuration file to the appropriate location
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy the pre-built dashboard application files to the appropriate directory in Nginx
COPY dist/apps/dashboard /etc/nginx/html/dashboard

# Copy the pre-built login application files to the appropriate directory in Nginx
COPY dist/apps/login /etc/nginx/html/login

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
