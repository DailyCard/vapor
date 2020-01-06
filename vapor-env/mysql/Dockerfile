FROM mysql:latest

LABEL maintainer="roni"
LABEL description="Docker container for Swift Vapor development"

RUN mkdir /run/secrets

ADD mysql /run/secrets/mysql

docker run --name mysql -it \
    -e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/mysql \
    -e MYSQL_USER_FILE=/run/secrets/mysql \
    -e MYSQL_PASSWORD_FILE=/run/secrets/mysql \
    -e MYSQL_DATABASE_FILE=/run/secrets/mysql \
    -p 33060:3306 \
    -v ~/Desktop/github/vapor/vapor-env/myvapor-db:/var/lib/mysql \
    --rm -d boxue/mysql:0.1.0
