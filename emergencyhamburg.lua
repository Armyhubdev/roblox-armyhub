-- Army Hub GUI (Emergency Hamburg)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ArmyHub"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.3, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "Army Hub"
Title.TextSize = 24
Title.TextColor3 = Color3.new(1, 1, 1)

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.Text = "-"
Close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Close.MouseButton1Click:Connect(function() Main.Visible = false end)

local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.new(0, 120, 1, -40)
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -120, 1, -40)
Content.Position = UDim2.new(0, 120, 0, 40)
Content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local function createTab(name, callback)
	local button = Instance.new("TextButton", Tabs)
	button.Size = UDim2.new(1, 0, 0, 35)
	button.Text = name
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.MouseButton1Click:Connect(callback)
end

local function clearContent()
	for _, v in pairs(Content:GetChildren()) do
		if v:IsA("GuiObject") then v:Destroy() end
	end
end

-- Tab: Aimbot
createTab("Aimbot", function()
	clearContent()
	local btn = Instance.new("TextButton", Content)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 20, 0, 20)
	btn.Text = "Enable Aimbot"
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)

	local enabled = false
	local RunService = game:GetService("RunService")

	local function getClosestPlayer()
		local closest, dist = nil, math.huge
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
				local pos = player.Character.Head.Position
				local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(pos)
				local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).magnitude
				if onScreen and mag < dist then
					dist = mag
					closest = player
				end
			end
		end
		return closest
	end

	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		btn.Text = enabled and "Aimbot ON" or "Enable Aimbot"
	end)

	RunService.RenderStepped:Connect(function()
		if enabled then
			local target = getClosestPlayer()
			if target and target.Character:FindFirstChild("Head") then
				workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
			end
		end
	end)
end)

-- Tab: ESP
createTab("ESP", function()
	clearContent()
	local btn = Instance.new("TextButton", Content)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 20, 0, 20)
	btn.Text = "Enable ESP"
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)

	local enabled = false
	local drawings = {}

	local function createESP(player)
		local box = Drawing.new("Text")
		box.Color = Color3.new(1, 1, 1)
		box.Size = 16
		box.Center = true
		box.Outline = true
		box.Visible = false
		drawings[player] = box
	end

	local function removeESP(player)
		if drawings[player] then
			drawings[player]:Remove()
			drawings[player] = nil
		end
	end

	Players.PlayerAdded:Connect(createESP)
	Players.PlayerRemoving:Connect(removeESP)
	for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then createESP(p) end end

	game:GetService("RunService").RenderStepped:Connect(function()
		if enabled then
			for player, text in pairs(drawings) do
				if player.Character and player.Character:FindFirstChild("Head") then
					local head = player.Character.Head.Position
					local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head)
					if onScreen then
						text.Position = Vector2.new(screenPos.X, screenPos.Y)
						text.Text = player.Name
						text.Visible = true
					else
						text.Visible = false
					end
				end
			end
		else
			for _, text in pairs(drawings) do
				text.Visible = false
			end
		end
	end)

	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		btn.Text = enabled and "ESP ON" or "Enable ESP"
	end)
end)

-- Tab: Teleport
createTab("Teleport", function()
	clearContent()
	local places = {
		{"To Police", Vector3.new(73, 5, -120)},
		{"To Hospital", Vector3.new(210, 5, -90)},
		{"To Bank", Vector3.new(160, 5, 75)},
	}
	for i, info in pairs(places) do
		local btn = Instance.new("TextButton", Content)
		btn.Size = UDim2.new(0, 200, 0, 30)
		btn.Position = UDim2.new(0, 20, 0, i * 35)
		btn.Text = info[1]
		btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.MouseButton1Click:Connect(function()
			LocalPlayer.Character:MoveTo(info[2])
		end)
	end
end)

-- Tab: Vehicle Mods
createTab("Vehicle Mods", function()
	clearContent()
	local btn = Instance.new("TextButton", Content)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 20, 0, 20)
	btn.Text = "Boost Car Speed"
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)

	btn.MouseButton1Click:Connect(function()
		local seat = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("VehicleSeat", true)
		if seat then
			seat.MaxSpeed = 500
			seat.Torque = 500000
		end
	end)
end)

-- Tab: Misc
createTab("Misc", function()
	clearContent()

	local noclip = false
	local btn = Instance.new("TextButton", Content)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 20, 0, 20)
	btn.Text = "Toggle NoClip"
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)

	game:GetService("RunService").Stepped:Connect(function()
		if noclip and LocalPlayer.Character then
			for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)

	btn.MouseButton1Click:Connect(function()
		noclip = not noclip
		btn.Text = noclip and "NoClip ON" or "Toggle NoClip"
	end)
end)

-- Tab: Credits
createTab("Credits", function()
	clearContent()
	local text = Instance.new("TextLabel", Content)
	text.Size = UDim2.new(1, -40, 0, 40)
	text.Position = UDim2.new(0, 20, 0, 20)
	text.Text = "Made by Army Hub Dev 💣"
	text.TextColor3 = Color3.new(1, 1, 1)
	text.BackgroundTransparency = 1
end)
