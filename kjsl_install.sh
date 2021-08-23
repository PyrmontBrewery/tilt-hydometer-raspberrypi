# kevs installer on a raspi
# for Mountain Culture Dolly brew :-)

if [ ! -f "~/kjsl_tilt" ]; then 
sudo apt-get update
sudo apt-get install python3-distutils

git clone https://github.com/kevleyski/aioblescan.git

cd aioblescan
sudo -H python3 setup.py install

# node red
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --nodered-version="0.18.4"

cd ~/.node-red
sudo -H npm install node-red-dashboard@2.15.5

sudo cp ./kjsl_flow/flow.json $HOME

touch ~/kjsl_tilt

echo "You need to reboot then run ~/ksj;_install.sh again"
exit

fi

# step 2

curl -X POST http://localhost:1880/flows -H "Content-Type: application/json" -H "Node-RED-Deployment-Type: nodes" --data "@/home/pi/flow.json"

echo "Web browser: http://<this_raspberry_pi_ip>:1880/ui"

