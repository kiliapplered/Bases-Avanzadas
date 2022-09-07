# !/bin/bash
# @Autor Najera Noyola Karla Andrea
# @Fecha 17 de agosto de 2022
# @Descripción Ejercicio práctico 02 - Tema 1

#
# Variables que se obtienen a partir de la llamada en consola
#
archivoImagenes="${1}"
numImagenes="${2}"
archivoZip="${3}"

#
# Función encargada de mostrar ayuda en la pantalla
#
function ayuda(){
  codigoSalida="${1}"
  cat s-02-ayuda.sh
  exit "${codigoSalida}"
}

#
# Validación de parámetros
#

# Validar no nulo
if [ -z "${archivoImagenes}" ]; then
  echo "ERROR: El nombre del archivo de imagen no está especificado"
  ayuda 100
else
  # Validar que exista
  if ! [ -f "${archivoImagenes}" ]; then
    echo "ERROR: El nombre del archivo de imagen no existe"
    ayuda 101
  fi;
fi;

# Validar número de imágenes
if ! [[ "${numImagenes}" =~ [0-9]+ && "${numImagenes}" -gt 0 &&
  "${numImagenes}" -le 90 ]]; then
  echo "ERROR: El número de imágenes especificado no es válido"
  ayuda 102
fi;

# Si se especifica ruta de salida, checar que exista el directorio
if [ -n "${archivoZip}" ]; then
  dirSalida=$(dirname "${archivoZip}")
  nombreZip=$(basename "${archivoZip}")
  
  if ! [ -d "${dirSalida}" ]; then
    echo "ERROR: Directorio de salida no existe"
    ayuda 103
  fi;
else
  dirSalida="/tmp/${USER}/imagenes"
  mkdir -p "${dirSalida}"
  nombreZip="imagenes-$(date '+%Y-%m-%d-%H-%M-%S').zip"
fi;

#
# Leer archivo de imágenes
#
count=0
while read -r linea
do
  if [ "${count}" -ge "${numImagenes}" ]; then
    echo "Total de imágenes obtenidas: ${count}"
    break;
  fi;
  wget -q -p "${dirSalida}" "${linea}"
  status=$?
  if ! [ "$status" -eq 0 ]; then
    echo "ERROR: no se puede descargar imagen"
    ayuda 104
  fi;
  count=$((count+1))
done < "${archivoImagenes}"

#Inicialización de la variable de entorno
export IMG_ZIP_FILE = ${dirSalida}/${nombreZip}
rm -f "${IMG_ZIP_FILE}"
# Creación del archivo zip y cambiando sus permisos
zip -j "${IMG_ZIP_FILE}" "${dirSalida}/*"
chmod 600 "${IMG_ZIP_FILE}"
# Generación del archivo de texto
unzip -zl "${IMG_ZIP_FILE}" > "${dirSalida]"/s-00-lista-archivos.txt"
rm -f "${dirSalida}/*.jpg"