# Dockerfile for the raugen-docs-html
FROM python:3.12.0

# Install dependencies required for Puppeteer
RUN apt-get update && apt-get install -y apache2 --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of the application code
COPY ./docs/_build/html /var/www/html/

# Expose the port
EXPOSE 80