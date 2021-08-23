# kevs installer on a raspi
# for Mountain Culture Dolly brew :-)

HERE=$PWD
cp $HERE/kjsl_flow/flow.json $HOME

if [ ! -f ~/kjsl_tilt ]; then 

echo "Installing Tilt Pi"

sudo apt-get update
sudo apt-get -y install python3-distutils
sudo apt-get -y install bluez bluez-hcidump bluez-firmware wpasupplicant

pip install --upgrade pip
sudo apt-get -y install libbluetooth-dev
sudo pip3 install bluepy pybluez

git clone https://github.com/kevleyski/aioblescan.git

cd aioblescan
sudo -H python3 setup.py install

# node red
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --nodered-version="0.18.4"

cd ~/.node-red
sudo -H npm install node-red-dashboard@2.15.5


touch ~/kjsl_tilt

echo "You need to reboot then run kjsl_install.sh again"
exit

fi

# step 2

sudo systemctl enable nodered.service
sudo systemctl start nodered.service

curl -X POST http://localhost:1880/flows -H "Content-Type: application/json" -H "Node-RED-Deployment-Type: nodes" --data "@/home/pi/flow.json"

echo "Web browser: http://<this_raspberry_pi_ip>:1880/ui"

