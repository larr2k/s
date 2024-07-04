local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))() 

--//Toggle\\--
getgenv().Toggle = false -- This toggles the esp, turning it to false will turn it off
getgenv().TC = false -- This toggles team check, turning it on will turn on team check
local PlayerName = "Name" -- You can decide if you want the Player's name to be a display name which is "DisplayName", or username which is "Name"

--//Variables\\--
local P = game:GetService("Players")
local LP = P.LocalPlayer

--//Debounce\\--
local DB = false

--//Loop\\--
while task.wait() do
	if not getgenv().Toggle then
		break
	end
	if DB then 
		return 
	end
	DB = true

	pcall(function()
		for i,v in pairs(P:GetChildren()) do
			if v:IsA("Player") then
				if v ~= LP then
					if v.Character then

						local pos = math.floor(((LP.Character:FindFirstChild("HumanoidRootPart")).Position - (v.Character:FindFirstChild("HumanoidRootPart")).Position).magnitude)
						-- Credits to Infinite Yield for this part (pos) ^^^^^^

						if v.Character:FindFirstChild("Totally NOT Esp") == nil and v.Character:FindFirstChild("Icon") == nil and getgenv().TC == false then
							--//ESP-Highlight\\--
							local ESP = Instance.new("Highlight", v.Character)

							ESP.Name = "Totally NOT Esp"
							ESP.Adornee = v.Character
							ESP.Archivable = true
							ESP.Enabled = true
							ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							ESP.FillColor = v.TeamColor.Color
							ESP.FillTransparency = 0.5
							ESP.OutlineColor = Color3.fromRGB(255, 255, 255)
							ESP.OutlineTransparency = 0

							--//ESP-Text\\--
							local Icon = Instance.new("BillboardGui", v.Character)
							local ESPText = Instance.new("TextLabel")

							Icon.Name = "Icon"
							Icon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
							Icon.Active = true
							Icon.AlwaysOnTop = true
							Icon.ExtentsOffset = Vector3.new(0, 1, 0)
							Icon.LightInfluence = 1.000
							Icon.Size = UDim2.new(0, 800, 0, 50)

							ESPText.Name = "ESP Text"
							ESPText.Parent = Icon
							ESPText.BackgroundColor3 = v.TeamColor.Color
							ESPText.BackgroundTransparency = 1.000
							ESPText.Size = UDim2.new(0, 800, 0, 50)
							ESPText.Font = Enum.Font.SciFi
							ESPText.Text = v[PlayerName].." | Distance: "..pos
							ESPText.TextColor3 = v.TeamColor.Color
							ESPText.TextSize = 18.000
							ESPText.TextWrapped = true
						else
							if v.TeamColor ~= LP.TeamColor and v.Character:FindFirstChild("Totally NOT Esp") == nil and v.Character:FindFirstChild("Icon") == nil and getgenv().TC == true then
								--//ESP-Highlight\\--
								local ESP = Instance.new("Highlight", v.Character)

								ESP.Name = "Totally NOT Esp"
								ESP.Adornee = v.Character
								ESP.Archivable = true
								ESP.Enabled = true
								ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								ESP.FillColor = v.TeamColor.Color
								ESP.FillTransparency = 0.5
								ESP.OutlineColor = Color3.fromRGB(255, 255, 255)
								ESP.OutlineTransparency = 0

								--//ESP-Text\\--
								local Icon = Instance.new("BillboardGui", v.Character)
								local ESPText = Instance.new("TextLabel")

								Icon.Name = "Icon"
								Icon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
								Icon.Active = true
								Icon.AlwaysOnTop = true
								Icon.ExtentsOffset = Vector3.new(0, 1, 0)
								Icon.LightInfluence = 1.000
								Icon.Size = UDim2.new(0, 800, 0, 50)

								ESPText.Name = "ESP Text"
								ESPText.Parent = Icon
								ESPText.BackgroundColor3 = v.TeamColor.Color
								ESPText.BackgroundTransparency = 1.000
								ESPText.Size = UDim2.new(0, 800, 0, 50)
								ESPText.Font = Enum.Font.SciFi
								ESPText.Text = v[PlayerName].." | Distance: "..pos
								ESPText.TextColor3 = v.TeamColor.Color
								ESPText.TextSize = 18.000
								ESPText.TextWrapped = true
							else
								if not v.Character:FindFirstChild("Totally NOT Esp").FillColor == v.TeamColor.Color and not v.Character:FindFirstChild("Icon").TextColor3 == v.TeamColor.Color then
									v.Character:FindFirstChild("Totally NOT Esp").FillColor = v.TeamColor.Color
									v.Character:FindFirstChild("Icon").TextColor3 = v.TeamColor.Color
								else
									if v.Character:FindFirstChild("Totally NOT Esp").Enabled == false and v.Character:FindFirstChild("Icon").Enabled == false then
										v.Character:FindFirstChild("Totally NOT Esp").Enabled = true
										v.Character:FindFirstChild("Icon").Enabled = true
									else
										if v.Character:FindFirstChild("Icon") then
											v.Character:FindFirstChild("Icon")["ESP Text"].Text = v[PlayerName].." | Distance: "..pos
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)

	wait()

	DB = false
