#!/bin/bash


source /home/prepare/prepare.conf

# 1. Aplicacions habilitades
shopt -s nullglob
for f in /home/examen/*.desktop; do
   rm -f "$f"
done

for i in $(echo $AVAILABLE_APPS | sed "s/,/ /g"); do
   cp "/home/prepare/desktop_shortcuts/$i.desktop" /home/examen/
   chown examen.examen "/home/examen/$i.desktop"
done

# 2. Allow internet
if [ "$ALLOW_INTERNET" == "YES" ]; then
   mv /etc/polkit-1/localauthority/50-local.d/ofs-restrict-internet.pkla /etc/polkit-1/localauthority/50-local.d/ofs-restrict-internet.no
   cp /home/prepare/desktop_shortcuts/internet.desktop /home/examen/
   chown examen.examen /home/examen/internet.desktop
   service network-manager start
else
   rm -rf /home/examen/internet.desktop
   mv /etc/polkit-1/localauthority/50-local.d/ofs-restrict-internet.no /etc/polkit-1/localauthority/50-local.d/ofs-restrict-internet.pkla
   service network-manager stop
fi

# 3. Allow mount external
if [ "$ALLOW_MOUNT_EXTERNAL" == "YES" ]; then
   mv /etc/polkit-1/localauthority/50-local.d/ofs-restrict-mount.pkla /etc/polkit-1/localauthority/50-local.d/ofs-restrict-mount.no
else
   mv /etc/polkit-1/localauthority/50-local.d/ofs-restrict-mount.no /etc/polkit-1/localauthority/50-local.d/ofs-restrict-mount.pkla
fi


# 4. HighContrast

# Translate Real Username to Real User ID
#RUSER_UID="1000"
#RUID="examen"

#if [ "$HIGH_CONTRAST" == "YES" ]; then
#	sudo -u ${RUID} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" dconf write /org/mate/marco/general/theme "'ContrastHigh'"
#	sudo -u ${RUID} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" gsettings set org.mate.desktop.interface icon-theme "'ContrastHigh'"
#	sudo -u ${RUID} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" gsettings set org.mate.marco.general theme "'ContrastHigh'"
#else
#	sudo -u ${RUID} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" gsettings set org.mate.desktop.interface gtk-theme "'Menta'"
#	sudo -u ${RUID} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" gsettings set org.mate.desktop.interface icon-theme "'Menta'"
#	sudo -u ${RUID} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" gsettings set org.mate.marco.general theme "'Menta'"
#fi

# 5. Admin
if [ "$ADMIN" == "YES" ]; then
   cp /home/prepare/desktop_shortcuts/matecc.desktop /home/examen/
   cp /home/prepare/desktop_shortcuts/mate-terminal.desktop /home/examen/
   cp /home/prepare/desktop_shortcuts/ocs-config.desktop /home/examen/
   cp /home/prepare/desktop_shortcuts/nav-fitx.desktop /home/examen/
   chown examen.examen /home/examen/matecc.desktop
   chown examen.examen /home/examen/mate-terminal.desktop
   chown examen.examen /home/examen/ocs-config.desktop
   chown examen.examen /home/examen/nav-fitx.desktop
else

   rm -rf /home/examen/matecc.desktop 
   rm -rf /home/examen/mate-terminal.desktop
   rm -rf /home/examen/ocs-config.desktop
   rm -rf /home/examen/nav-fitx.desktop

fi



exit 0
