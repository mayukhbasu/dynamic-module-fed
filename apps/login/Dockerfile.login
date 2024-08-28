# Use an official Ubuntu 22.04 image
FROM ubuntu:22.04

# Install Nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Remove the default configuration file (optional, but ensures no conflicts)
RUN rm /etc/nginx/sites-enabled/default

# Copy your custom Nginx configuration file to the appropriate location
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the default server configuration file to the appropriate location
COPY default.conf /etc/nginx/sites-available/default

# Enable the site by creating a symlink in sites-enabled
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Copy the built login application files to the appropriate directory in Nginx
COPY dist/apps/login /var/www/html/login

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