end

-- Create a window
local Window = OrionLib:MakeWindow({
    Name = "Larry2k Hub",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "OrionTest"
}) 

-- Create a tab for universal teleports
local universal = Window:MakeTab({
    Name = "universal",
    Icon = "rbxassetid://4483345998",  -- Adjust icon as needed
    PremiumOnly = false
})

-- Create a section for teleports
local teleportsSection = universal:AddSection({
    Name = "Teleports"
})

-- Function to get a list of active player names
local function getActivePlayerNames()
    local activePlayerNames = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(activePlayerNames, player.Name)
    end
    return activePlayerNames
end

-- Dropdown menu to select a player
local playerDropdown = nil
local selectedPlayer = nil

-- Function to update the selected player
local function updateSelectedPlayer(playerName)
    selectedPlayer = playerName
    if playerName then
        playerDropdown:SetValue(playerName)
    end
end

-- Function to create or update the dropdown menu
local function updatePlayerDropdown()
    local playerList = getActivePlayerNames()

    -- Create dropdown if it doesn't exist
    if not playerDropdown then
        playerDropdown = teleportsSection:AddDropdown({
            Name = "Select Player",
            Options = playerList,
            Callback = function(selectedOption)
                updateSelectedPlayer(selectedOption)
            end
        })
    else
        playerDropdown:UpdateOptions(playerList)
    end

    -- Update selected player if it's still in the list
    if selectedPlayer and not table.find(playerList, selectedPlayer) then
        selectedPlayer = nil
    end

    -- Update dropdown value to reflect selected player
    if selectedPlayer then
        playerDropdown:SetValue(selectedPlayer)
    end
end

-- Update dropdown initially
local playerList = getActivePlayerNames()()
while wait(0.1) do
  local playerList = getActivePlayerNames()
-- Button to teleport to selected player
teleportsSection:AddButton({
    Name = "Player TP",
    Callback = function()
        if selectedPlayer then
            local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
            if targetPlayer then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                print("Teleported to:", selectedPlayer)
            else
                warn("Player not found:", selectedPlayer)
            end
        else
            warn("No player selected")
        end
    end
})

local localplayeruniversal = universal:AddSection({
    Name = "LocalPlayer"
})

toggleSection:AddToggle({
    Name = "Esp",
    Default = false,
    Callback = function(value)
        print("Toggle value:", value)
        if value then
            getgenv().Toggle = true
            print("Esp enabled!")
        else
            getgenv().Toggle = false
            print("Esp disabled!")
        end
    end
})


local robaconveniencestore = Window:MakeTab({
    Name = "Rob A Convenience Store",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
}) 

-- Create a section for teleports
local teleports001 = robaconveniencestore:AddSection({
    Name = "Teleports"
}) 

-- Function to teleport
local function teleportTo(location)
    local player = game.Players.LocalPlayer
    local character = player.Character 

    if character and character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = character.HumanoidRootPart
        local humanoid = character:FindFirstChildOfClass("Humanoid") 

        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end 

        humanoidRootPart.CFrame = location
    else
        warn("Character or HumanoidRootPart not found")
    end
end 

-- Sell button
teleports001:AddButton({
    Name = "Sell",
    Callback = function()
        print("sell pressed")
        -- Replace with your desired CFrame for "Sell"
        local sellLocation = CFrame.new(76, 3, -22) -- Example coordinates
        teleportTo(sellLocation)
    end
}) 

-- Steal button
teleports001:AddButton({
    Name = "Steal",
    Callback = function()
        print("steal pressed")
        -- Replace with your desired CFrame for "Steal"
        local stealLocation = CFrame.new(58, 3, 7) -- Example coordinates
        teleportTo(stealLocation)
    end
}) 



OrionLib:Init()
