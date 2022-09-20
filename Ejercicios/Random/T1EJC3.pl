[karla@pc-knn ~]$ export ORACLE_SID=knnbda1
[karla@pc-knn ~]$ sqlplus sys as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 19 19:10:33 2022
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Enter password: 
Connected to an idle instance.

idle> startup
ORACLE instance started.

Total System Global Area  805303360 bytes
Fixed Size		    8901696 bytes
Variable Size		  255852544 bytes
Database Buffers	  532676608 bytes
Redo Buffers		    7872512 bytes
Database mounted.
Database opened.
idle> create user karla01 identified by karla01 quota unlimited on users;
create user karla01 identified by karla01 quota unlimited on users
            *
ERROR at line 1:
ORA-01920: user name 'KARLA01' conflicts with another user or role name


idle> grant create session, create table to karla01;

Grant succeeded.

idle> grant sysdba to karla01;

Grant succeeded.

idle> desc v$pwfile_users;
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 USERNAME					    VARCHAR2(128)
 SYSDBA 					    VARCHAR2(5)
 SYSOPER					    VARCHAR2(5)
 SYSASM 					    VARCHAR2(5)
 SYSBACKUP					    VARCHAR2(5)
 SYSDG						    VARCHAR2(5)
 SYSKM						    VARCHAR2(5)
 ACCOUNT_STATUS 				    VARCHAR2(30)
 PASSWORD_PROFILE				    VARCHAR2(128)
 LAST_LOGIN					    TIMESTAMP(9) WITH TIME ZONE
 LOCK_DATE					    DATE
 EXPIRY_DATE					    DATE
 EXTERNAL_NAME					    VARCHAR2(1024)
 AUTHENTICATION_TYPE				    VARCHAR2(8)
 COMMON 					    VARCHAR2(3)
 CON_ID 					    NUMBER

idle> select username from v$pwfile_users;

USERNAME
--------------------------------------------------------------------------------
SYS
SYSBACKUP
KARLA0104
KARLA0105
KARLA0106
KARLA01

6 rows selected.

idle> shutdown immediate
Database closed.
Database dismounted.
ORACLE instance shut down.
idle> exit
Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
[karla@pc-knn ~]$ connect sys as sysdba
bash: connect: command not found
[karla@pc-knn ~]$ sqlplus sys as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 19 19:15:50 2022
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Enter password: 
Connected to an idle instance.

idle> connect sys as sysdba
Enter password: 
Connected to an idle instance.
idle> startup
ORACLE instance started.

Total System Global Area  805303360 bytes
Fixed Size		    8901696 bytes
Variable Size		  255852544 bytes
Database Buffers	  532676608 bytes
Redo Buffers		    7872512 bytes
Database mounted.
Database opened.
idle> revoke sysdba from karla01;

Revoke succeeded.

idle> select username from v$pwfile_users;

USERNAME
--------------------------------------------------------------------------------
SYS
SYSBACKUP
KARLA0104
KARLA0105
KARLA0106

idle> disconnect
Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
idle> 