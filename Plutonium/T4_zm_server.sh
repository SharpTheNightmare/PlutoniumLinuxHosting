#!/bin/bash
## Variable Region
_script="$(readlink -f ${BASH_SOURCE[0]})" 
# Delete last component from $_script
_mydir="$(dirname $_script)"
# Name of the server shown in the title of the terminal window
NAME="T4 Zombies 1"
# Your Game Path (where there is binkw32.dll)
PAT=./t4gamefiles
# Paste the server key from https://platform.plutonium.pw/serverkeys
KEY="KEY_HERE"
# Name of the config file the server should use. (default: dedicated_sp.cfg)
CFG=dedicated_zm.cfg
# Port used by the server (default: 28960) -> Don't forget to allow server port in ufw fail2ban
PORT=28961
# Game Mode ( Multiplayer / Zombie ) -> ( t4mp / t4sp )
MODE=t4sp
# Mod name (default "")
MOD=""
## End Region

## Update Region
# Plutonium game dir
INSTALLDIR=./

# Update your server game file
./plutonium-updater -d "$INSTALLDIR"
## End Region

## Server Start Region
echo -e '\033]2;'Plutonium - $NAME - Server restart'\007'
echo "Visit plutonium.pw | Join the Discord (plutonium) for NEWS and Updates!"
echo "Server "$NAME" will load $CFG and listen on port $PORT UDP!"
echo "To shut down the server close this window first!"
printf -v NOW '%(%F_%H:%M:%S)T' -1
echo ""$NOW" $NAME server started."

while true
do
wine .\\bin\\plutonium-bootstrapper-win32.exe $MODE $PAT -dedicated +start_map_rotate +set key $KEY +set fs_game $MOD +set net_port $PORT +set sv_config $CFG 2> /dev/null
printf -v NOW '%(%F_%H:%M:%S)T' -1
echo ""$NOW" WARNING: $NAME server closed or dropped... server restarting."
sleep 1
done
## End Region