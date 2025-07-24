-- Army Hub: Emergency Hamburg GUI (Offline Full Version)
-- UI Library Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local TabList = Instance.new("Frame")

-- Draggable Setup
MainFrame.Draggable = true
MainFrame.Active = true

-- Styling
ScreenGui.Name = "ArmyHubGUI"
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Parent = ScreenGui

Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Army Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Parent = MainFrame

CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.Text = "-"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.Parent = MainFrame
CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

TabList.Name = "TabList"
TabList.Size = UDim2.new(0, 150, 1, -40)
TabList.Position = UDim2.new(0, 0, 0, 40)
TabList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TabList.Parent = MainFrame

-- Create tab buttons and section frames
local sections = {
	"Aimbot",
	"ESP",
	"Teleport",
	"Vehicle Mods",
	"Player Mods",
	"Misc",
	"Credits"
}

local tabButtons = {}
local sectionFrames = {}

for i, name in ipairs(sections) do
	local btn = Instance.new("TextButton")
	btn.Name = name .. "Tab"
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
	btn.Text = name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 18
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Parent = TabList
	tabButtons[name] = btn

	local frame = Instance.new("Frame")
	frame.Name = name .. "Frame"
	frame.Size = UDim2.new(1, -150, 1, -40)
	frame.Position = UDim2.new(0, 150, 0, 40)
	frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	frame.Visible = false
	frame.Parent = MainFrame
	sectionFrames[name] = frame

	btn.MouseButton1Click:Connect(function()
		for _, f in pairs(sectionFrames) do f.Visible = false end
		frame.Visible = true
	end)
end

-- Aimbot Logic
local aimbotEnabled = false
local function getClosest()
	local players = game:GetService("Players")
	local closest, distance = nil, math.huge
	for _, plr in pairs(players:GetPlayers()) do
		if plr ~= players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
			local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.Head.Position)
			if onScreen then
				local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
				if dist < distance then
					closest = plr
					distance = dist
				end
			end
		end
	end
	return closest
end

local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
RunService.RenderStepped:Connect(function()
	if aimbotEnabled then
		local target = getClosest()
		if target and target.Character and target.Character:FindFirstChild("Head") then
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
		end
	end
end)

local aimbotBtn = Instance.new("TextButton", sectionFrames["Aimbot"])
aimbotBtn.Size = UDim2.new(0, 200, 0, 50)
aimbotBtn.Position = UDim2.new(0, 20, 0, 20)
aimbotBtn.Text = "Toggle Aimbot"
aimbotBtn.Font = Enum.Font.Gotham
aimbotBtn.TextSize = 20
aimbotBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
aimbotBtn.MouseButton1Click:Connect(function()
	aimbotEnabled = not aimbotEnabled
	aimbotBtn.Text = aimbotEnabled and "Aimbot ON" or "Aimbot OFF"
end)

-- ESP Logic
local espEnabled = false
local drawings = {}

local function clearESP()
	for _, drawing in pairs(drawings) do
		drawing:Remove()
	end
	table.clear(drawings)
end

RunService.RenderStepped:Connect(function()
	if not espEnabled then clearESP() return end
	clearESP()
	for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
		if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
			local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.Head.Position)
			if onScreen then
				local nameTag = Drawing.new("Text")
				nameTag.Text = plr.Name
				nameTag.Position = Vector2.new(pos.X, pos.Y)
				nameTag.Size = 16
				nameTag.Color = Color3.fromRGB(255, 0, 0)
				nameTag.Outline = true
				nameTag.Center = true
				nameTag.Visible = true
				table.insert(drawings, nameTag)
			end
		end
	end
end)

local espBtn = Instance.new("TextButton", sectionFrames["ESP"])
espBtn.Size = UDim2.new(0, 200, 0, 50)
espBtn.Position = UDim2.new(0, 20, 0, 20)
espBtn.Text = "Toggle ESP"
espBtn.Font = Enum.Font.Gotham
espBtn.TextSize = 20
espBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
espBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espBtn.Text = espEnabled and "ESP ON" or "ESP OFF"
end)

-- Teleport Tab
local tpFrame = sectionFrames["Teleport"]
local tpLocations = {
	{ name = "Police Station", pos = Vector3.new(123, 10, 456) },
	{ name = "Bank", pos = Vector3.new(200, 10, -150) },
	{ name = "Hospital", pos = Vector3.new(-320, 10, 210) },
}
for i, loc in ipairs(tpLocations) do
	local btn = Instance.new("TextButton", tpFrame)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 20, 0, (i-1)*50 + 20)
	btn.Text = "Teleport: " .. loc.name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 18
	btn.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
	btn.MouseButton1Click:Connect(function()
		game.Players.LocalPlayer.Character:MoveTo(loc.pos)
	end)
end

-- Other sections: placeholder
for _, name in ipairs({ "Vehicle Mods", "Player Mods", "Misc", "Credits" }) do
	local label = Instance.new("TextLabel", sectionFrames[name])
	label.Size = UDim2.new(1, -40, 0, 30)
	label.Position = UDim2.new(0, 20, 0, 20)
	label.Text = name .. " features coming soon..."
	label.Font = Enum.Font.Gotham
	label.TextSize = 18
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.BackgroundTransparency = 1
end
