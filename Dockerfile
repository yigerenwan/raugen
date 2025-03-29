FROM ubuntu 

# Install dependencies required for Puppeteer
RUN apt update && apt install -y apache2 apache2-utils  \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of the application code
COPY ./docs/_build/html /var/www/html/

# Expose the port
EXPOSE 80

CMD [“apache2ctl”, “-D”, “FOREGROUND”]