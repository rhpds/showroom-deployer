# Use Red Hat Universal Base Image (UBI) 9 with the ubi9/nginx-122 image as the base image
FROM registry.access.redhat.com/ubi9/nginx-122

# Copy Nginx configuration
# Commented out: we now get our nginx config from configMap
#COPY nginx.conf /etc/nginx/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# Expose port 8080
EXPOSE 8080
ENV NGINX_DEFAULT_CONF_PATH=/showroom/
ENV NGINX_CONF_PATH=/showroom/
ENV NGINX_CONFIGURATION_PATH=/showroom/
# Set the user to run Nginx as a non-root user

# Start Nginx
CMD ["nginx", "-c", "/showroom/nginx.conf", "-g", "daemon off;"]
