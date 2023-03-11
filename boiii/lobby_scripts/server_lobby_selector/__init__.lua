Lobby.Process.CreateDedicatedModsLobby = function (f8_arg0, f8_arg1)
	local lobby_mode = Engine.DvarString( nil, "sv_lobby_mode" )
	if lobby_mode ~= "" then
		if lobby_mode == "zm" then
			f8_arg1 = LobbyData.UITargets.UI_ZMLOBBYONLINECUSTOMGAME
		elseif lobby_mode == "cp" then
			f8_arg1 = LobbyData.UITargets.UI_CPLOBBYONLINECUSTOMGAME
		elseif lobby_mode == "cpzm" then
			f8_arg1 = LobbyData.UITargets.UI_CP2LOBBYONLINECUSTOMGAME
		elseif lobby_mode == "fr" then
			f8_arg1 = LobbyData.UITargets.UI_FRLOBBYONLINEGAME
			f8_arg1.maxClients = Engine.DvarInt( nil, "com_maxclients" )
		elseif lobby_mode == "doa" then
			f8_arg1 = LobbyData.UITargets.UI_DOALOBBYONLINE
		elseif lobby_mode == "mp" then
			f8_arg1 = LobbyData.UITargets.UI_MPLOBBYONLINEMODGAME
		elseif lobby_mode == "arena" then
			f8_arg1 = LobbyData.UITargets.UI_MPLOBBYONLINEARENAGAME
		end
	end
	local f8_local0 = Dvar.sv_playlist
	Engine.SetPlaylistID(f8_local0:get())
	local f8_local1 = Lobby.Actions.ExecuteScript(function ()
		Lobby.ProcessNavigate.SetupLobbyMapAndGameType(f8_arg0, f8_arg1)
	end)
	local f8_local2 = Lobby.Actions.SetNetworkMode(f8_arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE)
	local f8_local3 = Lobby.Actions.LobbySettings(f8_arg0, f8_arg1)
	local f8_local4 = Lobby.Actions.UpdateUI(f8_arg0, f8_arg1)
	local f8_local5 = Lobby.Actions.LobbyHostStart(f8_arg0, f8_arg1.mainMode, f8_arg1.lobbyType, f8_arg1.lobbyMode, f8_arg1.maxClients)
	local f8_local6 = Lobby.Actions.AdvertiseLobby(true)
	local f8_local7 = Lobby.Actions.ExecuteScript(function ()
		Engine.QoSProbeListenerEnable(f8_arg1.lobbyType, true)
		Engine.SetDvar("live_dedicatedReady", 1)
		Engine.RunPlaylistRules(f8_arg0)
		Engine.RunPlaylistSettings(f8_arg0)
		Lobby.Timer.HostingLobby({controller = f8_arg0, lobbyType = f8_arg1.lobbyType, mainMode = f8_arg1.mainMode, lobbyTimerType = f8_arg1.lobbyTimerType})
		if Engine.DvarInt( nil, "sv_skip_lobby" ) == 1 then 
			Engine.Exec(0, "launchgame")
		end
	end)
	Lobby.Process.AddActions(f8_local2, f8_local3)
	Lobby.Process.AddActions(f8_local3, f8_local1)
	Lobby.Process.AddActions(f8_local1, f8_local4)
	Lobby.Process.AddActions(f8_local4, f8_local5)
	Lobby.Process.AddActions(f8_local5, f8_local6)
	Lobby.Process.AddActions(f8_local6, f8_local7)
	Lobby.Process.AddActions(f8_local7, nil)
	return {head = f8_local2, interrupt = Lobby.Interrupt.NONE, force = true, cancellable = true}
end