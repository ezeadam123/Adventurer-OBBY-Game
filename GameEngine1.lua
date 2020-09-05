

--//Epic Minigames gives good ideas of what can be used in the levels

--//Variables
local counter = 0 
local counter2 = 0
--local counter2format = math.floor(counter2*100)/100
local counter3 = 0
local maps = game:GetService("ServerStorage").Maps:GetChildren()
--local spawnParts = game.Workspace:WaitForChild("Model").SpawnParts:GetChildren()
local gameLength = 50
local raceinProgress = game.ReplicatedStorage:WaitForChild("RaceInProgress")
local statusFrame = game.StarterGui.GameUI.StatusFrame


--//Functions
function msg(status)
	statusFrame.TextLabel.Text = status
end


--//Game Engine

while true do
	
	
	wait(1)
	local message = Instance.new("Hint", game.Workspace)
	
	repeat 
		wait()
		message.Text = "Need two or more players to start"
		print("Need two or more players")
		game.Players:GetPlayers() -- repeatedly gets the number of players till it reaches over 2
	until #game.Players:GetPlayers() >= 1
	
	msg("Intermission")
	message.Text = "Intermission"
	wait(10)
	
	
	print("Starting..")
	
	--table we will store the players in 
	local players = {}
	print("number of players in game.. "..#game.Players:GetPlayers())
	for i, v in pairs(game.Players:GetPlayers())do
		wait()
		table.insert(players, v)
	end
	
	--waiting for the characters to load
	
	for i, player in pairs(players)do
		if player then
			local checkforchar = player:WaitForChild("Settings").CharacterReady
			if checkforchar.Value == true then
				print("Character loaded and ready to teleport")
			else
				repeat
					wait(0.01)
				until checkforchar.Value == true
				
			end
			
		else
			table.remove(players, i)
		end
	end
	
--for loop, goes in once, checks, goes out again, checks again

	for i,player in pairs(players)do --only works in a while true do loop
		if player then
			print("worked skoodaddle one")
			
			counter = counter + 1
			print(counter)
			--[[
			f i == 1 then
				v.Character.HumanoidRootPart.Position = game.Workspace.Part.Position 
			end
			wait(1)
				--]]
		else
			
			table.remove(players, i)
		end	
	end
	
	print("how many players we got from the count...".. counter)
	wait(2)
	
	--determining how many spawns are needed for each player
	
	
	--selecting map
	local randomMap = maps[math.random(1, #maps)]
	local clonedRandomMap = randomMap:Clone()
	local theme = clonedRandomMap.Theme
	local difficulty = clonedRandomMap.Difficulty
	
	if maps then
		if randomMap then
			print(randomMap.Name)
			if clonedRandomMap then
				clonedRandomMap.Parent = game.Workspace
				for i,player in pairs(players)do
					if player then
						local remoteClientThemeDiffEvent = player:WaitForChild("RemoteClientThemeDiffEvent")
						if remoteClientThemeDiffEvent then
							print("fired bois")
							remoteClientThemeDiffEvent:FireClient(player, theme, difficulty)
						end
						
					else
						table.remove(players, i)
					
					end
				end
				--make the status value the theme value here
				--make the status value the difficulty string value here
			end
		end
	end
	
	wait(3)
	print("Teleporting players to map..")
	--//PCall Function
	
	local spawnParts = clonedRandomMap.SpawnParts:GetChildren()
	
	local bool, result = pcall(function()
		
		if counter == 0 then
			message.Text = "All players are AFK"
			print(#players)	 
								--bool is the bool value, whether true or false of the pcall function. result is the return vale
		elseif counter == 1 then			  --a pcall function is used so a script won't break, and instead the script continues on.
			players[1].Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[1].CFrame.X, spawnParts[1].CFrame.Y + 1.2, spawnParts[1].CFrame.Z) 
			wait()
			players[1].Character.HumanoidRootPart.CFrame = players[1].Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.pi*1.5, 0)--math.pi is equal to have a rotation in degrees(180 degrees)
			
			return "Worked without an error.. 1 player teleported"	
			--one spawn part
			
		elseif counter == 2 then
		
			players[1].Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[1].CFrame.X,spawnParts[1].CFrame.Y + 1, spawnParts[1].CFrame.Z) 
			players[2].Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[2].CFrame.X,spawnParts[2].CFrame.Y + 1, spawnParts[2].CFrame.Z) 
			players[1].Character.HumanoidRootPart.CFrame = players[1].Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.pi*1.5, 0)
			players[2].Character.HumanoidRootPart.CFrame = players[2].Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.pi*1.5, 0)
			print("two spawn parts")
			return "Worked without an error.. 2 players teleported"	
			--two spawn parts
		
		elseif counter == 3 then
			
			players[1].Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[1].CFrame.X,spawnParts[1].CFrame.Y + 1, spawnParts[1].CFrame.Z) 
			players[2].Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[2].CFrame.X,spawnParts[2].CFrame.Y + 1, spawnParts[2].CFrame.Z) 
			players[3].Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[3].CFrame.X,spawnParts[3].CFrame.Y + 1, spawnParts[3].CFrame.Z) 
		
			players[1].Character.HumanoidRootPart.CFrame = players[1].Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.pi*1.5, 0)
			players[2].Character.HumanoidRootPart.CFrame = players[2].Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.pi*1.5, 0)
			players[3].Character.HumanoidRootPart.CFrame =  players[3].Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.pi*1.5, 0)
		
			print("three spawn parts")
			
			return "Worked without an error.. 3 players teleported"	
		end
		
	
	end)
	
	print(result)
	

	
	--starting game, going to fire an remote client event that will display 3, 2, 1 BEGIN!
	for i, player in pairs(players)do
		local playing = player:WaitForChild("Playing")
		if playing then
			if player then --this client event will fire for each player in the game
				playing.Value =  true
				print("event fired from server")
				local remoteClientStartGameEvent = player:WaitForChild("RemoteClientStartGameEvent")
				remoteClientStartGameEvent:FireClient(player)
			else	
				table.remove(players, i)
			end
		end
	end
	
	
	--giving the players who are currently in the game the STAMINA BAR
	
	for i, player in pairs(players) do
		if player then
			if player:WaitForChild("Playing").Value == true then
				local staminaFrame = player.PlayerGui.GameUI:WaitForChild("StaminaTop")
				if staminaFrame then
					local remoteClientStaminaEvent = player:WaitForChild("RemoteClientStaminaEvent")
					if remoteClientStaminaEvent then
						remoteClientStaminaEvent:FireClient(player, staminaFrame)
					end
				end
			end
		end
	end
	
	
	if #players > 0 then
		raceinProgress.Value = true
		
		wait(2.89) --remember this number: 3.89, correct number for us to wait at
		
		
		print("Work you thingy")
		
		message.Text = "You have 400 seconds for someone to win finish the obby first!"
		wait(1)
	else
		print("all players are AFK")
	end
	--//Setting up the race script now
	
	while raceinProgress.Value == true do
		wait(0.2)
		counter2 = counter2 + 0.2
		
		--print(counter2)
		msg(counter2)
		message.Text = counter2
		for i, player in pairs(players)do
			if player then
					local char = player.Character
					if char then
						if char.Humanoid.Health > 0 then
							--print("Player still alive")
							--player still alive
					else
							
						table.remove(players, i)
						
						end
					
					else
						print("character not found")
					end
					
				else
					table.remove(players, i)
			end
		end
	
	if #players == 0 then
		wait(0.5)
		message.Text = "No one won, all the players have died."
		msg("No one won, all players have died")
		break
		
	end
	
	if counter2 >= 100 then --if time has run out, break the loop, and end the game
		for i, v in pairs(players)do
			v.Character.Humanoid.WalkSpeed = 0
		end
		
		wait(0.5)
		message.Text = "No one won, time ran out."
	
		break
	end	
	
	end
	
	print("Finished with a time of.."..counter2.." seconds")
	
	wait(1)
	
	--//checking for the winner now
	
	
	print("Update me..")
	
	print(#players.." still in this round")
	
	for i = 1, 4, 0.5 do
		wait(0.1)
		for i, player in pairs(game.Players:GetPlayers())do
			if player then
				print("Worked..")
				local winnerCheck = player:WaitForChild("Winner")
				if winnerCheck then
					print("Worked two..")
					if winnerCheck.Value == true then --if the players winner value is equal to true after raceinprogress is set to false, a player has won, if it's not equal to true, the player has lost and will be removed from the players list
						print("Worked three..")
						local playerXP = player:WaitForChild("PlayerXPFolder").PlayerXP
						if playerXP then
							local wins = player:WaitForChild("leaderstats").Wins
							if wins then
								local remoteClientEndGameEvent = player:WaitForChild("RemoteClientEndGameEvent")
								if remoteClientEndGameEvent then
									counter3 = counter3 + 1
									
									print(player.Name.." has won 1st place!")
									message.Text = (player.Name.." has won 1st place with a time of "..counter2.." seconds!")
									
									if counter2 <= 15 then
										--the client event will be fired in each conditional statement to make sure the correct value is shown
									
										local addedXP = 56
										playerXP.Value = playerXP.Value + 8
										remoteClientEndGameEvent:FireClient(player, addedXP)
										
									--[[elseif counter2 > 15 and counter2 < 50 then
										
										local addedXP = 35
										playerXP.Value = playerXP.Value + 5
										remoteClientEndGameEvent:FireClient(player, addedXP)
										--]]
									elseif counter2 < 100 then
										local addedXP = 14
										playerXP.Value = playerXP.Value + 2
										remoteClientEndGameEvent:FireClient(player, addedXP)
									end
								end
							end
								
							--[[
							local remoteClientWinnerXPEvent = player:WaitForChild("RemoteClientWinnerXPEvent")
							if remoteClientWinnerXPEvent then
								print("Worked four")
								remoteClientWinnerXPEvent:FireClient(player, playerXP)
							end
							--]]						
						end
						
					else
						
						print("2nd or 3rd place")
						local playerXP = player:WaitForChild("PlayerXPFolder").PlayerXP
						
						local remoteClientEndGameEvent = player:WaitForChild("RemoteClientEndGameEvent")
						if remoteClientEndGameEvent then
							if playerXP then
								local addedXP = 3.5
								playerXP.Value = playerXP.Value + 0.5
								remoteClientEndGameEvent:FireClient(player, addedXP)

							end
						end	
						
						table.remove(players, i)
					end
				else
					table.remove(players, i)
				end
			else
				table.remove(players, i)
			end
		end
	
	end
	
	
	--rewarding the player with a win
	
	for i, player in pairs(game.Players:GetPlayers())do
		if player.Winner.Value == true then
			local wins = player.leaderstats.Wins
			if wins then
				wins.Value = wins.Value + 1
			end
		end
	end
	
	
	
	
	print("IJFKFWFWOIJFWFW"..counter3)
	
	if counter3 == 40 then
		message.Text = "We actually have a tie!!"
	elseif counter3 == 60 then
		message.Text = "Holy smokes we have a threeway tie!!!"
	end
	--print("FWUIFNJKMFWOIFWJKM"..#winners)
	
	
	
	
	
	--if counter3 == 0 then
		--message.Text = "No one has won!"
		--print("No one has won!")
	--elseif counter3 == 2 then
		--print("Tie!")
	--elseif counter3 == 3 then
		--print("Threeway tie!")
	--end
	
-
	wait(3)
	
	--teleporting all the players back to main lobby
	
	local bool1, result1 = pcall(function()
		
		for i, player in pairs(game.Players:GetPlayers())do
			if player then
				--teleport players back here
				if player.Character then
					if player.Character.Humanoid.Health > 0 then
						--player.PlayerGui.GameUI["Theme/Difficulty"].Visible = false
						--player.PlayerGui.GameUI["Theme/Difficulty"].Difficulty.TextColor3 = Color3.new(0, 0, 0)
						--player.PlayerGui.GameUI["Theme/Difficulty"].Theme.Text = "Theme: "
						--player.PlayerGui.GameUI["Theme/Difficulty"].Difficulty.Text = "Difficulty: "
						player.Character.Humanoid.WalkSpeed = 16
						player.Character.HumanoidRootPart.CFrame = game.Workspace.LobbySpawn.CFrame
						player.Winner.Value = false
						
					end
				end
			end
		end
	end)
	wait()
	
	
	clonedRandomMap:Destroy()
	message:Destroy()
	counter = 0
	counter2 = 0
	counter3 = 0
end