@ECHO OFF

SET PGPATH=D:\PostgreSQL\11\bin\psql

SET DATABASE=study
SET DBUSR=postgres
SET PGPASSWORD=12345678
SET IPADDRESS=localhost
SET PORT=5432


%PGPATH% -h %IPADDRESS% -p %PORT% -d %DATABASE% -U %DBUSR% -f MST_���[�U�[���.sql


%PGPATH% -h %IPADDRESS% -p %PORT% -d %DATABASE% -U %DBUSR% -f STY_�P����.sql
%PGPATH% -h %IPADDRESS% -p %PORT% -d %DATABASE% -U %DBUSR% -f STY_�P��e�X�g���.sql
%PGPATH% -h %IPADDRESS% -p %PORT% -d %DATABASE% -U %DBUSR% -f STY_�P��e�X�g�ڍ׏��.sql

pause
