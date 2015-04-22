#!/bin/bash

#Spin up the maria database
docker run -d --name hydraproductiondb andrewkrug/mariadb

#Spin up jetty
docker run -d --name hydraproductionjetty andrewkrug/hydrajetty

#Spin up osfsufia
docker run -d -p 80:80 -P --name osfsufiaproduction --link hydraproductiondb:hydraproductiondb --link hydraproductionjetty:hydraproductionjetty  andrewkrug/osfdigitalarchive
