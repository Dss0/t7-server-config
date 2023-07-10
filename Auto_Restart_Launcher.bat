@echo off
:://////////////////////////////////////////////////////////////////////////
:://           BOIII Dedicated Server Configuration start-up file        ///
:://////////////////////////////////////////////////////////////////////////
:://                 Name of the server to identify your bat             ///
:://////////////////////////////////////////////////////////////////////////

set name=BOIII Nameofserver

:://////////////////////////////////////////////////////////////////////////
:://      The regex search for the window name of the sever. (optional)   //
:://                                                                      //
:://     This will help identify which window needs closing in case the   //
:://     server errors out or freezes according to filename on g_log      //
:://                                                                      //
:://     If hosting multiable. I would suggest putting your hostname      //
:://          Example: Default BOIII Server  on mp_                       //
:://                                                                      //
:://     No color codes! This is base off your server window title!       //
:://////////////////////////////////////////////////////////////////////////

set server_title_regex=on zm_           // Or "on mp_

:://////////////////////////////////////////////////////////////////////////
:://                  Your Game Server Port. (Optional)                   //
:://                                                                      //
:://  Make sure you Port Forward UDP on your router and Windows Advaned   //
:://  Firewall. See https://portforward.com/                              //
:://////////////////////////////////////////////////////////////////////////

set GamePort=0000

:://////////////////////////////////////////////////////////////////////////
:://    Rate to check if server crash or freeze by reading game_mp.log    //
::// If gts timelimit is longer then 10 mins. You might want to increase  //
:://////////////////////////////////////////////////////////////////////////
:://   10800 - 3 hours                                                    //
:://   7200 - 2 hours                                                     //
:://   3600 - 1 hour                                                      //
:://   1800 - 30 mins                                                     //
:://   1200 - 20 mins   (recommended)                                     //
:://   900 - 15 mins                                                      //
:://   720 - 12 mins                                                      //
:://   660 - 11 mins    (Don't recommend!)                                //
:://////////////////////////////////////////////////////////////////////////

set check_rate=720

:://////////////////////////////////////////////////////////////////////////
:://                  Server log location and filename                    //
:://          Only change if you hosting more then 1 server               //
:://      Unless you change g_log on server.cfg then match with that.     //
:://////////////////////////////////////////////////////////////////////////

set log_path=%cd%\Boiii
set log_file=games_zm.log

:://////////////////////////////////////////////////////////////////////////
::// Below edits are optional unless you run multiable servers or mods.   //
:://////////////////////////////////////////////////////////////////////////
:://                 Load a mod on your server (Optional)                 //
:://                   Example: ModfolderName=mods/bots                   //
:://                                                                      //
:://                   UNLOAD a mod on your server                        //
:://                   Example: ModfolderName=                            //
:://////////////////////////////////////////////////////////////////////////

set ModFolderName=

:://////////////////////////////////////////////////////////////////////////
::// 	Your edited server.cfg in the "zone" folder goes here...          //
:://	This is were you edit your hostname, rcon, inactivity, etc        //
:://        (Only change if you hosting more then 1 server)               //
:://////////////////////////////////////////////////////////////////////////

set ServerFilename=server_zm.cfg

:://////////////////////////////////////////////////////////////////////////
:://  DONE!! WARNING! Don't mess with anything below this line. SEROUSLY! //
:://             Only edit if you know what you doing!!!                  //
:://////////////////////////////////////////////////////////////////////////

// Create a copy of boiii.exe and rename it to something like boiiitdm.exe then edit the .exe names below to suit!
title %name% - Auto Restart
echo (%date%)  -  (%time%) Starting %name% with port %GamePort% with %ServerFilename%....
start boiiitdm.exe -dedicated +set fs_game "%ModFolderName%" +set net_port "%GamePort%" +set logfile 2 +exec %ServerFilename%   //this line
echo (%date%)  -  (%time%) Now watching %log_path%\%log_file% modified date.
::Code inspired by Guy from botware.
::Reference https://github.com/ineedbots/iw4x_bot_warfare/blob/master/z_server_watchdog.bat
dir "%log_path%"\"%log_file%" > nul
for /f "delims=" %%i in ('"forfiles /p "%log_path%" /m "%log_file%" /c "cmd /c echo @ftime" "') do set modif_time_temp=%%i

:Server
	set modif_time=%modif_time_temp%

	timeout /t %check_rate% /nobreak > nul
    ::echo (%date%)  -  (%time%) Checking if %log_file% date has been modified since %check_rate% seconds is up...
	
	dir "%log_path%"\"%log_file%" > nul
	for /f "delims=" %%i in ('"forfiles /p "%log_path%" /m "%log_file%" /c "cmd /c echo @ftime" "') do set modif_time_temp=%%i

	if "%modif_time_temp%" == "%modif_time%" (
		echo "(%date%)  -  (%time%) WARNING: %name% hung, killing server..."            
		::https://stackoverflow.com/questions/26552368/windows-batch-file-taskkill-if-window-title-contains-text
		for /f "tokens=2 delims=," %%a in ('
			tasklist /fi "imagename eq boiiitdm.exe" /v /fo:csv /nh                                  //this line
			^| findstr /r /c:"boiiitdm.exe"                                                            //this line
		') do taskkill /pid %%a /f
		
	    timeout /T 8 /nobreak > nul
		echo "(%date%)  -  (%time%) Rebooting %name% with port %GamePort% with %ServerFilename% again..."
        start boiiitdm.exe -dedicated +set fs_game "%ModFolderName%" +set net_port "%GamePort%" +set logfile 2 +exec %ServerFilename%  //this line
	    timeout /T 60 /nobreak > nul	
	    echo "(%date%)  -  (%time%) Now watching %log_path%\%log_file% modified date again."	
	)
goto Server
