# DayZ-ModStarter
A starter project for building DayZ mods

This project provides the basic building blocks to get a DayZ mod up and running.

This includes:

+ The mod directory structure (3_Game, 4_World, 5_Mission)
+ The configuration/meta-data (config.cpp)
+ The client/server code (5_Mission/client.c, 5_Mission/server.c)
+ Scripts to simplify building, signing and cold deploying the mod to the client and server

## Getting Started

1. Clone or download this project.
2. Edit vars.bat and modify _all_ paths to point to the correct locations on your machine. The private and public key paths are _optional_, but it appears that unlike Arma 3 the current version of the DayZ server requires _all mods_ be signed. So most likely you will need to generate these keys.
3. Open a Windows Command Prompt (or cmd.exe) window and run `develop.bat`. Keep this window open.
4. If all goes well, you should see the DayZ server startup along with the client (game) automatically connecting to the server. Sometimes a weird bug occurs where your mouse gets locked in a small area at the top of the screen after launching the server. Simply, Alt+Tab out and the normal behaviour will be restored.
5. To verify the mod was loaded on the server, open or tail `script.log` in serverProfile under the project directory and you should see a message that says __DayZModStarter loaded!__.  This validates the mod was loaded successfully on the server.
6. To verify the mod was loaded on the client, open up the game options and ensure Game, Admin and Player messages are enabled. Once you hit apply, you should see (GAME): Tick appear on the bottom left part of your screen. This validates the mod was loaded successfully on the client.
7. At this point, you are ready to code your mod. Once you've made changes you'd like pushed to the client and server, simply go back to the Command Prompt window and press any key. The build/deploy cycle will repeat and your client and server will be restarted to reflect the changes.

## Logs
All server logs go under the serverProfile directory at the root of the project. The server start is configured to use this directory.

## Customizing
A templating tool isn't currently available. You can modify __DayZModStarter__ to whatever you wish and simply change the modName in the vars.bat file. Author details can be changed in config.cpp.

## Scripts
__vars.bat__: Environment variables used by the various scripts. Leveraging this script makes running the scripts easier as you don't need to provide any command line arguments. The scripts are also built to take command line arguments but only if the variables are not set in this file.

__build.bat__: Wraps around the Bohemia Interactive DayZ Tools AddOnBuilder and generates a client/server ready @modName directory with .pbo file. These generated assets are written to the build directory.

__deploy.bat__: Deploys everything under the build directory to the DayZ Server. Also copies all public keys to the server 'keys' directory.

__startClient.bat__: Starts the DayZ game/client and automatically connects to the development server (localhost:3302) with all mods discovered in the server root path.

__stopClient.bat__: Terminates all instances of the DayZ game/client currently running.

__startServer.bat__: Starts the DayZ server with all mods enabled.

__stopServer.bat__: Terminates all instances of the DayZ server currently running.

__develop.bat__: Continuously rebuilds and cold deploys to the DayZ Server upon key press. A cold deploy means restarting the server and the client
in order reload the latest built code.
