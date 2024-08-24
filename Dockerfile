# Stage 1: Use Nginx to serve the pre-built Angular applications
FROM nginx:alpine

# Copy Nginx configuration file (optional, if you have a custom configuration)
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the pre-built dashboard application files to the appropriate directory in Nginx
COPY dist/apps/dashboard /usr/share/nginx/html/dashboard

# Copy the pre-built login application files to the appropriate directory in Nginx
COPY dist/apps/login /usr/share/nginx/html/login

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
