
# ocsconfig:
# Aplicacio grafica que permet modificar els permisos que se li donaran a l'usuari examen escrivint al fitxer prepare.conf

import sys,os
import pyforms
from   pyforms          import BaseWidget
from   pyforms.controls import ControlText
from   pyforms.controls import ControlButton
from   pyforms.controls import ControlCheckBox
from   pyforms.controls import ControlCheckBoxList
import re

FILE="/home/prepare/prepare.conf"

class OCSConfig(BaseWidget):

    def truetoyes(self, a):
       if a == True:
          return "YES"
       else:
          return "NO"

    def yestotrue(self, a):
       if a == "YES":
          return True
       else:
          return False

    def __init__(self):
        super(OCSConfig,self).__init__('Restrictor de permisos')

        avail_apps=""
        avail_apps_list=[]
        internet=False
        external=False
        admin=False

        try: 
           f = open(FILE)
           for line in f:
              if line[0] != "#":
                 if line.find("AVAILABLE_APPS") > -1:
                    avail_apps=line.split("=")[1][:-1]
                 elif line.find("ALLOW_INTERNET") > -1:
                    if line.split("=")[1].find("YES") > -1:
                       internet=True
                    else:
                       internet=False
                 elif line.find("ALLOW_MOUNT_EXTERNAL") > -1:
                    if line.split("=")[1].find("YES") > -1:
                       external=True
                    else:
                       external=False
           
                 elif line.find("ADMIN") > -1:
                    if line.split("=")[1].find("YES") > -1:
                       admin=True
                    else:
                       admin=False
           f.close()
           avail_apps_list=avail_apps.split(",")
        except:
           print("Fitxer "+FILE+" inexistent. El cream.")

        #Definition of the forms fields
        self._internet     = ControlCheckBox('Permet Internet')
        self._internet.value = internet
        self._externaldev     = ControlCheckBox('Permet dispositius externs')
        self._externaldev.value = external
        self._apps = ControlCheckBoxList("Llista d'aplicacions disponibles")
        self._apps +=   ('libreoffice-calc','libreoffice-calc' in avail_apps_list)
        self._apps +=   ('libreoffice-writer','libreoffice-writer' in avail_apps_list)
        self._apps +=   ('libreoffice-startcenter','libreoffice-startcenter' in avail_apps_list)
        self._apps +=   ('pluma','pluma' in avail_apps_list)
        self._apps +=   ('galculator','galculator' in avail_apps_list)

        self._admin      = ControlCheckBox('Mode administrador', admin)
        self._admin.value = admin
        self._bapply        = ControlButton('Aplica')
        self._bexit        = ControlButton('Surt')
        self._bapply.value = self.__buttonActionApply
        self._bexit.value = self.__buttonActionCancel
        self.formset = [ ('_internet', '_externaldev'), '_apps', '_admin', ('_bapply','_bexit'), ' ' ]


    def __buttonActionApply(self):
        """Button action event"""
        f = open(FILE,'w')
        f.write("AVAILABLE_APPS="+str(self._apps.value).replace('\'','').replace('[','').replace(']','').replace(' ','') +"\n")
        f.write("ALLOW_INTERNET="+self.truetoyes(self._internet.value)+"\n")
        f.write("ALLOW_MOUNT_EXTERNAL="+self.truetoyes(self._externaldev.value)+"\n")
        f.write("ADMIN="+self.truetoyes(self._admin.value)+"\n")
        f.close()
        os.popen("/bin/bash /home/prepare/prepare.sh")
    
    def __buttonActionCancel(self):
        """Button action event"""
        sys.exit()

#Execute the application
if __name__ == "__main__":   pyforms.start_app( OCSConfig )
