FROM mysql:latest
WORKDIR /mysql/data
ENV MYSQL_ROOT_PASSWORD=root
COPY db_restaurante.sql /docker-entrypoint-initdb.d/
COPY dw_restaurante.sql /docker-entrypoint-initdb.d/