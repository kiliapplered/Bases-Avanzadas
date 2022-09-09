# !/bin/bash
# @Autor Najera Noyola Karla Andrea
# @Fecha 31 de agosto de 2022
# @Descripción Ejercicio 

echo "Creando dispositivos con loop devices"

echo "Creando /unam-bda/disk-images"
mkdir -p /unam-bda/disk-images

cd /unam-bda/disk-images

echo "Creando disk*.img"
dd if=/dev/zero of=disk1.img bs=100M count=10
dd if=/dev/zero of=disk2.img bs=100M count=10
dd if=/dev/zero of=disk3.img bs=100M count=10

echo "Mostrando la creación de los archivos"
du -sh disk*img

echo "Asociando los archivos img a loop devices"
losetup -fP disk1.img
losetup -fP disk2.img
losetup -fP disk3.img

echo "Comprobando la asociacion de los loop devices"
losetup -a

echo "Dando formato ext4 a los 3 archivos img"
mkfs.ext4 disk1.img
mkfs.ext4 disk2.img
mkfs.ext4 disk3.img

echo "Crear los directorios donde los dispositivos serán montados"
mkdir /unam-bda/d01
mkdir /unam-bda/d02
mkdir /unam-bda/d03

echo "Editar /etc/fstab de forma manual"