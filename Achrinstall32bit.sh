#!/bin/bash

# Verificar que el script se ejecuta como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script debe ejecutarse como root" 
   exit 1
fi

echo "Actualizando el sistema..."
pacman -Syu --noconfirm

echo "Instalando paquetes base..."
pacman -S --noconfirm base base-devel linux linux-firmware nano sudo networkmanager

echo "Habilitando NetworkManager..."
systemctl enable NetworkManager

echo "Creando usuario..."
useradd -m -G wheel -s /bin/bash usuario
echo "usuario:password" | chpasswd
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

echo "Instalando XFCE 4.20 y Wayland..."
pacman -S --noconfirm xfce4 xfce4-goodies wayland

echo "Instalando Librewolf..."
pacman -S --noconfirm librewolf

echo "Configurando entorno gráfico..."
echo "exec startxfce4" > /home/usuario/.xinitrc
chown usuario:usuario /home/usuario/.xinitrc

echo "Instalación completada. Reinicia el sistema."
