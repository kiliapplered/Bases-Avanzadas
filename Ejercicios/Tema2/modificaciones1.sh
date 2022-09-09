# !/bin/bash
# @Autor Najera Noyola Karla Andrea
# @Fecha 31 de agosto de 2022
# @Descripción Modificaciones al archivo fstab

mount -o loop /dev/loop0/unam-bda/d01

cat /etc/fstab

# Loop devices para bda
/unam-bda/disk-images/disk1.img     /unam-bda/d01     auto      loop      0       0
/unam-bda/disk-images/disk2.img     /unam-bda/d02     auto      loop      0       0
/unam-bda/disk-images/disk3.img     /unam-bda/d03     auto      loop      0       0

# NOTA MENTAL: TENER MUCHO CUIDADO AL EJECUTAR ESTAS INSTRUCCIONES!!!!!!!!!!!!!!

# Sin reiniciarla poner lo siguiente para probar
sudo mount -a
df -h | grep "/*unam-bda/"
# Si ejecuta sin error, los archivos fueron montados de manera exitosa
# Nota: Podemos crear ligas para usar otros directorios (util en mi caso)