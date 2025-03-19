#!/bin/bash

# Actualizar el sistema
apt-get update
apt-get -y

# Abrir el puerto 397 en el firewall
sudo ufw allow 397/tcp


# Opcional: Habilitar el firewall
sudo ufw enable

# Opcional: Reiniciar el firewall para aplicar los cambios
sudo ufw reload

# Editar el archivo de configuración de SSH para cambiar el puerto
sudo sed -i 's/#Port 22/Port 397/' /etc/ssh/sshd_config

# Reiniciar el servicio SSH para aplicar los cambios
sudo systemctl enable ssh
sudo systemctl restart ssh

# Opcional: Mostrar el estado del firewall
sudo ufw status

# Opcional: Mostrar el estado del servicio SSH
sudo systemctl status ssh

#instalar timeshift
sudo apt-get install timeshift

timeshift --create --comments "Initial Setup"
#timeshift --restore para volver a un punto anterior
#listados
systemctl list-units --type=service --state=running
#keygen
ssh-copy-id -p 397 -i ~/.ssh/id_rsa.pub usuario@<ip servidor>
# Instalar Snort
sudo apt-get install -y snort

# Configurar Snort (opcional, dependiendo de tus necesidades) ip+/32
# Aquí puedes agregar comandos adicionales para configurar Snort según tus requisitos específicos

# Mostrar el estado de Snort
sudo systemctl status snort

sudo nano /etc/snort/rules/local.rules

alert ip 92.119.141.208 any -> $HOME_NET any (msg:"Alert: Traffic from 92.119.141.208"; sid:1000001; rev:1;)

sudo nano /etc/snor/rules/icmp.rules
alert icmp any any -> any any (msg:"ICMP ping detected"; sid:1000002; rev:1;)
sudo systemctl restart snort
# Instalar Fail2Ban
sudo apt-get install -y fail2ban

# Configurar Fail2Ban (opcional, dependiendo de tus necesidades)
# Aquí puedes agregar comandos adicionales para configurar Fail2Ban según tus requisitos específicos

# Iniciar y habilitar Fail2Ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# Mostrar el estado de Fail2Ban
sudo systemctl status fail2ban

sudo ufw allow 2222/tcp
iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222

# Instalar Cowrie
sudo apt-get install git python3-venv libssl-dev libffi-dev build-essential libpython3-dev python3-minimal authbind

sudo adduser --disabled-password cowrie

sudo su - cowrie -c "
git clone http://github.com/cowrie/cowrie

cd cowrie

pwd
# debemos de estar en /home/cowrie/cowrie
python3 -m venv cowrie-env

source cowrie-env/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade -r requirements.txt
bin/cowrie start
"
#
#sudo cat /etc/shadow

#hashcat --identify hash.txt


#sudo nano /etc/login.defs

#buscar linea ENCRYTP_METHOD
#Cambiar a SHA256
#172.233.
#scp -P 397 root_passwords.txt 10.0.2.28:/home/user/codewordlist
# -r pa carpetas

#for i in {1..250}; do
#  echo "Probando https://geomancia.neocities.org/wordlist-$i.txt..."
#  status=$(curl -o /dev/null -s -w "%{http_code}" "https://geomancia.neocities.org/wordlist-$i.txt")
#  if [ "$status" -eq 200 ]; then
#    echo "Encontrado: https://geomancia.neocities.org/wordlist-$i.txt"
#    break
#  fi
#done

#for i in {251..500}; do
#  echo "Probando https://geomancia.neocities.org/wordlist-$i.txt..."
#  status=$(curl -o /dev/null -s -w "%{http_code}" "https://geomancia.neocities.org/wordlist-$i.txt")
#  if [ "$status" -eq 200 ]; then
#    echo "Encontrado: https://geomancia.neocities.org/wordlist-$i.txt"
#    break
# fi
#done

#wget -O wordlist.txt (ruta)