


--//Variables

local replicatedStorage = game:GetService("ReplicatedStorage")
local minimizeButtonRemoteFunction = replicatedStorage["RemoteEvents/Functions"]:WaitForChild("MinimizeButtonRemoteFunction")
local afkButtonRemoteFunction = replicatedStorage["RemoteEvents/Functions"]:WaitForChild("AFKButtonRemoteFunction")
local afkSpawn = game.Workspace:WaitForChild("AFKLobby").AFKSpawn
local lobbySpawn = game.Workspace:WaitForChild("LobbySpawn")
--//remote event for the level gui 
local remoteClientEndGameEvent = replicatedStorage:WaitForChild("RemoteEvents/Functions").RemoteClientEndGameEvent




--//Remote Functions
--[[
afkButtonRemoteFunction.OnServerInvoke = function(plr)
	print("Recieved from client sir")
	if plr then
		if plr.Character then
			local afk = plr:WaitForChild("Settings").AFK
			if afk then
				if afk.Value == false then
					afk.Value = true
					plr.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(afkSpawn.CFrame.X, afkSpawn.CFrame.Y + 1, afkSpawn.CFrame.Z)
					return true
				elseif afk.Value == true then
					afk.Value = false
					plr.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(lobbySpawn.CFrame.X, lobbySpawn.CFrame.Y + 1, lobbySpawn.CFrame.Z)
					
					return false
				end
			end
		end
	end
	
end
--]]

minimizeButtonRemoteFunction.OnServerInvoke = function(plr, inGameFrame)
	print("recieved from client")
	if plr then
		if inGameFrame then
			if inGameFrame.Position == UDim2.new(0.01, 0, 0.375, 0)then
				--levelFrame:TweenPosition(UDim2.new(0.09,642,0.07,259),"In","Bounce",0.5)
				inGameFrame:TweenPosition(UDim2.new(-0.066, 0, 0.375, 0), "In", "Bounce", 0.5)
				
				return true
				 
			elseif inGameFrame.Position == UDim2.new(-0.066, 0, 0.375, 0) then
				
				inGameFrame:TweenPosition (UDim2.new(0.01, 0, 0.375, 0), "In", "Bounce", 0.5)
				return false
			end
		end
	end
end

--//Remote Functions



remoteClientEndGameEvent.OnServerEvent:Connect(function(plr, level)
	print("Recieved from client")
	
	if plr then
		level = level + 1
		print("players level: "..level)
	end
	--[[
	if plr then
		print("bois")
		if playerXP then
			print("boomshakala")
			if xpNeeded then
				print("skrt skrt ")
				if level then
					print("almost made it bois")
					if playerXP >= xpNeeded then
						print("holy moly")
						level = level + 1
						playerXP = 0
						xpNeeded = (xpNeeded *  math.sqrt(100))
					end
				end
			end
		end
	end
	--]]
end)