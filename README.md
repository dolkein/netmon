
Simple Network Monitor Web Site

uses cron to run ping and speed tests, saving data in /etc/netmon.  Needs a web server to chart the results over time.  Very basic stuff here.  Wanted to know how my network was doing over time.

![Sample web data](https://github.com/dolkein/netmon/screenshot.png

Prerequisites:
Web Server with /var/www/html root folder (suggest lighthttp)
speedtest-cli installed

Instructions:
Download Zip asset file into temp folder
cd scripts folder
chmod 755 install.sh
sudo ./install.sh

Default file locations
/etc/netmon - scripts and data folders
/var/www/html/netmon/ - simple web page and javascript 
crontab - scripts to run speedtest and ping test to collect results.

Uninstall it !
cd scripts folder
chmod 755 uninstall.sh
sudo ./uninstall.sh

Note: delete all the downloaded files 

Developer Note:

Create clean ZIP on a Mac
zip -9 -r netmon.zip netmon -x "*/.DS_Store*" -x "*/.__MACOSX*" -x "\*.DS_Store\*" -x "\*.__MACOSX\*" -x "*/.settings*" -x "*/.project*"
