local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))() 


getgenv().EspSettings = {
	TeamCheck = false,
	ToggleKey = "RightAlt",
	RefreshRate = 10, -- how fast the esp updates (milliseconds)
	MaximumDistance = 500, -- only renders players within this distance
	FaceCamera = false, -- Makes esp appear 2D
	AlignPoints = false, -- Improves 2D effect; only works while FaceCamera is enabled
	-- AlignPoints: This may cause esp to have abnormal behavior when looking from certain angles
	MouseVisibility = {
		Enabled = true, -- makes any drawing objects transparent when they are near your mouse
		Radius = 60,
		Transparency = 0.3,
		Method = "Hover", -- "Radius" or "Hover" | Hover is newest method and is a lot more accurate than Radius
		HoverRadius = 50,
		Selected = { -- set any of these to false to ignore them
			Boxes = true,
			Tracers = true,
			Names = true,
			Skeletons = true,
			HealthBars = true,
			HeadDots = true,
			LookTracers = true
		}
	},
	Highlights = {
		Enabled = false,
		Players = {}, -- put player usernames into this table to 'highlight' them
		Transparency = 1,
		Color = Color3.fromRGB(255, 150, 0),
		AlwaysOnTop = true
	},
	NPC = {
		Color = Color3.fromRGB(150,150,150),
		Transparency = 1,
		RainbowColor = false,
		Overrides = {
			Boxes = true,
			Tracers = true,
			Names = true,
			Skeletons = true,
			HealthBars = true,
			HeadDots = true,
			LookTracers = true
		}
	},
	Boxes = {
		Enabled = true,
		Transparency = 1,
		Color = Color3.fromRGB(255,255,255),
		UseTeamColor = true,
		RainbowColor = false,
		Outline = true,
		OutlineColor = Color3.fromRGB(0,0,0),
		OutlineThickness = 1,
		Thickness = 1
	},
	Tracers = {
		Enabled = true,
		Transparency = 1,
		Color = Color3.fromRGB(255,255,255),
		UseTeamColor = true,
		RainbowColor = false,
		Outline = true,
		OutlineColor = Color3.fromRGB(0,0,0),
		OutlineThickness = 1,
		Origin = "Top", -- "Top" or "Center" or "Bottom" or "Mouse"
		Thickness = 1
	},
	Names = {
		Enabled = true,
		Transparency = 1,
		Color = Color3.fromRGB(255,255,255),
		UseTeamColor = true,
		RainbowColor = false,
		Outline = true,
		OutlineColor = Color3.fromRGB(0,0,0),
		Font = Drawing.Fonts.UI, -- UI or System or Plex or Monospace
		Size = 18,
		ShowDistance = false,
		ShowHealth = true,
		UseDisplayName = false,
		DistanceDataType = "m", -- what it says after the distance (ex. 100m)
		HealthDataType = "Percentage" -- "Percentage" or "Value"
	},
	Skeletons = {
		Enabled = true,
		Transparency = 1,
		Color = Color3.fromRGB(255,255,255),
		UseTeamColor = true,
		RainbowColor = false,
		Outline = true,
		OutlineColor = Color3.fromRGB(0,0,0),
		OutlineThickness = 1,
		Thickness = 1
	},
	HealthBars = {
		Enabled = true,
		Transparency = 1,
		Color = Color3.fromRGB(0,255,0),
		UseTeamColor = true,
		RainbowColor = false,
		Outline = true,
		OutlineColor = Color3.fromRGB(0,0,0),
		OutlineThickness = 1,
		Origin = "None", -- "None" or "Left" or "Right"
		OutlineBarOnly = true
	},
	HeadDots = {
		Enabled = true,
		Transparency = 1,
		Color = Color3.fromRGB(255,255,255),
		UseTeamColor = true,
		RainbowColor = false,
		Outline = true,
		OutlineColor = Color3.fromRGB(0,0,0),
		OutlineThickness = 1,
		Thickness = 1,
		Filled = false,
		Scale = 1
	},
	LookTracers = {
		Enabled = true,
		Transparency = 1,
		Color = Color3.fromRGB(255,255,255),
		UseTeamColor = true,
		RainbowColor = false,
		Outline = true,
		OutlineColor = Color3.fromRGB(0,0,0),
		OutlineThickness = 1,
		Thickness = 1,
		Length = 5
	}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dragon5819/Main/main/esp", "UniversalEsp"))()


-- Create a window
local Window = OrionLib:MakeWindow({
    Name = "Larry2k Hub",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "OrionTest"
}) 
--[[
    local aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
    aimbot.Load()
]]
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

local localplayeruniversal = universal:AddSection({
    Name = "LocalPlayer"
})


localplayeruniversal:AddToggle({
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
