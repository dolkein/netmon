#!/bin/sh

cwd=$(pwd)

DIR="/var/www/html/"
if [ -d "$DIR" ]; then
  echo "Found web server folder in ${DIR}..."
else
  echo "Exiting: Need to have a web server folder at ${DIR}..."
  echo "Suggest installing lighthttp - sudo apt install lighttpd"
  exit
fi

if [ -e "/usr/bin/speedtest-cli" ]; then
  echo "Found speedtest-cli"
else 
  echo "Exiting: Need to have a speedtest-cli installed"
  echo "Use sudo apt-get install speedtest-cli"
  exit
fi

DIR="/etc/netmon/"
if [ -d "$DIR" ]; then
  echo "Upgrading netmon in ${DIR}..."
else
  echo "Creating netmon in ${DIR}..."
  sudo mkdir ${DIR}
  sudo mkdir ${DIR}/data
fi

DIR="/var/www/html/netmon/"
if [ -d "$DIR" ]; then
  echo "Found netmon web folder in ${DIR}..."
else
  echo "Creating netmon web folder at ${DIR}..."
  sudo mkdir ${DIR}
fi

echo "Copying files into /var/www/html ..."
sudo cp ../index.html ${DIR}/.
sudo cp -R ../Chart ${DIR}/.
sudo cp -R ../js ${DIR}/.
sudo cp  ../scripts/speedtest.sh /etc/netmon/.
sudo cp  ../scripts/pingtest.sh /etc/netmon/.

sudo chmod 755 /etc/netmon/pingtest.sh
sudo chmod 755 /etc/netmon/speedtest.sh

cd /var/www/html/netmon
sudo ln -s /etc/netmon/data data
cd $cwd

sudo chmod 777 /etc/netmon/data

echo "Generating initial data (30 seconds) ..."
sudo /etc/netmon/speedtest.sh
sudo /etc/netmon/pingtest.sh
sudo chmod 777 /etc/netmon/data/*.csv

CHECK=$(crontab -l | egrep -v "^(#|$)" | grep -q 'speedtest.sh'; echo $?)
if [ "$CHECK" -eq "1" ]; then
    echo "Installing crontab speedtest..."
    crontab -l > mycron
    echo '*/15 * * * * /etc/netmon/speedtest.sh' >> mycron
    crontab mycron
    rm mycron
else 
    echo "Already setup for crontab speedtest..."
fi

CHECK=$(crontab -l | egrep -v "^(#|$)" | grep -q 'pingtest.sh'; echo $?)
if [ "$CHECK" -eq "1" ]; then
    echo "Installing crontab pingtest..."
    crontab -l > mycron
    echo '*/5 * * * * /etc/netmon/pingtest.sh' >> mycron
    crontab mycron
    rm mycron
else 
    echo "Already setup for crontab pingtest..."
fi


