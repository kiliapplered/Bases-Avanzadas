#!/bin/bash
echo "Creando nuevo archivo de passwords"
#PASSWORD no es el mismo. Cuando se ejecute el comando pide el password de los usuarios SYS y SYSBACKUP
#Se colcan todos los usaurios que se crean por default al crear la base de datos
#FORMAT: Formato de sintaxis del archivo
orapwd FILE='${ORACLE_HOME}/dbs/orapwknnbda1' \
  FORMAT=12.2 \
  SYS=PASSWORD \ 
  SYSBACKUP=PASSWORD 

echo "Listo :D"

#Nota 1: usar un chmod 755 para poder ejecutar el archivo desde el usuario oracle.
#Nota 2: Oracle no puede ser administrador en el sistema operativo. 
#Nota 3: Oracle debe ejecutar este script debido a que otros usuarios no son los dueños. 
#Nota 4: Al ejecutarse, solicita las contraseñas de SYS y SYSBACKUP. Deble cumplir con al menos 8 caracteres, letras y números y un caracter especial. 
#Nota 5: Los usuarios siguen existiendo en el diccionario de datos. Solo se perdío su contraseña en el archivo de contraseñas. 