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
3. Open a Windows Command Prompt (or cmd.exe) window and run `develop.bat`. Keep this window open. Do not be alarmed if you see:

```bat
ERROR: The process "DayZServer_x64.exe" not found.
ERROR: The process "DayZ_BE.exe" not found.
ERROR: The process "DayZ_x64.exe" not found.
```
All this means is that the client and server were not already running. This is expected the first time around.
4. If all goes well, you should see the DayZ server startup along with the client (game) automatically connecting to the server.
5. To verify the mod was loaded on the server, open or tail `script.log` in serverProfile under the project directory and you should see:
```
SCRIPT       : DayZModStarter loaded!
```
This validates the mod was loaded successfully on the server.
6. To verify the mod was loaded on the client, open up the game options and ensure Game, Admin and Player messages are enabled. Once you hit apply, you should see (GAME): Tick appear on the bottom left part of your screen. This validates the mod was loaded successfully on the client.
7. At this point, you are ready to code your mod. Once you've made changes you'd like pushed to the client and server, simply go back to the Command Prompt window and press any key. The build/deploy cycle will repeat and your client and server will be restarted to reflect the changes.
