



--///Variables
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local minimizeButtonRemoteFunction = replicatedStorage["RemoteEvents/Functions"]:WaitForChild("MinimizeButtonRemoteFunction")
local afkButtonRemoteFunction = replicatedStorage["RemoteEvents/Functions"]:WaitForChild("AFKButtonRemoteFunction")

--//LevelFrameVariables
local levelFrame = script.Parent.LevelFrame
local levelLabel = levelFrame.CurrentLevel
local level = player:WaitForChild("leaderstats").Level
levelLabel.Text = "Level: "..level.Value

local xpLabel = levelFrame.XPBar.XPLabel
local playerXP = player:WaitForChild("PlayerXPFolder").PlayerXP
local xpNeeded = player:WaitForChild("PlayerXPFolder").XPNeeded
xpLabel.Text = ("EXP: "..playerXP.Value.." / "..xpNeeded.Value)

--//Theme, Difficulty Variables
local themedifficultyFrame = script.Parent["Hello World"]
local themeLabel = themedifficultyFrame.Theme
local difficultyLabel = themedifficultyFrame.Difficulty 
local selectedMap = game:GetService("ReplicatedStorage").SelectedMap
--local theme = game.Workspace:WaitForChild(selectedMap.Value).Theme
--local difficulty = game.Workspace:WaitForChild(selectedMap.Value).Difficulty
--themeLabel.Text = ("Theme: "..theme.Value)
--difficultyLabel.Text = ("Difficulty: "..difficulty.Value)

--//InGameFrame Variables
local inGameMenuFrame = script.Parent.InGameFrame
local minimizeButton = inGameMenuFrame.MinimizeButton
local afkButton = inGameMenuFrame.AFKButton
local settingsButton = inGameMenuFrame.SettingsButton
local statsButton = inGameMenuFrame.StatsButton


--///Events

--//Theme/Difficulty Event
--theme:GetPropertyChangedSignal("Value"):Connect(function()
	--themeLabel.Text = ("Theme: "..theme.Value)
--end)
--difficulty:GetPropertyChangedSignal("Value"):Connect(function()
	--difficultyLabel.Text = ("Difficulty: "..difficulty.Value)
--end)

--//XPLabel Event
playerXP:GetPropertyChangedSignal("Value"):Connect(function()
	xpLabel.Text = ("EXP: "..playerXP.Value.." / "..xpNeeded.Value)

end)

xpNeeded:GetPropertyChangedSignal("Value"):Connect(function()
	xpLabel.Text = ("EXP: "..playerXP.Value.." / "..xpNeeded.Value)
end)

--//LevelLabel Event

level:GetPropertyChangedSignal("Value"):Connect(function()
	levelLabel.Text = "Level: "..level.Value
end)



--//AFK Button Event
--[[
local debounce = false
afkButton.MouseButton1Click:Connect(function()
	if debounce == false then 
		debounce = true
		print("Fired from client, sent to server")
		local results = afkButtonRemoteFunction:InvokeServer()
		
		if results == true then
			afkButton.Text = "UN-AFK"
		elseif results == false then
			afkButton.Text = "Go AFK"
		end
	wait(0.5)
	debounce = false
	end
end)
--]]


--//Minimize Button Event
local debounce1 = false
minimizeButton.MouseButton1Click:Connect(function()
	
	if debounce1 == false then
		debounce1 = true
	
		print("Fired from client, sent to server")
		local results1 = minimizeButtonRemoteFunction:InvokeServer(minimizeButton.Parent)
		
		if results1 == true then
			minimizeButton.Text = "Open"
		elseif results1 == false then
			minimizeButton.Text = "Close"
			
		end
		
	wait(0.5)
	debounce1 = false
	end	
end)









