# T7 Server Config
Config for T7 Dedicated Servers for use with the BOIII Client.

# How to use
1. Download the BO3 Unranked Dedicated Server via Steam (it's located in the "Tools" section in your library)
2. Open the Unranked Server folder in windows explorer (if you own BO3 on Steam and have it installed it will be in your BO3 Game Folder)
3. Add boiii.exe to the Unranked Server Folder
4. Download this repository and move the startup batch files as well as the zone folder to the Unranked Server Folder
5. Edit the config(s) in /zone to your liking
6. Start the Server using BOIII_MP_Server.bat or BOIII_ZM_Server.bat

# Additional Steps required for hosting Zombies Dedicated Servers
As of right now you need to take additional Steps to host Zombies Servers, this may change in future Updates of BOIII.

1. Create the following Folder Structure inside the Unranked Server Folder:
```
boiii/lobby_scripts/zombie
```
2. [Get this LUA Script](https://github.com/JezuzLizard/T7-18-Player-Dedicated-Zombies-Server-Mod/blob/main/server/ui_scripts/zombies_server_mod/__init__.lua) and move it into the ```zombie``` Folder. The entire Path should now look like this:
```
Unranked Server/boiii/lobby_scripts/zombie/__init__.lua
```
3. For Zombie Dedis to work they need to have the Zombies Maps and common FastFiles, these do not come with the Unranked Server Files. This means you need to copy those over from your BO3 Game Folder.

Copy common fastfiles:
```
zone/en_zm_patch.ff
zone/en_zm_common.ff
zone/zm_patch.ff
zone/zm_common.fd
zone/zm_common.ff
zone/zm_levelcommon.ff
```
Now for the map. Shadows of Evil is zm_zod. 

```
zone/en_zm_zod.ff
zone/en_zm_zod_patch.ff
zone/zm_zod.ff
zone/zm_zod_patch.ff
```
You can use the zm_server.cfg as a short name references if you want to grab the others.


from your BO3 Game folder into the Unranked Server's ```zone``` Folder. Do the same with the FastFiles of the Maps you want to host on the Server, you do not need to copy the .xpak files, those hold Textures and Sounds which the Server doesn't need. 

If the server still instantly closes while opening the BOIII_ZM_Server.bat or BOIII_CP_Server.bat. Check the console_mp.log from identities\dedicatedpc\ folder. Scroll down until you see "Could not find zone: xxxx".

4. You are now ready to start the Server using BOIII_ZM_Server.bat. Do note that the Map Rotation doesn't start automatically right now, this means you have to type ```map_rotate``` into the Server Console after it has finished loading to load the first Map.
