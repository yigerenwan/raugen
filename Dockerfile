FROM ubuntu

# Install dependencies required for Apache
RUN apt-get update && apt-get install -y \
    apache2 \
    apache2-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of the application code
COPY ./docs/_build/html /var/www/html/

# Set proper permissions for Apache
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/

# Expose the port
EXPOSE 3000

# Configure Apache to run in foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]