#!/bin/bash

wget -O /etc/newadm/painel.zip https://github.com/EL-MERCENARIO/ADM-MANAGER-DANKELTHAHER/blob/master/request/painel.zip?raw=true /dev/null 2>&1
wget -O /etc/newadm/dados.zip https://github.com/EL-MERCENARIO/ADM-MANAGER-DANKELTHAHER/blob/master/request/dados.zip?raw=true /dev/null 2>&1

ve="\033[1;32m";am="\033[1;33m";ver="\033[1;31m";az="\033[1;36m";f="\033[0m"

meu_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && ip="$MEU_IP2" || ip="$MEU_IP"
}
meu_ip
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
BARRA="\e[0;31m======================================================\e[0m"
clear
cowsay -f eyes "Esta herramienta crea un panel en el cual deves de subir servers para que los demas usuarios descarguen.." | lolcat 
figlet ..ADM-PLUS.. | lolcat
sleep 2
echo -e "$BARRA"
echo -e "${ver}            +++++ ATENCION +++++${am} "
echo -e "$BARRA"
echo -e "TODAS LAS CONTRASENAS A SEGUIR COLOCAR SIEMPRE LA MISMA${f}"
echo -e "$BARRA"
read -p "Enter, Para Continuar!"
echo -e "$BARRA"
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
apt-get install mysql-server php5-mysql -y
mysql_install_db
echo ""
echo -e "${am}Siempre que se le solicite${ver}[Y/N]${am}elija la opcion${ver}Y${am} y presione ${ve}OK.${am} para todo lo que pide la instalacion!"
echo -e "$BARRA"
echo -e "${am}El siguiente procedimiento de instalacion te va a pedir una contrasena, escriba la contrasena que escribio antes y reconfirmala y despues solo ir presionando ${ver}Y${f}"
echo -e "$BARRA"
read -p "Enter, Para Continuar!"
mysql_secure_installation
echo -e "${az}ESPERE INSTALANDO LOS PAQUETES NECESARIOS${f}"
sleep 2
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
echo ""
stty -echo
tput setaf 7 ; tput bold ; read -p "Introduzca la misma contrasena (MySQL Password): " var7 ; tput sgr0
echo ""
echo -e "$BARRA"
stty echo ; echo
mysql -h localhost -u root -p$var7 -e "CREATE DATABASE adm"
echo -e "${ver}ATENCION - LOGIN Y CONTRASENA A SEGUIR ES PERSONAL NO DIVULGUEN ${f}"
echo -e "$BARRA"
echo ""
echo -e "${am}Ahora vamos a poner un LOGIN y CONTRASENA de acceso a la pagina de carga${ve}"
echo -e "$BARRA"
	read -p "Login: " var2
	read -p "Senha: " var3
	echo -ne "${f}"

cd /var/www/
   rm -rf index.html > /dev/null 2>&1
   cp /etc/newadm/painel.zip /var/www/
   unzip painel.zip > /dev/null 2>&1
   rm -rf painel.zip > /dev/null 2>&1
   chmod -R 777 /var/www/adm > /dev/null 2>&1
sed -i "s;123;$var7;g" /var/www/adm/system/seguranca.php > /dev/null 2>&1

cd /var/www/html/panelacm
   rm -rf index.html > /dev/null 2>&1
   cp /etc/newadm/painel.zip /var/www/html/panelacm
   unzip painel.zip > /dev/null 2>&1
   rm -rf painel.zip > /dev/null 2>&1 
   chmod -R 777 /var/www/html/adm > /dev/null 2>&1
sed -i "s;123;$var7;g" /var/www/html/adm/system/seguranca.php > /dev/null 2>&1

[[ ! -d /var/www/temp ]] && mkdir /var/www/temp
cd /var/www/temp && cp /etc/newadm/dados.zip /var/www/temp/
unzip dados.zip > /dev/null 2>&1

sed -i "s;adm123;$var2;g" ./banco_de_dados.sql > /dev/null 2>&1
sed -i "s;adm4321;$var3;g" ./banco_de_dados.sql > /dev/null 2>&1

mysql -h localhost -u root -p$var7 adm < banco_de_dados.sql > /dev/null 2>&1
rm -rf /var/www/temp
echo -e "$BARRA"
echo -e "${am}PANEL DE CARGA DE ACM INSTALADO PARA ENTRAR EN SU PANEL ACCESO${az}

"${ver}Url: ${ve}$ip:81/panelacm/login.php
echo -e "${am}Login: ${ve}$var2
"${am}Contrasena: ${ve}$var3
echo -e "${am}LINK PAGINA INICIAL ${ve}( $ip:81/panelacm )
${az}-------------------------------------------------------------------${f}"
echo -e "${am}"
read -p "Presione ENTER, Para continuar" naoa
sleep 2
echo -e "${f}"
exit
