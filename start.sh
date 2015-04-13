#!/bin/bash
set -e
chown -R mongodb:mongodb /var/lib/mongodb
exec sudo -u mongodb -H /usr/bin/mongod --config /etc/mongod.conf --httpinterface --rest