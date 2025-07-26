-- Army Hub GUI - Emergency Hamburg Edition

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Tabs = Instance.new("Frame")
local Buttons = {}
local Sections = {
    "Aimbot", "ESP", "Teleport", "Vehicle Mods", "Player Mods", "Misc", "Credits"
}
local UICorner = Instance.new("UICorner")

-- GUI Setup
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "ArmyHub"
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 600, 0, 350)
Main.Position = UDim2.new(0.25, 0, 0.25, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

Title.Name = "Title"
Title.Parent = Main
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Army Hub"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true
Title.BackgroundTransparency = 1

Close.Name = "Close"
Close.Parent = Main
Close.Size = UDim2.new(0, 40, 0, 40)
Close.Position = UDim2.new(1, -40, 0, 0)
Close.Text = "-"
Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

Tabs.Name = "Tabs"
Tabs.Parent = Main
Tabs.Size = UDim2.new(0, 120, 1, -40)
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Create Tabs
for i, name in ipairs(Sections) do
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Parent = Tabs
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Position = UDim2.new(0, 0, 0, (i - 1) * 32)
    Button.Text = name
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.MouseButton1Click:Connect(function()
        loadstring(Features[name])()
    end)
    Buttons[name] = Button
end

-- Feature Scripts (fully embedded)
Features = {}

Features["Aimbot"] = [[
loadstring(game:HttpGet("https://pastebin.com/raw/3jQ1V4NJ"))()
]]

Features["ESP"] = [[
loadstring(game:HttpGet("https://pastebin.com/raw/h8HuDGC4"))()
]]

Features["Teleport"] = [[
local player = game.Players.LocalPlayer
local destinations = {
    Police = Vector3.new(273, 5, -162),
    Bank = Vector3.new(180, 5, -60),
    Hospital = Vector3.new(-95, 5, 210)
}
for name, pos in pairs(destinations) do
    player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    wait(1)
end
]]

Features["Vehicle Mods"] = [[
local car = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("VehicleSeat")
if car then
    car.MaxSpeed = 300
    car.Torque = 99999
end
]]

Features["Player Mods"] = [[
local plr = game.Players.LocalPlayer
plr.Character.Humanoid.WalkSpeed = 50
plr.Character.Humanoid.JumpPower = 100
]]

Features["Misc"] = [[
-- NoClip toggle
local noclip = false
game:GetService("UserInputService").InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.N then
        noclip = not noclip
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)
]]

Features["Credits"] = [[
game.StarterGui:SetCore("SendNotification", {
    Title = "Army Hub",
    Text = "Made by @ArmyHubDev on GitHub",
    Duration = 5
})
]]

-- Draggable
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Main.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
