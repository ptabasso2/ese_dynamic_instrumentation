#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

createKeyspace () {

cat << EOF > /tmp/cass.cql
   CREATE KEYSPACE IF NOT EXISTS pejman WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1};
   CREATE TABLE IF NOT EXISTS pejman.guide (id timeuuid PRIMARY KEY, title text, description text, published boolean);
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'janig');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
   insert into pejman.guide (id,description,published,title) values (now(), 'test', false, 'pejman');
EOF

    until cqlsh -f /tmp/cass.cql; do
        echo "Waiting for cassandra to start..."
        sleep 1
    done
}


# Using docker-entrypoint.sh from dockerhub image cassandra:2
createKeyspace & docker-entrypoint.sh cassandra -f
