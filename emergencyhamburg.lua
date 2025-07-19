-- Simple Army Hub GUI with working tabs and buttons inside
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "ArmyHub"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.25, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 0

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "Army Hub | Emergency Hamburg"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Tabs
local Tabs = {
    "Aimbot", "ESP", "Teleport", "Vehicle", "Misc"
}

local Frames = {}

for i, tabName in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton", MainFrame)
    TabBtn.Size = UDim2.new(0, 90, 0, 30)
    TabBtn.Position = UDim2.new(0, (i - 1) * 95, 0, 50)
    TabBtn.Text = tabName
    TabBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    TabBtn.TextColor3 = Color3.new(1, 1, 1)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 14

    -- Frame for each tab
    local TabFrame = Instance.new("Frame", MainFrame)
    TabFrame.Size = UDim2.new(1, -20, 1, -90)
    TabFrame.Position = UDim2.new(0, 10, 0, 90)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false

    -- Add dummy content inside each
    local Button = Instance.new("TextButton", TabFrame)
    Button.Size = UDim2.new(0, 150, 0, 40)
    Button.Position = UDim2.new(0, 10, 0, 10)
    Button.Text = "Activate " .. tabName
    Button.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 16

    -- Store frame
    Frames[tabName] = TabFrame

    -- Tab click handler
    TabBtn.MouseButton1Click:Connect(function()
        -- Hide all other frames
        for _, frame in pairs(Frames) do
            frame.Visible = false
        end
        -- Show current
        TabFrame.Visible = true
    end)
end

-- Show first tab by default
Frames["Aimbot"].Visible = true
