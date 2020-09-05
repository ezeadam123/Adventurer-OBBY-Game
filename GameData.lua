

game.Players.PlayerAdded:Connect(function(plr)
	
	local leaderstats = Instance.new("Folder", plr)
	leaderstats.Name = "leaderstats"
	
	local level = Instance.new("IntValue", leaderstats)
	level.Name = "Level"
	level.Value = 1 
	
	local playerXPFolder = Instance.new("Folder", plr)
	playerXPFolder.Name = "PlayerXPFolder"
	
	local wins = Instance.new("IntValue", leaderstats)
	wins.Name = "Wins"
	
	local playerXP = Instance.new("NumberValue", playerXPFolder)
	playerXP.Name = "PlayerXP"
	
	local XPNeeded = Instance.new("IntValue", playerXPFolder)
	XPNeeded.Name = "XPNeeded"
	XPNeeded.Value = 100
	
	local livegameSettings = Instance.new("Folder", plr)
	livegameSettings.Name = "Settings"
	
	local characterReady = Instance.new("BoolValue", livegameSettings)
	characterReady.Name = "CharacterReady"
	
	local playing = Instance.new("BoolValue", plr)
	playing.Name = "Playing"
	
	local winner = Instance.new("BoolValue", plr)
	winner.Name = "Winner"
	
	local AFK = Instance.new("BoolValue", livegameSettings)
	AFK.Name = "AFK"
	
	
	
	--//RemoteClientVariables
	
	local remoteClientStartGameEvent = Instance.new("RemoteEvent", plr)
	remoteClientStartGameEvent.Name = "RemoteClientStartGameEvent"
	
	local remoteClientThemeDiffEvent = Instance.new("RemoteEvent", plr)
	remoteClientThemeDiffEvent.Name = "RemoteClientThemeDiffEvent"
	
	local remoteClientWinnerXPEvent = Instance.new("RemoteEvent", plr)
	remoteClientWinnerXPEvent.Name = "RemoteClientWinnerXPEvent"
	
	local remoteClientEndGameEvent = Instance.new("RemoteEvent", plr)
	remoteClientEndGameEvent.Name = "RemoteClientEndGameEvent"
	
	local remoteClientStaminaEvent = Instance.new("RemoteEvent", plr)
	remoteClientStaminaEvent.Name = "RemoteClientStaminaEvent"
	
	--local remoteClientEndGameEvent = Instance.new("RemoteEvent", plr)
	--remoteClientEndGameEvent.Name = "RemoteClientEndGameEvent"
	
	--local remoteEvent = Instance.new("RemoteEvent")
	--remoteEvent.Name = "RemoteEvent"
	--remoteEvent.Parent = plr
	
	
	--[[
	playerXP:ChangedPropertySignal("Value"):Connect(function()		
		print("skrt")
		if playerXP.Value >= XPNeeded.Value then
			level.Value = level.Value + 1
			playerXP.Value = 0
			XPNeeded.Value = (XPNeeded.Value *  math.sqrt(100))		
		end
	end)
	--]]
	
	--when the player is added, the script will continusly check for when the xpvalue changes
	
	playerXP:GetPropertyChangedSignal("Value"):Connect(function()		
			print("skrt")
			if plr then
				print("goteeem")
				if playerXP then
					if XPNeeded then
						if level then
							if playerXP.Value == XPNeeded.Value then
								print("holy moly")
								level.Value = level.Value + 1
								playerXP.Value = 0
								XPNeeded.Value = (XPNeeded.Value *  math.sqrt(16))
							elseif playerXP.Value > XPNeeded.Value then
								level.Value = level.Value + 1
								playerXP.Value = playerXP.Value - XPNeeded.Value
								XPNeeded.Value = (XPNeeded.Value * math.sqrt(16))
							end	--remoteClientEndGameEvent:FireServer(level.Value)
						end	
					end
				end
			end
		end)
	
	
	
	
	
	plr.CharacterAdded:Connect(function(char)
		
		
		char:WaitForChild("HumanoidRootPart").CFrame = game.Workspace.LobbySpawn.CFrame
		wait(0.5)
		plr.Settings:WaitForChild("CharacterReady").Value = true
		
		playing.Value = false
		
		char.Humanoid.Died:Connect(function()
			
			print("character has died")
			
		end)
	
		
		
	end)
end)


game.Players.PlayerRemoving:Connect(function(plr)
	
	plr.Settings:WaitForChild("CharacterReady").Value = false
end)