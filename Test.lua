local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local larry2khubversion = "V0.4 Alpha"

local Window = Fluent:CreateWindow({
    Title = "Larry2k Hub",
    SubTitle = larry2khubversion,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Universal = Window:AddTab({ Title = "Universal", Icon = "rbxassetid://4483345998" }),
    RobAConvenienceStore = Window:AddTab({ Title = "Rob A Convenience Store", Icon = "rbxassetid://4483345998" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Universal Tab
Tabs.Universal:AddParagraph({ Title = "Universal Features", Content = "Features in this tab are generally useful across different scenarios." })

local function getActivePlayerNames()
    local activePlayerNames = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(activePlayerNames, player.Name)
    end
    return activePlayerNames
end

local selectedPlayer = nil

local playerDropdown = Tabs.Universal:AddDropdown("PlayerDropdown", {
    Title = "Select Player",
    Values = getActivePlayerNames(),
    Default = nil,
    Callback = function(value)
        selectedPlayer = value
        print("Selected Player:", selectedPlayer)
    end
})

local function updatePlayerDropdown()
    playerDropdown:SetValue(nil)
    playerDropdown:UpdateValues(getActivePlayerNames())
end

game.Players.PlayerAdded:Connect(updatePlayerDropdown)
game.Players.PlayerRemoving:Connect(updatePlayerDropdown)

Tabs.Universal:AddButton({
    Title = "Player TP",
    Description = "Teleport to the selected player",
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


-- right here synscripts
local AimbotToggle = Tabs.Universal:AddToggle("AimbotEnabled", { Title = "Enable Aimbot", Default = false })
AimbotToggle:OnChanged(function()
    getgenv().AimbotEnabled = Options.AimbotEnabled.Value
end)

local TeamCheckToggle = Tabs.Universal:AddToggle("TeamCheck", { Title = "Aimbot Team Check", Default = false })
TeamCheckToggle:OnChanged(function()
    getgenv().TeamCheck = Options.TeamCheck.Value
end)

local WallCheckToggle = Tabs.Universal:AddToggle("WallCheck", { Title = "Aimbot Wall Check", Default = true })
WallCheckToggle:OnChanged(function()
    getgenv().WallCheck = Options.WallCheck.Value
end)

getgenv().AimbotEnabled = Options.AimbotEnabled.Value
getgenv().TeamCheck = Options.TeamCheck.Value
getgenv().WallCheck = Options.WallCheck.Value

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera

local function isVisible(targetPart)
    if getgenv().WallCheck then
        local origin = Camera.CFrame.Position
        local direction = (targetPart.Position - origin).Unit * 300

        local ray = Ray.new(origin, direction)
        local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character}, false, true)

        return part and part:IsDescendantOf(targetPart.Parent)
    end
    return true
end

local function getNearestTarget()
    local nearestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            if getgenv().TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end

            local distance = (LocalPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude

            if distance < shortestDistance and isVisible(player.Character.Head) then
                nearestPlayer = player
                shortestDistance = distance
            end
        end
    end
    return nearestPlayer
end

local function aimAt(target)
    if target and target.Character and target.Character:FindFirstChild("Head") then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().AimbotEnabled then
        local target = getNearestTarget()
        if target then
            aimAt(target)
        end
    end
end)

-- Rob A Convenience Store Tab
Tabs.RobAConvenienceStore:AddParagraph({ Title = "Rob A Convenience Store Features", Content = "Features specific to robbing convenience stores." })

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

Tabs.RobAConvenienceStore:AddButton({
    Title = "Sell",
    Description = "Teleport to Sell location",
    Callback = function()
        print("Sell pressed")
        local sellLocation = CFrame.new(76, 3, -22)
        teleportTo(sellLocation)
    end
})

Tabs.RobAConvenienceStore:AddButton({
    Title = "Steal",
    Description = "Teleport to Steal location",
    Callback = function()
        print("Steal pressed")
        local stealLocation = CFrame.new(58, 3, 7)
        teleportTo(stealLocation)
    end
})

-- Fluent settings and addons integration
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = ("Larry2k Hub " + larry2khubversion),
    Content = "Larry2k Hub has been loaded succesfully!",
    Duration = 5
})

SaveManager:LoadAutoloadConfig()
