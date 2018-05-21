# AVAL-01-UTILS

## DESCRIPCIO

Conjunt d'scripts emprat al projecte AVAL per personalitzar l'escriptori de forma amena per l'administrador.

Aquests fitxers es monten en una unitat separada d'un LiveCD. 

L'script prepare.sh s'executa i personalitza l'escriptori d'acord amb els paràmetres especificades en el fitxer prepare.conf. 

Així mateix, s'inclou un programa en python que actúa com a frontend del fitxer prepare.conf.


## FITXERS I DIRECTORIS

- prepare.sh: script que configura el sistema d'acord amb l'especificat a prepare.conf
- prepare.conf: fitxer de configuració on s'hi especifiquen les característiques de la sessió.
- scripts: scripts varis
- scripts/set_allowmount.sh: script que de forma automàtica modifica el prepare.conf i aplica el prepare.sh per permetre o prohibir el muntatge d'unitats externes.
- ocs-config: programa fontend del prepare.conf
- desktop-shortcuts: plantilla base de l'escriptori del sistema



## FITXER DE CONFIGURACIO

AVAILABLE_APPS: Llista separada per comes de les aplicacions disponibles. De moment poden ser:

libreoffice-calc
libreoffice-writer
libreoffice-startcenter
pluma (editor de textos)
galculator (calculadora)
Per exemple, AVAILABLE_APPS=libreoffice-calc

ALLOW_INTERNET: Si es permet Internet o no. Pot ser: YES o NO. Si és YES apareixerà a l'escriptori una icona del navegador Firefox.

ALLOW_MOUNT_EXTERNAL: Si es permet muntar USBs i memòries externes o no.

HIGH_CONTRAST: Si s'habilita un tema d'alt contrast o un normal.

ADMIN: Pot ser YES o NO. Habilita un menú d'administració



