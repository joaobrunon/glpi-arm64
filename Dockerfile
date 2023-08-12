# Use uma imagem base arm64. Aqui estamos usando PHP para o Debian.
FROM arm64v8/php:7.4-apache

# Atualize e instale dependências
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libldap2-dev libldap-2.4-2 libxmlrpc-epi-dev libbz2-dev libzip-dev \
       libicu-dev libxml2-dev libonig-dev

# Instalar extensões do PECL e habilitá-las
RUN pecl install apcu && docker-php-ext-enable apcu

# Instale extensões PHP que dependem de pacotes do sistema
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd ldap mysqli intl xmlrpc exif zip bz2 opcache

# Ative os módulos do Apache
RUN a2enmod expires headers rewrite

# Habilita AllowOverride All para a pasta GLPI
RUN echo '<Directory /var/www/html/glpi>' >> /etc/apache2/apache2.conf && \
    echo '    AllowOverride All' >> /etc/apache2/apache2.conf && \
    echo '</Directory>' >> /etc/apache2/apache2.conf

# Defina a pasta raiz do Apache para o diretório GLPI
ENV APACHE_DOCUMENT_ROOT /var/www/html/glpi

# Atualize a configuração do Apache
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

# Baixe e instale o GLPI. Ajuste para a versão desejada.
ENV GLPI_VERSION 9.5.6

RUN set -ex; \
    curl -o glpi.tar.gz -fSL "https://github.com/glpi-project/glpi/releases/download/${GLPI_VERSION}/glpi-${GLPI_VERSION}.tgz"; \
    tar -xzf glpi.tar.gz -C /var/www/html/; \
    chown -R www-data:www-data /var/www/html/glpi; \
    rm glpi.tar.gz

# Exponha a porta 80
EXPOSE 80
