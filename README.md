# SQL Server Linux Developer Edition
### Predefined environments in this container
1. SA_PASSWORD : `<YourStrong!Passw0rd>`
1. ACCEPT_EULA : `Y`
1. MSSQL_PID : `Developer`

### Installation
`docker pull norseto/sqlserver-linux`

### Database creation on startup
Create database creation sql file and save as `.sql` file.

---
[Sample sql file]

    CREATE DATABASE Work;
    GO
    ALTER DATABASE Work SET RECOVERY SIMPLE;
    ALTER DATABASE Work SET ALLOW_SNAPSHOT_ISOLATION ON;
    CREATE LOGIN foo WITH PASSWORD='bar', DEFAULT_DATABASE=Work, CHECK_POLICY=OFF;
    GO

    USE Work;
    CREATE USER foo FOR LOGIN foo WITH DEFAULT_SCHEMA=dbo;
    GO
    sp_addrolemember 'db_datawriter', 'foo';
    GO
    sp_addrolemember 'db_datareader', 'foo';
    GO

    CREATE TABLE TEST_TABLE (
      ID int primary key,
      NAME nvarchar(50)
    )
    GO

---
Start the container. The container runs .sql or .sh files in the /docker-entrypoint-initdb.d when master db does not exist.

`docker run -d -p 1403:1403 -v SQL_FILE_DIRECTORY:/docker-entrypoint-initdb.d norseto/sqlserver-linux`

Change SQL_FILE_DIRECTORY to the director .sql file exists.    
      
