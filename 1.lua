


local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))() 

-- Create a window
local Window = OrionLib:MakeWindow({
    Name = "Larry2k Hub",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "OrionTest"
}) 

local aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
Aimbot.Load()

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
updatePlayerDropdown()

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

-- Initialize Orion library
OrionLib:Init()

-- Function to update player list when players join or leave
game.Players.PlayerAdded:Connect(function(player)
    updatePlayerDropdown()
end)

game.Players.PlayerRemoving:Connect(function(player)
    updatePlayerDropdown()
end)

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
