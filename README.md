# T7 Server Config
Config for T7 Dedicated Servers for use with the T7x Client.

# How to use
1. Download the BO3 Unranked Dedicated Server via Steam (It's located in the "Tools" section in your steam library.)
2. Open the Unranked Server folder in windows explorer (if you own BO3 on Steam and have it installed it will be in your BO3 Game Folder)
3. Add t7x.exe to the UnrankedServer Folder
4. Download this repository and extract startup batch files as well as the t7x and zone folder to the UnrankedServer Folder
5. Edit the config(s) in /zone to your liking.
6. (Optional) Edit your game rules under boiii/gamesettings/mp.
6. Port forward UDP 27017.
7. Start the Server using BOIII_MP_Server.bat or T7x_ZM_Server.bat

# Additional Steps required for hosting Zombies Dedicated Servers
As of right now you need to take additional Steps to host Zombies Servers.
For Zombie Dedis to work they need to have the Zombies Maps and common FastFiles, these do not come with the UnrankedServer Files. This means you need to copy those over from your installed BO3 game folder.

Copy common fastfiles that is needed for zombies.

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

from your BO3 Game folder into the UnrankedServer's ```zone``` Folder. Do the same with the FastFiles of the Maps you want to host on the Server, you do not need to copy the .xpak files, those hold Textures and Sounds which the Server doesn't need. You can use the zm_server.cfg as a short name references if you want to grab the others.

You are now ready to start the Server using T7x_ZM_Server.bat. If the server still instantly closes while opening the T7x_ZM_Server.bat or T7x_CP_Server.bat. Check the console_mp.log from identities\dedicatedpc\ folder. Scroll down until you see "Could not find zone: xxxx".
