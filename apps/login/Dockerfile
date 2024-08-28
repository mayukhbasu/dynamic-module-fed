# Use an official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y nginx && apt-get clean

# Copy built files to the appropriate directory
COPY dist/apps/login /var/www/html/login

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
