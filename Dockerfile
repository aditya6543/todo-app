# Use an official lightweight Nginx image as a parent image
FROM nginx:alpine

# Copy the static content (your index.html file) to the default Nginx public directory
COPY index.html /usr/share/nginx/html

# Expose port 80 to allow traffic to the web server
EXPOSE 80

# The default command for the nginx image is to start the server,
# so no CMD is needed here.
