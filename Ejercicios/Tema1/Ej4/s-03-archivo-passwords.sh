#! /bin/bash
# @Autor: 	   Najera Noyola Karla Andrea
# @Fecha creación: 27/07/2022
# @Descripción:    Script 3 del ejercicio 4: Archivo de passwords

echo "Realizando respaldo del archivo de passwords"
cd ${ORACLE_HOME}/dbs/
mkdir /home/${USER}/backups
mv orapwknnbda1 /home/${USER}/backups

echo "Eliminando archivo"
rm -f orapwknnbda1

echo "Creando nuevo archivo de passwords"
# PASSWORD no es el mismo. Cuando se ejecute el comando pide el password de los usuarios SYS y SYSBACKUP
# Se colocan todos los usaurios que se crean por default al crear la base de datos
# FORMAT: Formato de sintaxis del archivo
orapwd file='${ORACLE_HOME}/dbs/orapwknnbda1' force=y format=12.2 sys=password sysbackup=password 

echo "Listo :D"

# Nota 1: usar un chmod 755 para poder ejecutar el archivo desde el usuario oracle.
# Nota 2: Oracle no puede ser administrador en el sistema operativo. 
# Nota 3: Oracle debe ejecutar este script debido a que otros usuarios no son los dueños. 
# Nota 4: Al ejecutarse, solicita las contraseñas de SYS y SYSBACKUP. Deble cumplir con al menos 8 caracteres, letras y números y un caracter especial. 
# Nota 5: Los usuarios siguen existiendo en el diccionario de datos. Solo se perdío su contraseña en el archivo de contraseñas. 
