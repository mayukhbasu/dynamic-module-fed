# Use an official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Install Nginx
RUN apt-get update && apt-get install -y nginx && apt-get clean

# Add a non-root user for Nginx
RUN useradd -r -s /bin/false nginx

# Remove the default Nginx configuration file
RUN rm /etc/nginx/sites-enabled/default

# Copy built files for the dashboard and login applications
COPY dist/apps/dashboard /var/www/html/dashboard
COPY dist/apps/login /var/www/html/login

# Copy custom Nginx configuration


COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
