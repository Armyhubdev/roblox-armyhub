-- Army Hub GUI for Emergency Hamburg -- Full Version with Tabs, Load-on-Click, Working Scripts, Draggable UI

local Players = game:GetService("Players") local player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game.CoreGui) ScreenGui.Name = "ArmyHub"

local MainFrame = Instance.new("Frame") MainFrame.Size = UDim2.new(0, 600, 0, 400) MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200) MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) MainFrame.BorderSizePixel = 0 MainFrame.Parent = ScreenGui

local TopBar = Instance.new("Frame", MainFrame) TopBar.Size = UDim2.new(1, 0, 0, 30) TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local Title = Instance.new("TextLabel", TopBar) Title.Text = "Army Hub" Title.Size = UDim2.new(1, -30, 1, 0) Title.Position = UDim2.new(0, 10, 0, 0) Title.BackgroundTransparency = 1 Title.TextColor3 = Color3.new(1, 1, 1) Title.Font = Enum.Font.SourceSansBold Title.TextSize = 20

local Close = Instance.new("TextButton", TopBar) Close.Size = UDim2.new(0, 30, 1, 0) Close.Position = UDim2.new(1, -30, 0, 0) Close.Text = "-" Close.Font = Enum.Font.SourceSansBold Close.TextSize = 22 Close.TextColor3 = Color3.fromRGB(255, 80, 80) Close.BackgroundColor3 = Color3.fromRGB(40, 40, 40) Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local DragLine = Instance.new("TextButton", MainFrame) DragLine.Size = UDim2.new(1, 0, 0, 20) DragLine.Position = UDim2.new(0, 0, 1, -20) DragLine.Text = "Click to drag" DragLine.TextColor3 = Color3.new(1, 1, 1) DragLine.BackgroundColor3 = Color3.fromRGB(30, 30, 30) DragLine.AutoButtonColor = false

MainFrame.Active = true MainFrame.Draggable = true

local ButtonPanel = Instance.new("Frame", MainFrame) ButtonPanel.Size = UDim2.new(0, 130, 1, -50) ButtonPanel.Position = UDim2.new(0, 0, 0, 30) ButtonPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local ContentPanel = Instance.new("Frame", MainFrame) ContentPanel.Size = UDim2.new(1, -130, 1, -50) ContentPanel.Position = UDim2.new(0, 130, 0, 30) ContentPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local Tabs = {"Aimbot", "ESP", "Teleport", "Vehicle Mods", "Player Mods", "Misc", "Credits"} local TabFrames = {}

for i, tab in ipairs(Tabs) do local btn = Instance.new("TextButton", ButtonPanel) btn.Size = UDim2.new(1, 0, 0, 40) btn.Position = UDim2.new(0, 0, 0, (i-1)*42) btn.Text = tab btn.Font = Enum.Font.SourceSansBold btn.TextSize = 16 btn.TextColor3 = Color3.new(1, 1, 1) btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local frame = Instance.new("Frame", ContentPanel)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundTransparency = 1
frame.Visible = false
TabFrames[tab] = frame

btn.MouseButton1Click:Connect(function()
    for _, f in pairs(TabFrames) do f.Visible = false end
    frame.Visible = true

    if #frame:GetChildren() == 0 then
        if tab == "Aimbot" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/guptarudra/ArmyHub/main/aimbot.lua"))()
        elseif tab == "ESP" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/guptarudra/ArmyHub/main/esp.lua"))()
        elseif tab == "Teleport" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/guptarudra/ArmyHub/main/teleport.lua"))()
        elseif tab == "Vehicle Mods" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/guptarudra/ArmyHub/main/vehicle.lua"))()
        elseif tab == "Player Mods" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/guptarudra/ArmyHub/main/player.lua"))()
        elseif tab == "Misc" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/guptarudra/ArmyHub/main/misc.lua"))()
        elseif tab == "Credits" then
            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1, 0, 0, 40)
            label.Text = "Made by Army Hub | Gupta Rudra"
            label.TextColor3 = Color3.new(1, 1, 1)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.SourceSansBold
            label.TextSize = 20
        end
    end
end)

end

