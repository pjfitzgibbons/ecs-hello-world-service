
postgres -D

createdb template_postgis

createlang plpgsql template_postgis
psql -d template_postgis -c "UPDATE pg_database SET datistemplate=true WHERE datname='template_postgis'"
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/postgis.sql
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/spatial_ref_sys.sql
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/postgis_comments.sql

psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/rtpostgis.sql
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/raster_comments.sql

psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/topology.sql
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-2.0/topology_comments.sql

killall postgres