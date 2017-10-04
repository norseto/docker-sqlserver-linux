#!/bin/sh

# Wait for the SQL Server to come up
# tweak from https://github.com/twright-msft/mssql-node-docker-demo-app/issues/7
until /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -Q "SELECT 1"
do 
    (>&2 echo "Failed to connect to SQL Server; waiting 2 seconds...")
    sleep 2s
    echo "Trying again..."
done
echo "Success! SQL Server is ready."

# Run the setup script to create the DB and the schema in the DB
echo "Running initial setup scripts..."
for file in /docker-entrypoint-initdb.d/*
do
    case $file in
    *.sql) /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -i $file;;
    *.sh)  /bin/sh $file;;
    *)     echo "Skipped: $file";;
    esac
done

echo "Initial setup done. Now you can change sa's password."
echo "see https://docs.microsoft.com/sql/linux/quickstart-install-connect-docker"

