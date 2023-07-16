# Use an official PHP image as the base image
FROM php:7.4-apache

# Set the working directory inside the container
WORKDIR /var/www/html

# Install libcurl dependencies and the required version
RUN apt-get update && apt-get install -y libcurl4-openssl-dev

# Install required PHP extensions and their dependencies
RUN apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libonig-dev \
    libzip-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql json zip gd mbstring curl xml bcmath

# Copy the CS-Cart files into the container
COPY . /var/www/html

# Enable Apache mod_rewrite module
RUN a2enmod rewrite

# # Configure Apache document root and AllowOverride
# RUN sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/public/' /etc/apache2/sites-available/000-default.conf
# RUN printf "\n<Directory \"/var/www/html/public\">\n\tOptions Indexes FollowSymLinks\n\tAllowOverride All\n\tRequire all granted\n</Directory>\n" >> /etc/apache2/apache2.conf

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service
CMD ["apache2-foreground"]
