#!/bin/sh
# determine first time execution.
if [ ! -f "/var/opt/mssql/data/master.mdf" ] ; then
    /mssql-setup.sh &
fi
/opt/mssql/bin/sqlservr
