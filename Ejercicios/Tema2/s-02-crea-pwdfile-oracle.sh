# !/bin/bash
# @Autor Najera Noyola Karla Andrea
# @Fecha 31 de agosto de 2022
# @Descripción Ejercicio 

echo "Creando archivos de passwords"

echo "configurando ORACLE_SID"
export ORACLE_SID="knnbda2"
echo "ORACLE_SID=${ORACLE_SID}"

echo "Creando archivos de passwords. Se sobreescribe si existe"
orapwd FORCE=Y \
  FILE='${ORACLE_HOME}/dbs/orapw${ORACLE_SID}' \
  FORMAT=12.2 \
  SYS=password

echo "Comprobando creación del archivo"
ls -l ${ORACLE_HOME}/dbs/orapw${ORACLE_SID}

# Nota: Colocar estos scripts en la carpeta de trabajo (unam-bda)
# Recomendable usar los permisos 755 para todo lo que hagamos

# Comentarios Random de Froylan xD (quitar antes de enviar a Campos)  
#hOLA 7U7 GUAPA 7U7
#cÓMO ANDAMOS? 7U7