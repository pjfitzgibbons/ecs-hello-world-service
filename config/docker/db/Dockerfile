FROM postgres

RUN echo "host    all             all             0.0.0.0/0            md5" >> /etc/postgresql/9.3/main/pg_hba.conf

RUN apt-get -y update

RUN apt-get -y install build-essential postgresql-9.1 postgresql-server-dev-9.1 libxml2-dev \
    libproj-dev libjson0-dev libgeos-dev xsltproc docbook-xsl docbook-mathml libgdal-dev

RUN apt-get -y install nano-tiny wget

WORKDIR /tmp
RUN wget http://postgis.net/stuff/postgis-2.1.8dev.tar.gz
RUN tar xf postgis-2.1.8dev.tar.gz
WORKDIR /tmp/postgis-2.1.8dev
RUN ./configure && \
    make && \
    make install && \
    ldconfig && \
    make comments-install

RUN ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/shp2pgsql
RUN ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/pgsql2shp
RUN ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/raster2pgsql

RUN if [ ! -d /docker-entrypoint-initdb.d ]; then mkdir /docker-entrypoint-initdb.d; fi
ADD gis_initdb.sh /docker-entrypoint-initdb.d/gis_initdb.sh


expose 5432
