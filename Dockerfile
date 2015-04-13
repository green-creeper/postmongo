############################################################
# Dockerfile to build Postgres+Mongo to host NoiseOftheWorld DB
############################################################

FROM postgres

MAINTAINER NoiseOfTheWorld <andrey.korlyuk@gmail.com>

# Install MongoDB.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update
RUN apt-get install -y mongodb-org-server
RUN sed 's/^bind_ip/#bind_ip/' -i /etc/mongod.conf 
RUN rm -rf /var/lib/apt/lists/* # 20150323
#ADD start /start
#RUN chmod 755 /start
EXPOSE 27017
EXPOSE 28017
#VOLUME ["/var/lib/mongodb"]
#CMD ["/start"]



ENV DB_NAME noisedb
ENV DB_USER admin
ENV DB_PASS password

ADD setupRemoteConnections.sh /docker-entrypoint-initdb.d/setupRemoteConnections.sh
RUN chmod 755 /docker-entrypoint-initdb.d/setupRemoteConnections.sh
ADD setup-database.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/setup-database.sh
