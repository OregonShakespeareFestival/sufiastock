#!/bin/bash

#Spin up the maria database
docker run -d --name hydraproductiondb andrewkrug/mariadb

#Spin up fedora4
docker run -d --name hydraproductionfedora andrewkrug/fedora4

#Spin up solr-latest
docker run -d --name hydraproductionsolr andrewkrug/solr

#Spin up osfsufia
docker run -d -p 80:80 -P --name osfsufiaproduction --link hydraproductiondb:hydraproductiondb --link hydraproductionfedora:hydraproductionfedora --link hydraproductionsolr:hydraproductionsolr andrewkrug/sufia
