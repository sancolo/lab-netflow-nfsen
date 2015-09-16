#!/bin/bash

  echo "===> Update repository <==="
  sudo apt-get -y update

  echo "===> Instalando apache2 <==="
  sudo apt-get install -y apache2

  echo "===> Instalando softflowd <==="
  sudo apt-get install -y softflowd
  sudo cp /vagrant_data/softflowd /etc/default/
  sudo service softflowd restart

  echo "===> Instalando tcpdump <==="
  sudo apt-get install -y tcpdump
  
  echo "===> Instalando tree, mtr-tiny <==="
  sudo apt-get install -y tree mtr-tiny 
  
  echo "===> Instalando tshark <==="
  sudo apt-get install -y tshark 
 
  echo "===> Instalando nfdump <==="
  sudo apt-get install -y nfdump
  
  echo "===> Instalando nfsen <==="
  echo "===> Instalando paquetes requeridos"
  echo "===> php5 librrds-perl libmailtools-perl libsocket6-perl"
  sudo apt-get install -y php5 librrds-perl libmailtools-perl libsocket6-perl 

  echo "===> Bajando fuente nfsen"
  sudo wget http://downloads.sourceforge.net/project/nfsen/stable/nfsen-1.3.6p1/nfsen-1.3.6p1.tar.gz
  sudo tar xvzf nfsen-1.3.6p1.tar.gz 
  # cd nfsen-1.3.6p1
  echo "===> Creando usuario netflow" 
  sudo useradd netflow
  sudo adduser netflow www-data
  sudo mkdir -p /data/nfsen
  echo "===> Instalando nfsen.conf"
  cd nfsen-1.3.6p1/
  sudo ./install.pl /vagrant_data/nfsen.conf < /vagrant_data/nfsen.input
  sudo cp /vagrant_data/*.pm /data/nfsen/libexec
  sudo chown root:www-data /dat/nfsen/libexec/*.pm 
  echo "Inicializa nfsen" 
  sudo /data/nfsen/bin/nfsen start 

  echo "===> Habilita forwarding IPv4/IPv6 on de fly<==="
  sudo sysctl -w net.ipv4.ip_forward=1
  sudo sysctl -w net.ipv6.conf.all.forwarding=1
